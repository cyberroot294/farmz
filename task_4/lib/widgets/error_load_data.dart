import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/lottie/40806-error-404.json",
            animate: true,
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.4,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Failed to load Data",
            style: Theme.of(context).primaryTextTheme.headline1,
          ),
        ],
      ),
    );
  }
}
