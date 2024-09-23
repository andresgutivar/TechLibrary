import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Color customColor = Color.fromARGB(210, 81, 232, 55);
  static const Color backgroundColorOptions = Color(0xfff8FFF7C);
  void _logOut() {
    //logica para cerrar sesion
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              title: LayoutBuilder(
                builder: (context, constraints) {
                  // Calcular el ancho disponible para los botones
                  double buttonWidth = (constraints.maxWidth - 2 * 16) / 3;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: buttonWidth,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: backgroundColorOptions,
                            foregroundColor: Colors.black,
                            side: const BorderSide(
                              color: customColor, // Color del borde
                              width: 3, // Ancho del borde
                            ),
                          ),
                          onPressed: () {
                            // Acción al agregar usuario
                          },
                          child: const Text('Agregar usuario'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: buttonWidth,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: backgroundColorOptions,
                            foregroundColor: Colors.black,
                            side: const BorderSide(
                              color: customColor, // Color del borde
                              width: 3, // Ancho del borde
                            ),
                          ),
                          onPressed: () {
                            // Acción al mostrar usuarios
                          },
                          child: const Text('Usuarios'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: buttonWidth,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: backgroundColorOptions,
                            foregroundColor: Colors.black,
                            side: const BorderSide(
                              color: customColor, // Color del borde
                              width: 3, // Ancho del borde
                            ),
                          ),
                          onPressed: () {
                            // Acción al agregar libro
                          },
                          child: const Text('Agregar libro'),
                        ),
                      ),
                    ],
                  );
                },
              ),
              centerTitle: true,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: IconButton(
                    icon: const Icon(Icons.logout_outlined),
                    color: Colors.black,
                    onPressed: _logOut, // Acción al cerrar sesión

                    iconSize: 30,
                  ),
                ),
              ],
            ),
            Container(
              height: 2,
              color: Colors.black,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              _buildExpansionTileCard(),
              _buildExpansionTileCard() // Aquí llamamos a nuestro método para crear la tarjeta
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpansionTileCard() {
    //aca se podria hacer un for que lea la base de datos y retorne todos los valores
    return const ExpansionTileCard(
      title: Text('Título de la tarjeta'),
      subtitle: Text('Subtítulo'),
      leading: Icon(Icons.info_outline),
      children: <Widget>[
        Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Este es el contenido dentro de la tarjeta expansible.'),
              Text('Puedes agregar más widgets aquí.'),
            ],
          ),
        ),
      ],
    );
  }
}
