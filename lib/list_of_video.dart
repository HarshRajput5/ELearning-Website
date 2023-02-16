import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:learning/reuse/reuse.dart';
import 'package:learning/video.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'firebase_options.dart';
import 'main.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:internet_file/internet_file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
    home: VideoList(subject: '/Physics'),
  ));
}


var Farifile;

class VideoList extends StatefulWidget {
  // static var Fari;

  const VideoList({super.key, required this.subject});

  // set subject(String subject) {}

  final String subject;

  @override
  // ignore: no_logic_in_create_state
  State<VideoList> createState() => _VideoListState(sub: subject);
}

var videoUrl;

class _VideoListState extends State<VideoList> {
  String sub;

  _VideoListState({required this.sub});

  late Future<ListResult> futureFiles;
  // var Farifile;

  // String? get subject => null;
  // ignore: non_constant_identifier_names
  // void VideoList(String subject){
  //   // futureFiles = FirebaseStorage.instance.ref('/').listAll();

  // }

  // late String subject='/';

  // late String subject;

  @override
  void initState() {
    User? user;
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    // String? subject;
    futureFiles = FirebaseStorage.instance.ref(sub).listAll();
    // VideoListName(subject);
    
  }


  // var NewImage=new CoursesBox(passingSub: passingSub, image: image)

  // static final storageRef = FirebaseStorage.instance.ref();

  Reference get storageRef => FirebaseStorage.instance.ref();


  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: const AppBarButton(),
        backgroundColor: Colors.red,
      ),
      body: Row(
        children: [
          // const Home(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Image.asset(
                              "images/${CoursesBox.imageName.toString()}.jpeg",
                              height: 200,
                              width: 200,
                            ),
                          ),
                          Text(
                            // "Physics",
                            CoursesBox.imageName.toString(),
                            style: const TextStyle(backgroundColor: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.amber.shade100,
                  child: const Text("This is physics tutorial"),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                      dragStartBehavior: DragStartBehavior.start,
                      child: FutureBuilder<ListResult>(
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
                                Farifile = file.name;
                                // Farifile=readfirestore(file);
                                return ListTile(
                                  // title: Text(file.name),
                                  trailing: TextButton(
                                    child: Text(file.name),
                                    onPressed: ()  async{
                                      // ignore: unused_local_variable, await_only_futures
                                      videoUrl = await storageRef
                                      // .fullPath;
                                          .child("${CoursesBox.imageName}/${file.name}")
                                          .getDownloadURL();
                                      // print(videoUrl);

                                      FireStore(
                                          file); //Store Data to Firebase Firestore
                                      readfirestore(file);

                                      // run();
                                      // print(Farifile);

                                      // print(videoUrl);

                                      // print(file);
                                      

                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const VideoPage(), //go to list of video

                                        ),
                                      );
                                    },
                                  ),
                                );
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
                      )
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     // ignore: avoid_print
                      //     ButtonList(
                      //       link: "images/physics.jpeg",
                      //       title: "Chapter 1 - Motion",
                      //       onPressed: () {
                      //         Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) =>
                      //                 const VideoPage(), //go to list of video
                      //           ),
                      //         );
                      //       },
                      //     ),
                      //     ButtonList(
                      //       title: "Chapter 2 - Newton's Law",
                      //       onPressed: () async {
                      //         print("Worked");
                      //         // SfPdfViewer.network("https://firebasestorage.googleapis.com/v0/b/learning-9329e.appspot.com/o/Rajput's%20Resume%20(1).pdf?alt=media&token=a756017b-f9ff-4eb8-aa14-0b0ad2db1470");
                      //         // final Uint8List bytes = await InternetFile.get(
                      //         //   "https://firebasestorage.googleapis.com/v0/b/learning-9329e.appspot.com/o/Rajput's%20Resume%20(1).pdf?alt=media&token=a756017b-f9ff-4eb8-aa14-0b0ad2db1470",
                      //         //   progress: (receivedLength, contentLength) {
                      //         //     final percentage =
                      //         //         receivedLength / contentLength * 100;
                      //         //     print(
                      //         //         'download progress: $receivedLength of $contentLength ($percentage%)');
                      //         //   },
                      //         // );
                      //         Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) =>
                      //             const Pdf()
                      //           //       const DownloadingDialog(), //go to list of video
                      //           //  pathReference = storageRef.child("images/stars.jpg"),
                      //             // Harsh();
                      //           ),
                      //         );
                      //         // // final imageUrl = await storageRef
                      //         //     .child("users/me/profile.png")
                      //         //     .getDownloadURL();
                      //         // final storageRef = FirebaseStorage.instance.ref();
                      //         // final islandRef = storageRef
                      //         //     .child("Rajput's Resume (1).pdf")
                      //         //     .getDownloadURL();
                      //         // final islandRef = storageRef.child("gs://learning-9329e.appspot.com/Rajput's Resume (1).pdf");
                      //         // try {
                      //         //   // const oneMegabyte = 1024 * 1024;
                      //         //   // ignore: unused_local_variable
                      //         //   final Uint8List? data =
                      //         //       await islandRef.getData();
                      //         //   // Data for "Rajput's Resume (1).pdf" is returned, use this as needed.
                      //         // } on FirebaseException catch (e) {
                      //         //   // Handle any errors.
                      //         //   // ignore: avoid_print
                      //         //   print(e);
                      //         // }
                      //       },
                      //     ),
                      //     ButtonList(link: "images/profile2.png", title: "profile"),
                      //     ButtonList(title: "Chapter 3 "),
                      //     ButtonList(title: "Chapter 4 "),
                      //     ButtonList(title: "Chapter 5 "),
                      //   ],

                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void FireStore(Reference file) {
    User? user;
    user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection('data/${user?.uid}/watch_list')
        .doc(file.name)
        .set({'video_name': file.name});
  }

  void readfirestore(Reference file) {
    User? user;
    user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection('data/${user?.uid}/watch_list')
        // .collection('data')
        .doc(file.name)
        // .doc(user?.uid)
        .get()
        .then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        // ignore: avoid_print
        // print(data['video_name']);
        // Farifile = data['video_name'];
      },
      // ignore: avoid_print
      onError: (e) => print("Error getting document: $e"),
    );
    // FirebaseFirestore.instance
    //     .collection('data/${user?.uid}/watch_list')
    //     .get()
    //     .snapshots().listen(
    //       (value) => print(value),
    //       onError: (e) => print("Error completing: $e"),
    //     );
    //  FirebaseFirestore.instance
    //     .collection('data/${user?.uid}/watch_list')
    //     .get().then
    //     // .snapshots.listen
    //     (
    //       (QuerySnapshot data) => print(data),
    //       onError: (e) => print("Error completing: $e"),
    //     );
  }
}
