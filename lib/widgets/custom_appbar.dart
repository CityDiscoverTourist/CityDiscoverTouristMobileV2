import 'package:flutter/material.dart';
import 'package:travel_hour/widgets/rounded_button.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Congratulations',
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

