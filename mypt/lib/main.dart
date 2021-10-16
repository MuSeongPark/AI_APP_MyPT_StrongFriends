import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mypt/firebase/authcheck.dart';
import 'package:mypt/screens/home_page.dart';



import 'package:mypt/screens/login_page.dart';
import 'package:mypt/theme.dart';
import 'package:camera/camera.dart';
// flutter run -d web-server --web-hostname=0.0.0.0

List<CameraDescription> cameras = [];

/*
void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  WidgetsFlutterBinding.ensureInitialized();
  // cameras = await availableCameras();
  runApp(const MyApp());
}
*/

// 아래는 앱으로 사용할시 주석을 없앰


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  // firebase 불러오기
  await Firebase.initializeApp();
  // final userCollectionReference = FirebaseFirestore.instance
  //     .collection('push_up')
  //     .doc('9AhwIW8za57Rq9AJA7MB');
  // userCollectionReference.get().then((value) => print(value.data()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      home: Authcheck(),
      debugShowCheckedModeBanner: false,
      theme: theme(),
    );
  }
}
