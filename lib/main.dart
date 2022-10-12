import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servo_app/connection.dart';
import 'package:servo_app/led.dart';
import 'package:provider/provider.dart';
import 'google_login_configs_provider/google_sign_in_configs_app.dart';
import 'google_login_configs_provider/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      title: "SmartCar",

        debugShowCheckedModeBanner: false,
        home:  FirstApp())
     );
}


class FirstApp extends StatefulWidget {
  const FirstApp({Key key}) : super(key: key);

  @override
  State<FirstApp> createState() => _FirstAppState();
}

class _FirstAppState extends State<FirstApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return MyApp();
            } else {
              return const LoginPage();
            }
          },
        ),
      ),
    );
  }
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Car',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: FutureBuilder(
        future: FlutterBluetoothSerial.instance.requestEnable(),
        builder: (context, future) {
          if (future.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Container(
                height: double.infinity,
                child: Center(
                  child: Icon(
                    Icons.bluetooth_disabled,
                    size: 200.0,
                    color: Colors.black12,
                  ),
                ),
              ),
            );
          } else {
            return Home();
          }
        },
        // child: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser;
    return SafeArea(
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: ClipOval(
                            child: Image.network(user.photoURL.toString())),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Text(
                          "Welcome !!!",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Center(
                                  child: Text(
                                    user.displayName.toString(),
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.montserrat(
                                      color: Colors.greenAccent.shade700,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.74,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),

                    ],
                  ),
                ),
              ],
            ),
          ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color:Colors.black),
        title: Text('Connection', style: GoogleFonts.montserrat(color:Colors.black)),
        actions: [
          IconButton( onPressed: () {
            final provider =
            Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.logout();
          }, icon:Icon(Icons.logout_rounded))
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Colors.black87,

            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/login_bg.gif')
            )
        ),
        child: SelectBondedDevicePage(
          onChatPage: (device1) {
            BluetoothDevice device = device1;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ChatPage(server: device);
                },
              ),
            );
          },
        ),
      ),
    ));
  }
}
