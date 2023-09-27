// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/sale_form_controller.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom.dart';
import 'package:pos_application_mobile/presentation/widgets/sparator/sparator_widget.dart';

class SaleTotalWidget extends StatefulWidget {
  const SaleTotalWidget({super.key});

  @override
  State<SaleTotalWidget> createState() => _SaleTotalWidgetState();
}

class _SaleTotalWidgetState extends State<SaleTotalWidget> {
  final controller = Get.find<SaleFormController>();
  final oCcy = NumberFormat("#,##0.00", "id_ID");
  double priceCutDiscount = 0;
  double ppnPrice = 0;
  double finalTotal = 0;
  String paymentMethod = "cash";
  double downPaymetNominal = 0;
  Timer? _debounce;


  /// ==================================
  /// Text Editing Controller Declarate.
  /// ==================================
  final TextEditingController editingDiscountPrice = TextEditingController(text: "0");
  final TextEditingController editingDiscountTotal = TextEditingController(text: "0");
  final TextEditingController editingDownPayment = TextEditingController(text: "0");


  void _discountTotalHandling(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      late double discount = double.parse(value);
      if (discount > 100) discount = 100;
      final double result = (discount / 100) * controller.sumTotalItem.value;
      setState(() {
        priceCutDiscount = controller.sumTotalItem.value - result;
      });
      _calculateFinalTotal();
      editingDiscountPrice.text = oCcy.format(result);
    });
  }


  void _discountTotalPriceDiscount(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      late int nominalDiscount = int.parse(value);
      if (nominalDiscount > controller.sumTotalItem.value) nominalDiscount = controller.sumTotalItem.value;
      final double discount = ( nominalDiscount / controller.sumTotalItem.value ) * 100;
      setState(() {
        priceCutDiscount = controller.sumTotalItem.value - nominalDiscount.toDouble();
      });
      _calculateFinalTotal();
      editingDiscountTotal.text = discount.toStringAsFixed(2);
    });
  }


  void _downpaymentInputHandling(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      finalTotal -= double.parse(value);
    });
    _calculateFinalTotal();
  }


  void _calculateFinalTotal() {
    final double sumTotalItem = controller.sumTotalItem.value.toDouble();
    final double differentDiscountPrice = sumTotalItem - priceCutDiscount;
    controller.finalTotalPrice.value = (sumTotalItem - differentDiscountPrice - double.parse(editingDownPayment.text)).toDouble();
    controller.update();
  }


  double getTotal(double sumTotalItem, double discountNominal, double downPaymentNominal) {
    if (discountNominal == 0 || downPaymentNominal == 0) {
      return sumTotalItem - (discountNominal - downPaymetNominal);
    }
    return sumTotalItem;
  }


  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  Widget paymentMethodWidgetHandling() {
    if (paymentMethod == "cash") {
      return Text(
        "Rp ${oCcy.format(editingDiscountPrice.text == '0' ? controller.sumTotalItem.value : priceCutDiscount)}",
        textAlign: TextAlign.end,
        style: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
          fontSize: 14
        ),
      );
    }

    return SizedBox(
      width: 100,
      child: TextFormField(
        onChanged: _downpaymentInputHandling,
        textAlign: TextAlign.end,
        controller: editingDownPayment,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          fontSize: 12
        ),
        
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaleFormController>(builder: (controller) {
      
      return Column(
        verticalDirection: VerticalDirection.up,
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${"detail".tr} ${"item".tr}".toCapitalize(),
                  style: GoogleFonts.lato(
                    fontSize: 16, 
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text("cloth".tr.toCapitalize()),
                    const Spacer(),
                    SizedBox(
                      width: 50,
                      child:  Text(
                        "${controller.sumTotalPcs.value} pcs",
                        style: GoogleFonts.lato(
                          fontSize: 14
                        ),
                      )
                    ),
                    SizedBox(
                      width: 110,
                      child: Text(
                        "Rp ${oCcy.format(controller.sumTotalItem.value)}",
                        textAlign: TextAlign.end,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),


                /// ===================
                /// Discount Calculate
                /// ===================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("discount".tr.toCapitalize()),
                    const Spacer(),
                    SizedBox(
                      width: 50,
                      child:  TextFormField(
                        textAlign: TextAlign.end,
                        controller: editingDiscountTotal,
                        keyboardType: TextInputType.number,
                        onChanged: _discountTotalHandling,
                        style: const TextStyle(
                          fontSize: 14
                        ),
                      )
                    ),
                    const Icon(Icons.percent, size: 12),
                    const SizedBox(width: 10),
                    Text("Rp", style: GoogleFonts.lato(fontSize: 12)),
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        onChanged: _discountTotalPriceDiscount,
                        textAlign: TextAlign.end,
                        controller: editingDiscountPrice,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 14
                        ),
                        
                      )
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Rp ${oCcy.format(editingDiscountPrice.text == '0' ? controller.sumTotalItem.value : priceCutDiscount)}",
                    textAlign: TextAlign.end,
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                    ),
                  ),
                ),
               
                const SizedBox(height: 30),
                CustomPaint(
                  painter: SparatorWidget(),
                  size: const Size(double.infinity, 10)
                ),
                const SizedBox(height: 10),


                /// ================
                /// Payment Method
                /// ================
                SizedBox(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "payment method".tr.toCapitalize(),
                            style: GoogleFonts.lato(
                              fontSize: 16, 
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          DropdownButton(
                            items: const [
                              DropdownMenuItem(value: "cash", child: Text("Cash")),
                              DropdownMenuItem(value: "down payment", child: Text("Down Payment")),
                            ],
                            value: paymentMethod,
                            alignment: Alignment.center,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black
                            ),
                            onChanged: (value) => setState(() {
                              paymentMethod = value!;
                            }),
                          ),
                        ],
                      ),
                      const Spacer(),
                      paymentMethodWidgetHandling()
                    ],
                  ),
                ),


                /// ===============
                /// Final Total
                /// ===============
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.centerRight,
                  child: Row(
                    children: [
                      Text(
                        "total".toCapitalize(),
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                      const Spacer(),
                      Obx(() => Text(
                        "Rp ${oCcy.format(controller.finalTotalPrice.value)}",
                        textAlign: TextAlign.end,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),)
                    ],
                  )
                ),


                /// ===============
                /// Submit Button
                /// ===============
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 20
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      PAMBottom(
                        borderRadius: BorderRadius.circular(10),
                        title: "submit".tr.toCapitalize(),
                        onTab: () {
                          controller.paymentMethodChoose.value = paymentMethod;
                          controller.discountNominal.value = priceCutDiscount.toInt();
                          controller.setPaymentMethod(paymentMethod);
                          controller.storeSale(int.parse(editingDownPayment.text));
                        },
                      ),
                    ]
                  )
                ),
              ],
            )
          ),
        ],
      );
    });
  }
}