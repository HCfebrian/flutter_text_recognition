import 'package:flutter/material.dart';
import 'package:flutter_text_recognition/core/colors.dart';

class HorizontalPizzaCard extends StatelessWidget {
  final pizzaPicUrl;
  final pizzaName;
  final pizzaCal;
  final pizzaSize;
  final pizzaPrice;
  final purchaseQuantity;
  final purchaseDate;
  final Function onPress;

  const HorizontalPizzaCard({
    Key key,
    @required this.pizzaPicUrl,
    @required this.pizzaName,
    @required this.pizzaCal,
    @required this.pizzaSize,
    @required this.pizzaPrice,
    @required this.purchaseQuantity,
    @required this.purchaseDate,
    @required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        showDialog(
            context: context,
            child: AlertDialog(
              title: Text("Delete this?"),
              content: RaisedButton(
                onPressed: onPress,
                child: Text("yes"),
              ),
            ));
      },
      child: Container(
        height: 120,
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        decoration: BoxDecoration(
            color: appColorCardBackground,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Image.asset(
                pizzaPicUrl,
                height: 100,
                width: 100,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pizzaName.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          color: appColorSecondaryDarkBlue,
                          fontWeight: FontWeight.w600),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.av_timer_outlined,
                              color: Colors.green,
                              size: 14,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              purchaseDate.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        Row(
                          children: [
                            Icon(
                              Icons.battery_charging_full_outlined,
                              color: appColorPrimaryYellow,
                              size: 14,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              pizzaCal.toString() + " KCal",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text("SIZE " + pizzaSize.toString(),
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black45,
                            fontWeight: FontWeight.w600))
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, right: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\$ ${pizzaPrice.toString()}",
                      style: TextStyle(
                          fontSize: 14,
                          color: appColorPrimaryYellow,
                          fontWeight: FontWeight.w600)),
                  Text("X ${purchaseQuantity.toString()}",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black45,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
