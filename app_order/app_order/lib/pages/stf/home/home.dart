import 'dart:async';

import 'package:app_order/models.dart/post.dart';

import 'package:app_order/pages/stf/home/print_product.dart';
import 'package:app_order/pages/stf/home/product.dart';

import 'package:app_order/provider/auth_provider.dart';
import 'package:app_order/theme/app_assets.dart';
import 'package:app_order/theme/app_color.dart';
import 'package:app_order/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:intl/intl.dart' as intl;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controller = TextEditingController();
  final PageController _pageController =
      PageController(viewportFraction: 0.9, initialPage: 1);

  late AuthencationProvider auth;
  late double sizeH;
  late double sizeW;
  int currentIndex = 0;
  late Timer _timer;

  List<String> items = [
    'shoes',
    'shirt',
    'pants',
    'glasses',
    'technological',
    'foods',
    'book',
    'unknown',
  ];
  List<String> icons = [
    AppAssets.shoes,
    AppAssets.shirt,
    AppAssets.pant,
    AppAssets.glasses,
    AppAssets.tech,
    AppAssets.food,
    AppAssets.book,
    AppAssets.shoes,
  ];
  List<String> image = [
    AppAssets.hinh1,
    AppAssets.hinh2,
    AppAssets.hinh3,
    AppAssets.hinh4,
    AppAssets.hinh5,
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (currentIndex < image.length) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    auth = Provider.of<AuthencationProvider>(context);
    sizeH = MediaQuery.of(context).size.height; // lay size height man hinh
    sizeW = MediaQuery.of(context).size.width; // lay size height man hinh
    return Scaffold(
      backgroundColor: AppColor.kButtonFirstColor,
      body: FutureBuilder(
        future: auth.getAllPost(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  elevation: 0,
                  backgroundColor: AppColor.kButtonFirstColor,
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      child: Image.asset(
                        AppAssets.fill,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  title: Text(
                    "WalaShop",
                    style: AppStyle.h1.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      shadows: [
                        const Shadow(
                          offset: Offset(3, 3),
                          blurRadius: 2.0,
                          color: AppColor.kButtonSecondColor,
                        ),
                      ],
                    ),
                  ),
                  flexibleSpace: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        child: Column(
                          children: [
                            SizedBox(
                              height: sizeH * 0.08,
                              width: sizeW * 0.9,
                              child: TextField(
                                controller: controller,
                                obscureText: false,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white.withOpacity(.3),
                                        width: 1.0),
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  labelText: "Bạn Muốn Mua thứ gì...",
                                  labelStyle:
                                      AppStyle.h5.copyWith(color: Colors.white),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: sizeW),
                                  ),
                                ),
                                style: AppStyle.h4,
                              ),
                            ),
                            SizedBox(
                              height: sizeH * 0.1,
                              width: sizeW,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: items.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => PrintProduct(
                                              text: items[index],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: Image.asset(
                                                icons[index],
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            items[index],
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  expandedHeight: sizeH * 0.25,
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      listSale(),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: sizeH * 0.2,
                        child: Stack(
                          children: [
                            Positioned(
                              height: 40,
                              width: sizeW,
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                              ),
                            ),
                            saleCard(),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.grey[200],
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0,
                            childAspectRatio: 1 / 1.4,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            int value = int.parse(snapshot.data![index].price);
                            final price = intl.NumberFormat.decimalPattern()
                                .format(value);
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        Product(post: snapshot.data![index]),
                                  ),
                                );
                              },
                              child: Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: sizeH * 0.2,
                                        width: sizeW * 0.5,
                                        child: Image.network(
                                          snapshot.data![index].image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          snapshot.data![index].name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Đã bán : ${snapshot.data![index].sellId.length}',
                                          style: AppStyle.h4.copyWith(
                                            color: AppColor.kOne,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          // ignore: unnecessary_brace_in_string_interps
                                          '${price} đ',
                                          style: AppStyle.h5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else {
            return const Center(
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }

  Widget listSale() {
    return SizedBox(
      height: sizeH * 0.2,
      width: sizeW,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            children: image
                .map((e) => Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: sizeH * 0.2,
                            width: sizeW,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2.0,
                                  offset: Offset(5, 5),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                e,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
                .toList(),
          ),
          Positioned(
            left: sizeW * 0.09,
            bottom: sizeH * 0.02,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: image.length,
              effect: const ExpandingDotsEffect(
                expansionFactor: 4,
                dotWidth: 8,
                dotHeight: 8,
                spacing: 4,
                activeDotColor: Colors.white,
              ),
              onDotClicked: (index) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget saleCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: sizeH * 0.1,
            width: sizeW * 1 / 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                AppAssets.sale,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: sizeH * 0.16,
            width: sizeW * 2 / 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                AppAssets.sale1,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: sizeH * 0.1,
            width: sizeW * 1 / 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                AppAssets.sale2,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
