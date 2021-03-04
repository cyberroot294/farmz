import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:task_4/screen/account.dart';
import 'all_news.dart';
import 'dictionary.dart';
import 'gallery.dart';
import 'news.dart';

class Home extends StatelessWidget with ChangeNotifier {
  int _selectedIndex = 0;

  void changeSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  List<Widget> _widgetOptions = <Widget>[
    News(),
    AllNews(),
    Gallery(),
    Dictionary(),
    Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Home>(
      builder: (context, child) => Scaffold(
        body: SafeArea(
          child: Container(
            child: Provider.of<Home>(context)._widgetOptions.elementAt(
                  Provider.of<Home>(context, listen: false)._selectedIndex,
                ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300],
                hoverColor: Colors.grey[100],
                gap: 4,
                activeColor: Colors.black,
                iconSize: 26,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100],
                tabs: [
                  GButton(
                    icon: Icons.home_outlined,
                    backgroundColor: Color(0xFFD4334C),
                    iconActiveColor: Colors.white,
                    text: 'Home',
                    textColor: Colors.white,
                  ),
                  GButton(
                    icon: Icons.list_outlined,
                    backgroundColor: Color(0xFFD4334C),
                    iconActiveColor: Colors.white,
                    text: 'News',
                    textColor: Colors.white,
                  ),
                  GButton(
                    icon: Icons.photo_album_outlined,
                    backgroundColor: Color(0xFFD4334C),
                    iconActiveColor: Colors.white,
                    text: 'Gallery',
                    textColor: Colors.white,
                  ),
                  GButton(
                    icon: Icons.book_outlined,
                    backgroundColor: Color(0xFFD4334C),
                    iconActiveColor: Colors.white,
                    text: 'Dictionary',
                    textColor: Colors.white,
                  ),
                  GButton(
                    icon: Icons.person_outline_rounded,
                    backgroundColor: Color(0xFFD4334C),
                    iconActiveColor: Colors.white,
                    text: 'Profile',
                    textColor: Colors.white,
                  ),
                ],
                selectedIndex:
                    Provider.of<Home>(context, listen: true)._selectedIndex,
                onTabChange: (index) {
                  Provider.of<Home>(context, listen: false)
                      .changeSelectedIndex(index);
                },
              ),
            ),
          ),
        ),
      ),
      create: (_) => Home(),
    );
  }
}
