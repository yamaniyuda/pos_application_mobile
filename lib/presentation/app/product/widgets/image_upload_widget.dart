// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/app/utils/system_utils.dart';
import 'package:pos_application_mobile/presentation/app/product/controllers/product_detail_controller.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_image_form/pam_image_form_widget.dart';

class ImageUploadWidget extends StatelessWidget {
  ImageUploadWidget({super.key, this.images});

  final List<String>? images;
  final controller = Get.find<ProductDetailController>();

  void _uploadImageHandler(List<XFile> files) {
    controller.storeImageCloth(files);
  }

  @override
  Widget build(BuildContext context) {
    return PAMImageFormWidget(
      onSubmit: _uploadImageHandler,
      frontWidget: (popUp) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${"image".tr} ${"product".tr}".toCapitalize()),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Obx(() => ListView(
                      scrollDirection: Axis.horizontal,
                      children: controller.imageData.map((element) {
                        return Image.network(
                          element.image!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Image.asset(
                            "assets/images/img_placeholder.png",
                            fit: BoxFit.cover,
                          ),
                        );
                      }).toList(),
                    ))
                  ),
                  InkWell(
                    onTap: () async {
                      await popUp();
                      SystemUtils.changeStatusAndBottomBarColor(
                        context,
                        statusBarColor: Colors.white.withOpacity(.004),
                        statusBarIconBrightness:  Brightness.light
                      );
                    },
                    child: Container(
                      height: 70,
                      width: 70,
                      color: Colors.black54,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    )
                  )
                ],
              )
            )
          ],
        );
      }
    );
  }
}
