
import 'package:ages_app/Screens/Articles/components/ajouter.dart';
import 'package:flutter/material.dart';
import '../../../Module/custom_appbar.dart';

class ArticlesAjouter extends StatelessWidget {
  const ArticlesAjouter({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(false, "Articles"),
      body: AjouterArticle(context),
      );
  }
}