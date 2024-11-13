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
                          onPressed: () => _showLogoutDialog(context),
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
                      IconButton(
                        icon: Icon(Icons.more_vert, color: Colors.black),
                        onPressed: () {
                          _showDropdownMenu(context);
                        },
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

  void _showLogoutDialog(BuildContext context) {
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('¿Estás seguro?'),
        content: const Text('¿Estás seguro de cerrar sesión en esta cuenta?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
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
    );
  }

  void _showDropdownMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Botón de cerrar en la esquina superior derecha
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                // Elementos del menú
                MenuButton(
                  label: 'Agregar usuario',
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(
                        context, NewUserTypeSelectionPage.routeName);
                  },
                ),
                MenuButton(
                  label: 'Usuarios',
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, ViewUsersPage.routeName);
                  },
                ),
                MenuButton(
                  label: 'Agregar libro',
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/registerBook');
                  },
                ),
                const Divider(),
                MenuButton(
                  label: 'Cerrar sesión',
                  onPressed: () {
                    Navigator.pop(context);
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MenuButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  static const Color customColor = Color.fromARGB(210, 81, 232, 55);
  const MenuButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: customColor // Cambia el color según el diseño
              ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
