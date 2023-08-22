// ignore_for_file: unused_element

part of 'customer_type_form_screen.dart';

class _SelectOptionCustomerTypeScreen extends StatelessWidget {
  _SelectOptionCustomerTypeScreen({super.key});
  Rx<String> _value = ''.obs;

  void changeRadioSelection(String value) {
    _value.value = value;
  }  

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    _value.value = "${arguments["data"]}";

    List<Map<String, String>> reasonReportTypes = [
      { "label": "general".tr.toCapitalize(), "value": "umum" },
      { "label": "shopee".tr.toCapitalize(), "value": "shopee" },
      { "label": "tiktok".tr.toCapitalize(), "value": "tiktok" },
      { "label": "distributor".tr.toCapitalize(), "value": "distributor" },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('choosee customer type'.tr.toCapitalize()),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "choosee customer category"
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: reasonReportTypes.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => changeRadioSelection(reasonReportTypes[index]["value"]!),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: index != (reasonReportTypes.length - 1)
                                  ? Colors.black54
                                  : Colors.transparent
                            )
                          )
                        ),
                        child: Obx(() => Row(
                          children: [
                            Radio(
                              value: reasonReportTypes[index]["value"] as String,
                              groupValue: _value.value,
                              onChanged: (String? value) {
                                changeRadioSelection(value!);
                              }
                            ),
                            Flexible(
                              child: Text(
                                reasonReportTypes[index]["label"]!,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ))
                      )
                    );
                  }
                )
              ),
              PAMBottom(
                title: "choosee customer type".tr.toCapitalize(),
                isLoading: false,
                borderRadius: BorderRadius.circular(10),
                onTab: () async {
                  
                },
              )
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: 20),
              //   child: Button(
              //     loading: false,
              //     child: Text(
              //       AppLocalizations.of(context)!.confirmation,
              //       style: primaryText.copyWith(
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //     onPressed: () async {
              //       Navigator.pop(context, _radioSelected);
              //     },
              //   ),
              // )
            ],
          ),
        )
      ),
    );
  }
}