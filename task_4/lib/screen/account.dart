import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_4/main.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String _email = "";
  String _username = "";

  @override
  void initState() {
    _loadDataPref();
    super.initState();
  }

  _loadDataPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("data loaded");
    setState(() {
      _email = prefs.getString('email');
      _username = prefs.getString('username');
    });
  }

  signOut() async {
    Provider.of<Profile>(context, listen: false).isAuthenticated = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://st4.depositphotos.com/4329009/19956/v/600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "Username : " + _username,
                style: GoogleFonts.montserrat(fontSize: 24),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15).copyWith(bottom: 30),
              child: Text(
                "Email : " + _email,
                style: GoogleFonts.montserrat(fontSize: 18),
              ),
            ),
            Container(
              child: RaisedButton(
                onPressed: () {
                  signOut();
                },
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Color(0xFFD4334C),
                child: Text(
                  "Sign Out",
                  style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
