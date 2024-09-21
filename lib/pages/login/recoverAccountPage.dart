import 'package:flutter/material.dart';

class RecoverAccountPage extends StatefulWidget {
  //decimos que esta pantalla sufrira modificaciones con "StatefulWidget"
  const RecoverAccountPage({super.key});

  @override
  State<RecoverAccountPage> createState() => _RecoverAccountPageState();
}

class _RecoverAccountPageState extends State<RecoverAccountPage> {
  final _emailController = TextEditingController(); //useState

  void _login() {
    //funcion que se llamara para hacer la conceccion
    String email = _emailController.text;

    Navigator.pushNamed(context, '/home');
    // Aquí puedes agregar la lógica para iniciar sesión con Firebase
    print("Email: $email");
  }

  @override
  Widget build(BuildContext context) {
    const Color customColor = Color.fromARGB(210, 81, 232, 55);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: customColor,
        title: const Text("Volver"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Recuperar cuenta',
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
                width: 300,
                child: ElevatedButton(
                  onPressed: _login,
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
            ],
          ),
        ),
      ),
    );
  }
}
