import 'package:ages_app/Items/Items.dart';
import 'package:ages_app/Module/Exceptions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../Module/utils.dart' as utils;
import 'package:ages_app/Auths/components/rounded_input_field.dart';
import 'package:ages_app/Module/MyProvider.dart';

import 'package:provider/provider.dart';

Container AjouterArticle(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final descController = TextEditingController();
  final qtyController = TextEditingController();
  final Map<String, String> _data = {'name': "", 'location': "", 'quantity': "",'description': ""};
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment(1, 1),
      end: Alignment(-1, -1),
      colors: [
        Colors.blue.shade400,
        Colors.red.shade200,
      ],
    )),
    child: Expanded(
      child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Entrer les infos de l'article",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                RoundedInputField(
                  controller: nameController,
                  hintText: "Nom de l'article",
                  onChanged: (value) => _data['name'] = value,
                ),
                RoundedInputField(
                  controller: locationController,
                  hintText: "Localisation primaire",
                  onChanged: (value) => _data['location'] = value,
                ),
                RoundedInputField(
                  controller: qtyController,
                  hintText: "Quantité en stock",
                  onChanged: (value) => _data['quantity'] = value,
                ),
                RoundedInputField(
                  controller: descController,
                  hintText: "Description courte",
                  onChanged: (value) => _data['description'] = value,
                ),
                context.watch<MyProvider>().loading
                    ? CupertinoActivityIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          try {
                            try {
                              if(_data['name'] == null && _data['description'] != null)
                                {throw UIException("Entrer au minimum le nom et un phrase descriptive");}
                              context.read<MyProvider>().setLoading(true);
                              context.read<MyProvider>().setItem(
                                  await Item.RegisterItem('${_data['name']}',
                                      '${_data['location']}',int.parse('${_data['quantity']}'),'${_data['description']}'));
                            } catch (e) {
                              final snackBar = SnackBar(
                                content: Text('$e'),
                                backgroundColor: Colors.red,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          } finally {
                            context.read<MyProvider>().setLoading(false);
                            Navigator.pushNamed(context, "/Articles");
                          }
                        },
                        child: Text("Ajouter l'article")),
              ],
            ),
          ),
    ),
  );
}

buildCallContainer(String Title, Color color, BuildContext context) {
  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Center(
          child: Text(
        Title,
        style: utils.CustomTextStyle.HeaderCardTextFont(context),
      )),
    ),
  );
}
