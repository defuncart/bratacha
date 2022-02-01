import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    required this.buttonText,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String buttonText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => Theme.of(context).colorScheme.secondary),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
