import 'package:cloud_firestore/cloud_firestore.dart';

// 사용자의 uid를 받아요.
class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user_file');

//회원가입시 사용자가 입력한 email, password를 받아서
  Future updateUserData(
    String _email,
    String _password,
  ) async {
//user_file 컬렉션에서 고유한 uid document를 만들고 그 안에 email, password 필드값을 채워넣어요.
    return await userCollection.doc(uid).set({
      'email': _email,
      'password': _password,
    });
  }
}
