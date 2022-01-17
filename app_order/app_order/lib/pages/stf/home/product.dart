import 'package:app_order/models.dart/post.dart';
import 'package:app_order/models.dart/town.dart';
import 'package:app_order/pages/stf/login/login_page.dart';
import 'package:app_order/pages/stl/custom_button.dart';
import 'package:app_order/provider/auth_provider.dart';
import 'package:app_order/test/test_api.dart';
import 'package:app_order/theme/app_assets.dart';
import 'package:app_order/theme/app_color.dart';
import 'package:app_order/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';

class Product extends StatefulWidget {
  const Product({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  late AuthencationProvider _auth;
  bool isLoading = false;
  List<String> colors = [];
  List<String> sizes = [];
  late String color;
  late String size;
  int valueCount = 1;
  List<Town> towns = [];
  int indexTown = 0;
  int indexDis = 0;
  int indexWard = 0;
  String nameTown = "";
  String nameDis = "";
  String nameWard = "";
  getData() async {
    towns = await fetchData();
  }

  @override
  void initState() {
    super.initState();
    for (var e in widget.post.color) {
      colors.add(e);
    }
    for (var e in widget.post.size) {
      sizes.add(e);
    }

    color = colors[0];
    size = sizes[0];
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double sizeH = MediaQuery.of(context).size.height;
    double sizeW = MediaQuery.of(context).size.height;
    int value = int.parse(widget.post.price);
    _auth = Provider.of<AuthencationProvider>(context);
    final price = intl.NumberFormat.decimalPattern().format(value);

    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(
                        height: sizeH * 0.5,
                        width: sizeW,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              widget.post.image,
                              fit: BoxFit.fitHeight,
                            ),
                            Positioned(
                              top: 30,
                              left: 30,
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Image.asset(
                                    AppAssets.iconBack,
                                    color: Colors.black,
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: sizeW,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: RichText(
                                text: TextSpan(
                                  text: 'Wala',
                                  style: const TextStyle(
                                    color: AppColor.kButtonFirstColor,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' | ${widget.post.name}',
                                      style: AppStyle.h3,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            customSizedBox(sizeH * 0.01),
                            const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                "Giới thiệu sản phẩm",
                                style: AppStyle.h3,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                widget.post.bio,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(.6),
                                  letterSpacing: 0.5,
                                  wordSpacing: 1,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            customSizedBox(sizeH * 0.01),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SizedBox(
                                width: sizeW,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "màu sắc : ",
                                      style: AppStyle.h3,
                                    ),
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: color,
                                          icon: const Icon(
                                              Icons.arrow_drop_down_rounded),
                                          items: colors.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(value),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              color = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            customSizedBox(sizeH * 0.01),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SizedBox(
                                width: sizeW,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Kích cỡ : ",
                                      style: AppStyle.h3,
                                    ),
                                    DecoratedBox(
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          value: size,
                                          icon: const Icon(
                                              Icons.arrow_drop_down_rounded),
                                          items: sizes.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(value),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              size = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            customSizedBox(sizeH * 0.01),
                            chooseTown(),
                            chooseDis(),
                            chooseWard(),
                            customSizedBox(sizeH * 0.01),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SizedBox(
                                width: sizeW,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Giá thành : ",
                                      style: AppStyle.h3,
                                    ),
                                    Text(
                                      '$price đ',
                                      style: AppStyle.h4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            customSizedBox(sizeH * 0.01),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SizedBox(
                                width: sizeW,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomButton(
                                      height: sizeH * 0.08,
                                      width: sizeW / 10,
                                      func: () {
                                        setState(() {
                                          if (valueCount != 0) {
                                            valueCount--;
                                          }
                                        });
                                      },
                                      text: "-",
                                    ),
                                    Text(
                                      "$valueCount",
                                      style: AppStyle.h3,
                                    ),
                                    CustomButton(
                                      height: sizeH * 0.08,
                                      width: sizeW / 10,
                                      func: () {
                                        setState(() {
                                          valueCount++;
                                        });
                                      },
                                      text: "+",
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            customSizedBox(sizeH * 0.01),
                            widget.post.id == _auth.user.id
                                ? const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      "Xin lỗi  bạn không phải người mua nên không thể chọn hình thức thanh toán.",
                                      style: TextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                : nameTown != "" ||
                                        nameDis != "" ||
                                        nameWard != ""
                                    ? Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: CustomButton(
                                          height: sizeH * 0.07,
                                          width: sizeW,
                                          func: () =>
                                              buyProduct(value * valueCount),
                                          text: "Thành Tiền",
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: SizedBox(
                                          height: sizeH * 0.07,
                                          width: sizeW,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              gradient: const LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: [
                                                    Colors.grey,
                                                    Colors.blueGrey
                                                  ]),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Thành Tiền",
                                                style: AppStyle.h4.copyWith(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget customSizedBox(double size) {
    return SizedBox(
      height: size,
      width: MediaQuery.of(context).size.width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
      ),
    );
  }

  Widget chooseTown() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Chọn Thành Phố : ",
            style: AppStyle.h3,
          ),
          nameTown == ""
              ? TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: towns.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  indexTown = index;
                                  nameTown = towns[index].name!;
                                });
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  towns[index].name!,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "Chọn Thành Phố",
                    style:
                        AppStyle.h4.copyWith(color: AppColor.kButtonFirstColor),
                  ),
                )
              : Row(
                  children: [
                    Text(
                      nameTown,
                      style: const TextStyle(color: Colors.blueGrey),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          nameTown = "";
                          indexTown = 0;
                          indexDis = 0;
                          nameDis = "";
                          nameWard = "";
                          indexWard = 0;
                        });
                      },
                      icon: const Icon(
                        Icons.cancel,
                        color: AppColor.kButtonSecondColor,
                      ),
                    )
                  ],
                ),
        ],
      ),
    );
  }

  Widget chooseDis() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Chọn Quận huyện : ",
            style: AppStyle.h3,
          ),
          if (nameTown != "")
            nameDis == ""
                ? TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: towns[indexTown].districts!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    indexDis = index;
                                    nameDis = towns[indexTown]
                                        .districts![index]
                                        .name!;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    towns[indexTown].districts![index].name!,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Chọn Quận huyện",
                      style: AppStyle.h4
                          .copyWith(color: AppColor.kButtonFirstColor),
                    ),
                  )
                : Row(
                    children: [
                      Text(
                        nameDis,
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            indexDis = 0;
                            nameDis = "";
                            nameWard = "";
                            indexWard = 0;
                          });
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: AppColor.kButtonSecondColor,
                        ),
                      )
                    ],
                  ),
        ],
      ),
    );
  }

  Widget chooseWard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Chọn phường xã",
            style: AppStyle.h3,
          ),
          if (nameDis != "")
            nameWard == ""
                ? TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: towns[indexTown]
                                .districts![indexDis]
                                .wards!
                                .length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    indexWard = index;
                                    nameWard = towns[indexTown]
                                        .districts![indexDis]
                                        .wards![index]
                                        .name!;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    towns[indexTown]
                                        .districts![indexDis]
                                        .wards![index]
                                        .name!,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "Chọn phường xã",
                      style: AppStyle.h4
                          .copyWith(color: AppColor.kButtonFirstColor),
                    ),
                  )
                : Row(
                    children: [
                      Text(
                        nameWard,
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            nameWard = "";
                            indexWard = 0;
                          });
                        },
                        icon: const Icon(
                          Icons.cancel,
                          color: AppColor.kButtonSecondColor,
                        ),
                      )
                    ],
                  ),
        ],
      ),
    );
  }

  void buyProduct(int price) async {
    setState(() {
      isLoading = true;
    });
    try {
      String res = await _auth.order(
        uid: _auth.user.id,
        idOwner: widget.post.id,
        price: price,
        color: color,
        size: size,
        numberPhone: _auth.user.numberPhone,
        address: '$nameTown,$nameDis,$nameWard',
        productId: widget.post.idPost,
        nameProduct: widget.post.name,
        typeProduct: widget.post.type,
      );
      setState(() {
        isLoading = true;
      });
      if (res == "success") {
        showSnackBar("Đạt hàng thành công", context, true);
      } else {
        showSnackBar(res, context, false);
      }

      Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showSnackBar("Đạt hàng Thất bài", context, true);
    }
    setState(() {
      isLoading = false;
    });
  }
}
