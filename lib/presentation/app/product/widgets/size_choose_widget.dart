// ignore_for_file: invalid_use_of_protected_member, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/domain/entities/size_entity.dart';

class SizeChooseWidget extends GetView {
  SizeChooseWidget({
    super.key, 
    required this.onChange, 
    required this.sizes,
    required this.value,
    this.hiddenSizes
  }) {
    _clothSizes.addAll(value);
  }

  final List<SizeEntity> sizes;
  final Function(List<SizeEntity>) onChange;
  final List<SizeEntity> value;
  final List<String>? hiddenSizes;

  late RxList<SizeEntity> _clothSizes = <SizeEntity>[].obs;


  List<SizeEntity> _sizeFilterHidden() {
    if (hiddenSizes != null) {
      return sizes.where((element) => !hiddenSizes!.contains(element.id)).toList();
    }
    return sizes;
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
              "${"choose".tr} ${"size".tr}".toCapitalize(),
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
              children: _sizeFilterHidden().map<Widget>((e) {
                return Container(
                  width: 40,
                  margin: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      if (_clothSizes.contains(e)) {
                        _clothSizes.remove(e);
                      } else {
                        _clothSizes.add(e);
                      }
                      onChange(_clothSizes.value);
                    },
                    child: Obx(() => Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black54,
                          width: 2
                        ),
                        color: _clothSizes.contains(e)
                          ? Theme.of(context).primaryColor.withOpacity(.2)
                          : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        e.name!,
                        style: GoogleFonts.lato(
                          color: Colors.black54,
                          fontSize: 12
                        ),
                      )
                    ))
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
