import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class LottieCow extends StatelessWidget {
  final Color color;

  LottieCow({this.color = Colors.transparent});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: this.color,
        child: Lottie.asset(
          "assets/lottie/44991-a-fitness-cow.json",
          alignment: Alignment.center,
          animate: true,
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width * 0.5,
          repeat: true,
        ),
      ),
    );
  }
}
