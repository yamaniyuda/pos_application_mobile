import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/cloth_controller.dart';
import 'package:pos_application_mobile/presentation/app/sale/model/cloth_form_payload.dart';

class ProductAddActionWidget extends StatelessWidget {
  ProductAddActionWidget({
    super.key,
    required this.clothColorId,
    required this.clothFormPayload,
    required this.clothSizeId,
    required this.value,
    required this.clothSizePriceId
  });

  final ClothFormPayload clothFormPayload;
  final String clothColorId;
  final String clothSizeId;
  final String value;
  final String clothSizePriceId;

  final controller = Get.find<ClothController>();
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textEditingController.text = (clothFormPayload.items[clothSizeId]?['qyt'] ?? 0).toString();

    return Row(
      children: [
        /// ========================
        /// Decrement Button Handler
        /// ========================
        IconButton.filled(
          onPressed: () {
            controller.updateItems(
              payload: clothFormPayload, 
              clothColorId: clothColorId, 
              clothSizeId: clothSizeId, 
              clothSizePriceId: clothSizePriceId,
              qyt: -1 
            );
          },
          icon: const Icon(Icons.indeterminate_check_box, color: Colors.red),
        ),


        SizedBox(
          width: 50,
          child: TextFormField(
            key: Key(clothSizeId),
            controller: textEditingController,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black54.withOpacity(0.1),
              border: InputBorder.none
            ),
            onChanged: (String? value) {
              if (value != "") {
                controller.updateItems(
                  payload: clothFormPayload, 
                  clothColorId: clothColorId, 
                  clothSizeId: clothSizeId, 
                  clothSizePriceId: clothSizePriceId,
                  reset: true,
                  qyt: int.parse(value ?? '0')
                );
              }
            },
          )
        ),


        /// =========================
        /// Increment Buttom Handler
        /// =========================
        IconButton.filled(
          onPressed: () {
            controller.updateItems(
              payload: clothFormPayload, 
              clothColorId: clothColorId, 
              clothSizeId: clothSizeId, 
              clothSizePriceId: clothSizePriceId,
              qyt: 1
            );

            textEditingController.text = (clothFormPayload.items[clothSizeId]?['qyt'] ?? 0).toString();
          },
          icon: Icon(Icons.add_box_rounded, color: Theme.of(context).primaryColor),
        )
      ],
    );
  }
}