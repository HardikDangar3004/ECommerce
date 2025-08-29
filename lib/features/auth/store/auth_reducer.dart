import 'auth_actions.dart';
import 'auth_state.dart';

AuthState authReducer(AuthState state, dynamic action) {
  if (action is LoginRequested) {
    return state.copyWith(isLoading: true, error: null);
  } else if (action is LoginSuccess) {
    return state.copyWith(
      user: action.user,
      isLoading: false,
      error: null,
      isAuthenticated: true,
    );
  } else if (action is LoginFailure) {
    return state.copyWith(
      isLoading: false,
      error: action.error,
      isAuthenticated: false,
    );
  } else if (action is SignupRequested) {
    return state.copyWith(isLoading: true, error: null);
  } else if (action is SignupSuccess) {
    return state.copyWith(
      user: action.user,
      isLoading: false,
      error: null,
      isAuthenticated: true,
    );
  } else if (action is SignupFailure) {
    return state.copyWith(
      isLoading: false,
      error: action.error,
      isAuthenticated: false,
    );
  } else if (action is LogoutRequested) {
    return state.copyWith(
      user: null,
      isLoading: false,
      error: null,
      isAuthenticated: false,
    );
  } else if (action is AuthStateChanged) {
    return state.copyWith(
      user: action.user,
      isAuthenticated: action.user != null,
    );
  } else if (action is ClearError) {
    return state.copyWith(error: null);
  }
  return state;
}
