import 'package:biblioteca/services/authentication.dart';
import 'package:flutter/material.dart';

class SingUpPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final AuthenticationService authService = AuthenticationService();

  SingUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color customColor = Color.fromARGB(210, 81, 232, 55);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Volver"),
        backgroundColor: customColor,
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Crear cuenta',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 800,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
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
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                    width: 392,
                    child: TextField(
                      controller: _nameController, //onchangeText = setEmail
                      decoration: InputDecoration(
                        //style = {{icon...}}
                        labelText: 'Nombre',
                        prefixIcon:
                            const Icon(Icons.perm_identity, color: customColor),
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
                          borderSide: const BorderSide(
                            color: customColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  SizedBox(
                    width: 392,
                    child: TextField(
                      controller: _lastNameController, //onchangeText = setEmail
                      decoration: InputDecoration(
                        //style = {{icon...}}
                        labelText: 'Apellido',
                        prefixIcon:
                            const Icon(Icons.perm_identity, color: customColor),
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
                          borderSide: const BorderSide(
                            color: customColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 16),
                SizedBox(
                  width: 800,
                  child: TextField(
                    controller: _dniController,
                    decoration: InputDecoration(
                      //style = {{icon...}}
                      labelText: 'DNI',
                      prefixIcon:
                          const Icon(Icons.card_membership, color: customColor),
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
                      prefixIcon:
                          const Icon(Icons.password, color: customColor),
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
                  width: 800,
                  child: TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      //style = {{icon...}}
                      labelText: 'Numero de telefono',
                      prefixIcon: const Icon(Icons.phone, color: customColor),
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
                    onPressed: () => _signUp(context),
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
                      'Crear cuenta',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signUp(BuildContext context) {
    authService.signUp(
        context, _emailController.text, _passwordController.text);
  }
}
