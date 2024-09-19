import 'package:flutter/gestures.dart'; //para verificar cuando se da click al texto de "recuperala"
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController(); //useState
  final _passwordController = TextEditingController(); //useState

  void _login() {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Aquí puedes agregar la lógica para iniciar sesión con Firebase
    print("Email: $email, Password: $password");
  }

  @override
  Widget build(BuildContext context) {
    const Color customColor = Color.fromARGB(210, 81, 232, 55);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Iniciar sesion',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 800,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    prefixIcon: const Icon(Icons.email, color: customColor),
                    focusedBorder: OutlineInputBorder(
                      //color del borde para cuando esta seleccionado
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: customColor,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      //color del borde para cuando No esta seleccionado
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: customColor.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 800,
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Iniciar Sesión'),
              ),
              const SizedBox(height: 16),
              // Texto con enlace de recuperación de contraseña
              RichText(
                //permite usar varios tipos de textos en una misma linea
                text: TextSpan(
                  text: '¿Olvidaste tu clave? ',
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Recupérala',
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer() //de libreria importada
                        ..onTap = () {
                          // Navegar a otra pantalla o acción
                          Navigator.pushNamed(context, '/');
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              RichText(
                //permite usar varios tipos de textos en una misma linea
                text: TextSpan(
                  text: '¿No tienes una cuenta? ',
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'Creala',
                      style: const TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer() //de libreria importada
                        ..onTap = () {
                          // Navegar a otra pantalla o acción
                          Navigator.pushNamed(context, '/');
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
