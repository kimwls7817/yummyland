import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  // 이메일과 비밀번호로 로그인
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // Google 로그인 메서드 추가
  Future<User?> signInWithGoogle() async {
    try {
      // 사용자가 Google 로그인 선택
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // 로그인 취소 시
      }

      // 인증 정보 가져오기
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Firebase로 인증 정보 전달
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Firebase로 로그인
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print('Error during Google sign in: $e');
      return null;
    }
  }

  // 로그아웃 메서드
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // 현재 유저 확인
  User? get currentUser {
    return _auth.currentUser;
  }
}
