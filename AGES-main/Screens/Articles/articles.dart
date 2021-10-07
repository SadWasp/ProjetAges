import 'package:ages_app/Items/Items.dart';
import 'package:ages_app/Module/MyProvider.dart';
import 'package:ages_app/Users/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Module/custom_appbar.dart';
import 'components/body.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<Item>> listItem = Item.getListItems();
    User user = context.read<MyProvider>().getUser();
    return Scaffold(
      appBar: CustomAppBar(false, "Articles"),
      body: ArticlesBody(listItem, user),
      );
  }
}