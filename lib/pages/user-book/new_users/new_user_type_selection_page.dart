import 'package:biblioteca/pages/user-book/new_users/new_user_page.dart';
import 'package:biblioteca/pages/user-book/new_users/new_user_page_arguments.dart';
import 'package:flutter/material.dart';

class NewUserTypeSelectionPage extends StatelessWidget {
  static const routeName = '/newUserTypeSelection';

  const NewUserTypeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Wrap(
                direction: constraints.maxWidth < 600
                    ? Axis.vertical
                    : Axis.horizontal,
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  // Usamos Flexible para que ocupe un espacio más grande que el del texto pero sin ocupar todo el espacio
                  Flexible(
                    flex: 1, // La cantidad de espacio que debería ocupar
                    child: Container(
                      width: constraints.maxWidth > 400
                          ? 250
                          : constraints.maxWidth * 0.8, // Ancho adaptativo
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          NewUserPage.routeName,
                          arguments: NewUserPageArguments(UserType.alumno),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8FFF7C),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 6,
                        ),
                        child: const Text(
                          'Alumno',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1, // El mismo flex para los otros botones
                    child: Container(
                      width: constraints.maxWidth > 400
                          ? 250
                          : constraints.maxWidth * 0.8, // Ancho adaptativo
                      child: ElevatedButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          NewUserPage.routeName,
                          arguments: NewUserPageArguments(UserType.docente),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8FFF7C),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 6,
                        ),
                        child: const Text(
                          'Docente',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
