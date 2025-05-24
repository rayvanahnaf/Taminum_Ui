
import 'package:flutter/material.dart';

class OrderField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const OrderField({
    Key? key,
    required this.labelText,
    required this.controller,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          labelText: 'Customer name',
          labelStyle: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}