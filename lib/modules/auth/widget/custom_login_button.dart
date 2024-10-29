import 'package:flutter/material.dart';

class CustomLoginButton {
  final VoidCallback onClick;

  CustomLoginButton({required this.onClick});

  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      child: const Text('Login'),
    );
  }
}
