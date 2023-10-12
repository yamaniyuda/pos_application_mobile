import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/domain/entities/stock_entity.dart';
import 'package:pos_application_mobile/presentation/app/stock/widget/stock_bottom_sheet_widget.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom.dart';
import 'package:pos_application_mobile/presentation/widgets/sparator/sparator_widget.dart';

class StockCardWidget extends StatelessWidget {
  StockCardWidget({
    super.key,
    required this.stockEntity
  });

  final StockEntity stockEntity;
  final oCcy = NumberFormat("#,##0.00", "id_ID");


  String _getCreatedDate() {
    final DateFormat dateFormat = DateFormat("dd MM yyyy");
    final DateTime dateTime = DateTime.parse(stockEntity.createdAt!);
    return dateFormat.format(dateTime);
  }


  void _onTabButtonHandler() {
    Get.bottomSheet(
      StockBottomSheet(stockEntity: stockEntity),
      isScrollControlled: true
    );
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
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

            
            /// =================
            /// Previus Stock
            /// =================
            Row(
              children: [
                Text(
                  "previous stock".tr.toCapitalize(),
                  style: GoogleFonts.lato(
                    color: Colors.grey,
                    fontSize: 12
                  ),
                ),
                const Spacer(),
                Text(
                  "${stockEntity.previousStock ?? 0} pcs",
                  style: GoogleFonts.lato(
                    fontSize: 12
                  ),
                ),
              ],
            ),


            /// =================
            /// Stock In
            /// =================
            Row(
              children: [
                Text(
                  "stock in".tr.toCapitalize(),
                  style: GoogleFonts.lato(
                    color: Colors.grey,
                    fontSize: 12
                  ),
                ),
                const Spacer(),
                Text(
                  "${stockEntity.stockIn ?? 0} pcs",
                  style: GoogleFonts.lato(
                    fontSize: 12
                  ),
                ),
              ],
            ),


            /// =================
            /// Stock In
            /// =================
            Row(
              children: [
                Text(
                  "stock out".tr.toCapitalize(),
                  style: GoogleFonts.lato(
                    color: Colors.grey,
                    fontSize: 12
                  ),
                ),
                const Spacer(),
                Text(
                  "${stockEntity.stockOut ?? 0} pcs",
                  style: GoogleFonts.lato(
                    fontSize: 12
                  ),
                ),
              ],
            ),


            /// =================
            /// Created By
            /// =================
            Row(
              children: [
                Text(
                  "created by".tr.toCapitalize(),
                  style: GoogleFonts.lato(
                    color: Colors.grey,
                    fontSize: 12
                  ),
                ),
                const Spacer(),
                Text(
                  stockEntity.createdBy?.name ?? "-",
                  style: GoogleFonts.lato(
                    fontSize: 12
                  ),
                ),
              ],
            ),


            /// =================
            /// Crated At
            /// =================
            Row(
              children: [
                Text(
                  "date created".tr.toCapitalize(),
                  style: GoogleFonts.lato(
                    color: Colors.grey,
                    fontSize: 12
                  ),
                ),
                const Spacer(),
                Text(
                  _getCreatedDate(),
                  style: GoogleFonts.lato(
                    fontSize: 12
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            PAMBottom(
              color: Theme.of(context).primaryColor.withOpacity(.2),
              fontColor: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              title: "update".tr.toCapitalize(),
              onTab: _onTabButtonHandler,
            )
          ],
        ),
      ),
    );
  }
}