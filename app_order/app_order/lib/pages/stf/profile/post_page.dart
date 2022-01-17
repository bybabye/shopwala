import 'dart:typed_data';

import 'package:app_order/pages/stf/login/login_page.dart';
import 'package:app_order/provider/auth_provider.dart';
import 'package:app_order/theme/app_assets.dart';
import 'package:app_order/theme/app_color.dart';
import 'package:app_order/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController controllerBio = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerColor = TextEditingController();
  TextEditingController controllerSize = TextEditingController();
  List color = [];
  List size = [];
  String dropdownValue = 'shoes';
  late AuthencationProvider auth;
  Uint8List? file;
  bool _isLoading = false;

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Create Post"),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("take a photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List fileCamera = await pickImage(ImageSource.camera);
                  if (fileCamera.isNotEmpty) {
                    setState(() {
                      file = fileCamera;
                    });
                  }
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("take a libary"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List fileGallery = await pickImage(ImageSource.gallery);
                  if (fileGallery.isNotEmpty) {
                    setState(() {
                      file = fileGallery;
                    });
                  }
                },
              ),
            ],
          );
        });
  }

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
  @override
  void initState() {
    super.initState();
    controllerBio.addListener(() {});
    controllerPrice.addListener(() {});
    controllerName.addListener(() {});
    controllerSize.addListener(() {});
    controllerColor.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    double sizeH = MediaQuery.of(context).size.height;
    double sizeW = MediaQuery.of(context).size.height;
    auth = Provider.of<AuthencationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          _isLoading
              ? const SizedBox()
              : TextButton(
                  onPressed: file == null ||
                          controllerBio.text == "" ||
                          controllerPrice.text == "" ||
                          controllerColor.text == "" ||
                          controllerName.text == "" ||
                          controllerColor.text == ''
                      ? () {}
                      : () => _post(),
                  child: Text(
                    "Post",
                    style: file == null ||
                            controllerBio.text == "" ||
                            controllerPrice.text == "" ||
                            controllerColor.text == "" ||
                            controllerName.text == "" ||
                            controllerColor.text == ''
                        ? AppStyle.h3.copyWith(color: Colors.grey)
                        : AppStyle.h3
                            .copyWith(color: AppColor.kButtonFirstColor),
                  ),
                ),
        ],
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
              "Post",
              style: AppStyle.h3,
            ),
          ),
          alignment: Alignment.center,
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: sizeW,
                        child: TextField(
                          controller: controllerName,
                          decoration: InputDecoration(
                            hintText: 'Tên Sản Phẩm...',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: sizeW,
                            child: TextField(
                              controller: controllerSize,
                              decoration: InputDecoration(
                                hintText: 'Size...',
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Lưu ý : nhập danh sách size phải có ký tự cách hoặc chấm hoặc chấm phẩy. ",
                            style: AppStyle.h5.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: sizeW,
                            child: TextField(
                              controller: controllerColor,
                              decoration: InputDecoration(
                                hintText: 'color...',
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "Lưu ý : nhập danh sách màu phải có ký tự cách hoặc chấm hoặc chấm phẩy. ",
                            style: AppStyle.h5.copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: sizeW,
                        child: TextField(
                          controller: controllerBio,
                          decoration: InputDecoration(
                            hintText: 'Ghi chú sản phẩm của bạn...',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: sizeW,
                        child: TextField(
                          controller: controllerPrice,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Price',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          file == null
                              ? InkWell(
                                  onTap: () => _selectImage(context),
                                  child: SizedBox(
                                    height: sizeH * 0.25,
                                    width: sizeW * 0.2,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.add),
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: sizeH * 0.25,
                                  width: sizeW * 0.2,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                    ),
                                    child: Image.memory(
                                      file!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          SizedBox(
                            height: sizeH * 0.06,
                            width: sizeW * 0.2,
                            child: DecoratedBox(
                              decoration: BoxDecoration(border: Border.all()),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  value: dropdownValue,
                                  icon:
                                      const Icon(Icons.arrow_drop_down_rounded),
                                  items: items.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(value),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  _post() async {
    setState(() {
      _isLoading = true;
    });
    if (controllerColor.text.contains(".")) {
      color = controllerColor.text.split('.');
    } else if (controllerColor.text.contains(" ")) {
      color = controllerColor.text.split(' ');
    } else if (controllerColor.text.contains(",")) {
      color = controllerColor.text.split(',');
    } else {
      color.add(controllerColor.text);
    }
    if (controllerSize.text.contains(".")) {
      size = controllerSize.text.split('.');
    } else if (controllerSize.text.contains(" ")) {
      size = controllerSize.text.split(' ');
    } else if (controllerSize.text.contains(",")) {
      size = controllerSize.text.split(',');
    } else {
      size.add(controllerSize.text);
    }
    String res = await auth.post(
      email: auth.user.email,
      id: auth.user.id,
      file: file!,
      bio: controllerBio.text,
      type: dropdownValue,
      price: controllerPrice.text,
      color: color,
      name: controllerName.text,
      size: size,
    );
    if (res == 'success') {
      showSnackBar("Tạo bài đăng thành công", context, true);
      setState(() {
        _isLoading = true;
      });
    } else {
      showSnackBar("Tạo bài đăng thất bại", context, false);
      setState(() {
        _isLoading = false;
      });
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
  }
}

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? _file = await _imagePicker.pickImage(source: source);

  if (_file != null) {
    return await _file.readAsBytes();
  }
}
