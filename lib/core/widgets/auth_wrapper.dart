import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../store/app_state.dart';
import '../di/service_locator.dart';
import '../routes/app_router.dart';
import '../../features/auth/store/auth_actions.dart';

class AuthWrapper extends StatefulWidget {
  final Widget child;

  const AuthWrapper({super.key, required this.child});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  late Stream<User?> _authStateChanges;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _authStateChanges = ServiceLocator.firebaseAuthService.authStateChanges;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = snapshot.data;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          final store = StoreProvider.of<AppState>(context, listen: false);
          store.dispatch(AuthStateChanged(user));
        });

        if (!_hasNavigated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (user != null) {
              if (ModalRoute.of(context)?.settings.name != AppRouter.products) {
                Navigator.of(context).pushReplacementNamed(AppRouter.products);
              }
            } else {
              if (ModalRoute.of(context)?.settings.name != AppRouter.login) {
                Navigator.of(context).pushReplacementNamed(AppRouter.login);
              }
            }
            _hasNavigated = true;
          });
        }

        return widget.child;
      },
    );
  }
}
