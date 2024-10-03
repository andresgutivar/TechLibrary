import 'package:flutter/material.dart';

class InfoLoanPage extends StatelessWidget {
  InfoLoanPage({super.key, required this.book});
  final Map<String, dynamic> book;
  @override
  Widget build(BuildContext context) {
    const Color customColor = Color(0xfff8FFF7C);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informacion sobre el prestamo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // SizedBox que contiene el texto con el estilo deseado
                Text(
                  'Informacion sobre la prestadora',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 800,
                  child: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 16),
                MyText(
                    text: 'Nombre',
                    value: book['lenderId'],
                    customColor: customColor),
                const SizedBox(height: 16),
                MyText(
                    text: 'Apellido',
                    value: book['lenderId'],
                    customColor: customColor),
                const SizedBox(height: 16),
                MyText(
                    text: 'DNI',
                    value: book['lenderId'],
                    customColor: customColor),
                const SizedBox(height: 16),
                MyText(
                    text: 'Correo electronico',
                    value: book['lenderId'],
                    customColor: customColor),
                const SizedBox(height: 16),
                MyText(
                    text: 'Telefono',
                    value: book['lenderId'],
                    customColor: customColor),
                const SizedBox(height: 64),

                Text(
                  'Informacion sobre lector del libro',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 800,
                  child: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 400,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //backgroundColor: backgroundColorOptions,
                      foregroundColor: Colors.black,
                      side: BorderSide(
                        color: customColor, // Color del borde
                        width: 3, // Ancho del borde
                      ),
                    ),
                    onPressed: () {
                      //redirige a la pantalla de informacion de usuario
                    },
                    child: const Text(
                      'Informacion sobre usuario',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 64),
                Text(
                  'Marcar libro como devuelto',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 800,
                  child: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 400,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //backgroundColor: backgroundColorOptions,
                      foregroundColor: Colors.black,
                      side: BorderSide(
                        color: customColor, // Color del borde
                        width: 3, // Ancho del borde
                      ),
                    ),
                    onPressed: () {
                      //cambia el estado del libro a devuelto
                    },
                    child: const Text(
                      'Devolver',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
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
}

class MyText extends StatelessWidget {
  final String text;
  final String value;
  final Color customColor;
  const MyText(
      {super.key,
      required this.text,
      required this.value,
      required this.customColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          width: 800,
          //height: 80,
          decoration: BoxDecoration(
            color: customColor,
            border: Border.all(color: Colors.green, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Text(
            text + ' : ' + value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ));
  }
}
