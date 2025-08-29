import 'package:ecommerce_demo/core/ui/ui_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../../../core/store/app_state.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validation_utils.dart';
import '../../store/auth_actions.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/ui/ui_space.dart';
import '../../../../core/ui/ui_padding.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();
  // Visibility handled inside custom widgets
  // bool _isPasswordVisible = false;
  // bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (store) => _ViewModel.fromStore(store),
      builder: (context, viewModel) {
        return Scaffold(
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).unfocus(),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return _buildMobileLayout(context, viewModel);
                } else if (constraints.maxWidth < 900) {
                  return _buildTabletLayout(context, viewModel);
                } else {
                  return _buildDesktopLayout(context, viewModel);
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context, _ViewModel viewModel) {
    return SingleChildScrollView(
      padding: UISpacing.all(UISpacing.padding_24),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLogo(context),
            sizedBoxH32,
            _buildSignupForm(context, viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context, _ViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(UIRadius.radius_12),
                bottomRight: Radius.circular(UIRadius.radius_12),
              ),
            ),
            child: Center(child: _buildLogo(context)),
          ),
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            padding: UISpacing.all(UISpacing.padding_48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_buildSignupForm(context, viewModel)],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, _ViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
            ),
            child: Center(child: _buildLogo(context)),
          ),
        ),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            padding: UISpacing.all(UISpacing.padding_64),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_buildSignupForm(context, viewModel)],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.shopping_cart,
          size: 48.0,
          color: Colors.white, // Always white for good contrast on gradient
        ),
        sizedBoxH16,
        Text(
          AppStrings.appName,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Colors.white, // Always white for good contrast on gradient
            fontWeight: FontWeight.bold,
          ),
        ),
        sizedBoxH8,
        Text(
          AppStrings.appDescription,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.white70,
          ), // Use white70 for subtitle
        ),
      ],
    );
  }

  Widget _buildSignupForm(BuildContext context, _ViewModel viewModel) {
    return Card(
      child: Padding(
        padding: UISpacing.all(UISpacing.padding_24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppStrings.createAccount,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              sizedBoxH8,
              Text(
                AppStrings.signUpToAccount,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.textHint),
                textAlign: TextAlign.center,
              ),
              sizedBoxH32,
              CustomEmailField(
                controller: _emailController,
                validator: ValidationUtils.validateEmail,
                showErrorBorder: viewModel.error != null,
                focusNode: _emailFocus,
                onFieldSubmitted: (_) => _passwordFocus.requestFocus(),
              ),
              sizedBoxH16,
              CustomPasswordField(
                controller: _passwordController,
                validator: ValidationUtils.validatePassword,
                textInputAction: TextInputAction.next,
                focusNode: _passwordFocus,
                onFieldSubmitted: (_) => _confirmPasswordFocus.requestFocus(),
              ),
              sizedBoxH16,
              CustomConfirmPasswordField(
                controller: _confirmPasswordController,
                passwordController: _passwordController,
                focusNode: _confirmPasswordFocus,
                onFieldSubmitted: (_) => _handleSignup(),
              ),
              // Show error message if any
              if (viewModel.error != null) ...[
                sizedBoxH16,
                Container(
                  padding: UISpacing.all(UISpacing.padding_12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.error.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Theme.of(context).colorScheme.error,
                        size: 20,
                      ),
                      sizedBoxW16,
                      Expanded(
                        child: Text(
                          viewModel.error!,
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onErrorContainer,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.error,
                          size: 20,
                        ),
                        onPressed: () {
                          final store = StoreProvider.of<AppState>(
                            context,
                            listen: false,
                          );
                          store.dispatch(ClearError());
                        },
                      ),
                    ],
                  ),
                ),
              ],
              sizedBoxH24,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: viewModel.isLoading ? null : _handleSignup,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: UISpacing.padding_16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(UIRadius.radius_12),
                    ),
                  ),
                  child: viewModel.isLoading
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(AppStrings.signup),
                ),
              ),
              sizedBoxH16,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.alreadyHaveAccount),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(AppStrings.signIn),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      final store = StoreProvider.of<AppState>(context, listen: false);
      store.dispatch(
        SignupRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }
}

class _ViewModel {
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;

  _ViewModel({
    required this.isLoading,
    required this.error,
    required this.isAuthenticated,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      isLoading: store.state.authState.isLoading,
      error: store.state.authState.error,
      isAuthenticated: store.state.authState.isAuthenticated,
    );
  }
}
