import 'package:flutter/material.dart';
import 'package:pos_application_mobile/presentation/app/product/widgets/image_upload_widget.dart';

class SettingDetailWidget extends StatelessWidget {
  const SettingDetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ImageUploadWidget()
        ],
      ),
    );
  }
}