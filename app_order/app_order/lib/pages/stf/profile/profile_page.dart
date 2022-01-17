import 'package:app_order/models.dart/post.dart';
import 'package:app_order/pages/stf/profile/post_page.dart';
import 'package:app_order/provider/auth_provider.dart';
import 'package:app_order/theme/app_color.dart';
import 'package:app_order/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late AuthencationProvider auth;
  late double sizeH;
  late double sizeW;
  @override
  void initState() {
    super.initState();
  }

  List<Widget> iconButton = [
    IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.shopping_bag,
        size: 30,
      ),
    ),
    IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.sell_outlined,
        size: 30,
      ),
    ),
    IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.add_shopping_cart_rounded,
        size: 30,
      ),
    ),
    IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.rate_review_outlined,
        size: 30,
      ),
    ),
  ];

  List<String> nameItem = [
    'Đang bán',
    'Đơn hàng được đặt',
    'Đơn hàng đã mua',
    'chờ đánh giá'
  ];

  @override
  Widget build(BuildContext context) {
    auth = Provider.of<AuthencationProvider>(context);
    sizeH = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    sizeW = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    auth.signOut();
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.exit_to_app))
            ],
            leading: const SizedBox(),
            flexibleSpace: Stack(
              children: [
                Positioned(
                  left: 10,
                  bottom: 10,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 45,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(auth.user.image),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            auth.user.name,
                            style: AppStyle.h2
                                .copyWith(fontSize: 20, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            auth.user.email,
                            style: AppStyle.h4.copyWith(color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            expandedHeight: sizeH * 0.3,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: sizeH * 0.2,
                  width: sizeW,
                  child: Card(
                    shadowColor: Colors.blueGrey,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sản phẩm của tôi",
                            style: AppStyle.h3,
                          ),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      iconButton[index],
                                      Text(nameItem[index]),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const PostPage()));
        },
        backgroundColor: AppColor.kButtonSecondColor,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
