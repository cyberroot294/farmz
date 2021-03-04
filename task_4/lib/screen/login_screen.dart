import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_4/widgets/curve_background.dart';
import 'package:task_4/widgets/input_form.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:task_4/main.dart';
import 'package:task_4/widgets/lottie_cow.dart';

import 'home.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String nEmail, nPassword;

  @override
  void initState() {
    super.initState();
    // getDataPref();
  }

  // getDataPref() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   int nvalue = sharedPreferences.getInt("value");

  //   setState(() {
  //     // _loginStatus = nvalue == 1 ? statusLogin.signIn : statusLogin.notSignIn;
  //   });
  //   print("data loaded");
  // }

  signOUt() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("value", null);
    // ignore: deprecated_member_use
    sharedPreferences.commit();
    setState(() {
      // _loginStatus = statusLogin.notSignIn;
    });
    print("logout from login screen tapped");
    // notifyListeners();
  }

  void checkForm() {
    final _form = _formKey.currentState;
    _form.save();
    Provider.of<Profile>(context, listen: false)
        .submitDataLogin(context, nEmail, nPassword);
    Provider.of<Profile>(context, listen: false).loading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<Profile>(context).isAuthenticated
        ? Home()
        : Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return SafeArea(
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: CustomPaint(
                          painter: CurvePainter1(),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: CustomPaint(
                          painter: CurvePainter2(),
                        ),
                      ),
                      Provider.of<Profile>(context, listen: false).loading
                          ? LottieCow(
                              color: Colors.transparent,
                            )
                          : Container(
                              child: ListView(
                                children: [
                                  Center(
                                    child: Container(
                                      margin: EdgeInsets.only(top: 150),
                                      child: Text(
                                        "FarmZ",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                          color: Color(0xFF444444),
                                          fontSize: 42,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1.7,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 50),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        InputForm(
                                          hintText: "Email atau Username",
                                          prefixIcon: Icon(
                                            Icons.person_outline,
                                            color: Colors.grey,
                                          ),
                                          controller: emailController,
                                          onSaved: (value) => nEmail = value,
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        InputForm(
                                          hintText: "Password",
                                          prefixIcon: Icon(
                                            Icons.lock_outline_rounded,
                                            color: Colors.grey,
                                          ),
                                          onSaved: (value) => nPassword = value,
                                          controller: passwordController,
                                          obscureText: true,
                                        ),
                                        SizedBox(
                                          height: 60,
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.15,
                                          ),
                                          child: RaisedButton(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 15),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            onPressed: () {
                                              if (emailController
                                                      .text.isEmpty ||
                                                  passwordController
                                                      .text.isEmpty) {
                                                CoolAlert.show(
                                                  animType:
                                                      CoolAlertAnimType.scale,
                                                  context: context,
                                                  type: CoolAlertType.warning,
                                                  text:
                                                      "Harap isi semua field yang ada !!!",
                                                  title: "Validation Error",
                                                  lottieAsset:
                                                      "assets/lottie/51101-error.json",
                                                );
                                              } else if (passwordController
                                                      .text.length <
                                                  6) {
                                                CoolAlert.show(
                                                  animType:
                                                      CoolAlertAnimType.scale,
                                                  context: context,
                                                  type: CoolAlertType.warning,
                                                  text:
                                                      "Password Terlalu Pendek",
                                                  title: "Validation Error",
                                                  lottieAsset:
                                                      "assets/lottie/51101-error.json",
                                                );
                                              } else {
                                                // return Provider.of<Profile>(context, listen: false).
                                                checkForm();
                                                setState(() {});
                                              }
                                            },
                                            color: Color(0xFF6A75CE),
                                            child: Text(
                                              "Login",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Center(
                                    child: Container(
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Belum punya akun ?  ",
                                              style: TextStyle(
                                                shadows: [
                                                  Shadow(
                                                    color: Colors.black38,
                                                    offset: Offset(0, -4),
                                                  )
                                                ],
                                                fontSize: 14,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "Daftar Disini",
                                              style: TextStyle(
                                                shadows: [
                                                  Shadow(
                                                    color: Colors.black45,
                                                    offset: Offset(0, -4),
                                                  )
                                                ],
                                                fontSize: 14,
                                                color: Colors.transparent,
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationThickness: 1.4,
                                                decorationColor: Colors.black45,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  print("Pushed");
                                                  Navigator.pushNamed(
                                                      context, "/register");
                                                },
                                            )
                                          ],
                                          style: TextStyle(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                );
              },
            ),
          );
    //
  }
}

// class LoginScreen extends StatelessWidget with ChangeNotifier {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   String nEmail, nPassword;
//   statusLogin _loginStatus = statusLogin.notSignIn;

//   void checkForm() {
//     final _form = _formKey.currentState;
//     // if (_form.validate()) {
//     _form.save();
//     submitDataLogin();
//     // }
//   }

//   void submitDataLogin() async {
//     final response =
//         await http.post("http://101.102.2.108/backend/login.php", body: {
//       "email_or_username": nEmail,
//       "password": nPassword,
//     });
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       int value = data["value"];
//       String message = data["message"];
//       print(data);

//       String dataUsername = data["username"];
//       String dataEmail = data["email"];

//       if (value == 1) {
//         // setState(() {
//         _loginStatus = statusLogin.signIn;
//         saveDataPref(value, dataUsername, dataEmail);
//         print(message);
//         // });
//       } else if (value == 2) {
//         return CoolAlert.show(
//           animType: CoolAlertAnimType.scale,
//           context: context,
//           type: CoolAlertType.warning,
//           text: "Harap masukkan email atau username dan password dengan benar",
//           title: "Credentials Salah",
//           lottieAsset: "assets/lottie/51101-error.json",
//         );
//       } else {
//         print(message);
//       }
//     }
//   }

//   saveDataPref(int value, String dUsername, String dEmail) async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     // setState(() {
//     sharedPreferences.setInt("value", value);
//     sharedPreferences.setString("username", dUsername);
//     sharedPreferences.setString("email", dEmail);
//     // });
//   }

//   // @override
//   // void initState() {
//   //   getDataPref();
//   //   super.initState();
//   // }

//   getDataPref() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     // setState(() {
//     int nvalue = sharedPreferences.getInt("value");
//     _loginStatus = nvalue == 1 ? statusLogin.signIn : statusLogin.notSignIn;
//     // });
//   }

//   signOUt() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     // setState(() {
//     sharedPreferences.setInt("value", null);
//     // ignore: deprecated_member_use
//     sharedPreferences.commit();
//     _loginStatus = statusLogin.notSignIn;
//     notifyListeners();
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     getDataPref();
//     switch (_loginStatus) {
//       case statusLogin.signIn:
//         return Account(
//           signOut: signOUt,
//         );
//         break;
//       default:
//         return Scaffold(
//           body: Builder(
//             builder: (BuildContext context) {
//               return SafeArea(
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height,
//                       child: CustomPaint(
//                         painter: CurvePainter1(),
//                       ),
//                     ),
//                     Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height,
//                       child: CustomPaint(
//                         painter: CurvePainter2(),
//                       ),
//                     ),
//                     Container(
//                       child: ListView(
//                         children: [
//                           Center(
//                             child: Container(
//                               margin: EdgeInsets.only(top: 90),
//                               child: Text(
//                                 "FarmZ",
//                                 textAlign: TextAlign.center,
//                                 style: GoogleFonts.montserrat(
//                                   color: Color(0xFF444444),
//                                   fontSize: 42,
//                                   fontWeight: FontWeight.w700,
//                                   letterSpacing: 1.7,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 50),
//                           Form(
//                             key: _formKey,
//                             child: Column(
//                               children: [
//                                 InputForm(
//                                   hintText: "Email atau Username",
//                                   prefixIcon: Icon(
//                                     Icons.person_outline,
//                                     color: Colors.grey,
//                                   ),
//                                   controller: emailController,
//                                   onSaved: (value) => nEmail = value,
//                                 ),
//                                 SizedBox(
//                                   height: 30,
//                                 ),
//                                 InputForm(
//                                   hintText: "Password",
//                                   prefixIcon: Icon(
//                                     Icons.lock_outline_rounded,
//                                     color: Colors.grey,
//                                   ),
//                                   onSaved: (value) => nPassword = value,
//                                   controller: passwordController,
//                                   obscureText: true,
//                                 ),
//                                 SizedBox(
//                                   height: 60,
//                                 ),
//                                 Container(
//                                   width: MediaQuery.of(context).size.width,
//                                   padding: EdgeInsets.symmetric(
//                                     horizontal:
//                                         MediaQuery.of(context).size.width *
//                                             0.15,
//                                   ),
//                                   child: RaisedButton(
//                                     padding: EdgeInsets.symmetric(vertical: 15),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(30),
//                                     ),
//                                     onPressed: () {
//                                       if (emailController.text.isEmpty ||
//                                           passwordController.text.isEmpty) {
//                                         CoolAlert.show(
//                                           animType: CoolAlertAnimType.scale,
//                                           context: context,
//                                           type: CoolAlertType.warning,
//                                           text:
//                                               "Harap isi semua field yang ada !!!",
//                                           title: "Validation Error",
//                                           lottieAsset:
//                                               "assets/lottie/51101-error.json",
//                                         );
//                                       } else if (passwordController
//                                               .text.length <
//                                           6) {
//                                         CoolAlert.show(
//                                           animType: CoolAlertAnimType.scale,
//                                           context: context,
//                                           type: CoolAlertType.warning,
//                                           text: "Password Terlalu Pendek",
//                                           title: "Validation Error",
//                                           lottieAsset:
//                                               "assets/lottie/51101-error.json",
//                                         );
//                                       } else {
//                                         // setState(() {
//                                         checkForm();
//                                         // });
//                                         notifyListeners();
//                                       }
//                                     },
//                                     color: Color(0xFF6A75CE),
//                                     child: Text(
//                                       "Login",
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 30,
//                           ),
//                           Center(
//                             child: Container(
//                               child: RichText(
//                                 text: TextSpan(
//                                   children: [
//                                     TextSpan(
//                                       text: "Belum punya akun ?  ",
//                                       style: TextStyle(
//                                         shadows: [
//                                           Shadow(
//                                             color: Colors.black38,
//                                             offset: Offset(0, -4),
//                                           )
//                                         ],
//                                         fontSize: 14,
//                                         color: Colors.transparent,
//                                       ),
//                                     ),
//                                     TextSpan(
//                                       text: "Daftar Disini",
//                                       style: TextStyle(
//                                         shadows: [
//                                           Shadow(
//                                             color: Colors.black45,
//                                             offset: Offset(0, -4),
//                                           )
//                                         ],
//                                         fontSize: 14,
//                                         color: Colors.transparent,
//                                         fontWeight: FontWeight.bold,
//                                         decoration: TextDecoration.underline,
//                                         decorationThickness: 1.4,
//                                         decorationColor: Colors.black45,
//                                       ),
//                                       recognizer: TapGestureRecognizer()
//                                         ..onTap = () {
//                                           print("Tapped");
//                                           Navigator.popAndPushNamed(
//                                               context, "/register");
//                                         },
//                                     )
//                                   ],
//                                   style: TextStyle(),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//         break;
//     }
//   }
// }
