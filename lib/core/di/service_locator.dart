import '../services/firebase_auth_service.dart';
import '../services/local_storage_service.dart';

class ServiceLocator {
  static FirebaseAuthService? _firebaseAuthService;
  static LocalStorageService? _localStorageService;

  static FirebaseAuthService get firebaseAuthService {
    _firebaseAuthService ??= FirebaseAuthService();
    return _firebaseAuthService!;
  }

  static Future<void> init() async {
    try {
      // Initialize services
      _firebaseAuthService = FirebaseAuthService();
      _localStorageService = LocalStorageService();
    } catch (e) {
      // Handle initialization error
    }
  }

  static void dispose() {
    // Clean up resources if needed
    _firebaseAuthService = null;
    _localStorageService = null;
  }

  static LocalStorageService get localStorageService {
    _localStorageService ??= LocalStorageService();
    return _localStorageService!;
  }
}
