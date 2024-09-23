import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color customColor = Color.fromARGB(210, 81, 232, 55);
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
                  double buttonWidth = (constraints.maxWidth - 2 * 16) /
                      3; // tres botones y dos espacios de 16px

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: buttonWidth,
                        child: ElevatedButton(
                          // style: ButtonStyle(backgroundColor: customColor),
                          onPressed: () {},
                          child: const Text('Agregar usuario'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: buttonWidth,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Usuarios'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: buttonWidth,
                        child: ElevatedButton(
                          onPressed: () {},
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
                    onPressed: () {},
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
          child: Column(
            children: [
              Card(
                color: customColor,
                clipBehavior: Clip.hardEdge,
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    debugPrint('Card tapped.');
                  },
                  child: const SizedBox(
                    width: 1000,
                    height: 100,
                    child: Text('A card that can be tapped'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
