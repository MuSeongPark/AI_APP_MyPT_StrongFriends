import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mypt/screens/home_page.dart';
import 'package:mypt/screens/login_page.dart';
import 'package:mypt/theme.dart';
import 'package:camera/camera.dart';
// flutter run -d web-server --web-hostname=0.0.0.0

List<CameraDescription> cameras = [];


void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  WidgetsFlutterBinding.ensureInitialized();
  //cameras = await availableCameras();
  runApp(const MyApp());
}
/*
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}
*/

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      theme: theme(),
    );
  }
}
