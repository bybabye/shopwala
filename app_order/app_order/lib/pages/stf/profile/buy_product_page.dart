import 'package:app_order/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuyProductPage extends StatefulWidget {
  const BuyProductPage({Key? key}) : super(key: key);

  @override
  _BuyProductPageState createState() => _BuyProductPageState();
}

class _BuyProductPageState extends State<BuyProductPage> {
  late AuthencationProvider auth;

  @override
  Widget build(BuildContext context) {
    auth = Provider.of<AuthencationProvider>(context);
    return Scaffold();
  }
}
