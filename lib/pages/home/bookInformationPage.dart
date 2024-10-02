import 'package:flutter/material.dart';

class BookInformationPage extends StatelessWidget {
  BookInformationPage({super.key, required this.book});
  final Map<String, dynamic> book;
  @override
  Widget build(BuildContext context) {
    const Color customColor = Color(0xfff8FFF7C);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles'),
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
                MyText(
                    text: 'Titulo',
                    value: book['title'],
                    customColor: customColor),
                const SizedBox(height: 16),
                MyText(
                    text: 'Autor',
                    value: book['author'],
                    customColor: customColor),
                const SizedBox(height: 16),

                MyText(
                    text: 'Codigo ISBN',
                    value: book['isbn'],
                    customColor: customColor),
                const SizedBox(height: 16),

                MyText(
                    text: 'Estado',
                    value: book['status'],
                    customColor: customColor),
                const SizedBox(height: 16),

                MyText(
                    text: 'Paginacion',
                    value: book['pagination'],
                    customColor: customColor),
                const SizedBox(height: 16),

                MyText(
                    text: 'Editorial',
                    value: book['editorial'],
                    customColor: customColor),
                const SizedBox(height: 16),
                MyText(
                    text: 'Edicion',
                    value: book['edition'],
                    customColor: customColor),
                const SizedBox(height: 16),
                MyText(
                    text: 'Lugar de edicion',
                    value: book['editingPlace'],
                    customColor: customColor),
                const SizedBox(height: 16),
                MyText(
                    text: 'Anio de edicion',
                    value: book['yearEdition'],
                    customColor: customColor),
                const SizedBox(height: 16),
                MyText(
                    text: 'Ubicacion fisica',
                    value: book['location'],
                    customColor: customColor),
                const SizedBox(height: 16),
                MyText(
                    text: 'Descriptor primario',
                    value: book['primaryDescriptor'],
                    customColor: customColor),
                const SizedBox(height: 16),
                MyText(
                    text: 'Descriptor secundario',
                    value: book['secondaryDescriptor'],
                    customColor: customColor),
                const SizedBox(height: 16),
                MyText(
                    text: 'Notas',
                    value: book['notes'],
                    customColor: customColor),
                const SizedBox(height: 16),
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
