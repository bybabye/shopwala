import 'package:app_order/models.dart/post.dart';

import 'package:app_order/pages/stf/home/product.dart';
import 'package:app_order/provider/auth_provider.dart';
import 'package:app_order/theme/app_assets.dart';
import 'package:app_order/theme/app_color.dart';
import 'package:app_order/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;

class PrintProduct extends StatefulWidget {
  const PrintProduct({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  State<PrintProduct> createState() => _PrintProductState();
}

class _PrintProductState extends State<PrintProduct> {
  late AuthencationProvider auth;
  @override
  Widget build(BuildContext context) {
    double sizeH = MediaQuery.of(context).size.height;
    double sizeW = MediaQuery.of(context).size.width;
    auth = Provider.of<AuthencationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: SizedBox(
            child: Image.asset(
              AppAssets.fill,
              color: Colors.white70,
            ),
          ),
        ),
        elevation: 0,
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
              ]),
        ),
      ),
      body: FutureBuilder(
        future: auth.getPost(widget.text),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                childAspectRatio: 1 / 1.4,
              ),
              itemBuilder: (BuildContext context, int index) {
                int value = int.parse(snapshot.data![index].price);
                final price = intl.NumberFormat.decimalPattern().format(value);
                return Container(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              Product(post: snapshot.data![index]),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                              '$price đ',
                              style: AppStyle.h5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
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
}
