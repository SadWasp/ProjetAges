import 'package:ages_app/Items/Items.dart';
import 'package:ages_app/Module/Exceptions.dart';
import 'package:ages_app/Screens/Scanner/scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../Module/utils.dart' as utils;
import 'package:ages_app/Auths/components/rounded_input_field.dart';
import 'package:ages_app/Module/MyProvider.dart';

import 'package:provider/provider.dart';

Container AjouterArticle(BuildContext context) {
  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final descController = TextEditingController();
  final qtyController = TextEditingController();
  final Map<String, String> _data = context.read<MyProvider>().getNewItem();
  
  Size size = MediaQuery.of(context).size;
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
      flex: 1,
      child: Container(
        height: size.height,
        child: Wrap(
          
          children: [
            SizedBox(height: size.height * 0.1),
            Container(
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
                        hintText: _data['name']=="" ? "Nom de l'article" : _data['name'].toString(),
                        onChanged: (value) => _data['name'] = value,
                        icon: Icons.integration_instructions ,
                      ),
                      RoundedInputField(
                        controller: locationController,
                        hintText: _data['location']=="" ? "Localisation de l'article" : _data['location'].toString(),
                        onChanged: (value) => _data['location'] = value,
                        icon: Icons.padding_rounded ,
                      ),
                      RoundedInputField(
                        controller: qtyController,
                        hintText: _data['quantity']=="" ? "Quantité en stock" : _data['quantity'].toString(),
                        onChanged: (value) => _data['quantity'] = value,
                        icon: Icons.exposure ,
                      ),
                      RoundedInputField(
                        controller: descController,
                        hintText: _data['description']=="" ? "Description courte" : _data['description'].toString(),
                        onChanged: (value) => _data['description'] = value,
                        icon: Icons.description ,
                      ),
                      Container(
                  margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 3)
              ),child:Text(context.read<MyProvider>().getScan())),
                     ElevatedButton(
                        onPressed: ()=>{
                          Navigator.pushNamed(context, '/CodeBar'),
                        },
                        child: Container(child: Text("Scan Code bar"))
                      ),
                      context.watch<MyProvider>().loading
                          ? CupertinoActivityIndicator()
                          : ElevatedButton(
                              onPressed: () async {
                                try {
                                  try {
                                    String codebar = context.read<MyProvider>().getScan();
                                    if(_data['name'] == null && _data['description'] != null)
                                      {throw UIException("Entrer au minimum le nom et un phrase descriptive");}
                                    if(codebar == "")
                                    {throw UIException("Code bar incorrecte, Réessayé...");}
                                    context.read<MyProvider>().setLoading(true);
                                    context.read<MyProvider>().setItem(
                                        await Item.RegisterItem('${_data['name']}',
                                            '${_data['location']}',int.parse('${_data['quantity']}'),'${_data['description']}', codebar));
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
