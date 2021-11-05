import 'package:ages_app/Module/constants.dart';
import 'package:flutter/material.dart';
import 'package:ages_app/Users/User.dart';
import 'package:ages_app/Module/utils.dart' as utils;
import 'package:google_fonts/google_fonts.dart';

class body extends StatelessWidget {
  const body({
    Key? key,
    required this.size,
    required this.user,
  }) : super(key: key);

  final Size size;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          SizedBox(height: size.height * 0.2),
          Text("AGES",
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 55,
                    color: Colors.deepPurple.shade500),
              )), //
          SizedBox(height: size.height * 0.02),
          Text("Bonjour " + user.getUsername(),
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.deepPurple.shade500),
              )), //
          SizedBox(height: size.height * 0.05),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: kHighLightSecondaryTextColor,
                child: new InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/Articles');
                  },
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 50, horizontal: 44),
                      child: Text("Articles ",
                          style: utils.CustomTextStyle.HeaderCardTextFont(
                              context))),
                ),
              ),
              Card(
                color: kHighLightSecondaryTextColor,
                child: new InkWell(
                    onTap: () {
                      
                      Navigator.pushNamed(context, '/Commande');
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                      child: Text("Commandes",
                          style: utils.CustomTextStyle.HeaderCardTextFont(
                              context)),
                    )),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Card(
              color: kHighLightSecondaryTextColor,
              child: new InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/Profile');
                },
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50, horizontal: 51),
                    child: Text("Profile",
                        style:
                            utils.CustomTextStyle.HeaderCardTextFont(context))),
              ),
            ),
            user.getRole() == "admin"
                ? Card(
                    color: kHighLightSecondaryTextColor,
                    child: new InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/AdminPannel');
                      },
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 50, horizontal: 22),
                          child: Text("Panneau Admin",
                              style: utils.CustomTextStyle.HeaderCardTextFont(
                                  context))),
                    ),
                  )
                : user.getRole() == "User"
                ? Card(
                    color: kHighLightSecondaryTextColor,
                    child: new InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/LocalisationPage');
                      },
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 50, horizontal: 33),
                          child: Text("Localisation",
                              style: utils.CustomTextStyle.HeaderCardTextFont(
                                  context))),
                    ),
                  ): Card(
                    color: Colors.transparent,
                    child: new InkWell(
                      child: Padding(
                          padding: EdgeInsets.all(53),
                          child: Text("            ")),
                    ),
                  ),
          ]),
        ],
      ),
    );
  }
}
