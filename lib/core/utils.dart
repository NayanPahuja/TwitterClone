 import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String content){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(content),
      ));

}

String getInitials(String email){
  return email.split('@')[0].toUpperCase();
}
