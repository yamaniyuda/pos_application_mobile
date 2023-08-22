import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/customer_type/customer_type.dart';

class ClothingCategoryScreen extends GetView<CustomerTypeController> {
  const ClothingCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "customer type".tr.toCapitalize(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [

            /* build list view */
            _buildHeader(),
            _buildListColor()

          ],
        ),
      )
    );
  }
  
  _buildHeader() {}
  
  _buildListColor() {}
}