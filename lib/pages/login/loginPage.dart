import 'package:biblioteca/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart'; //para verificar cuando se da click al texto de "recuperala"
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationService authService = AuthenticationService();
  final db = FirebaseFirestore.instance;

  LoginPage({super.key});

  void _login(BuildContext context) {
    //funcion que se llamara para hacer la conceccion
    // String email = _emailController.text;
    // String password = _passwordController.text;
    authService.signInWithEmailAndPassword(
        context, _emailController.text, _passwordController.text);
    //Navigator.pushNamed(context, '/home');
    // Aquí puedes agregar la lógica para iniciar sesión con Firebase
    //print("Email: $email, Password: $password");
  }

  @override
  Widget build(BuildContext context) {
    // check if it is debug mode
    if (kDebugMode) {
      authService.signInWithEmailAndPassword(
          context, "bertolini.diego@gmail.com", "123123123");
    }

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
                  controller: _emailController, //onchangeText = setEmail
                  decoration: InputDecoration(
                    //style = {{icon...}}
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
                  decoration: InputDecoration(
                    //style = {{icon...}}
                    labelText: 'Clave',
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
                  obscureText: true, //ocultar clave
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () => _login(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF8FFF7C), // Color de fondo 8FFF7C
                    foregroundColor: Colors.black, // Color del texto
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    // Espaciado interno
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12), // Bordes redondeados
                    ),
                    elevation: 6, // Sombra del botón
                  ),
                  child: const Text(
                    'Iniciar Sesión',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
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
                          Navigator.pushNamed(context,
                              '/recoverAccount'); //navigation.navigate(...)
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
                          Navigator.pushNamed(context, '/signUp');
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
