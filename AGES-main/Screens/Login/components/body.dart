
import 'package:ages_app/Auths/components/rounded_input_field.dart';
import 'package:ages_app/Auths/components/rounded_password_field.dart';
import 'package:ages_app/Commande/commande.dart';
import 'package:ages_app/Module/MyProvider.dart';
import 'package:provider/provider.dart';
import 'package:ages_app/Users/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:ages_app/Module/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Map<String,String>_data = {'username': "", 'pw': ""};

    final pwController = TextEditingController();
    final UNController = TextEditingController();
    Size size = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment(-1, -1),
          end: Alignment(0, 0),
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
                  "Connection",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  key: new Key("username"),
                  hintText: "Nom d'utilisateur",
                  controller: UNController,
                  onChanged: (value) =>_data['username'] = value,
                  icon: Icons.person ,
                ),
                RoundedPasswordField(
                  controller: pwController,
                  text: "Mot de passe",
                  onChanged: (value) =>_data['pw'] = value,
                ),
                context.watch<MyProvider>().loading ? CupertinoActivityIndicator() :
                ElevatedButton(
                    onPressed: () async {
                       try{
                        try{
                          context.read<MyProvider>().setLoading(true);
                          context.read<MyProvider>().setUser(await User.AuthenticateUser('${_data['username']}', '${_data['pw']}'));
                        }
                        catch(e){
                          final snackBar = SnackBar(content: Text('$e'), backgroundColor: Colors.red,);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        }
                      }
                      finally{
                        context.read<MyProvider>().setLoading(false);
                      }
                     
                    },
                    child: Text("Connection")),
                SizedBox(height: size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: [
                        Text(
                          "Pas encore de compte ? -",
                          style: TextStyle(
                            fontSize: 16,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1
                              ..color = kPurple,
                          ),
                        ),
                        Text(
                          "Pas encore de compte ? -",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(color: kPrimaryColor),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/Signup');
                        },
                        child: const Text("S'enregistrer")),
                  ],
                ),
                SizedBox(height: size.height * 0.5),
              ],
            ),
          ),
        ));
  }
}
