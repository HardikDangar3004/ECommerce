import 'package:flutter/material.dart';
import 'custom_text_field.dart';

class CustomTextFieldDemo extends StatefulWidget {
  const CustomTextFieldDemo({super.key});

  @override
  State<CustomTextFieldDemo> createState() => _CustomTextFieldDemoState();
}

class _CustomTextFieldDemoState extends State<CustomTextFieldDemo> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _customController = TextEditingController();

  bool _showErrorBorders = false;
  String? _customErrorText;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _customController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Text Field Demo'),
        actions: [
          IconButton(
            icon: Icon(_showErrorBorders ? Icons.error : Icons.check_circle),
            onPressed: () {
              setState(() {
                _showErrorBorders = !_showErrorBorders;
              });
            },
            tooltip: 'Toggle Error Borders',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Specialized Fields',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),

                      // Email Field
                      CustomEmailField(
                        controller: _emailController,
                        showErrorBorder: _showErrorBorders,
                        onChanged: (value) {
                          setState(() {
                            _customErrorText = value.isEmpty
                                ? 'Email is required'
                                : null;
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      CustomPasswordField(
                        controller: _passwordController,
                        showErrorBorder: _showErrorBorders,
                      ),
                      const SizedBox(height: 16),

                      // Confirm Password Field
                      CustomConfirmPasswordField(
                        controller: _confirmPasswordController,
                        passwordController: _passwordController,
                        showErrorBorder: _showErrorBorders,
                      ),
                      const SizedBox(height: 16),

                      // Name Fields
                      Row(
                        children: [
                          Expanded(
                            child: CustomNameField(
                              controller: _firstNameController,
                              labelText: 'First Name',
                              hintText: 'Enter first name',
                              showErrorBorder: _showErrorBorders,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: CustomNameField(
                              controller: _lastNameController,
                              labelText: 'Last Name',
                              hintText: 'Enter last name',
                              showErrorBorder: _showErrorBorders,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Custom Text Field',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 16),

                      CustomTextField(
                        controller: _customController,
                        labelText: 'Custom Field',
                        hintText: 'This is a custom text field',
                        prefixIcon: Icons.edit,
                        suffixIcon: Icons.info,
                        onSuffixIconPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Info button pressed!'),
                            ),
                          );
                        },
                        showErrorBorder: _showErrorBorders,
                        errorText: _customErrorText,
                        maxLength: 50,
                        onChanged: (value) {
                          setState(() {
                            if (value.length > 30) {
                              _customErrorText = 'Text too long (max 30 chars)';
                            } else {
                              _customErrorText = null;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form is valid!')),
                    );
                  }
                },
                child: const Text('Validate Form'),
              ),

              const SizedBox(height: 16),

              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _emailController.clear();
                    _passwordController.clear();
                    _confirmPasswordController.clear();
                    _firstNameController.clear();
                    _lastNameController.clear();
                    _customController.clear();
                    _customErrorText = null;
                  });
                },
                child: const Text('Clear All Fields'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
