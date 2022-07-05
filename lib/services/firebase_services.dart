import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  static final FirebaseServices _instance = FirebaseServices._internal();

  factory FirebaseServices() {
    return _instance;
  }

  FirebaseServices._internal();

  late User _userInfo;

  User get userInfo => _userInfo;

  void initializationUserInfo() {
    _userInfo = FirebaseAuth.instance.currentUser!;
  }

  Future<UserCredential> signInWithGoogle() async {
    // 구글 로그인 진행 및 구글 로그인을 위한 정보 획득
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // 파이어베이스 사용자 로그인 진행 및 로그인 정보 반환
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // 파이어베이스 로그아웃 및 구글 로그아웃을 진행하는 메소드
  Future<void> signOutFromGoogle() async {
    // 구글 로그아웃 진행
    await GoogleSignIn().signOut();

    // 파이어베이스 로그아웃 진행
    await FirebaseAuth.instance.signOut();
  }
}
