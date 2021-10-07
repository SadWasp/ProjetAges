import 'package:flutter/widgets.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:flutter/material.dart';
import '../../../Module/utils.dart';

//DATABASE & BACKEND
final List data = [
  {'color': Colors.purple,'commande':[{'nom':'aspirateur', 'nombre' : 3 }]},
  {'color': Colors.pink.shade900},
  {'color': Colors.purple.shade800}
];

class SwipeCard extends StatefulWidget {
  @override
  _SwipeCardState createState() => _SwipeCardState();
}

//Must update 3 or 4 at the time so we dont crash the app
class _SwipeCardState extends State<SwipeCard> {
  
  List<Cards> cards = [
    Cards(
      data[0]['color'],
    ),
    Cards(
      data[1]['color'],
    ),
    Cards(
      data[2]['color'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: cards,
      ),
    );
  }
}

class Cards extends StatelessWidget {
  final Color color;
  Cards(this.color);

  @override
  Widget build(BuildContext context) {
    
    return Swipable(
        child: Container(
          decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment(1, 1),
        end: Alignment(-1, -1),
        colors: [
          Colors.blue.shade400,
          Colors.red.shade200,
        ],
      )),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: color,
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                          child: Text(
                        "Commande #",
                        style: CustomTextStyle.TextFontInfo(context),
                      ))),
                  Expanded(
                      child: Container(
                    child: Text("12/12/12",
                        style: CustomTextStyle.TextFontInfo(context)),
                  )),
                ],
              ),
              Container(
                  child: Text(
                "000000",
                style: CustomTextStyle.TextFontTitle(context),
              )),
              Container(
                  width: 400,
                  height: 200,
                  child: Card(
                      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("list"),
                      ))),
              Container(child: Row(
                children: [
                  Container( alignment:Alignment(0,0), width: 75, height: 120 ,child: SizedBox.expand(child: Card(child: Text("card1"),))),
                  Container(child: Card(child: Text("card2"),))
                ],
              ),)
            ],
          ),
        ),
      ),
    ));
    /*
            RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: "Commande #",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ]
                  ,
                ),
              ),*/
  }
}
