import 'package:biblioteca/services/authentication.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart'; //para verificar cuando se da click al texto de "recuperala"
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationService authService = AuthenticationService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // check if it is debug mode
    if (kDebugMode) {
      authService.signInWithEmailAndPassword(
          context, "bertolini.diego@gmail.com", "123123123");
    }

    const Color customColor = Color.fromARGB(210, 81, 232, 55);

    void login() {
      if (_formKey.currentState!.validate()) {
        authService.signInWithEmailAndPassword(
            context, _emailController.text, _passwordController.text);
      }
    }

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
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
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El campo no debe estar vacío';
                      }
                      String pattern =
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                      RegExp regex = RegExp(pattern);
                      if (!regex.hasMatch(value)) {
                        return 'El correo electrónico debe ser válido';
                      }
                      return null;
                    },
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
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El campo no debe estar vacío';
                      }

                      return null;
                    },
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
                    onPressed: () => login(),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        recognizer:
                            TapGestureRecognizer() //de libreria importada
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
                        recognizer:
                            TapGestureRecognizer() //de libreria importada
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
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }
}
