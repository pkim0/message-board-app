import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'splash_screen.dart';
import 'login_page.dart';
import 'home_page.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Background message received: ${message.notification?.body}');
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Message Board App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.done) {
            FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
            
            return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, authSnapshot) {
                if (authSnapshot.connectionState == ConnectionState.waiting) {
                  return SplashScreen();
                }

                if (authSnapshot.hasData && authSnapshot.data != null) {
                  return HomePage();
                }

                return LoginPage();
              },
            );
          }

          return SplashScreen();
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
