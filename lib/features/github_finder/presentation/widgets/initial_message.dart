import 'package:flutter/material.dart';

class InitialMessage extends StatelessWidget {
  final String text;

  const InitialMessage(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}
