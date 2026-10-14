import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_store/core/errors/failure.dart';
import 'package:my_store/core/util/hive_boxes.dart';
import 'package:my_store/feature/sign_in_log_in/data/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<Either<Failures, User?>> logInWithEmail(
    String email,
    String password,
  ) async {
    try {
      // هنا يجب أن يكون تسجيل دخول وليس إنشاء حساب
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Hive.box(HiveBoxes.basicBox).put(HiveBoxes.kIsLoginBox, true);

      return right(credential.user);
    } on FirebaseAuthException catch (e) {
      print(e.message.toString());
      return left(ServerFailure(_handleAuthException(e)));
    } catch (e) {
      print(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, User?>> createUserWithEmail(
    String name,
    String email,
    String password,
  ) async {
    try {
      // هنا إنشاء حساب جديد
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await credential.user!.updateDisplayName(name);
      await credential.user!.reload(); // لإعادة تحميل البيانات وتأكيد الحفظ
      Hive.box(HiveBoxes.basicBox).put(HiveBoxes.kIsLoginBox, true);
      return right(credential.user);
    } on FirebaseAuthException catch (e) {
      return left(ServerFailure(_handleAuthException(e)));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  // دالة مساعدة لتوضيح الأخطاء
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'المستخدم غير موجود';
      case 'wrong-password':
        return 'كلمة المرور خاطئة';
      case 'email-already-in-use':
        return 'البريد الإلكتروني مسجل بالفعل';
      case 'weak-password':
        return 'كلمة المرور ضعيفة جداً';
      case 'invalid-email':
        return 'صيغة البريد الإلكتروني غير صحيحة';
      default:
        return e.message.toString();
    }
  }

  @override
  Future<void> signOut() async {
    Hive.box(HiveBoxes.basicBox).put(HiveBoxes.kIsLoginBox, false);
    await _auth.signOut();}


  @override
  Future<Either<Failures, bool>> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return right(true);
    } on FirebaseAuthException catch (e) {
      return left(ServerFailure(e.message ?? 'خطأ في إرسال البريد'));
    }
  }

  bool _isGoogleSignInInitialized = false;

  Future<void> _ensureGoogleSignInInitialized() async {
    if (!_isGoogleSignInInitialized) {
      await GoogleSignIn.instance.initialize(
        serverClientId:
            '35113220655-tphn70t8s3sf1bg6nf57tsotcrmrpfs3.apps.googleusercontent.com',
      );
      _isGoogleSignInInitialized = true;

    }
  }

  @override
  Future<Either<Failures, UserCredential>> signInWithGoogle() async {
    try {
      await _ensureGoogleSignInInitialized();
      final GoogleSignInAccount googleUser =
          await GoogleSignIn.instance.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      if (googleAuth.idToken == null) {
        return left(ServerFailure('تعذر الحصول على ID Token من Google'));
      }

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      Hive.box('settings').put('isLogin', true);
      return right(
        await FirebaseAuth.instance.signInWithCredential(credential),
      );

    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return left(ServerFailure('تم إلغاء تسجيل الدخول'));
      }
      return left(
        ServerFailure('خطأ في Google Sign-In: ${e.description ?? e.code.name}'),
      );
    } on FirebaseAuthException catch (e) {
      return left(
        ServerFailure(e.message ?? 'حدث خطأ الرجاء المحاولة مرة اخرى لاحقا'),
      );
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
