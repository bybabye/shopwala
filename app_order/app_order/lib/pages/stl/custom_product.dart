import 'package:app_order/models.dart/post.dart';

import 'package:flutter/material.dart';

class CustomProduct extends StatelessWidget {
  const CustomProduct({
    Key? key,
    required this.post,
  }) : super(key: key);
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(post.name),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
