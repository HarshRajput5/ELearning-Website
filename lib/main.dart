import 'package:flutter/material.dart';
import 'package:learning/list_of_video.dart';
import 'login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'reuse/reuse.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

//   const cors = require("cors");
// app.use(cors());

  runApp(
      const MyApp(),
    
  );
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;

  @override
  void initState(){
    super.initState();
    user=FirebaseAuth.instance.currentUser;
    // ignore: avoid_print
    print(user?.uid.toString());
  }


  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      home: 
      // const HomePage()
      user!=null?const HomePage():const Login(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage()
       
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  // signout function
  

  void signOut() async {
    await auth.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Login(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: const AppBarButton(),
          backgroundColor: Colors.red,
          actions: [
            // ElevatedButton(
            //     style: const ButtonStyle(
            //       backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
            //     ),
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const Login(),
            //         ),
            //       );
            //     },
            //     child: Image.asset("images/profile2.png")
            //     // Image.asset("images/profile2.png")
            //     ),
            
            FloatingActionButton(
              onPressed: () {
                signOut();
              },
              // ignore: sort_child_properties_last
              child: const Icon(Icons.logout_rounded),
              backgroundColor: Colors.green,
            ),
          ],
        ),
        backgroundColor: Colors.amber.shade100,
      
      body: Row(
        mainAxisSize: MainAxisSize.max,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Home(),
          // ignore: prefer_const_constructors
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: Colors.amber.shade100,
                // ignore: prefer_const_constructors
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // ignore: prefer_const_constructors
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CoursesBox(passingSub: 'Physics/', image: 'Physics',),
                          CoursesBox(passingSub: 'Chemistry/',image: 'Chemistry'),
                          CoursesBox(passingSub: 'Maths/',image: 'Maths'),
                        ],
                      ),
                    ),
                  //   Row(
                  //     // mainAxisSize: MainAxisSize.max,
                  //     children: [
                  //       Container(
                  //           // child: Image.asset("images/physics.jpeg"),
                  //           )
                  //     ],
                  //   ),
                  //
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
