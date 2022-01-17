import 'package:app_order/pages/stf/home/home_screen.dart';
import 'package:app_order/pages/stf/login/forgot_password.dart';
import 'package:app_order/pages/stf/login/sign_up_page.dart';

import 'package:app_order/pages/stl/custom_button.dart';
import 'package:app_order/pages/stl/custom_text_field.dart';
import 'package:app_order/provider/auth_provider.dart';
import 'package:app_order/theme/app_assets.dart';
import 'package:app_order/theme/app_color.dart';
import 'package:app_order/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  late AuthencationProvider _auth;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double sizeH = MediaQuery.of(context).size.height;
    double sizeW = MediaQuery.of(context).size.height;
    _auth = Provider.of<AuthencationProvider>(context);
    return Scaffold(
      body: SizedBox(
        height: sizeH,
        width: sizeW,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                AppAssets.logoTwo,
                fit: BoxFit.cover,
              ),
              const Text("Welcome Back!", style: AppStyle.h3),
              CustomTextField(
                controller: emailController,
                check: false,
                text: "Email",
              ),
              CustomTextField(
                controller: passController,
                check: true,
                text: "Password",
              ),
              CustomButton(
                height: sizeH * 0.07,
                width: sizeW,
                func: () async {
                  if (emailController.text.isNotEmpty ||
                      passController.text.isNotEmpty) {
                    String res = await _auth.loginUser(
                      email: emailController.text,
                      password: passController.text,
                    );
                    if (res == "success") {
                      showSnackBar("Đăng nhập thành công.!", context, true);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const HomeScreen(),
                        ),
                      );
                    } else {
                      showSnackBar(res, context, false);
                    }
                  } else {
                    showSnackBar(
                        "Bạn cần điền đầy đủ thông tin", context, false);
                  }
                },
                text: "LOGIN",
              ),
              InkWell(
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ForgotPassword())),
                child: Text(
                  "Forgot Password?",
                  style: AppStyle.h4.copyWith(color: AppColor.kTwo),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: AppStyle.h4.copyWith(color: AppColor.kOne),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Sign Up",
                      style: AppStyle.h4.copyWith(color: AppColor.kTwo),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

showSnackBar(String content, BuildContext context, bool check) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(content),
        backgroundColor: check ? Colors.green : Colors.red,
      ),
    );
}
