import 'package:get/get.dart';

///
/// Message for translation
///
class Messages extends Translations {
  final Map<String, Map<String, String>> language;
  Messages({ required this.language });

  @override
  Map<String, Map<String, String>> get keys => language;
}