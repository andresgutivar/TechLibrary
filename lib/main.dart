import 'package:biblioteca/globals/globals.dart';
import 'package:biblioteca/models/user_model.dart';
import 'package:biblioteca/pages/user-book/edit_users/edit_user_page.dart';
import 'package:biblioteca/pages/user-book/new_users/new_user_page.dart';
import 'package:biblioteca/pages/user-book/new_users/new_user_type_selection_page.dart';
import 'package:biblioteca/pages/user-book/view_users/view_user_detail_page.dart';
import 'package:biblioteca/pages/user-book/view_users/view_users_page.dart';
import 'package:biblioteca/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import "pages/login/login_page.dart";
import 'pages/home/homePage.dart';
import 'pages/login/recover_account_page.dart';
import 'pages/login/sign_up_page.dart';
import 'pages/book/new-book/registerbookPage.dart';
// import 'pages/home/registerUserPage.dart';
// import 'pages/book/edit-book/editBookPageNew.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:biblioteca/pages/book/details-book/bookInformationPage.dart';
import 'package:biblioteca/pages/book/edit-book/editBookPage.dart';
import 'package:biblioteca/pages/loan/register-loan/registerLoanPage.dart';
import 'package:biblioteca/pages/loan/view-loan/infoLoanPageNew.dart';
import 'pages/book/edit-book/editBookPageNew.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthenticationService authService = AuthenticationService();

  MyApp({super.key});

  // Stream that listens to authentication state changes
  Stream<User?> get authStateChanges =>
      FirebaseAuth.instance.authStateChanges();

  @override
  Widget build(BuildContext context) {
    Future<void> signOut() async {
      await FirebaseAuth.instance.signOut();
    }

    void saveUserInfo(UserModel user) async {
      FirebaseFirestore.instance
          .collection(UserModel.tableName)
          .withConverter(
            fromFirestore: UserModel.fromFirestore,
            toFirestore: (UserModel user, options) => user.toFirestore(),
          )
          .doc(user.dni)
          .set(user)
          .then((documentSnapshot) {
        signOut();
      });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder<User?>(
        stream: authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // If the snapshot has data, it means a user is logged in
            if (snapshot.data != null) {
              if (snapshot.data!.emailVerified) {
                // El usuario ya esta loggeado y verificado

                // Ir a buscar el DNI del usuario, mediante el UID
                FirebaseFirestore.instance
                    .collection(UserModel.tableName)
                    .where("uid", isEqualTo: snapshot.data!.uid)
                    .get()
                    .then(
                  (querySnapshot) {
                    CurrentUserData.currentDniUser =
                        querySnapshot.docs[0].data()['dni'];
                  },
                  onError: (e) => print("Error completing: $e"),
                );
                return HomePage();
              } else {
                SharedPreferences.getInstance().then((prefs) {
                  UserModel user = UserModel(
                      uid: snapshot.data!.uid,
                      dni: prefs.getString('dni'),
                      email: prefs.getString('email'),
                      name: prefs.getString('name'),
                      lastName: prefs.getString('lastName'),
                      phone: prefs.getString('phone'));

                  saveUserInfo(user);

                  prefs.remove('dni');
                  prefs.remove('email');
                  prefs.remove('name');
                  prefs.remove('lastName');
                  prefs.remove('phone');
                });
                return LoginPage();
              }
            } else {
              // No user logged in
              return LoginPage();
            }
          } else {
            // Waiting for authentication state to be available
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          }
        },
      ),
      // Modificamos aquí para manejar rutas con argumentos
      onGenerateRoute: (settings) {
        if (settings.name == '/registerLoan') {
          final String codigoISBN = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) {
              return RegisterLoanPage(codigoISBN: codigoISBN);
            },
          );
        }

        if (settings.name == '/informationBook') {
          final Map<String, dynamic> book =
              settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return BookInformationPage(book: book);
            },
          );
        }
        // if (settings.name == '/informationLoan') {
        //   final Map<String, dynamic> book =
        //       settings.arguments as Map<String, dynamic>;
        //   return MaterialPageRoute(
        //     builder: (context) {
        //       return InfoLoanPage(book: book);
        //     },
        //   );
        // }

        //Aquí pueden manejarse otras rutas si es necesario
        return null;
      },
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/recoverAccount': (context) => RecoverAccountPage(),
        '/signUp': (context) => SingUpPage(),
        '/registerBook': (context) => RegisterBookPage(),

        // '/registerUser': (context) => RegisterUserPage(),
        ViewUsersPage.routeName: (context) => ViewUsersPage(),
        ViewUserDetailPage.routeName: (context) => ViewUserDetailPage(),
        EditUserPage.routeName: (context) => EditUserPage(),
        NewUserPage.routeName: (context) => NewUserPage(),
        NewUserTypeSelectionPage.routeName: (context) =>
            NewUserTypeSelectionPage(),
        EditBookPageNew.routeName: (context) => EditBookPageNew(),
        infoLoanPageNew.routeName: (context) => infoLoanPageNew(),
        //'/informationBook': (context) => BookInformationPage(),
        //'/editBook': (context) => EditBookPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
