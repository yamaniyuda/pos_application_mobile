import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/domain/entities/stock_entity.dart';
import 'package:pos_application_mobile/presentation/app/stock/controllers/stock_controller.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom.dart';
import 'package:pos_application_mobile/presentation/widgets/sparator/sparator_widget.dart';

class StockBottomSheet extends StatelessWidget {
  StockBottomSheet({
    super.key,
    required this.stockEntity
  });

  final StockEntity stockEntity;
  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<StockController>();

  RxString stockForm = "0".obs;

  void _onSubmitHandler() {
    controller.adjustmentStock(
      stock: stockForm.value, 
      clothSizeId: stockEntity.referralId!
    );
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .6,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10)
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${"update".tr} ${"stock".tr}".toCapitalize(),
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.bold
            )
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.black54.withOpacity(.2)
                ),
                child: const Icon(Icons.inventory),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: Get.width * .4,
                    child: Text(
                      (stockEntity.clothStock?.clothColor?.cloth?.clothCategory?.name ?? '-').toCapitalize(),
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "${(stockEntity.clothStock?.clothColor?.color?.name ?? '-')} - ${(stockEntity.clothStock?.size?.name ?? '-')}".toCapitalize(),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                "${stockEntity.currentStock} pcs",
                style: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          CustomPaint(
            painter: SparatorWidget(),
            size: const Size(double.infinity, 10)
          ),

          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    isDense: true,
                    border: const OutlineInputBorder(),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'stock',
                    fillColor: Colors.black.withOpacity(.05),
                  ),
                  onChanged: (value) => stockForm.value = value,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    isDense: true,
                    border: const OutlineInputBorder(),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: 'reason',
                    fillColor: Colors.black.withOpacity(.05),
                  ),
                ),
              ],
            )
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: PAMBottom(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Theme.of(context).primaryColor.withOpacity(.2),
                      fontColor: Theme.of(context).primaryColor,
                      title: "cencel".tr.toCapitalize()
                    )
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: PAMBottom(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      title: "submit".tr.toCapitalize(),
                      onTab: _onSubmitHandler,
                    )
                  ),
                ],
              ),
            )
          )
        ],
      ),
    );
  }
}