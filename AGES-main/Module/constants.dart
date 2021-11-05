import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromRGBO(71, 87, 113,1);
const kPrimaryLightColor = Color.fromRGBO(232, 235, 241, 1);
const kHighLightPrimaryTextColor = Color.fromRGBO(248, 39, 9, 1);
const kHighLightSecondaryTextColor = Color.fromRGBO(87, 105, 164, 1);
const kPurple = Color.fromRGBO(184, 153, 255, 1);
//const kPrimaryLightColor = Color.fromRGBO(184, 153, 255, 1);
const Tokekey = "ThisIsASecureConThisIsASecureCon";

const siteweb = "https://sadwasp.pythonanywhere.com/";

String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
RegExp regExp = new RegExp(pattern);