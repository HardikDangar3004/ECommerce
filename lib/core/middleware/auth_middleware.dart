import 'package:redux/redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../features/auth/store/auth_actions.dart';
import '../di/service_locator.dart';

class AuthMiddleware extends MiddlewareClass {
  @override
  void call(Store store, dynamic action, NextDispatcher next) {
    // First, let the action go through to the reducer
    next(action);

    // Then handle side effects
    if (action is LoginRequested) {
      _handleLogin(store, action, next);
    } else if (action is SignupRequested) {
      _handleSignup(store, action, next);
    } else if (action is LogoutRequested) {
      _handleLogout(store, next);
    } else if (action is AuthStateChanged) {
      // This action is dispatched by the auth state listener
      // No additional processing needed
    }
  }

  Future<void> _handleLogin(
    Store store,
    LoginRequested action,
    NextDispatcher next,
  ) async {
    try {
      final authService = ServiceLocator.firebaseAuthService;
      final userCredential = await authService.signInWithEmailAndPassword(
        email: action.email,
        password: action.password,
      );

      // Update user profile with display name if available
      if (userCredential.user != null) {
        await authService.updateUserProfile(
          displayName: userCredential.user!.displayName,
        );
      }

      next(LoginSuccess(userCredential.user!));
    } catch (e) {
      next(LoginFailure(e.toString()));
    }
  }

  Future<void> _handleSignup(
    Store store,
    SignupRequested action,
    NextDispatcher next,
  ) async {
    try {
      final authService = ServiceLocator.firebaseAuthService;
      final userCredential = await authService.createUserWithEmailAndPassword(
        email: action.email,
        password: action.password,
      );

      // Update user profile with first and last name if provided
      if (userCredential.user != null &&
          action.firstName != null &&
          action.lastName != null) {
        final displayName = '${action.firstName} ${action.lastName}'.trim();
        await authService.updateUserProfile(displayName: displayName);
      }

      next(SignupSuccess(userCredential.user!));
    } catch (e) {
      next(SignupFailure(e.toString()));
    }
  }

  Future<void> _handleLogout(Store store, NextDispatcher next) async {
    try {
      final authService = ServiceLocator.firebaseAuthService;
      await authService.signOut();
      // The AuthStateChanged action will be dispatched by the auth state listener
    } catch (e) {
      // Handle logout error if needed
    }
  }
}
