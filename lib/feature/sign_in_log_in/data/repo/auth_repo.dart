import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/failure.dart';

abstract class AuthRepo {
  Future<Either<Failures,User?>> createUserWithEmail(String name,String email, String password);
  Future<Either<Failures,User?>> logInWithEmail(String email, String password);
  Future<void> signOut();
  Future<Either<Failures,bool>> sendPasswordResetEmail(String email);
  Future<Either<Failures,UserCredential>> signInWithGoogle();
}
