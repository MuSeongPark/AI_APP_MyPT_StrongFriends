import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mypt/screens/home_page.dart';
import 'package:mypt/theme.dart';
import 'package:camera/camera.dart';
// flutter run -d web-server --web-hostname=0.0.0.0

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: theme(),
    );
  }
}
