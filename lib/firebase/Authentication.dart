import 'package:deliveryapp/Models/DeliveryUser.dart';
import 'package:deliveryapp/firebase/Database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class Authentication {
  static var logger = Logger();
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static DeliveryUser? loginUser;

  static Future<void> signInWithAnonymous() async {
    UserCredential credential = await _firebaseAuth.signInAnonymously();
    if (credential.user != null) {
      logger.i(credential.user!.uid);
    }
  }

  static Future signOutWithGoogle() async {
    try {
      logger.i('sign out complete');
      return await _firebaseAuth.signOut();
    } catch (e) {
      logger.i('sign out failed');
      logger.i(e.toString());
      return null;
    }
  }

  static Future<User?> signInWithGoogle() async {
    User? user;
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? account = await googleSignIn.signIn();
    if (account != null) {
      GoogleSignInAuthentication authentication = await account.authentication;
      OAuthCredential googleCredential = GoogleAuthProvider.credential(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken,
      );

      UserCredential credential =
          await _firebaseAuth.signInWithCredential(googleCredential);
      if (credential.user != null) {
        user = credential.user!;
        logger.i(user);
      }
    } else {
      return Future.error('다시 시도해주세요.');
    }

    return user;
  }

  static Future<User?> signInWithEamilAndPassword(String id, String pw) async {
    User? user;
    String? errorCode;
    try {
      UserCredential credential = await _firebaseAuth
          .signInWithEmailAndPassword(email: id, password: pw);
      if (credential.user != null) {
        logger.i('user Not Null');
        user = credential.user!;

        DeliveryUser? fUser = await Database.getUserbyKey(user.uid);
        if (fUser != null) loginUser = fUser;
      } else {
        logger.i('Server Error');
        errorCode = "서버 에러입니다. 다시 시도해주세요.";
      }
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorCode = "이메일 형식이 아닙니다.";
          break;
        case "user-disabled":
          errorCode = error.code;
          break;
        case "user-not-found":
          errorCode = "가입되지 않은 이용자입니다.";
          break;
        case "wrong-password":
          errorCode = "비밀번호가 다릅니다.";
          break;
        default:
          errorCode = null;
      }
      if (errorCode != null) {
        logger.i(errorCode);
        return Future.error(errorCode);
      }
    }

    return user;
  }

  static Future<DeliveryUser?> createEmailAndPassword(
      String email, String pw) async {
    DeliveryUser? user;
    String? errorCode;

    try {
      UserCredential credential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: pw);
      if (credential.user != null) {
        logger.i(credential.user!);

        User authUser = credential.user!;
        user = DeliveryUser(authUser.uid, "", "", email, pw, "X", "", "");
      } else {
        logger.i('Server Error');
        errorCode = "서버 에러입니다. 다시 시도해주세요.";
      }
    } on FirebaseAuthException catch (error) {
      logger.i(error.code);

      errorCode = error.code;
      switch (error.code) {
        case "email-already-in-use":
          errorCode = "이미 가입된 이메일입니다.";
          break;
        case "invalid-email":
          errorCode = "이메일 형식이 아닙니다.";
          break;
        case "weak-password":
          errorCode = "비밀번호를 길게 설정해주세요.";
          break;
        case "operation-not-allowed":
          break;
        default:
          errorCode = null;
      }

      if (errorCode != null) {
        logger.i(errorCode);
        return Future.error(errorCode);
      }
    }

    return user;
  }
}
