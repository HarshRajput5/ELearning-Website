import 'dart:async';
import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learning/list_of_video.dart';
import 'package:learning/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:learning/login.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:firebase_database/firebase_database.dart';

import '../video.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber.shade200,
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Button(txt: "Dashboard"),
            Button(txt: "Courses"),
            Button(txt: "Resources"),
            Button(txt: "Chat"),
            Button(txt: "Profile"),
            Button(txt: "Setting"),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Button extends StatelessWidget {
  Button({super.key, required this.txt});

  late String txt;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {},
            style: const ButtonStyle(
              shadowColor: MaterialStatePropertyAll<Color>(Colors.red),
            ),
            child: Text(
              txt,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}

//List of Videos
// ignore: must_be_immutable
class ButtonList extends StatelessWidget {
  ButtonList(
      {super.key,
      this.link = "images/profile2.png",
      required this.title,
      this.onPressed});

  static final storageRef = FirebaseStorage.instance.ref();
  final islandRef = storageRef.child("Rajput's Resume (1).pdf");

  late String link;
  late String title;
  // ignore: prefer_typing_uninitialized_variables
  var onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Image.asset(
            link,
            height: 50,
            width: 50,
          ),
          Text(title)
        ],
      ),
    );
  }
}

//AppBar
class AppBarButton extends StatefulWidget {
  const AppBarButton({super.key});

  @override
  State<AppBarButton> createState() => _AppBarButtonState();
}

class _AppBarButtonState extends State<AppBarButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(), //go to list of video
            ),
          );
        },
        // ignore: prefer_const_constructors
        child: Text(
          "E-Learning",
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}

// var passingSub;
// String image;

class CoursesBox extends StatelessWidget {
   CoursesBox({super.key,required this.passingSub,required this.image});

  String passingSub;
  String image;
  static var imageName;

  // var passingSub;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: ElevatedButton(
            onPressed: () {
              imageName=image;
              // const VideoList().subject='';
              // print(passingSub);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  VideoList(subject: passingSub
                  //  'Physics/'
                   ),
                ),
              );
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Image.asset(
                    // ignore: unnecessary_brace_in_string_interps
                    "images/${image}.jpeg",
                    height: 200,
                    width: 200,
                  ),
                ),
                Text(
                  // "Physics",
                  image,
                  // style: TextStyle(backgroundColor: Colors.white),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DownloadingDialog extends StatefulWidget {
  const DownloadingDialog({Key? key}) : super(key: key);

  @override
  _DownloadingDialogState createState() => _DownloadingDialogState();
}

class _DownloadingDialogState extends State<DownloadingDialog> {
  Dio dio = Dio();
  double progress = 0.0;

  void startDownloading() async {
    const String url =
        "https://firebasestorage.googleapis.com/v0/b/learning-9329e.appspot.com/o/Rajput's%20Resume%20(1).pdf?alt=media&token=a756017b-f9ff-4eb8-aa14-0b0ad2db1470";
    const String fileName = "HResume.pdf";

    String path = await _getFilePath(fileName);

    await dio.download(
      url,
      path,
      onReceiveProgress: (recivedBytes, totalBytes) {
        setState(() {
          progress = recivedBytes / totalBytes;
        });

        print(progress);
      },
      deleteOnError: true,
    );
  }

  Future<String> _getFilePath(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return "${dir.path}/$filename";
  }

  @override
  void initState() {
    super.initState();
    startDownloading();
    print("run");
  }

  @override
  Widget build(BuildContext context) {
    String downloadingprogress = (progress * 100).toInt().toString();

    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Downloading: $downloadingprogress%",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}

// class Harsh {
//   final storage = FirebaseStorage.instance;
//   static final storageRef = FirebaseStorage.instance.ref();
//   final pathReference = storageRef.child("Rajput's Resume (1).pdf").getData();
// }

class Pdf extends StatefulWidget {
  const Pdf({super.key});

  @override
  State<Pdf> createState() => _PdfState();
}

class _PdfState extends State<Pdf> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Container(
        child: SfPdfViewer.network(
          // 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
          "https://firebasestorage.googleapis.com/v0/b/learning-9329e.appspot.com/o/Rajput's%20Resume%20(1).pdf?alt=media&token=a756017b-f9ff-4eb8-aa14-0b0ad2db1470",
        ),
      )),
    );
  }
}

class File extends StatefulWidget {
  const File({super.key});

  @override
  State<File> createState() => _FileState();
}

class _FileState extends State<File> {
  late Future<ListResult> futureFiles;

  @override
  void initState() {
    super.initState();
    futureFiles = FirebaseStorage.instance.ref('/').listAll();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ListResult>(
      future: futureFiles,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final files = snapshot.data!.items;
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: files.length,
            itemBuilder: (context, index) {
              final file = files[index];
              return GetStudentName(file);
            },
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  readfirebasestore(Reference file) {
    User? user;
    user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection('data/${user?.uid}/watch_list')
        .doc(file.name)
        .get();
  }
}

class GetStudentName extends StatelessWidget {
  // final String documentId;
  User? user;
  late Reference file;

  GetStudentName(this.file);

  // @override
  // Widget build(BuildContext context) {
  // CollectionReference watchlist = FirebaseFirestore.instance.collection('data/${user?.uid}/watch_list');

  // return FutureBuilder<DocumentSnapshot>(
  //   //Fetching data from the documentId specified of the student
  //   future: watchlist.doc(file.name).get(),
  //   builder:
  //       (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
  //     //Error Handling conditions
  //     if (snapshot.hasError) {
  //       return Text("Something went wrong");
  //     }
  //     if (snapshot.hasData && !snapshot.data!.exists) {
  //       return Text("Document does not exist");
  //     }
  //     //Data is output to the user
  //     if (snapshot.connectionState == ConnectionState.done) {
  //       Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
  //       return Text("Full Name: ${data['video_name']}");
  //     }
  //     return Text("loading");
  //   },
  // );

  // }
  void run() {
    var db = FirebaseFirestore.instance;
    final docRef = db.collection("cities").doc("SF");
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        print(data);
      },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

// ignore: non_constant_identifier_names
class HR {
  // ignore: unused_element
  HR() {
    User? user;
  user = FirebaseAuth.instance.currentUser;
     FirebaseFirestore.instance
        .collection('data/${user?.uid}/watch_list')
        .get().then
        // .snapshots.listen
        (
          (QuerySnapshot data) => print(data),
          onError: (e) => print("Error completing: $e"),
        );
  }
}


