import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService extends ChangeNotifier {
  User? currentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  void signUp({
    required String email,
    required String password,
    required Function() onSuccess,
    required Function(String err) onError,
  }) async {
    //회원가입
    // 유효성 검사
    if (email.isEmpty) {
      onError("이메일을 입력해 주세요.");
      return;
    } else if (password.isEmpty) {
      onError("비밀번호를 입력해 주세요.");
      return;
    }

    try {
      // 회원가입 요청
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      onSuccess();
      //성공
    } on FirebaseAuthException catch (e) {
      // if (e.code == 'weak-password') {
      //   onError('비밀번호를 6자리 이상 입력해 주세요.');
      // } else if (e.code == 'email-already-in-use') {
      //   onError('이미 가입된 이메일 입니다.');
      // } else if (e.code == 'invalid-email') {
      //   onError('이메일 형식을 확인해주세요.');
      // } else if (e.code == 'user-not-found') {
      //   onError('일치하는 이메일이 없습니다.');
      // } else if (e.code == 'wrong-password') {
      //   onError('비밀번호가 일치하지 않습니다.');
      // } else {
      //   onError(e.message!);
      // }
      // 회원가입 실패 ( 유효성 통과 x )
      onError(e.message!);
    } catch (e) {
      // 서버 error
      onError(e.toString());
    }
  }

  void signIn({
    required String email,
    required String password,
    required Function() onSuccess,
    required Function(String err) onError,
  }) async {
    //로그인
    if (email.isEmpty) {
      onError('이메일을 입력해주세요.');
      return;
    } else if (password.isEmpty) {
      onError('비밀번호를 입력해주세요.');
      return;
    }

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      onSuccess();
      notifyListeners();
      // 로그인 상태 변화 알림
    } on FirebaseAuthException catch (e) {
      onError(e.message!);
    } catch (e) {
      onError(
        e.toString(),
      );
    }
  }

  void signOut() async {
    //로그아웃
    await FirebaseAuth.instance.signOut();
    notifyListeners();
    // 로그아웃 한 뒤 LoginPage 상단 갱신하기 위해 호출
  }
}
