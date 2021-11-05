import 'package:ages_app/Module/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomTextStyle {

  static TextStyle TextFontTitle(BuildContext context) {
    return TextStyle(fontSize: 22,color: kHighLightPrimaryTextColor,);
  }
  static TextStyle TextFontSemiTitle(BuildContext context){
    return TextStyle(fontSize: 19,color: kHighLightSecondaryTextColor);
  }
  static TextStyle TextFontPrimaryDescription(BuildContext context) {
    return TextStyle(fontSize: 18,color: kHighLightPrimaryTextColor,);
  }
  static TextStyle TextFontInfo(BuildContext context){
    return TextStyle(fontSize: 15,color:kHighLightSecondaryTextColor);
  }
  static TextStyle TextFontInfoWhite(BuildContext context){
    return TextStyle(fontSize: 15,color:Colors.white);
  }

  static TextStyle HeaderCardTextFont(BuildContext context){
    return TextStyle(fontSize: 15,color: Colors.white,);
  }
   static TextStyle HeaderCardButtonFont(BuildContext context){
    return TextStyle(fontSize: 17,color: kHighLightSecondaryTextColor,);
  }

  static TextStyle DisconnectButton(BuildContext context){
    return TextStyle(fontSize: 15,color:kHighLightSecondaryTextColor);
  }
  static TextStyle CardsNoOrder(BuildContext context){
    return TextStyle(fontSize: 25,color: kHighLightSecondaryTextColor);
  }
}