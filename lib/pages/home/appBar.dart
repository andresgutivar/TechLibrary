import 'package:biblioteca/pages/user-book/new_users/new_user_type_selection_page.dart';
import 'package:biblioteca/pages/user-book/view_users/view_users_page.dart';
import 'package:biblioteca/services/authentication.dart';
import 'package:flutter/material.dart';

class MyAppBarWidget extends StatelessWidget {
  final Color customColor;
  final Color backgroundColorOptions;
  final _authService = AuthenticationService();

  MyAppBarWidget({
    super.key,
    required this.customColor,
    required this.backgroundColorOptions,
  });

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
                bool isWide = constraints.maxWidth > 912;

                if (isWide) {
                  double buttonWidth = (constraints.maxWidth - 3 * 16) / 3.2;
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
                              color: customColor,
                              width: 3,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, NewUserTypeSelectionPage.routeName);
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
                              color: customColor,
                              width: 3,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, ViewUsersPage.routeName);
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
                              color: customColor,
                              width: 3,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/registerBook');
                          },
                          child: const Text('Agregar libro'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 50, // Ajusta el ancho para el icono circular
                        child: IconButton(
                          icon: const Icon(Icons.logout_outlined),
                          color: Colors.black,
                          onPressed: () => showDialog<String>(
                            context: context,
                            barrierDismissible: false,
                            useRootNavigator: false,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('¿Estás seguro?'),
                              content: const Text(
                                  '¿Estás seguro de cerrar sesión en esta cuenta?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () => [
                                    _authService.signOut(context),
                                    Navigator.pop(context, 'Cancel')
                                  ],
                                  child: const Text('Aceptar'),
                                ),
                              ],
                            ),
                          ),
                          iconSize: 30,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("Menu", style: TextStyle(color: Colors.black)),
                      PopupMenuButton<String>(
                        icon: Icon(Icons.more_vert, color: Colors.black),
                        onSelected: (String route) {
                          if (route == 'logout') {
                            showDialog<String>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('¿Estás seguro?'),
                                content: const Text(
                                    '¿Estás seguro de cerrar sesión en esta cuenta?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _authService.signOut(context);
                                      Navigator.pop(context, 'Cancel');
                                    },
                                    child: const Text('Aceptar'),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            Navigator.pushNamed(context, route);
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem<String>(
                            value: NewUserTypeSelectionPage.routeName,
                            child: Text('Agregar usuario'),
                          ),
                          PopupMenuItem<String>(
                            value: ViewUsersPage.routeName,
                            child: Text('Usuarios'),
                          ),
                          PopupMenuItem<String>(
                            value: '/registerBook',
                            child: Text('Agregar libro'),
                          ),
                          const PopupMenuDivider(),
                          PopupMenuItem<String>(
                            value: 'logout',
                            child: Text('Cerrar sesión'),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
            centerTitle: true,
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
