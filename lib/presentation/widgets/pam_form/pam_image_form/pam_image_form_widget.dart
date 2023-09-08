import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_image_form/pam_image_form_controller.dart';

typedef FrontWidget = Widget Function(Function);

class PAMImageFormWidget extends StatelessWidget {
  PAMImageFormWidget({
    super.key,
    this.images,
    required this.frontWidget,
  });

  final FrontWidget frontWidget;
  final List<String>? images;
  final controller = Get.put(PAMImageFormController());

  Future<void> pickImageFromLocal() async {
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
        fit: BoxFit.cover,
        height: 80,
        width: 80,
      )
    ).toList();
  }


  /// Show Image Picker Pop Up.
  /// 
  /// The `_showImagesPickerPopUp` do call [Dialog] with has content
  /// all image current picker, besides that it can also do preview the data you
  /// has selected. With function [_caraouserItemsHandler] will filter items while show
  /// in UI.
  void _showImagePickerPopUp() {
    Get.dialog(
      Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)
          ),
          width: Get.width * .8,
          height: Get.height * .5,
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
              CarouselSlider(
                items: _caraouserItemsHandler(),
                options: CarouselOptions(
                  height: Get.height * .2
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return frontWidget(_showImagePickerPopUp);
  }
}
