import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'google_sign_in_configs_app.dart';

class GoogleSignInButtonWidget extends StatelessWidget {
  const GoogleSignInButtonWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Color color = Colors.green.shade500;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 60,
        width: size.width * 0.7,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: color.withAlpha(60),
              spreadRadius: 5,
              blurRadius: 10,
            ),
          ],
        ),
        child: OutlinedButton.icon(
          onPressed: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.login();
          },
          icon: FaIcon(
            FontAwesomeIcons.google,
            color:  Colors.white,
            size: 25,
          ),
          label: Text(' Sign In With Google ',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 18,

              )),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: color),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Color color = const Color(0xFFff9900);
    return Scaffold(
        body: Container(
            height:MediaQuery.of(context).size.height ,
            decoration: BoxDecoration(
              color: Colors.black87,

              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/login_bg.gif')
              )
            ),
            child: Center(
                child: Column(children: [
                     Container(
                padding: const EdgeInsets.only(top: 100, left: 0),
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.6,
                   width: MediaQuery.of(context).size.width * 0.6,
                    padding: const EdgeInsets.only(top: 0),
                    child: Image.asset(
                      'assets/ic_launcher.png',
                      scale: 1.0,
                    )),
              ),
                     Text(
                "Smart Car",
                style: GoogleFonts.dawningOfANewDay(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade500),
              ),
                     const SizedBox(
                height: 20,
              ),
                     const GoogleSignInButtonWidget(),
            ]))));
  }
}
