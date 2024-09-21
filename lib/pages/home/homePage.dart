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
                          onPressed: () {},
                          child: const Text('Enabled 1'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: buttonWidth,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Enabled 2'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: buttonWidth,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Enabled 3'),
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
      body: Column(
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
                    Text('Hello World'),
                    Text('Hello World'),
                    ElevatedButton(
                      onPressed: AlertDialog.new,
                      child: Text("data"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
