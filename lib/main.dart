import 'package:biblioteca/pages/home/view_user_detail.dart';
import 'package:biblioteca/pages/home/view_users.dart';
import 'package:biblioteca/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import "pages/login/loginPage.dart";
import 'pages/home/homePage.dart';
import 'pages/login/recoverAccountPage.dart';
import 'pages/login/signUpPage.dart';
import 'pages/home/registerbookPage.dart';
import 'pages/home/registerUserPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:biblioteca/pages/home/bookInformationPage.dart';
import 'package:biblioteca/pages/home/editBookPage.dart';
import 'package:biblioteca/pages/home/registerLoanPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final AuthenticationService authService = AuthenticationService();

  MyApp({super.key});

  // Stream that listens to authentication state changes
  Stream<User?> get authStateChanges => auth.authStateChanges();

  @override
  Widget build(BuildContext context) {
    Future<void> signOut() async {
      await FirebaseAuth.instance.signOut();
    }

    void saveUserInfo(String uid, String email, String name, String lastName,
        String dni, String phone) async {
      final data = {
        'uid': uid,
        'email': email,
        'name': name,
        'lastName': lastName,
        'dni': dni,
        'phone': phone,
      };
      db.collection("users").add(data).then((documentSnapshot) {
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
                return HomePage();
              } else {
                SharedPreferences.getInstance().then((prefs) {
                  String uid = snapshot.data!.uid;
                  String email = prefs.getString('email')!;
                  String name = prefs.getString('name')!;
                  String lastName = prefs.getString('lastName')!;
                  String dni = prefs.getString('dni')!;
                  String phone = prefs.getString('phone')!;
                  saveUserInfo(uid, email, name, lastName, dni, phone);
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
        //Aquí pueden manejarse otras rutas si es necesario
        return null;
      },
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => const HomePage(),
        '/recoverAccount': (context) => RecoverAccountPage(),
        '/signUp': (context) => SingUpPage(),
        '/registerBook': (context) => RegisterbookPage(),
        '/registerUser': (context) => RegisterUserPage(),
        '/viewUsers': (context) => ViewUsers(),
        '/viewUserDetail': (context) => ViewUserDetail(),
        '/informationBook': (context) => BookInformationPage(),
        '/editBook': (context) => EditBookPage(),
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
