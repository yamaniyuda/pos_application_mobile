// ignore_for_file: overridden_fields, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pos_application_mobile/app/extensions/string_extention.dart';
import 'package:pos_application_mobile/app/utils/system_utils.dart';
import 'package:pos_application_mobile/domain/entities/cloth_color_entity.dart';
import 'package:pos_application_mobile/presentation/app/product/controllers/product_detail_controller.dart';
import 'package:pos_application_mobile/presentation/app/product/product.dart';
import 'package:pos_application_mobile/presentation/app/product/widgets/setting_detail_widget.dart';
import 'package:pos_application_mobile/presentation/widgets/pam_bottom/pam_bottom_sheet.dart';

class ProductDetailScreen extends GetView<ProductDetailController> {
  const ProductDetailScreen({super.key});


  void _deleteSizeHandler(String id) {

  }

  void _editSizeHandler() {

  }


  /// Cloth Color Add Handler.
  /// 
  /// The `cloth color add handler` this is function for handling add cloth color
  /// to redirect to [ProductFormScreen] and will trigger update current data when
  /// back from [ProductFormScreen] is is string result.
  void _clothColorAddHandler() async {
    final result = await Get.to(
      ProductFormScreen(
        type: ProductFormScreenType.addClothColor,
        hiddenColors: controller.dataDetail.clothColors?.map<String>((e) => e.color?.id ?? "").toList(),
      ),
      arguments: {
        "id": controller.dataDetail.id
      },
      binding: BindingsBuilder(() {
        Get.put(ProductFormController());
      })
    );

    if (result is String) {
      controller.fetchDetailData();
    }
  }


