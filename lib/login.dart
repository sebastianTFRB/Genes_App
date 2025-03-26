import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:genesapp/usersScreen/screens_guias/guias_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter/services.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscureText = true;
  bool _rememberMe = false;
  String _error = '';

  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeIn);
    _animController.forward();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xFF48BB78),
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF4FD1C5),
                  Color(0xFF81E6D9),
                  Color(0xFF48BB78),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Condicional para evitar crash en emuladores x86
          if (!kIsWeb && defaultTargetPlatform != TargetPlatform.linux)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(color: Colors.black.withOpacity(0.1)),
              ),
            ),

          Center(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white70, width: 1),
                  ),
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/genesappLogo-removebg-preview.png',
                        height: 80,
                        filterQuality: FilterQuality.none,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        '¡Bienvenido a GenesApp! 👋',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                        decoration: _inputDecoration(
                          label: 'Correo electrónico',
                          icon: Icons.email,
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                        decoration: _inputDecoration(
                          label: 'Contraseña',
                          icon: Icons.lock,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility : Icons.visibility_off,
                              color: Colors.white,
                            ),
                            onPressed: () => setState(() => _obscureText = !_obscureText),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) => setState(() => _rememberMe = value!),
                            activeColor: Colors.white,
                            checkColor: Colors.teal,
                          ),
                          const Text(
                            'Recordar este correo',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _buildButton(
                        text: 'Ingresar',
                        onPressed: _isLoading ? null : _signInWithEmail,
                        loading: _isLoading,
                      ),
                      const SizedBox(height: 12),
                      _buildOutlinedButton(
                        text: 'Crear cuenta',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const RegisterScreen()),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      SignInButton(
                        Buttons.GoogleDark,
                        text: "Iniciar sesión con Google",
                        onPressed: _signInWithGoogle,
                      ),
                      if (_error.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            _error,
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      TextButton(
                        onPressed: () async {
                          await GoogleSignIn().signOut();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Listo, ahora puedes elegir otra cuenta")),
                          );
                        },
                        child: const Text("¿Usar otra cuenta de Google?", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      prefixIcon: Icon(icon, color: Colors.white),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white70),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required VoidCallback? onPressed,
    bool loading = false,
  }) {
    return SizedBox(
      width: 280,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1FD1AB),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 8,
          shadowColor: Colors.black45,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: loading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                text,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
      ),
    );
  }

  Widget _buildOutlinedButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 280,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }

  Future<void> _signInWithEmail() async {
    if (_emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
      setState(() => _error = 'Por favor completa todos los campos para iniciar sesión');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      await _navigateBasedOnRole(userCredential.user);
    } on FirebaseAuthException catch (e) {
      setState(() => _error = e.message ?? 'Error al iniciar sesión');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (!userDoc.exists) {
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'email': user.email,
            'role': 'patient',
            'created_at': DateTime.now(),
          });
        }

        await _navigateBasedOnRole(user);
      }
    } catch (e) {
      setState(() => _error = 'Error al iniciar sesión con Google');
    }
  }

  Future<void> _navigateBasedOnRole(User? user) async {
    if (!mounted || user == null) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const GuiasScreen()),
    );
  }
}
