import 'package:app_order/pages/stf/login/login_page.dart';
import 'package:app_order/pages/stl/custom_button.dart';
import 'package:app_order/pages/stl/custom_text_field.dart';
import 'package:app_order/provider/auth_provider.dart';
import 'package:app_order/theme/app_assets.dart';
import 'package:app_order/theme/app_color.dart';
import 'package:app_order/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  late AuthencationProvider _auth;
  @override
  Widget build(BuildContext context) {
    double sizeH = MediaQuery.of(context).size.height;
    double sizeW = MediaQuery.of(context).size.height;
    _auth = Provider.of<AuthencationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.kBG,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(AppAssets.iconBack)),
        title: const Align(
          child: Padding(
            padding: EdgeInsets.only(right: 40),
            child: Text(
              "Forgot Password",
              style: AppStyle.h3,
            ),
          ),
          alignment: Alignment.center,
        ),
      ),
      body: SizedBox(
        height: sizeH,
        width: sizeW,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset(
                AppAssets.logoFP,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Please enter your email below to receive your password reset instructions.",
                style: AppStyle.h3,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              CustomTextField(
                controller: emailController,
                check: false,
                text: "Email",
              ),
              const SizedBox(
                height: 40,
              ),
              CustomButton(
                height: sizeH * 0.07,
                width: sizeW,
                func: () async {
                  if (emailController.text.isNotEmpty) {
                    String res =
                        await _auth.forgotPassword(email: emailController.text);
                    if (res == "success") {
                      showSnackBar(
                          "Gửi biểu mẫu thành công! Hãy kiểm tra gmail của bạn.",
                          context,
                          true);
                      Navigator.pop(context);
                    } else {
                      showSnackBar(res, context, false);
                    }
                  } else {
                    showSnackBar(
                        "Bạn cần điền đầy đủ thông tin", context, false);
                  }
                },
                text: "SEND REQUEST",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
