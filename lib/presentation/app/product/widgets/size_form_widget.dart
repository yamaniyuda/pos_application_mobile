part of 'color_form_widget.dart';

class SizeFormWidget extends StatelessWidget {
  const SizeFormWidget({
    super.key,
    required this.controller,
    required this.index,
    required this.indexSize
  });

  final ProductFormController controller;
  final int index;
  final int indexSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            "${"size".tr} ${controller.clothSizePayloads[index][indexSize].name}".toCapitalize(),
            textAlign: TextAlign.start,
            style: GoogleFonts.lato(
              fontSize: 16
            ),
          ),
        ),
        const Divider(
          thickness: 2,
          color: Colors.black54,
        ),
        Container(
          width: 100,
          height: 3,
          margin: const EdgeInsets.only(bottom: 10),
          alignment: Alignment.centerRight,
          child: const Divider(
            thickness: 2,
            color: Colors.black54,
          ),
        ),
        TextFormField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            isDense: true,
            border: const OutlineInputBorder(),
            filled: true,
            labelText: 'stok',
            alignLabelWithHint: false,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            fillColor: Colors.black.withOpacity(.05)
          ),
          onChanged: (value) => controller.clothSizePayloads[index][indexSize].stock = int.parse(value),
          initialValue: (controller.clothSizePayloads[index][indexSize].stock).toString(),
          onSaved: (newValue) {
            controller.clothSizePayloads[index][indexSize].stock = int.parse(newValue!);
            controller.clothSizePayloads[index][indexSize].sizeId = controller.clothSizePayloads[index][indexSize].sizeId;
          },
          inputFormatters: [
            FilteringTextInputFormatter.deny(
              RegExp(r'^0+'),
            ),
          ],
          keyboardType: TextInputType.number,
        ),
        ...controller.dataClothPriceTypes.asMap().entries.map<Widget>(
          (d) => Container(
            margin: const EdgeInsets.only(top: 20),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10),
                isDense: true,
                border: const OutlineInputBorder(),
                filled: true,
                labelText: d.value.name,
                alignLabelWithHint: false,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                fillColor: Colors.black.withOpacity(.05)
              ),
              onChanged: (value) => controller.clothPricePayloads[index][indexSize][d.key].price = int.parse(value ?? "0"),
              initialValue: (controller.clothPricePayloads[index][indexSize][d.key].price ?? 0).toString(),
              onSaved: (newValue) {
                final price = int.parse(newValue!.isEmpty ? '0' : newValue);
                controller.clothPricePayloads[index][indexSize][d.key].price = price;
              },
              inputFormatters: [
                FilteringTextInputFormatter.deny(
                  RegExp(r'^0+'),
                ),
              ],
              keyboardType: TextInputType.number,
            ),
          ),
        ).toList(),
      ],
    );
  }
}
