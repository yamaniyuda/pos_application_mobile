import 'package:flutter/material.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_form/pam_image_form/pam_image_form_widget.dart';

class ImageUploadWidget extends StatelessWidget {
  const ImageUploadWidget({super.key, this.images});

  final List<String>? images;

  @override
  Widget build(BuildContext context) {
    return PAMImageFormWidget(
      frontWidget: (Function popUp) {
        return ListView(
          scrollDirection: Axis.horizontal,
          children: [
            InkWell(
              onTap: () => popUp(),
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
        );
      }
    );
  }
}
