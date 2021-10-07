import 'package:ages_app/Module/MyProvider.dart';
import 'package:ages_app/Screens/Articles/ajouterUnArticle.dart';
import 'package:ages_app/Screens/Articles/articles.dart';
import 'package:ages_app/Screens/Profile/profile_screen.dart';
import 'package:ages_app/Screens/Login/login_screen.dart';
import 'package:ages_app/Screens/Signup/Signup_screen.dart';
import 'package:ages_app/Screens/Commande/order_screen.dart';
import 'package:ages_app/Screens/Admin/AdminPannel.dart';
import 'package:ages_app/Screens/HeaderPage/headerpage_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=>MyProvider()),
    ],
    child: MyApp(),)
    );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => context.watch<MyProvider>().user == null ? LoginScreen() : HeaderPage(),
      '/Login': (BuildContext context) => context.watch<MyProvider>().user == null ? LoginScreen() : HeaderPage(),
      '/Signup': (BuildContext context) => context.watch<MyProvider>().user == null ? SignUpScreen() : HeaderPage(),
      '/Articles': (BuildContext context) => context.watch<MyProvider>().user == null ? LoginScreen() : ArticlePage(),
      '/Header': (BuildContext context) => context.watch<MyProvider>().user == null ? LoginScreen() : HeaderPage(),
      '/Profile': (BuildContext context) => context.watch<MyProvider>().user == null ? LoginScreen() : ProfileScreen(),
      '/Commande': (BuildContext context) => context.watch<MyProvider>().user == null ? LoginScreen() : OrderScreen(),
      '/AjouterArticle': (BuildContext context) => context.watch<MyProvider>().user?.getRole() == "admin" ?  ArticlesAjouter() : HeaderPage(),
      '/AdminPannel': (BuildContext context) => context.watch<MyProvider>().user?.getRole() == "admin" ? AdminScreen() : HeaderPage(),
    },
      title: 'AGES',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

