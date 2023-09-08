// ignore_for_file: invalid_use_of_protected_member, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/domain/entities/color_entity.dart';

class ColorChooseWidget extends GetView {
  ColorChooseWidget({
    super.key, 
    required this.onChange, 
    required this.colors, 
    required this.value,
    this.hiddenColor
  }) {
    _colorsChoose.addAll(value);
  }

  final List<ColorEntity> colors;
  final Function(List<ColorEntity>) onChange;
  final List<ColorEntity> value;
  final List<String>? hiddenColor;

  late final RxList<ColorEntity> _colorsChoose = <ColorEntity>[].obs;

  List<ColorEntity> _colorFilteringHidden() {
    if (hiddenColor == null) {
      return colors;
    }
    return colors.where((element) {
      return hiddenColor!.contains(element.id) == false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "${"choose".tr} ${"color".tr}".toCapitalize(),
              style: GoogleFonts.lato(
                fontSize: 11,
                color: Colors.black
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            padding: const EdgeInsets.all(10),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _colorFilteringHidden().map<Widget>((e) {
                Color colorLeading;
                try {
                  colorLeading = Color(int.parse(
                          "#${e.codeHexa ?? 'ffffff'}"
                              .substring(1, 7),
                          radix: 16) +
                      0xFF000000);
                } catch (_) {
                  colorLeading = Color(
                      int.parse("#ffffff'".substring(1, 7), radix: 16) +
                          0xFF000000);
                }
                return Container(
                  width: 40,
                  margin: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      if (_colorsChoose.contains(e)) {
                        _colorsChoose.remove(e);
                      } else {
                        _colorsChoose.add(e);
                      }
                      onChange(_colorsChoose.value);
                    },
                    child: Obx(() {
                      return Container(
                        decoration: BoxDecoration(
                          color: colorLeading,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: _colorsChoose.contains(e)
                          ? const Icon(Icons.check)
                          : null
                        ,
                      );
                    })
                  )
                );
              }).toList(),
            )
          )
        ],
      ),
    );
  }
}
