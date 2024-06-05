import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInkwellButton extends StatelessWidget {
  final Widget nextPage;
  final String buttonText;

  const CustomInkwellButton({
    super.key,
    required this.nextPage,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (BuildContext context) => nextPage,
          ),
        );
      },
      child: Ink(
        height: 140,
        width: 140,
        decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
