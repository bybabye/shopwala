import 'package:app_order/pages/stf/login/login_page.dart';
import 'package:app_order/pages/stl/custom_button.dart';
import 'package:app_order/theme/app_assets.dart';
import 'package:app_order/theme/app_color.dart';
import 'package:app_order/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: const HomePage(),
      duration: 3000,
      imageSize: 130,
      imageSrc: AppAssets.logo,
      text: "Eating healthy and happy!",
      textType: TextType.TyperAnimatedText,
      textStyle: AppStyle.h4,
      backgroundColor: AppColor.kBG,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _sizeH;
  late double _sizeW;
  @override
  Widget build(BuildContext context) {
    _sizeH = MediaQuery.of(context).size.height;
    _sizeW = MediaQuery.of(context).size.width;
    final controller = PageController();

    final List<Widget> pages = [
      page("Fresh ingredients for tasty, home-cooked dinners.", false),
      page("Delivery 7 days a week. Pause or skip anytime.", false),
      page("Cook perfect meals with professional tips.", false),
      page("Tasty home cooked meals, without all the fuss.", true),
    ];

    return Scaffold(
        body: ListView.builder(
      scrollDirection: Axis.horizontal,
      controller: controller,
      itemCount: pages.length,
      itemBuilder: (context, index) {
        return SizedBox(
          height: _sizeH,
          width: _sizeW,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pages[index],
              const SizedBox(
                height: 20,
              ),
              SmoothPageIndicator(
                controller: controller,
                count: pages.length,
                effect: const WormEffect(
                  dotHeight: 5,
                  dotWidth: 15,
                  type: WormType.thin,
                  dotColor: AppColor.kOne,
                  activeDotColor: AppColor.kTwo,
                  // strokeWidth: 5,
                ),
              ),
            ],
          ),
        );
      },
    ));
  }

  Widget page(String text, bool check) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: check == false
          ? Text(
              text,
              style: AppStyle.h3,
              textAlign: TextAlign.center,
            )
          : Column(
              children: [
                Text(
                  text,
                  style: AppStyle.h3,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  height: _sizeH * 0.06,
                  width: _sizeW * 0.6,
                  func: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const LoginPage(),
                      ),
                    );
                  },
                  text: "GET STARTED",
                )
              ],
            ),
    );
  }
}
