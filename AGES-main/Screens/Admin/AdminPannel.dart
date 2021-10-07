
import 'package:ages_app/Module/MyProvider.dart';
import 'package:ages_app/Module/utils.dart' as utils;
import 'package:ages_app/Users/User.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../Module/custom_appbar.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    User user = context.read<MyProvider>().getUser();
    return Scaffold(
      appBar: CustomAppBar(false, "Articles"),
      body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment(-1, 0),
        end: Alignment(-0.5, -0.7),
        colors: [
          Colors.blue.shade400,
          Colors.red.shade200,
        ],
      )),
      child: Column(
        children: <Widget>[
          
          SizedBox(height: size.height * 0.1),
          Text("AGES",
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 55,
                    color: Colors.deepPurple.shade500),
              )), //
          SizedBox(height: size.height * 0.01),
          Text("Admin pannel",
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.redAccent.shade400),
              )), //
          SizedBox(height: size.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Colors.red,
                child: new InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, '/AjouterArticle');
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50,horizontal :23),
                    child: Text("Ajouter Article ",style: utils.CustomTextStyle.HeaderCardTextFont(context))
                    ),
                ),
              ),
              Card(
                color: Colors.blue,
                child: new InkWell(
                  onTap: (){
                    //Navigator.pushNamed(context, '/Commande');;
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50,horizontal :30),
                    child: Text("Commandes", style: utils.CustomTextStyle.HeaderCardTextFont(context)),)
                    ),
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Colors.green,
                child: new InkWell(
                  onTap: (){},
                  child: Padding(
                    padding:EdgeInsets.symmetric(vertical: 50,horizontal :51),
                    child: Text("Profile",style: utils.CustomTextStyle.HeaderCardTextFont(context))
                    ),
                ),
            ),
            
              user.getRole()=="User" ? 
              Card(
                color: Colors.transparent,
                child: new InkWell(
                  child: Padding(
                    padding: EdgeInsets.all(53),
                    child: Text("            ")
                    ),
                ),
              ) :
              Card(
                color: Colors.deepOrange,
                child: new InkWell(
                  onTap: (){},
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50,horizontal :22),
                    child: Text("Panneau Admin",style: utils.CustomTextStyle.HeaderCardTextFont(context))
                    ),
                ),
              ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Colors.red,
                child: new InkWell(
                  onTap: (){
                    //Navigator.pushNamed(context, '/Articles');
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50,horizontal :23),
                    child: Text("Ajouter Article ",style: utils.CustomTextStyle.HeaderCardTextFont(context))
                    ),
                ),
              ),
              Card(
                color: Colors.pinkAccent,
                child: new InkWell(
                  onTap: (){
                    //Navigator.pushNamed(context, '/Commande');;
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50,horizontal :30),
                    child: Text("Commandes", style: utils.CustomTextStyle.HeaderCardTextFont(context)),)
                    ),
                ),
            ],
          ),
        ],
      ),
    )
      );
  }
}