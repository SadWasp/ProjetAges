import 'package:ages_app/Auths/components/rounded_input_field.dart';
import 'package:ages_app/Auths/components/rounded_password_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ages_app/Module/MyProvider.dart';
import 'package:ages_app/Module/Exceptions.dart';
import 'package:ages_app/Users/User.dart';
import 'package:ages_app/Module/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatelessWidget {
  final pwController = TextEditingController();
  final cpwController = TextEditingController();
  final UNController = TextEditingController();
  final Map<String, String> _data = {'username': "", 'pw': "", 'cpw': ""};
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment(0, 0),
        end: Alignment(-1, -1),
        colors: [
          Colors.blue.shade400,
          Colors.red.shade200,
        ],
      )),
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.2),
              Text("AGES",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 55,
                        color: Colors.deepPurple.shade500),
                  )), //
              SizedBox(height: size.height * 0.05),
              Text(
                "S'enregistrer",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                controller: UNController,
                hintText: "Nom d'utilisateur",
                onChanged: (value) => _data['username'] = value,
              ),
              RoundedPasswordField(
                controller: pwController,
                text: "Mot de passe",
                onChanged: (value) => _data['pw'] = value,
              ),
              RoundedPasswordField(
                controller: cpwController,
                text: "Confirmer mot de passe",
                onChanged: (value) => _data['cpw'] = value,
              ),
              context.watch<MyProvider>().loading
                  ? CupertinoActivityIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        try {
                          try {
                            if(_data['cpw'] == null || _data['cpw'] == null  || (_data['cpw'] != _data['pw']))
                              {throw UIException("Entrer 2 mots de passes identiques.");}
                            context.read<MyProvider>().setLoading(true);
                            context.read<MyProvider>().setUser(
                                await User.RegisterUser('${_data['username']}',
                                    '${_data['pw']}', "User"));
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
                        }
                      },
                      child: Text("S'enregistrer")),
              SizedBox(height: size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Déjà un compte ? -"),
                  TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(color: kPrimaryColor),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/Login');
                      },
                      child: const Text("Se connecter")),
                ],
              ),
              SizedBox(height: size.height * 0.5),
            ],
          ),
        ),
      ),
    );
  }
}


