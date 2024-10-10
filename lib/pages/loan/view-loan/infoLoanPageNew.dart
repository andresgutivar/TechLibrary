import 'package:biblioteca/pages/loan/view-loan/infoLoanPageArguments.dart';
import 'package:flutter/material.dart';

class infoLoanPageNew extends StatefulWidget {
  const infoLoanPageNew({super.key});
  static const routeName = '/loanInfo';
  @override
  State<infoLoanPageNew> createState() => _infoLoanPageNewState();
}

class _infoLoanPageNewState extends State<infoLoanPageNew> {
  Widget build(BuildContext context) {
    @override
    final args =
        ModalRoute.of(context)!.settings.arguments as infoLoanPageArguments;
    print(args.isbn);
    return const Placeholder();
  }
}
/*tengo que hacer que se muestre:
info de prestadora (bibliotecaria)
boton que rediriga a info de usuairo que contiene el libro(alumno docente)
boton para dehacer el prestamo.*/