import 'package:flutter/material.dart';

class SingUpPage extends StatefulWidget {
  //decimos que esta pantalla sufrira modificaciones con "StatefulWidget"
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _RecoverAccountPageState();
}

class _RecoverAccountPageState extends State<SingUpPage> {
  final _emailController = TextEditingController(); //useState
  final _passwordController = TextEditingController(); //useState
  final _nameController = TextEditingController(); //useState
  final _lastNameController = TextEditingController(); //useState
  final _dniController = TextEditingController(); //useState
  final _phoneController = TextEditingController(); //useState

  void _login() {
    //funcion que se llamara para hacer la conceccion
    String email = _emailController.text;
    String password = _passwordController.text;
    String name = _nameController.text;
    String lastName = _lastNameController.text;
    String dni = _dniController.text;
    String phone = _phoneController.text;

    Navigator.pushNamed(context, '/home');
    // Aquí puedes agregar la lógica para iniciar sesión con Firebase
    print(
        "Email: $email, Password: $password name: $name, lastName: $lastName dni: $dni, phone: $phone");
  }

  @override
  Widget build(BuildContext context) {
    const Color customColor = Color.fromARGB(210, 81, 232, 55);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Volver"),
        backgroundColor: customColor,
      ),
      body: Padding(
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
                    prefixIcon: const Icon(Icons.password, color: customColor),
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
                    'Crear cuenta',
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