  /// Add Cloth Size Handler.
  /// 
  /// The `_addClothSizeHandler` will addn new cloth size in current color.
  /// When do add cloth size this function will redirect to [ProductFormScreen] and
  /// set arguments with [id] and [cloth_color_id] the will used for pos idenifier.
  void _addClothSizeHandler(ClothColorEntity clothColor) async {
    final result = await Get.to(
      ProductFormScreen(
        type: ProductFormScreenType.addClothSize,
        showColor: false,
        hiddenSizes: clothColor.clothSizes!.map<String>((e) => e.size?.id ?? "").toList(),
        chooseColorValue: [clothColor.color!],
      ),
      arguments: {
        "id": controller.dataDetail.id,
        "cloth_color_id": clothColor.id
      },
      binding: BindingsBuilder(() {
        Get.put(ProductFormController());
      })
    );

    if (result is String) {
      controller.fetchDetailData();
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    SystemUtils.changeStatusAndBottomBarColor(context,
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark);

    return Obx(() {
      if (controller.isLoading) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(controller.dataDetail.clothCategory!.name!.toCapitalize()),

        ),
        body: SafeArea(
          child: DefaultTabController(
            length: controller.dataDetail.clothColors!.length,
            child: NestedScrollView(
              // controller: controller.scrollController,
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: _bodyContent(context),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 20),
                  ),
                  SliverAppBar(
                    pinned: true,
                    elevation: 10, 
                    automaticallyImplyLeading: false,
                    forceElevated: true,
                    shadowColor: Colors.black54,
                    flexibleSpace: PreferredSize(
                      preferredSize: const Size.fromHeight(0),
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 50),
                            child: _tabBar(context)
                          ),
                          IconButton(
                            onPressed: _clothColorAddHandler, 
                            icon: const Icon(Icons.add)
                          ),
                        ],
                      ),
                    ),
                  )
                ];
              }, 
              body: TabBarView(
                children: controller.dataDetail.clothColors!.map<Widget>((e) {
                  return _tableColor(e);
                }).toList(),
              ),
            ),
          )
        ),
      );
    });
  }


  /// Renders a table of cloth sizes and their corresponding stock and prices.
  ///
  /// This function takes a [clothColor] as input and generates a table of cloth
  /// sizes, their stock quantities, and prices for each size.
  ///
  /// [clothColor]: The cloth color entity for which to display the sizes and prices.
  Widget _tableColor(ClothColorEntity clothColor) {
    final numberFormatter = NumberFormat.currency(locale: "id_ID");

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(Get.context!).primaryColor
            ),
            onPressed: () => _addClothSizeHandler(clothColor),
            child: SizedBox(
              width: 130,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.add, color: Colors.white),
                  Text("${"add".tr} ${"size".tr}".toCapitalize())
                ],
              ),
            )
          ),
        ),
        ..._listClothSize(clothColor, numberFormatter).toList()
      ],
    );
  }


  /// List Cloth Size.
  /// 
  /// The `_listCLothSize` is listing widget for size data each color.
  /// 
  Iterable<Widget> _listClothSize(ClothColorEntity clothColor, NumberFormat numberFormatter) {
    return clothColor.clothSizes!.map<Widget>((e) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${"size".tr} ${e.size?.name}".toCapitalize(),
            style: GoogleFonts.lato(
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 10),
          Table(
            columnWidths: {
              0: const FlexColumnWidth(16),
              1: const FlexColumnWidth(7)
            },
            children: [
              TableRow(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    // controller: controller.scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: Get.width * .2,
                              child: Text(
                                "stock".tr.toCapitalize(),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            ...e.clothSizePrices!.map<Widget>((f) {
                              return SizedBox(
                                width: Get.width * .34,
                                child: Text(
                                  f.clothPriceType!.name!,
                                  textAlign: TextAlign.end,
                                ),
                              );
                            }).toList(),
                            const SizedBox(width: 20)
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: Get.width * .2,
                              child: Text(
                                (e.stock ?? 0).toString(),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            ...e.clothSizePrices!.map<Widget>((f) {
                              return SizedBox(
                                width: Get.width * .34,
                                child: Text(
                                  numberFormatter.format(f.price),
                                  textAlign: TextAlign.end,
                                ),
                              );
                            }).toList()
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: -9,
                          offset: Offset(0, 2)
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: _editSizeHandler, 
                                icon: const Icon(Icons.edit, color: Colors.amber,)
                              ),
                              IconButton(
                                onPressed: () => _deleteSizeHandler(e.id!), 
                                icon: const Icon(Icons.delete, color: Colors.red)
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]
              )
            ],
          ),
        ],
      );
    });
  }


  /// Body Content Items Caraouser.
  /// The `_bodyContentItemsCaraouser` will do handling image for banner.
  /// if [controller.imageData] is empety this function will return dammy data
  /// sum 3, and when data exist in [controller.imageData] will show data exist
  /// with dummy image for error handling when image 404 when in fetch from
  /// remote storage.
  List<Widget> _bodyContentItemsCaraouser() {
    if (controller.imageData.isEmpty) {
      return [1, 2, 3].map((e) {
        return Builder(
          builder: (context) {
            return SizedBox(
              width: Get.width,
              child: Image.asset(
                "assets/images/img_placeholder.png",
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList();
    }

    return controller.imageData.map((e) {
      return Image.network(
        e.image!,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            "assets/images/img_placeholder.png",
            fit: BoxFit.cover,
          );
        },
      );
    }).toList();
  }

  Widget _bodyListImageBottomBanner() {
    return Obx(() => ListView(
      scrollDirection: Axis.horizontal,
      children: _bodyContentItemsCaraouser(),
    ));
  }


  /// Renders the main body content with product information.
  ///
  /// This method builds the UI for product information, including name,
  /// createdBy, and creation date.
  ///
  /// [context]: The BuildContext for the current widget tree.
  Widget _bodyContent(BuildContext context) {
    DateTime createdAt = DateTime.parse(controller.dataDetail.createdAt!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Container(
          color: Colors.black54,
          child: CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1
            ),
            items: _bodyContentItemsCaraouser(),
          ),
        )),
        SizedBox(
          height: 70,
          child: _bodyListImageBottomBanner(),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            children: [
              Text(
                controller.dataDetail.createdBy!.name!,
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor,
                  fontSize: 14.sp
                ),
              ),
              const Spacer(),
              PAMBottomSheet(
                buttom: const Icon(Icons.more_vert),
                title: "${"setting".tr} ${"product".tr}".toCapitalize(),
                bottomSheet: const SettingDetailWidget(),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            controller.dataDetail.clothCategory!.name!.toCapitalize(),
            style: GoogleFonts.lato(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "information".tr.toCapitalize(),
            style: GoogleFonts.lato(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    Text(
                      "created date".tr.toCapitalize(),
                      style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 50),
                    Text(
                        ": ${createdAt.day}-${createdAt.month}-${createdAt.year}"),
                  ],
                ),
              ),
              SizedBox(
                width: Get.width * .5,
                child: Row(
                  children: [
                    Text(
                      "updated date".tr.toCapitalize(),
                      style: GoogleFonts.lato(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 50),
                    const Text(": -"),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }


  /// Renders the TabBar widget for displaying cloth colors.
  ///
  /// This function creates and returns a TabBar widget that displays cloth colors
  /// as tabs.
  ///
  /// [context]: The BuildContext for the current widget tree.
  TabBar _tabBar(BuildContext context) {
    return TabBar(
      unselectedLabelColor: Colors.black54,
      labelColor: Theme.of(context).primaryColor,
      indicatorColor: Theme.of(context).primaryColor,
      indicatorWeight: 3,
      isScrollable: true,

      tabs: controller.dataDetail.clothColors!.map<Widget>((e) {
        final String nameColor = e.color?.name ?? "-";
        return Tab(
          child: Text(
            nameColor,
            style: GoogleFonts.lato(
              fontSize: 14
            ),
          ),
        );
      }).toList(),
    );
  }
}
