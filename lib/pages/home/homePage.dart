import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          // Agregar un widget Row para combinar botones con íconos y texto
          Row(
            children: [
              TextButton.icon(
                icon: const Icon(Icons.add_alert,
                    color: Color.fromARGB(255, 0, 0, 0)),
                label: const Text(
                  'Alert',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('This is a snackbar')));
                },
              ),
              const SizedBox(
                  width: 16), // Espacio entre el primer y segundo botón
              TextButton.icon(
                icon: const Icon(Icons.navigate_next,
                    color: Color.fromARGB(255, 0, 0, 0)),
                label: const Text(
                  'Next',
                  style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
              ),
            ],
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'This is the home page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
