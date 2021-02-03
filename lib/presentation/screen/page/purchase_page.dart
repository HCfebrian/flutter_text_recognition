import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_text_recognition/core/colors.dart';
import 'package:flutter_text_recognition/domain/entity/pizza_entity.dart';
import 'package:flutter_text_recognition/presentation/bloc/pizza_history/pizza_history_bloc.dart';
import 'package:flutter_text_recognition/presentation/bloc/scaner/scanner_bloc.dart';
import 'package:flutter_text_recognition/presentation/widget/backdrop_widget.dart';
import 'package:flutter_text_recognition/presentation/widget/custom_camera.dart';
import 'package:flutter_text_recognition/presentation/widget/horizontal_card_loading.dart';
import 'package:flutter_text_recognition/presentation/widget/horizontal_pizza_card.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:implicitly_animated_reorderable_list/transitions.dart';

class PurchaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PizzaHistoryBloc>(context).add(
      PizzaHistoryGetStreamEvent(),
    );
    return Stack(
      children: [
        Backdrop(color: appColorSecondaryDarkBlue),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Center(
              child: Text("History"),
            ),
          ),
          body: BlocListener<ScannerBloc, ScannerState>(
            listener: (BuildContext context, state) {
              if (state is ScannerConfirmedState) {
                showBottomSheet(
                  elevation: 5,
                  context: context,
                  builder: (context) {
                    return Container(
                      color: appColorBackground,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: 60,
                                    height: 5,
                                    decoration: BoxDecoration(
                                        color: appColorPrimaryYellow,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: appColorSecondaryDarkBlue,
                                  size: 50,
                                ),
                                Text(
                                  "You Earn Cashback : ${state.cashback}",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              if (state is ScannerNotConfirmedState) {
                showBottomSheet(
                  elevation: 5,
                  context: context,
                  builder: (context) {
                    return Container(
                      color: appColorBackground,
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: 60,
                                    height: 5,
                                    decoration: BoxDecoration(
                                        color: appColorPrimaryYellow,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.close,
                                  color: appColorSecondaryDarkBlue,
                                  size: 50,
                                ),
                                Text(
                                  "Failed : ${state.message}",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            },
            child: HistoryContent(),
          ),
        ),
      ],
    );
  }
}

class HistoryContent extends StatelessWidget {
  const HistoryContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PizzaHistoryBloc, PizzaHistoryState>(
      builder: (context, state) {
        print("size :");
        print(MediaQuery.of(context).size.width);
        print(MediaQuery.of(context).size.height);
        if (state is PizzaHistoryInitialState) {
          return Container();
        }

        if (state is PizzaHistoryLoadingState) {
          return ListView.builder(
              itemCount: 10 + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 16,
                        ),
                        child: Text(
                          "Scan Your Offline Receipt and Earn CashBack!",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: appColorSecondaryDarkBlue),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      RaisedButton(
                        onPressed: () {},
                        child: Text(
                          "Scan Your Receipt",
                          style: TextStyle(
                              fontSize: 16, color: appColorAccent0Gray),
                        ),
                        color: appColorAccent3Brown,
                      ),
                      SizedBox(
                        height: 6,
                      )
                    ],
                  );
                }
                return HorizontalCardLoading();
              });
        }

        if (state is PizzaHistoryLoadedState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 18),
                      child: Text(
                        "Scan Your Offline Receipt and Earn CashBack!",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: appColorAccent0Gray),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: RaisedButton(
                        onPressed: () async {
                          // BlocProvider.of<ScannerBloc>(context)
                          //     .add(ScanReceiptEvent());

                          final File val = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CustomCamera(),
                            ),
                          );

                          print( "Size media query"+ MediaQuery.of(context).size.toString());
                          BlocProvider.of<ScannerBloc>(context)
                              .add(ScanReceiptEvent(path: val, size: MediaQuery.of(context).size));
                          print("directory val:");
                          print(val.parent.path);
                          print("path val:");
                          print(val.path);
                        },
                        child: Text(
                          "Scan Your Receipt",
                          style: TextStyle(
                              fontSize: 16, color: appColorAccent0Gray),
                        ),
                        color: appColorPrimaryYellow,
                      ),
                    ),
                  ],
                ),
                Container(
                  child: ImplicitlyAnimatedList<PizzaHistoryEntity>(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    items: state.listPizza,
                    areItemsTheSame: (a, b) => a.purchaseId == b.purchaseId,
                    itemBuilder: (context, animation, item, index) {
                      return SizeFadeTransition(
                          sizeFraction: 0.7,
                          curve: Curves.easeInOut,
                          animation: animation,
                          child: HorizontalPizzaCard(
                            pizzaCal: item.pizzaCal,
                            purchaseDate: item.purchaseDate,
                            pizzaName: item.pizzaName,
                            pizzaSize: item.pizzaSize,
                            pizzaPicUrl: item.purchasePicUrl,
                            pizzaPrice: item.pizzaPrice,
                            purchaseQuantity: item.purchaseQuantity,
                          ));
                    },
                    removeItemBuilder: (context, animation, oldItem) {
                      return FadeTransition(
                        opacity: animation,
                        child: HorizontalPizzaCard(
                          pizzaCal: oldItem.pizzaCal,
                          purchaseDate: oldItem.purchaseDate,
                          pizzaName: oldItem.pizzaName,
                          pizzaSize: oldItem.pizzaSize,
                          pizzaPicUrl: oldItem.purchasePicUrl,
                          pizzaPrice: oldItem.pizzaPrice,
                          purchaseQuantity: oldItem.purchaseQuantity,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        // this is error state
        return Container(
          child: Center(
            child: Text((state as PizzaHistoryErrorState).message ?? "error!"),
          ),
        );
      },
    );
  }
}
