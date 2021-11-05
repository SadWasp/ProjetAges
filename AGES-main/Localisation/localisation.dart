import 'package:ages_app/Items/Items.dart';
import 'package:ages_app/Location/location.dart';
import 'package:ages_app/Module/MyProvider.dart';
import 'package:ages_app/Users/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../Module/custom_appbar.dart';
import 'components/body.dart';

class LocalisationPage extends StatelessWidget {
  const LocalisationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<List<Location>> listeLocalisation = Location.getListLocations();
    User user = context.read<MyProvider>().getUser();
    return Scaffold(
      appBar: CustomAppBar(false, "Localisation"),
      body: LocalisationBody(listeLocalisation, user),
      );
  }
}

