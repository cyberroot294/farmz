import 'dart:convert';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_4/screen/home.dart';
import 'package:task_4/screen/login_screen.dart';
import 'package:task_4/screen/register_screen.dart';
import 'package:http/http.dart' as http;

import 'constant.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAuthenticated = false;

  set isAuthenticated(bool val) {
    setState(() {
      _isAuthenticated = val;
    });
  }

  bool get isAuthenticated {
    return this._isAuthenticated;
  }

  @override
  void initState() {
    // Provider.of<Profile>(context, listen: false).getDataPref();
    getDataPref();
    super.initState();
  }

  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // int nvalue = sharedPreferences.getInt("value");
    bool nIsAuthenticated =
        sharedPreferences.getBool("isAuthenticated") ?? false;
    setState(() {
      this.isAuthenticated = nIsAuthenticated;
    });
    print(nIsAuthenticated);
    print("data loaded");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        // "/home": (context) => Home(),
      },
      theme: ThemeData(
        primaryColor: Colors.white,
        primaryTextTheme: TextTheme(
          headline1: TextStyle(
            fontFamily: "RedHat",
            color: Color(0xFF161616),
            fontWeight: FontWeight.w700,
            fontSize: 28,
          ),
          headline3: TextStyle(
            fontFamily: "RedHat",
            color: Color(0xFF161616),
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
          headline2: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontFamily: "RedHat",
          ),
          headline6: TextStyle(
            fontSize: 14,
            fontFamily: "RedHat",
            fontWeight: FontWeight.w700,
          ),
          subtitle1: TextStyle(
            fontSize: 11,
            fontFamily: "RedHat",
            fontWeight: FontWeight.w700,
            color: Color(0xFFA4A4A4),
          ),
          subtitle2: TextStyle(
            fontSize: 18,
            fontFamily: "RedHat",
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider<Profile>(
        builder: (context, child) {
          return Consumer<Profile>(
            builder: (context, profile, child) =>
                this.isAuthenticated ? Home() : LoginScreen(),
          );
        },
        create: (_) => Profile(),
      ),
    );
  }
}

class Profile extends ChangeNotifier {
  bool _isAuthenticated = false;

  bool get isAuthenticated {
    notifyListeners();
    return this._isAuthenticated;
  }

  set isAuthenticated(bool newVal) {
    this._isAuthenticated = newVal;
    notifyListeners();
  }

  void submitDataLogin(BuildContext context, String nEmail, nPassword) async {
    final response = await http.post(endpointApi + "login.php", body: {
      "email_or_username": nEmail,
      "password": nPassword,
    });

    Provider.of<Profile>(context, listen: false).loading = false;

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int value = data["value"];
      String message = data["message"];
      print(data);

      String dataUsername = data["username"];
      String dataEmail = data["email"];
      notifyListeners();

      if (value == 1) {
        Provider.of<Profile>(context, listen: false).isAuthenticated = true;
        saveDataPref(value, dataUsername, dataEmail, _isAuthenticated);
      } else if (value == 2) {
        return CoolAlert.show(
          animType: CoolAlertAnimType.scale,
          context: context,
          type: CoolAlertType.warning,
          text: "Harap masukkan email atau username dan password dengan benar",
          title: "Credentials Salah",
          lottieAsset: "assets/lottie/51101-error.json",
        );
      } else {
        print(message);
      }
    }
  }

  saveDataPref(
      int value, String dUsername, String dEmail, bool isAuthenticated) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("username", dUsername);
    sharedPreferences.setString("email", dEmail);
    sharedPreferences.setInt("value", value);
    if (value == 1) {
      sharedPreferences.setBool("isAuthenticated", isAuthenticated);
    } else {
      sharedPreferences.setBool("isAuthenticated", isAuthenticated);
    }
    notifyListeners();
  }

  bool _loading = false;

  set loading(bool newVal) {
    _loading = newVal;
    notifyListeners();
  }

  bool get loading {
    return _loading;
  }
}
