import 'package:ages_app/Items/Items.dart';
import 'package:ages_app/Location/location.dart';
import 'package:ages_app/MapModel/mapModel.dart';
import 'package:ages_app/Module/MyProvider.dart';
import 'package:ages_app/Module/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Module/utils.dart' as utils;

class GridViewWidget extends StatelessWidget {
  final int orderId;
  const GridViewWidget({Key? key, required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<dynamic> itemsByOrder = context.read<MyProvider>().getMapModel();
    return Expanded(
      child: Column(
        children: [
          GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 0,
                  mainAxisExtent: size.width / 3.625),
              itemCount: 9,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                int tileIndex = index + 1;
                List<dynamic> itemLocation = context.read<MyProvider>().getMapModel();
                List<dynamic> currentTileItem = itemLocation
                    .where((mapModel) => mapModel.zone == tileIndex)
                    .toList();

                return Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        color: kPrimaryLightColor,
                        child: Image.asset("images/Tile0$tileIndex.png"),
                      ),
                          (currentTileItem.length > 0) ? Stack( children:
                            List.generate(currentTileItem.length, (currentTileIndex) {
                          return Transform.translate(
                            offset: Offset(1.0 * currentTileItem[currentTileIndex].x, 1.0 * currentTileItem[currentTileIndex].y),
                            child: Stack(
                              children: [
                                Icon(Icons.location_on, color: Colors.greenAccent,size: 35,),
                              ],
                            ),
                          );
                        }),
                      ) : Stack(),
                      (currentTileItem.length > 0)
                          ? Transform.translate(offset: Offset(-50,28),
                            child: ElevatedButton(
                                onPressed: () => {},
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.transparent))),
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      Colors.transparent),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: kPrimaryLightColor,
                                  child: Text(
                                    currentTileItem.length.toString(),
                                    style: utils.CustomTextStyle.TextFontTitle(context),
                                  ),
                                ),
                              ),
                          )
                          : Container(),
                    ],
                  ),
                );
              }),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child:
                        Text("Ordre de ramassage: ", style: utils.CustomTextStyle.TextFontInfoWhite(context),),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                        child: ListView.builder(shrinkWrap: true,itemBuilder: (BuildContext context, int index,){
                          return Container(
                            color: kPrimaryLightColor,
                            margin : const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    color: kPrimaryLightColor,
                                    margin : const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${index + 1}:", textAlign: TextAlign.center,),
                                    )),
                                  Container(
                                    color: kPrimaryLightColor,
                                    margin : const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("${itemsByOrder[index].name}", textAlign: TextAlign.center,),
                                    )),
                                ],
                              ),
                            ),
                          );
                        }, itemCount: itemsByOrder.length,),
                      ),
                    ),
                  ],
                ),
              )
        ],
      ),
    );
  }
}
