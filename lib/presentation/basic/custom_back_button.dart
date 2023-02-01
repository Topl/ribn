import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final Function() onPressed;
  const CustomBackButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        size: 30,
        color: Colors.white,
      ),
      onPressed: onPressed,
      padding: EdgeInsets.all(0),
    );
  }
}
