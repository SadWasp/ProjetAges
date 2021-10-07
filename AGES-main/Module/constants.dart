import 'package:flutter/material.dart';

const kPrimaryColor = Color.fromRGBO(147, 102, 250, 1);
const kPrimaryLightColor = Color.fromRGBO(184, 153, 255, 1);
const Tokekey = "ThisIsASecureConThisIsASecureCon";

const siteweb = "https://sadwasp.pythonanywhere.com/";

String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
RegExp regExp = new RegExp(pattern);