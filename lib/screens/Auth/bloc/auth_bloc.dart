import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pro/screens/Auth/AuthRepository/Auth_Repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<SignInRequested>(_onEmailSignIn);
    on<GoogleSignInRequested>(_onGoogleSignIn);
  }

  Future<void> _onEmailSignIn(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signInWithEmail(
        event.email,
        event.password,
      );
      emit(user != null ? AuthSuccess() : AuthFailure("Invalid credentials"));
    } catch (e) {
      emit(AuthFailure("Sign in failed: ${e.toString()}"));
    }
  }

  Future<void> _onGoogleSignIn(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signInWithGoogle();
      emit(user != null ? AuthSuccess() : AuthFailure("Google sign-in failed"));
    } catch (e) {
      emit(AuthFailure("Google sign-in failed: ${e.toString()}"));
    }
  }
}
