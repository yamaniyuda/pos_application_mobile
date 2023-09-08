import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PAMImageFormController extends GetxController {
  /// Wraping selected image.
  final RxList<XFile> selectedImages = <XFile>[].obs;
}