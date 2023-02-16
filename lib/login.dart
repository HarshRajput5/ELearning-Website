import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart'
//     show FirebaseAuthPlatform;
import 'package:learning/main.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
// class _LoginPageState extends State<LoginPage> {
//   User? user;
//   @override
//   void initState() {
//     //   FirebaseAuth.instance
//     // .authStateChanges()
//     // .listen((User? user) {
//     //   if (user == null) {
//     //     print('User is currently signed out!');
//     //   } else {
//     //     print('User is signed in!');
//     //   }
//     // });
//     // FirebaseAuth.instance.currentUser;
//     setState(() {
//       // FirebaseAuth.instance.idTokenChanges().listen((User? user) {
//       //   if (user == null) {
//       //     print("sign out");
//       //   } else {
//       //     print("sign in");
//       //   }
//       // });
//       user = FirebaseAuth.instance.currentUser;
//       // ignore: avoid_print
//       print(user?.uid.toString());
//     });
//     super.initState();
//   }
// //       var currentUser = FirebaseAuth.instance.currentUser;
// // var user = FirebaseAuth.instance.currentUser;
// //   @override
// //   void initState() {
// //     super.initState();
// //     // FirebaseAuth.instance.authStateChanges().listen((User? user) {
// //     //   if (user == null) {
// //     //     print('User is currently signed out!');
// //     //   } else {
// //     //     print('User is signed in!');
// //     //   }
// //     // });
// //     // print(user?.uid.toString());
// // // if (currentUser != null) {
// // //   print(currentUser?.uid.toString());
// // // }
// //   }
// //   //  User? user;
//   // var auth=FirebaseAuth.instance;
//   // var isLogin=false;
//   // checkIfLogin()async{
//   //   auth.authStateChanges().listen((User? user) {
//   //     if(user !=null && mounted){
//   //       setState(() {
//   //         isLogin=true;
//   //       });
//   //     }
//   //    });
//   //    print(isLogin.toString());
//   // }
//   // void isLogin(BuildContext context) {
//   //   FirebaseAuth auth = FirebaseAuth.instance;
//   //   final user = auth.currentUser;
//   //   print(user?.uid.toString());
//   //   if (user != null) {
//   //     Navigator.pushReplacement(
//   //       context,
//   //       MaterialPageRoute(
//   //         builder: (context) => const MyApp(),
//   //       ),
//   //     );
//   //     // ignore: avoid_print
//   //     print(user.uid.toString());
//   //   } else {
//   //     Navigator.pushReplacement(
//   //       context,
//   //       MaterialPageRoute(
//   //         builder: (context) => const Login(),
//   //       ),
//   //     );
//   //     print(user?.uid.toString());
//   //   }
//   // }
//   // print(user)
//   @override
//   Widget build(BuildContext context) {
//     // ignore: prefer_const_constructors
//     return MaterialApp(
//       // ignore: unnecessary_null_comparison
//       home: const Login(),
//       // user != null ? const HomePage() : const Login(),
//     );
//   }
// }

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

// var isLogin=false;

class _LoginState extends State<Login> {
  final countrycode = TextEditingController();
  final otp = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var mobileNo = "";
  var temp;

  // User? user;

  @override
  void dispose() {
    countrycode.dispose();
    otp.dispose();
    super.dispose();
  }

  // ignore: non_constant_identifier_names
  Verify(ConfirmationResult confirmationResult) async {
    UserCredential userCredential = await confirmationResult.confirm(otp.text);

    userCredential.additionalUserInfo!.isNewUser
        // ignore: avoid_print
        ? print("Successful")
        // ignore: avoid_print
        : print("exists");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade100,
      body: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: countrycode,
                        onChanged: (value) {
                          mobileNo = value;
                        },
                        decoration: const InputDecoration(
                          label: Text("Enter your phone number"),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: otp,
                        decoration:
                            const InputDecoration(label: Text("Enter OTP")),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          // print(user?.uid.toString());
                          Verify(temp);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const HomePage(), //go to list of video
                            ),
                          );
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    FirebaseAuth auth = FirebaseAuth.instance;

                    // Wait for the user to complete the reCAPTCHA & for an SMS code to be sent.
                    // ignore: unused_local_variable

                    ConfirmationResult confirmationResult = await auth
                        // ignore: unnecessary_string_interpolations, prefer_interpolation_to_compose_strings
                        .signInWithPhoneNumber('${'+91' + mobileNo}');
                    temp = confirmationResult;
                  },
                  child: const Text("Send OTP"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
