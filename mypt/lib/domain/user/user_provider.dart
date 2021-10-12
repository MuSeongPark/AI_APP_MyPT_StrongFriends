import 'package:get/get.dart';

const host = '0.0.0.0';

class UserProvider extends GetConnect {

  Future<Response> login(Map data) => post('$host/login', data);
  
}