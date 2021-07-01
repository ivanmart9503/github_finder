import 'package:flutter/material.dart';

class FailureMessage extends StatelessWidget {
  final String text;

  const FailureMessage(this.text);

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
