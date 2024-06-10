import 'package:flutter/material.dart';
import 'package:settings_page/viewmodels/auth_viewmodel.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final AuthViewmodel _authViewmodel = AuthViewmodel();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _password = '';

  void onResetPressed() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _authViewmodel.resetPassword(password: _password);
      } catch (e) {
        if (mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Error'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    e.toString(),
                  ),
                ],
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Reset password'),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'New password',
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter password';
                  }
                  return null;
                },
                onSaved: (String? newValue) {
                  _password = newValue ?? '';
                },
              ),
            ),
            TextButton(
              onPressed: onResetPressed,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
