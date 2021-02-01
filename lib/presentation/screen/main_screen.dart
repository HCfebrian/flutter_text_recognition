import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_text_recognition/core/colors.dart';
import 'package:flutter_text_recognition/presentation/bloc/pizza_history/pizza_history_bloc.dart';
import 'package:flutter_text_recognition/presentation/bloc/scaner/scanner_bloc.dart';
import 'package:flutter_text_recognition/presentation/screen/page/purchase_page.dart';

import '../../injection_container.dart';

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<PizzaHistoryBloc>(
        create: (BuildContext context) => PizzaHistoryBloc(sl()),
      ),
      BlocProvider<ScannerBloc>(create: (context) => sl())
    ], child: MainScreen());
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final pageController = PageController(initialPage: 0);
  GlobalKey _bottomNavigationKey = GlobalKey();
  int destinationPage = 1;
  bool enableSwap = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: appColorBackground,
          drawerScrimColor: appColorPrimaryYellow,
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            buttonBackgroundColor: appColorPrimaryYellow,
            height: 75,
            color: appColorSecondaryDarkBlue,
            backgroundColor: appColorBackground,
            animationDuration: Duration(milliseconds: 250),
            letIndexChange: (index) => true,
            items: [
              Icon(
                Icons.home,
                // size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.near_me_rounded,
                // size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.shopping_cart,
                // size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.av_timer_outlined,
                // size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.account_circle,
                // size: 30,
                color: Colors.white,
              ),
            ],
            onTap: (index) {
              enableSwap = false;
              destinationPage = index;
              pageController.animateToPage(index,
                  duration: Duration(milliseconds: 250), curve: Curves.easeOut);
            },
          ),
          body: PageView(
            controller: pageController,
            onPageChanged: (index) {
              print("index " + index.toString());
              if (enableSwap) {
                CurvedNavigationBarState navBarState =
                    _bottomNavigationKey.currentState;
                navBarState.setPage(index);
              }
              if (destinationPage == index) {
                enableSwap = true;
              }
            },
            children: [
              Scaffold(
                appBar: AppBar(
                  title: Center(
                    child: Text("Home"),
                  ),
                ),
                body: Center(
                  child: Text(1.toString()),
                ),
              ),
              Scaffold(
                appBar: AppBar(
                  title: Center(
                    child: Text("Location"),
                  ),
                ),
                body: Center(
                  child: Text(
                    2.toString(),
                  ),
                ),
              ),
              Scaffold(
                appBar: AppBar(
                  title: Center(
                    child: Text("Cart"),
                  ),
                ),
                body: Center(
                  child: Text(3.toString()),
                ),
              ),
              PurchaseScreen(),
              Scaffold(
                appBar: AppBar(
                  title: Center(
                    child: Text("Profile"),
                  ),
                ),
                body: Center(
                  child: Text(
                    5.toString(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
