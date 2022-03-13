import 'package:flutter/material.dart';
import 'package:left_over/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function() press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    @required this.press,
  }) : super(key: key);

  //use case tarihler yaz üstüne - user name i böyle girdim - yanlış girdim output doğru çıktı. use case yaz yüzdeleri ver - use case göster 

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don’t have an Account ? " : "Already have an Account ? ",
          style: const TextStyle(color: lightBlueBlockColor),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up" : "Log In",
            style: const TextStyle(
              color: selectedBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
