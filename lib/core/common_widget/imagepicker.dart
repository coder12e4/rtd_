import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rtd_project/core/color/colors.dart';
import 'package:rtd_project/core/common_widget/commen_botten.dart';

class Imagepiker extends StatefulWidget {
  const Imagepiker({
    super.key,
    required this.onImageSelected,
    required this.press,
  });
  // final String sizeText;
  final ValueChanged<XFile?> onImageSelected;
  final Function() press;

  @override
  State<Imagepiker> createState() => _ImagepikerState();
}

class _ImagepikerState extends State<Imagepiker> {
  // final XFile imagefile;
  // final RegisterController imagePickerService = Get.find();

  final picker = ImagePicker();
  XFile? image;
  int fileSize = 0;
  Future pickImage(ImageSource source) async {
    image = await picker.pickImage(source: source);
    fileSize = await image!.length();

    return image;
  }

  bool isGallery = false;
  bool isCamera = false;
  @override
  Widget build(BuildContext context) {
    // return GetBuilder<RegisterController>(
    //   builder: (value) {
    return Container(
      height: 280.h,
      width: 390.w,
      decoration: const BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadiusDirectional.only(
          topEnd: Radius.circular(50),
          topStart: Radius.circular(50),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          const Text(
            "Upload your ID Proof",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () async {
                  widget.onImageSelected(await pickImage(ImageSource.gallery));

                  setState(() {
                    isGallery = true;
                    isCamera = false;
                  });

                  // if (imagefile != null) {}
                  // value.selectFromGallery('gallery');
                  log(widget.onImageSelected.toString());
                },
                child: isGallery == false
                    ? Container(
                        width: 116,
                        height: 121,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(36),
                            color: const Color(0xfff3f3f3)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/gallary.png'),
                            SizedBox(
                              height: 5.h,
                            ),
                            const Text("Choose from Gallery",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ))
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Image.file(
                              File(image!.path),
                              height: 80.h,
                              width: 121.w,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            const Text(
                              'Selected Image',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                // : Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Text('Choose image less than 2 MB'.tr),
                //   ),
              ),
              GestureDetector(
                onTap: () async {
                  widget.onImageSelected(await pickImage(ImageSource.camera));
                  setState(() {
                    isCamera = true;
                    isGallery = false;
                  });
                  // value.selectFromGallery('camera');
                  log(widget.onImageSelected.toString());
                },
                child: isCamera == false
                    ? Container(
                        width: 116,
                        height: 121,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(36),
                            color: const Color(0xfff3f3f3)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/camara.png'),
                            SizedBox(
                              height: 5.h,
                            ),
                            const Text("Capture from Camera",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ))
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Image.file(
                              File(image!.path),
                              height: 80.h,
                              width: 121.w,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            const Text(
                              'Selected Image',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
              )
            ],
          ),
          SizedBox(
            height: 20.h,
          ),
          // const Text("*Maximum Image Size 2 MB",
          //     style: TextStyle(
          //       color: Colors.red,
          //       fontSize: 16,
          //       fontWeight: FontWeight.w600,
          //     )),
          SizedBox(
            height: 20.h,
          ),
          ButtonWidget(
              press: widget.press,
              buttonBackgroundColor: buttenBlue,
              buttonForegroundColor: whiteColor,
              buttonText: 'Upload',
              borderAvalable: true)
        ],
      ),
    );
    // },
    // );
  }
}
