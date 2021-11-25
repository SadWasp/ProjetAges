import 'package:ages_app/Localisation/localisation.dart';
import 'package:ages_app/Module/MyProvider.dart';
import 'package:ages_app/Module/constants.dart';
import 'package:ages_app/Screens/Articles/ajouterUnArticle.dart';
import 'package:ages_app/Screens/Articles/articles.dart';
import 'package:ages_app/Screens/Articles/components/Cart.dart';
import 'package:ages_app/Screens/Profile/profile_screen.dart';
import 'package:ages_app/Screens/Login/login_screen.dart';
import 'package:ages_app/Screens/Scanner/scanner.dart';
import 'package:ages_app/Screens/Signup/Signup_screen.dart';
import 'package:ages_app/Screens/Commande/order_screen.dart';
import 'package:ages_app/Screens/Admin/AdminPannel.dart';
import 'package:ages_app/Screens/HeaderPage/headerpage_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/MAP/floorplan_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MyProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const MaterialColor kToDark = const MaterialColor(
      0xFF37474F, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
      const <int, Color>{
        50: const Color(0xffce5641), //10%
        100: const Color(0xffb74c3a), //20%
        200: const Color(0xffa04332), //30%
        300: const Color(0xff89392b), //40%
        400: const Color(0xff733024), //50%
        500: const Color(0xff5c261d), //60%
        600: const Color(0xff451c16), //70%
        700: const Color(0xff2e130e), //80%
        800: const Color(0xff170907), //90%
        900: const Color(0xff000000), //100%
      },
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => context.watch<MyProvider>().user == null
            ? LoginScreen()
            : HeaderPage(),
        '/Login': (BuildContext context) =>
            context.watch<MyProvider>().user == null
                ? LoginScreen()
                : HeaderPage(),
        '/Signup': (BuildContext context) =>
            context.watch<MyProvider>().user == null
                ? SignUpScreen()
                : HeaderPage(),
        '/Articles': (BuildContext context) =>
            context.watch<MyProvider>().user == null
                ? LoginScreen()
                : ArticlePage(),
        '/Header': (BuildContext context) =>
            context.watch<MyProvider>().user == null
                ? LoginScreen()
                : HeaderPage(),
        '/Profile': (BuildContext context) =>
            context.watch<MyProvider>().user == null
                ? LoginScreen()
                : ProfileScreen(),
        '/Commande': (BuildContext context) =>
            context.watch<MyProvider>().user == null
                ? LoginScreen()
                : OrderScreen(),
        '/AjouterArticle': (BuildContext context) =>
            context.watch<MyProvider>().user?.getRole() == "admin"
                ? ArticlesAjouter()
                : HeaderPage(),
        '/Cart': (BuildContext context) =>
            context.watch<MyProvider>().user == null
                ? LoginScreen()
                : CartBody(context.watch<MyProvider>().getCart(),
                    context.watch<MyProvider>().getUser(), context),
        '/AdminPannel': (BuildContext context) =>
            context.watch<MyProvider>().user?.getRole() == "admin"
                ? AdminScreen()
                : HeaderPage(),
        '/CodeBar': (BuildContext context) =>
            (context.watch<MyProvider>().user?.getRole() == "admin" ||
                    context.watch<MyProvider>().user?.getRole() == "User")
                ? BarcodeScanPage()
                : HeaderPage(),
        '/LocalisationPage': (BuildContext context) =>
            (context.watch<MyProvider>().user?.getRole() == "admin") ||
                    (context.watch<MyProvider>().user?.getRole() == "User")
                ? LocalisationPage()
                : HeaderPage(),
        '/MapPage': (BuildContext context) =>
            (context.watch<MyProvider>().user?.getRole() == "admin") ||
                    (context.watch<MyProvider>().user?.getRole() == "User")
                ? FloorPlanScreen()
                : HeaderPage(),
      },
      title: 'AGES',
      theme: ThemeData(
        primarySwatch: kToDark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
