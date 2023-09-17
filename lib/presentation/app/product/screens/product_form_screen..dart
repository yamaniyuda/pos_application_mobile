// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/app/utils/system_utils.dart';
import 'package:pos_application_mobile/domain/entities/color_entity.dart';
import 'package:pos_application_mobile/presentation/app/product/controllers/product_form_controller.dart';
import 'package:pos_application_mobile/presentation/app/product/widgets/color_choose_widget.dart';
import 'package:pos_application_mobile/presentation/app/product/widgets/color_form_widget.dart';
import 'package:pos_application_mobile/presentation/app/product/widgets/select_option_cloth_type_screen.dart';
import 'package:pos_application_mobile/presentation/app/product/widgets/size_choose_widget.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_form.dart';

/// Define type from screen Product form screen.
enum ProductFormScreenType { store, addClothColor, addClothSize }

/// Product Form Screen
///
/// The `ProductFormScreen` has navigation arguments [ClothEntity]
/// when status is updated.
///
/// Navigation Parameters:
/// - `id` : This a unique identifier for representation data current cloth;
/// - `cloth_color_id`: This a unique identifier for representation data current color choose.
class ProductFormScreen extends GetView<ProductFormController> {
  ProductFormScreen({
    super.key, 
    this.type = ProductFormScreenType.store,
    this.showColor = true,
    this.hiddenColors,
    this.hiddenSizes,
    this.chooseColorValue,

  });

  final ProductFormScreenType type;
  final List<String>? hiddenColors;
  final List<String>? hiddenSizes;
  final List<ColorEntity>? chooseColorValue;
  final bool showColor;

  final _formKey = GlobalKey<FormState>();

  int getExpandedHeight() {
    if (type == ProductFormScreenType.store) return 250;
    if (type == ProductFormScreenType.addClothColor) return 200;
    return 120;
  }

  Function getActionMethod() {
    if (type == ProductFormScreenType.store) return controller.storeCloth;
    if (type == ProductFormScreenType.addClothColor) return controller.updateClothAddNewColor;
    return controller.updateClothAddNewSize;
  }

  String _getTitle() {
    if (type == ProductFormScreenType.store) {
      return "${"store".tr} ${"product".tr}".toCapitalize();
    } else if (type == ProductFormScreenType.addClothColor) {
      return  "${"store".tr} ${"color".tr}".toCapitalize();
    } else {
      return "${"store".tr} ${"size".tr}".toCapitalize();
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    SystemUtils.changeStatusAndBottomBarColor(context);

    if (type == ProductFormScreenType.addClothSize && chooseColorValue != null) {
      controller.updateClothColor(chooseColorValue!);
    }

    return Scaffold(
      body: Obx(() {
      if (controller.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            /// app bar sliver.
            SliverAppBar(
              title: Text(_getTitle()),
              expandedHeight: getExpandedHeight().toDouble(),
              pinned: true,
              elevation: 2,
              forceElevated: true,
              flexibleSpace: FlexibleSpaceBar(
                background: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        
                        /// ===================================
                        /// Cloth choose color widget handling.
                        /// ===================================
                        if (showColor) ColorChooseWidget(
                          onChange: (p0) => controller.updateClothColor(p0),
                          value: controller.colorChoose,
                          colors: controller.dataColors,
                          hiddenColor: hiddenColors,
                        ),
      
                        /// ==================================
                        /// Cloth Size choose widget handling.
                        /// ==================================
                        SizeChooseWidget(
                          onChange: (p0) => controller.updateClothSize(p0),
                          sizes: controller.dataSizes,
                          value: controller.sizeChoose,
                          hiddenSizes: hiddenSizes,
                        ),

                        /// ====================
                        /// Cloth type handling.
                        /// ====================
                        if (type == ProductFormScreenType.store) Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10
                          ),
                          child: PAMFormTextFieldWidget(
                            screen: SelectOptionClothTypeScreen(),
                            decoration: const BoxDecoration(),
                            inputDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              isDense: true,
                              border: const OutlineInputBorder(),
                              filled: true,
                              labelText: "cloth category".tr.toCapitalize(),
                              alignLabelWithHint: false,
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              fillColor: Colors.black.withOpacity(.05)
                            ),
                            onSaved: (p0) {
                              controller.clothCategoryId.value = p0!;
                            },
                          ),
                        ),
                          
                      ],
                    ),
                  ),
                ),
              ),
            ),
      
            SliverList.builder(
              itemCount: controller.colorChoose.length,
              itemBuilder: (context, index) {
                Color headerColor;
      
                try {
                  headerColor = Color(int.parse(
                          "#${controller.clothColorPayloads[index].color}"
                              .substring(1, 7),
                          radix: 16) +
                      0xFF000000);
                } catch (_) {
                  headerColor = Color(
                      int.parse("#ffffff".substring(1, 7), radix: 16) +
                          0xFF000000);
                }
                return ColorFormWidget(
                  index: index,
                  headerColor: headerColor,
                  showSku: type == ProductFormScreenType.addClothSize ? false : true,
                  key: ValueKey(controller.clothColorPayloads[index]),
                );
              },
            ),
            
            if (controller.colorChoose.isNotEmpty) SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: PAMBottom(
                  borderRadius: BorderRadius.circular(10),
                  title: _getTitle(),
                  onTab: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      /// Do action to remote data source.
                      getActionMethod()();
                    }
                  },
                ),
              )
            )
          ],
        ),
      );
    }));
  }
}
