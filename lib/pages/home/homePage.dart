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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const myAppBarWidget(
          customColor: customColor,
          backgroundColorOptions: backgroundColorOptions,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          _buildSearchBar(), // Coloca el SearchBar aquí
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                _buildExpansionTileCard(),
                _buildExpansionTileCard(), // Aquí llamamos a nuestro método para crear la tarjeta
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 50.0, // Controlar la altura máxima
          minWidth: 200.0, // Controlar el ancho mínimo
          maxWidth: 1000.0, // Controlar el ancho máximo
        ),
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search), // Icono de búsqueda
            hintText: 'Buscar...', // Texto de sugerencia
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0), // Bordes redondeados
              borderSide:
                  const BorderSide(color: Colors.grey), // Color del borde
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0), // Bordes redondeados
              borderSide: const BorderSide(
                  color: customColor), // Color del borde al tener foco
            ),
          ),
          onChanged: (value) {
            // Aquí puedes manejar el cambio de texto
          },
        ),
      ),
    );
  }

  Widget _buildExpansionTileCard() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ExpansionTileCard(
        baseColor: backgroundColorOptions,
        expandedColor: backgroundColorOptions,
        title: const Text('<tittleBook>'),
        subtitle: const Text('<descriptor primario>'),
        leading: const Icon(Icons.done),
        children: <Widget>[
          const Divider(
            thickness: 1.0,
            height: 1.0,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Autor: <AuthorBook> '),
                Text('Code: <ISBN>'),
              ],
            ),
          ),
          OverflowBar(
            alignment: MainAxisAlignment.center,
            spacing: 60.0,
            overflowAlignment: OverflowBarAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: const Text('Editar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColor,
                    foregroundColor: Colors.black,
                    elevation: 3,
                  ),
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: const Text('Eliminar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColor,
                    foregroundColor: Colors.black,
                    elevation: 3,
                  ),
                  onPressed: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.info_outline),
                  label: const Text('Detalles'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: customColor,
                    foregroundColor: Colors.black,
                    elevation: 3,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class myAppBarWidget extends StatelessWidget {
  final Color customColor;
  final Color backgroundColorOptions;

  const myAppBarWidget(
      {super.key,
      required this.customColor,
      required this.backgroundColorOptions});
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
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
                          side: BorderSide(
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
                          side: BorderSide(
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
                          side: BorderSide(
                            color: customColor, // Color del borde
                            width: 3, // Ancho del borde
                          ),
                        ),
                        onPressed: () {
                          // Acción al agregar libro
                          Navigator.pushNamed(context, '/registerBook');
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
                  onPressed: () {
                    // Acción al agregar libro
                    Navigator.pushNamed(context, '/login');
                  }, // Acción al cerrar sesión

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
    );
  }
}
