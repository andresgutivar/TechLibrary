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
                const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 50, 246, 0),
                  child: Text('AH'),
                ),
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
        body: // Generated code for this Column Widget...
            Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      'https://picsum.photos/seed/470/600',
                      fit: BoxFit.cover,
                    ),
                  ),
                  const Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Hello World',
                      ),
                      Text(
                        'Hello World',
                      ),
                      ElevatedButton(
                          onPressed: AlertDialog.new, child: Text("data"))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
