import 'package:flutter/material.dart';

import '../../../Module/utils.dart' as utils;

class MapAppBar extends StatelessWidget {
  const MapAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: Size.zero,
        child: Column(
          children: [
            Text("Carte de l'entrepot",
                style: utils.CustomTextStyle.TextFontPrimaryDescription(context)),
            Icon(Icons.arrow_drop_down_circle_outlined),

          ],
        ),
      ),
    );
  }
}
