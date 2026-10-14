import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/feature/sign_in_log_in/data/repo/auth_repo.dart';
import 'package:my_store/feature/sign_in_log_in/presentation/manger/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepo}) : super(AuthInitial());
  final AuthRepo authRepo;
  Future<void> createUserWithEmail(
    String email,
    String password,
    String name,
  ) async {
    emit(AuthLoading());
    final result = await authRepo.createUserWithEmail(email, password, name);
    result.fold(
      (failure) {
        emit(AuthFailure(failure.errorMessage));
      },
      (user) {
        emit(AuthSuccess(user!));
      },
    );
  }

  Future<void> logIn(String email, String password) async {
    emit(AuthLoading());
    final result = await authRepo.logInWithEmail(email, password);
    result.fold(
      (failure) {
        emit(AuthFailure(failure.errorMessage));
      },
      (user) {
        emit(AuthSuccess(user!));
      },
    );
  }

  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      emit(AuthFailure("الرجاء إدخال البريد الإلكتروني أولاً."));
      return;
    }
    emit(AuthLoading());
    final result = await authRepo.sendPasswordResetEmail(email);
    result.fold(
      (failure) {
        emit(AuthFailure(failure.errorMessage));
      },
      (success) {
        emit(
          AuthPasswordResetSuccess(
            "تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني.",
          ),
        );
      },
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());
    await authRepo.signOut();
    emit(AuthLoggedOut());
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    final result = await authRepo.signInWithGoogle();
    result.fold(
      (failure) {
        emit(AuthFailure(failure.errorMessage));
      },
      (user) {
        emit(AuthSuccess(user.user!));
      },
    );
  }




}
