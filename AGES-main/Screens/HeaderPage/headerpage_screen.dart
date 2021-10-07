import 'package:ages_app/Module/MyProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ages_app/Users/User.dart';

import 'components/body.dart';

class HeaderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = context.read<MyProvider>().getUser();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: body(size: size, user: user),
    );
  }
}
