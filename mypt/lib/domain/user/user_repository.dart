
import 'package:get/get_connect.dart';
import 'package:mypt/controller/dto/LoginReqDto.dart';
import 'package:mypt/domain/user/user_provider.dart';

class UserRepository {

  final UserProvider _userProvider = UserProvider();

  Future<void> login(String username, String password) async {
    LoginReqDto loginReqDto = LoginReqDto(username, password);
    Response response = await _userProvider.login(loginReqDto.toJson(username, password));

    print(response);
  }

}