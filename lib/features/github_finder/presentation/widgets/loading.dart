import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.grey),
        ),
      ),
    );
  }
}
