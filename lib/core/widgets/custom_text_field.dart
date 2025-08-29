import 'package:flutter/material.dart';
import '../constants/app_strings.dart';
import '../utils/validation_utils.dart';
import '../constants/app_colors.dart';
import '../ui/ui_padding.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final bool autofocus;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final Color? fillColor;
  final bool filled;
  final String? errorText;
  final bool showErrorBorder;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.autofocus = false,
    this.focusNode,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.textInputAction,
    this.contentPadding,
    this.border,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.fillColor,
    this.filled = false,
    this.errorText,
    this.showErrorBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasError = errorText != null || showErrorBorder;

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      enabled: enabled,
      maxLines: maxLines,
      maxLength: maxLength,
      autofocus: autofocus,
      focusNode: focusNode,
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null
            ? IconButton(icon: Icon(suffixIcon), onPressed: onSuffixIconPressed)
            : null,
        contentPadding:
            contentPadding ??
            UISpacing.symmetric(
              horizontal: UISpacing.padding_16,
              vertical: UISpacing.padding_12,
            ),
        border:
            border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: hasError
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.outline,
                width: hasError ? 2.0 : 1.0,
              ),
            ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: hasError
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.outline,
            width: hasError ? 2.0 : 1.0,
          ),
        ),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: hasError
                    ? Theme.of(context).colorScheme.error
                    : theme.primaryColor,
                width: hasError ? 2.0 : 2.0,
              ),
            ),
        errorBorder:
            errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 2.5,
              ),
            ),
        focusedErrorBorder:
            focusedErrorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 2.5,
              ),
            ),
        fillColor: fillColor,
        filled: filled,
        errorText: errorText,
        errorStyle: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontSize: 12,
        ),
        labelStyle: TextStyle(
          color: hasError ? Theme.of(context).colorScheme.error : null,
        ),
        hintStyle: TextStyle(color: AppColors.textHint),
      ),
    );
  }
}

// Specialized text field variants for common use cases
class CustomEmailField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? errorText;
  final bool showErrorBorder;
  final bool enabled;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final ValueChanged<String>? onFieldSubmitted;

  const CustomEmailField({
    super.key,
    required this.controller,
    this.validator,
    this.errorText,
    this.showErrorBorder = false,
    this.enabled = true,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      labelText: AppStrings.email,
      hintText: AppStrings.enterEmail,
      prefixIcon: Icons.email,
      keyboardType: TextInputType.emailAddress,
      validator: validator,
      errorText: errorText,
      showErrorBorder: showErrorBorder,
      enabled: enabled,
      focusNode: focusNode,
      onChanged: onChanged,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: TextInputAction.next,
    );
  }
}

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final String? errorText;
  final bool showErrorBorder;
  final bool enabled;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  const CustomPasswordField({
    super.key,
    required this.controller,
    this.labelText = 'Password',
    this.hintText = 'Enter your password',
    this.validator,
    this.errorText,
    this.showErrorBorder = false,
    this.enabled = true,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.controller,
      labelText: widget.labelText,
      hintText: widget.hintText,
      prefixIcon: Icons.lock,
      suffixIcon: isPasswordVisible ? Icons.visibility : Icons.visibility_off,
      onSuffixIconPressed: () {
        setState(() {
          isPasswordVisible = !isPasswordVisible;
        });
      },
      obscureText: !isPasswordVisible,
      validator: widget.validator,
      errorText: widget.errorText,
      showErrorBorder: widget.showErrorBorder,
      enabled: widget.enabled,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
    );
  }
}

class CustomConfirmPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController passwordController;
  final String? Function(String?)? validator;
  final String? errorText;
  final bool showErrorBorder;
  final bool enabled;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  const CustomConfirmPasswordField({
    super.key,
    required this.controller,
    required this.passwordController,
    this.validator,
    this.errorText,
    this.showErrorBorder = false,
    this.enabled = true,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  State<CustomConfirmPasswordField> createState() =>
      _CustomConfirmPasswordFieldState();
}

class _CustomConfirmPasswordFieldState
    extends State<CustomConfirmPasswordField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.controller,
      labelText: 'Confirm Password',
      hintText: 'Confirm your password',
      prefixIcon: Icons.lock,
      suffixIcon: isPasswordVisible ? Icons.visibility : Icons.visibility_off,
      onSuffixIconPressed: () {
        setState(() {
          isPasswordVisible = !isPasswordVisible;
        });
      },
      obscureText: !isPasswordVisible,
      validator:
          widget.validator ??
          (value) => ValidationUtils.validateConfirmPassword(
            value,
            widget.passwordController.text,
          ),
      errorText: widget.errorText,
      showErrorBorder: widget.showErrorBorder,
      enabled: widget.enabled,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.textInputAction ?? TextInputAction.done,
    );
  }
}

class CustomNameField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final String? errorText;
  final bool showErrorBorder;
  final bool enabled;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  const CustomNameField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.errorText,
    this.showErrorBorder = false,
    this.enabled = true,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      labelText: labelText,
      hintText: hintText,
      prefixIcon: Icons.person,
      validator: validator,
      errorText: errorText,
      showErrorBorder: showErrorBorder,
      enabled: enabled,
      focusNode: focusNode,
      onChanged: onChanged,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: textInputAction ?? TextInputAction.next,
    );
  }
}
