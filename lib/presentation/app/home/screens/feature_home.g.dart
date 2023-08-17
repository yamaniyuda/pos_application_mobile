part of 'home_screen.dart';

/// this is widgets use for handling ui render
/// not just render this widget also will render specific user
class _FeatureHome extends GetView<HomeController> {
  List<double> _weeklySummery = [
    4.2,
    5.2,
    42.2,
    12.5,
    49.4,
    23.5,
    22.4
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            controller: controller.tabController,
            labelColor: Theme.of(context).primaryColor,
            indicatorColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(
                child: Text(
                  "purchase".tr.toCapitalize(),
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "booking".tr.toCapitalize(),
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor
                  ),
                ),
              )
            ]
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: Get.height * 0.5,
            child: TabBarView(
              controller: controller.tabController,
              children: [
                Center(
                  child: SizedBox(
                    height: 200,
                    child: BarCharWidget(weeklySummary: _weeklySummery),
                  ),
                ),
                const Center(
                  child: Text("booking"),
                ),
              ]
            )
          ),
        ],
      ),
    );
  }
}