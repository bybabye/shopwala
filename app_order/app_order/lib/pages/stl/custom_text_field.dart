import 'package:app_order/theme/app_color.dart';
import 'package:app_order/theme/app_style.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.check,
    required this.text,
    required this.controller,
  }) : super(key: key);

  final String text;
  final bool check;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: check,
      decoration: InputDecoration(
        labelText: text,
        labelStyle: AppStyle.h5.copyWith(color: AppColor.kText),
      ),
      style: AppStyle.h4,
    );
  }
}
