import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String Error;
  const ErrorText({super.key, required this.Error});


  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text(Error),
    );
  }
}

class ErrorPage extends StatelessWidget {
  final String Error;
  const ErrorPage({super.key, required this.Error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorText(Error: Error),
    );
  }
}
