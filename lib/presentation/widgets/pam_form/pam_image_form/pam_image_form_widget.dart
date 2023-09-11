// ignore_for_file: unnecessary_null_comparison, invalid_use_of_protected_member

import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/app/utils/system_utils.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_image_form/pam_image_form_controller.dart';

typedef FrontWidget = Widget Function(Future<void> Function());

class PAMImageFormWidget extends StatelessWidget {
  PAMImageFormWidget({
    super.key,
    this.images,
    required this.frontWidget,
    required this.onSubmit
  });

  final FrontWidget frontWidget;
  final List<String>? images;
  final Function(List<XFile>) onSubmit;
  final controller = Get.put(PAMImageFormController());


  /// Picker Image From Local.
  /// 
  /// The `_pickerImageFromLocal` do handling a image picker form
  /// local file. After selected image this function will store
  /// images selected to state controller.
  Future<void> _pickImageFromLocal() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage();
    controller.selectedImages.addAll(images);
  }

  
  /// Caraouser Item Handler.
  /// 
  /// The `_caraouserItemHandler` will handling items for caraouser,
  /// when data [controller.selectedImages] is exist will show items
  /// images and preview and while for data that does not exist will 
  /// return images icons with 3 items.
  List<Widget> _caraouserItemsHandler() {
    if (controller.selectedImages.isEmpty) {
      return  List<Widget>.filled(
        3,
        Container(
          alignment: Alignment.center,
          width: 80,
          height: 80,
          child: const Icon(Icons.image_search_rounded),
        ) 
      );
    }

    return controller.selectedImages.map(
      (element) => Image.file(
        File(element.path),
        fit: BoxFit.contain,
        width: 150,
      )
    ).toList();
  }


  /// Show Image Picker Pop Up.
  /// 
  /// The `_showImagesPickerPopUp` do call [Dialog] with has content
  /// all image current picker, besides that it can also do preview the data y ou
  /// has selected. With function [_caraouserItemsHandler] will filter items while show
  /// in UI.
  Future<void> _showImagePickerPopUp() {
    SystemUtils.changeStatusAndBottomBarColor(
      Get.context!,
      statusBarColor: Colors.white.withOpacity(.005),
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black54,
      systemNavigationBarIconBrightness: Brightness.light
    );


    return Get.dialog(
      Center(
        child: Container(
          width: Get.width * .8,
          height: Get.height * .6,
          decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              DefaultTextStyle(
                style: GoogleFonts.lato(
                  fontSize: 18, color: 
                  Colors.black54,
                  fontWeight: FontWeight.bold
                ),
                child: Text(
                  "${"upload".tr} ${"image".tr}".toCapitalize(),
                )
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() => CarouselSlider(
                items: _caraouserItemsHandler(),
                  options: CarouselOptions(
                    height: Get.height * .2,
                    autoPlay: true,
                  )
                )),
              ),
              const SizedBox(height: 20),
              Obx(() => Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: Get.height * .15,
                color: Colors.grey[600],
                child: Row(
                  children: [
                    if (controller.selectedImages.asMap().containsKey(0)) Image.file(
                      File(controller.selectedImages[0].path),
                      fit: BoxFit.fill,
                      width: (Get.width * .8) / 3.5,
                      height: Get.height * .15,
                    ),
                    if (controller.selectedImages.asMap().containsKey(1)) Image.file(
                      File(controller.selectedImages[1].path),
                      fit: BoxFit.fill,
                      width: (Get.width * .8) / 3.5,
                      height: Get.height * .15,
                    ),
                    if (controller.selectedImages.length > 2) Stack(
                      children: [
                        Image.file(
                          File(controller.selectedImages[2].path),
                          fit: BoxFit.fill,
                          width: (Get.width * .8) / 3.5,
                          height: Get.height * .15,
                        ),
                        Container(
                          color: Colors.black54,
                          width: (Get.width * .8) / 3.5,
                          height: Get.height * .15,
                          alignment: Alignment.center,
                          child: DefaultTextStyle(
                            style: GoogleFonts.lato(
                              fontSize: 24, 
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                            ),
                            child: Text(
                              "+ ${controller.selectedImages.length - 2}",
                            )
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  onPressed: () => _pickImageFromLocal(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(Get.context!).primaryColor
                  ),
                  child: Text("${"choose".tr} ${"image"}".toCapitalize()),
                ),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                  bottom: 20
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: (Get.width * .8) / 2.5,
                      child: ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(Get.context!).primaryColor
                        ),
                        child: Text("cancel".tr.toCapitalize()),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: (Get.width * .8) / 2.5,
                      child: ElevatedButton(
                        onPressed: () => onSubmit(controller.selectedImages),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(Get.context!).primaryColor
                        ),
                        child: Text("submit".tr.toCapitalize()),
                      ),
                    ),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    )
    .then((value) =>controller.selectedImages.clear());
  }

  @override
  Widget build(BuildContext context) {
    return frontWidget(_showImagePickerPopUp);
  }
}
