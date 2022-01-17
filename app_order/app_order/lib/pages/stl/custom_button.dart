import 'package:app_order/theme/app_color.dart';
import 'package:app_order/theme/app_style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.height,
    required this.width,
    required this.func,
    required this.text,
  }) : super(key: key);
  final double height;
  final double width;
  final Function() func;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: SizedBox(
        height: height,
        width: width,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [AppColor.kButtonFirstColor, AppColor.kButtonSecondColor],
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: AppStyle.h4.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
