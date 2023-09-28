
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/app/utils/system_utils.dart';
import 'package:pos_application_mobile/presentation/app/sale/controllers/sale_detail_controller.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_badge/pam_badge.dart';

class SaleDetailScreen extends GetView<SaleDetailController> {
  const SaleDetailScreen({super.key});

  Color _getColorBadge(String status) {
    print(status);
    if (status.toLowerCase() == "lunas") return Colors.green[200]!;
    if (status.toLowerCase() == "batal") return Colors.red[200]!;
    if (status.toLowerCase() == "pending") return Colors.yellow[200]!;
    return Colors.grey[200]!;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    SystemUtils.changeStatusAndBottomBarColor(context,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark);
        
    return GetBuilder<SaleDetailController>(builder: (controller) {
      if (controller.isLoading) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      return Scaffold(
        appBar: AppBar(
          title: Text("${"detail".tr} ${"sale".tr}".toCapitalize()),
        ),
        body: SafeArea(
          child: DefaultTabController(
            length: 3, 
            child: NestedScrollView(
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder: _headerContaint,
              body: TabBarView(
                children: [
                  _itemContaint(),
                  _saleContaint(),
                  _purchaseContaint()
                ],
              )
            )
          ),
        ),
      );
    });
  }


  List<Widget> _headerContaint(BuildContext context, bool boolean) {
    return [
      SliverToBoxAdapter(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10)
                      ),
                      color: Colors.black54.withOpacity(.2)
                    ),
                    child: const Icon(Icons.sell, size: 30),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        width: Get.width * .5,
                        child: Flexible(
                          child: Text(
                            (controller.dataDetail.customer?.name ?? "").toCapitalize(),
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      Text(controller.dataDetail.customer?.customerType?.name ?? "")
                    ],
                  ),
                  const Spacer(),
                  PamBadge(
                    text: Text(
                      controller.dataDetail.status ?? "",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold
                      ),
                    ), 
                    color: _getColorBadge(controller.dataDetail.status ?? "")
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text("payment method".tr.toCapitalize()),
                  const Spacer(),
                  Text(
                    (controller.dataDetail.paymentMethod ?? "").toCapitalize(),
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text("${"created".tr} ${"date".tr}".toCapitalize()),
                  const Spacer(),
                  Text(
                    "${
                      DateFormat('dd MM yyyy')
                        .format(DateTime.parse(controller.dataDetail.createdAt!))
                      }  ( ${
                        controller.dataDetail.createdBy!.name
                      } )",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Text("${"updated".tr} ${"date".tr}".toCapitalize()),
                  const Spacer(),
                  Text(
                    "${
                      DateFormat('dd MM yyyy')
                        .format(DateTime.parse(controller.dataDetail.updatedAt!))
                      }  ( ${
                        controller.dataDetail.updatedBy!.name
                      } )",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      )
    ];
  }


  Widget _itemContaint() {
    return Container();
  }


  Widget _saleContaint() {
    return Container();
  }


  Widget _purchaseContaint() {
    return Container();
  }
}