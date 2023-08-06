import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> loadTestEnv() async {
  await dotenv.load(fileName: '.env');
}