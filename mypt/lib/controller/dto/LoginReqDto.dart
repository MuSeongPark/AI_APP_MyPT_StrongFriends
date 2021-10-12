class LoginReqDto {
  final String? username;
  final String? password;

  LoginReqDto(this.username, this.password);

  Map<String, dynamic> toJson(String username, String password) => {
        'username': username,
        'password': password,
      };
}
