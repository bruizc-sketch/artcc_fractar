import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _authService = AuthService(); // Lógica de Firebase
  
  bool _isLoading = false;
  bool _esRegistro = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      if (_esRegistro) {
        // Registro
        await _authService.registro(
          _emailController.text.trim(), 
          _passController.text.trim()
        );
        if(mounted) ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("¡Bienvenido a ArtCC Fractar!"))
        );
      } else {
        // Login
        await _authService.login(
          _emailController.text.trim(), 
          _passController.text.trim()
        );
      }
      
      if (mounted) {
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen())
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.redAccent,
        )
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[50],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.palette_outlined, 
                    size: 80, 
                    color: Colors.deepPurple
                  ),
                ),
                const SizedBox(height: 20),
                
                const Text(
                  "ArtCC Fractar",
                  style: TextStyle(
                    fontSize: 32, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.deepPurple
                  ),
                ),
                const Text(
                  "Gestión de Stock Educativo",
                  style: TextStyle(
                    fontSize: 16, 
                    color: Colors.grey,
                    letterSpacing: 1.1
                  ),
                ),
                const SizedBox(height: 40),

                // CAMPO EMAIL
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Correo Institucional",
                    prefixIcon: const Icon(Icons.alternate_email, color: Colors.deepPurple),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                    ),
                  ),
                  validator: (v) => (v == null || !v.contains('@')) ? "Email inválido" : null,
                ),
                const SizedBox(height: 16),

                // CAMPO CONTRASEÑA
                TextFormField(
                  controller: _passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    prefixIcon: const Icon(Icons.lock_outline, color: Colors.deepPurple),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                    ),
                  ),
                  validator: (v) => (v == null || v.length < 6) ? "Mínimo 6 caracteres" : null,
                ),
                const SizedBox(height: 30),

                // BOTÓN PRINCIPAL
                _isLoading
                    ? const CircularProgressIndicator(color: Colors.deepPurple)
                    : SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            _esRegistro ? "REGISTRARSE" : "INGRESAR AL SISTEMA",
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                
                const SizedBox(height: 20),

                // CAMBIAR MODO
                TextButton(
                  onPressed: () => setState(() => _esRegistro = !_esRegistro),
                  child: Text(
                    _esRegistro 
                      ? "¿Ya tienes cuenta? Inicia Sesión" 
                      : "¿No tienes acceso? Crea una cuenta",
                    style: TextStyle(color: Colors.deepPurple[700], fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}