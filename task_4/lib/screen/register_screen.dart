import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_4/widgets/curve_background.dart';
import 'package:task_4/widgets/input_form.dart';
import 'package:http/http.dart' as http;
import 'package:task_4/widgets/lottie_cow.dart';

import '../constant.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool loading = false;

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _registerForm = GlobalKey<FormState>();
  String nEmail;
  String nPassword;
  String nUsername;

  void checkForm() {
    setState(() {
      print("username $nUsername");
      print("password $nPassword");
      print("email $nEmail");
      print("email from controller ${emailController.text}");
      final _form = _registerForm.currentState;
      _form.save();
      submitDataRegister(nEmail, nUsername, nPassword);
    });
  }

  submitDataRegister(String nEmail, String nUsername, String nPassword) async {
    print("haha");
    final response = await http.post(endpointApi + "register.php", body: {
      "email": this.nEmail,
      "username": this.nUsername,
      "password": this.nPassword,
    });
    setState(() {
      loading = false;
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      int value = data["value"];
      String message = data["message"];
      print(data);

      if (value == 1) {
        return CoolAlert.show(
          animType: CoolAlertAnimType.scale,
          context: context,
          type: CoolAlertType.success,
          title: message,
          text: "Silahkan login terlebih dahulu",
        );
      } else if (value == 2) {
        return CoolAlert.show(
          animType: CoolAlertAnimType.scale,
          context: context,
          type: CoolAlertType.warning,
          title: "Terjadi kesalahan",
          text: message,
          lottieAsset: "assets/lottie/51101-error.json",
        );
      } else {
        print(message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                loading
                    ? LottieCow(
                        color: Colors.transparent,
                      )
                    : Container(
                        child: ListView(
                          children: [
                            Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 120),
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
                              key: _registerForm,
                              child: Column(
                                children: [
                                  InputForm(
                                    hintText: "Email",
                                    prefixIcon: Icon(
                                      Icons.mail_outline,
                                      color: Colors.grey,
                                    ),
                                    controller: this.emailController,
                                    onSaved: (email) {
                                      String a = email;
                                      setState(() {
                                        nEmail = a;
                                      });
                                      return a;
                                    },
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  InputForm(
                                    hintText: "Username",
                                    prefixIcon: Icon(
                                      Icons.person_outline,
                                      color: Colors.grey,
                                    ),
                                    controller: this.usernameController,
                                    onSaved: (value) {
                                      var a = value;
                                      setState(() {
                                        nUsername = a;
                                      });
                                      return a;
                                    },
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
                                    controller: this.passwordController,
                                    onSaved: (value) {
                                      return nPassword = value;
                                    },
                                    obscureText: true,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.15,
                                    ),
                                    child: RaisedButton(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      onPressed: () {
                                        if (emailController.text.isEmpty ||
                                            usernameController.text.isEmpty ||
                                            passwordController.text.isEmpty) {
                                          CoolAlert.show(
                                            animType: CoolAlertAnimType.scale,
                                            context: context,
                                            type: CoolAlertType.warning,
                                            text:
                                                "Harap isi semua field yang ada",
                                            title: "Validation Error",
                                            lottieAsset:
                                                "assets/lottie/51101-error.json",
                                          );
                                        } else if (usernameController
                                                .text.length <
                                            6) {
                                          CoolAlert.show(
                                            animType: CoolAlertAnimType.scale,
                                            context: context,
                                            type: CoolAlertType.warning,
                                            text:
                                                "Harap masukkan username dengan panjang setidaknya 6 karakter",
                                            title: "Validation Error",
                                            lottieAsset:
                                                "assets/lottie/51101-error.json",
                                          );
                                        } else if (passwordController
                                                .text.length <
                                            6) {
                                          CoolAlert.show(
                                            animType: CoolAlertAnimType.scale,
                                            context: context,
                                            type: CoolAlertType.warning,
                                            text:
                                                "Harap masukkan password dengan panjang setidaknya 6 karakter",
                                            title: "Validation Error",
                                            lottieAsset:
                                                "assets/lottie/51101-error.json",
                                          );
                                        } else {
                                          setState(() {
                                            loading = true;
                                            checkForm();
                                          });
                                        }
                                      },
                                      color: Color(0xFF6A75CE),
                                      child: Text(
                                        "Daftar",
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
                                        text: "Sudah punya akun ?  ",
                                        style: TextStyle(
                                          shadows: [
                                            Shadow(
                                              color: Colors.black38,
                                              offset: Offset(0, -4),
                                            )
                                          ],
                                          color: Colors.transparent,
                                          fontSize: 14,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Login Disini",
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
                                          decoration: TextDecoration.underline,
                                          decorationThickness: 1.4,
                                          decorationColor: Colors.black45,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            print("popped");
                                            Navigator.pop(context);
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
  }
}
