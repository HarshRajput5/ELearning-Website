// import 'dart:math';
// import 'package:video_player_web/video_player_web.dart';
// import 'package:video_player/video_player.dart';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:learning/list_of_video.dart';
import 'package:learning/reuse/reuse.dart';
import 'package:flutter/gestures.dart';
import 'package:learning/video_player.dart';
// import 'package:get';
import 'main.dart';

void main() {
  runApp(
    const VideoPage(),
  );
}

// var videoUrl;

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {

  Reference get storageRef => FirebaseStorage.instance.ref();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            // ignore: prefer_const_constructors
            title: const AppBarButton(),
            backgroundColor: Colors.red,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_rounded)
              //  Icons.arrow_back_rounded
              ,
            )),
        body: Row(
          children: [
            // const Home(),
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Container(
                          // color: Colors.amber.shade200,
                          height: 500,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                            // color: Colors.amber.shade400,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Padding(
                              //   padding: const EdgeInsets.only(top: 10.0),
                              //   child: Image.asset(
                              //     "images/physics.jpeg",
                              //     height: max(300, 300),
                              //     width: 300,
                              //   ),
                              // ),
                              // const Text(
                              //   "Physics",
                              //   style: TextStyle(backgroundColor: Colors.white),
                              // ),
                              VideoPlayerScreen(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   color: Colors.amber.shade100,
                  //   child: const Text("This is physics tutorial"),
                  // )
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  dragStartBehavior: DragStartBehavior.start,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // ignore: avoid_print
                      ButtonList(
                        link: "images/physics.jpeg",
                        title: "Chapter 1 - Motion",
                        onPressed: () {
                          // VideoList.Farifile;
                          // print(Farifile);


    //                       videoUrl =
    // // ignore: unnecessary_brace_in_string_interps
    // await storageRef.child("Physics/${Farifile}").getDownloadURL();

                            // print(videoUrl);

                          // ignore: non_constant_identifier_names
                          // Reference? Ref=storageRef.child('Physics');
                          // const fileName = 'video.mp3';
                          // // ignore: unused_local_variable
                          // final spaceRef = Ref.child(fileName);

                          // var url=spaceRef.getDownloadURL();

                          // print(url);

                          // ignore: unused_local_variable
                          // var urlRef=FirebaseStorage.child("Physics").child('video1.mp3');

                          // final videoUrl = await storageRef
                          //             // .fullPath;
                          //                 .child('/')
                          //                 .getDownloadURL();
                          //             print(videoUrl);
                          // Farifile;
                          // VideoList.readfirestore(VideoList.Farifile);
                          // print(const VideoList().readfirestore());
                          // GetStudentName();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         const File(), //go to list of video
                          //   ),
                          // );
                          // HR();
                        },
                      ),
                      ButtonList(title: "Chapter 2 - Newton's Law"),
                      ButtonList(link: "images/profile2.png", title: "profile"),
                      ButtonList(title: "Chapter 3 "),
                      ButtonList(title: "Chapter 4 "),
                      ButtonList(title: "Chapter 5 "),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
