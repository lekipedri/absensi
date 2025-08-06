import 'package:absensiapp/services/shared_preferences_services.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'absensi_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _handleLogin() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final user = await AuthService.login(email, password);

    if (user != null) {
      await SharedPrefService.saveString('name', user['name']!);
      await SharedPrefService.saveString('email', user['email']!);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => AbsensiPage(
                  namaUser: user['name']!,
                )),
      );
    } else {
      setState(() {
        _error = 'Email atau password salah';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Absensi')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (_error != null)
              Text(_error!, style: TextStyle(color: Colors.red)),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 24),
            _loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _handleLogin,
                    child: Text('Login'),
                  ),
          ],
        ),
      ),
    );
  }
}
