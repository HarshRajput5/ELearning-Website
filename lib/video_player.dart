import 'dart:async';
import 'dart:html';
// import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:learning/list_of_video.dart';
import 'package:learning/video.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      const VideoPlayerScreen(),
      
    );
  
} 

// class VideoPlayerApp extends StatelessWidget {
//   const VideoPlayerApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Video Player Demo',
//       home: VideoPlayerScreen(),
//     );
//   }
// }

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  // Reference get storageRef => FirebaseStorage.instance.ref();


  @override
  void initState(){
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.

    // Reference get storageRef => FirebaseStorage.instance.ref();


    final storageRef = FirebaseStorage.instance.ref();
    final pathReference = storageRef.child("Shivam_Full_Video_Song___Baahubali_2_The_Conclusion___Prabhas,_Anushka_Shetty,__.mp4");
    final gsReference = FirebaseStorage.instance
        .refFromURL("gs://learning-9329e.appspot.com/Shivam_Full_Video_Song___Baahubali_2_The_Conclusion___Prabhas,_Anushka_Shetty,__.mp4");

    // videoUrl =
    // // ignore: unnecessary_brace_in_string_interps
    // await storageRef.child("Physics/${Farifile}").getDownloadURL();

    _controller = VideoPlayerController.network(
      // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      // gsReference.toString(),
      // "gs://learning-9329e.appspot.com/Shivam_Full_Video_Song___Baahubali_2_The_Conclusion___Prabhas,_Anushka_Shetty,__.mp4",
      // "https://firebasestorage.googleapis.com/v0/b/learning-9329e.appspot.com/o/Shivam_Full_Video_Song___Baahubali_2_The_Conclusion___Prabhas%2C_Anushka_Shetty%2C__.mp4?alt=media&token=756858a9-1c03-4e3e-88cb-56cdfb6b4741",
      videoUrl.toString(),
      
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);
  }

  // ignore: non_constant_identifier_names
  String VideoDuration(Duration duration) {
    String twoDigits(int n) {
      return n.toString().padLeft(2, '0');
    }

    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: 
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the VideoPlayerController has finished initialization, use
                  // the data it provides to limit the aspect ratio of the video.
                  return Container(
                    width: 500,
                    height: 400,
                    child: AspectRatio(
                      aspectRatio: 
                      // 10,
                      _controller.value.aspectRatio,
                      // Use the VideoPlayer widget to display the video.
                      child: VideoPlayer(_controller),
                    ),
                  );
                } else {
                  // If the VideoPlayerController is still initializing, show a
                  // loading spinner.
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Container(
              color: Colors.amber.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      // Wrap the play or pause in a call to `setState`. This ensures the
                      // correct icon is shown.
                      setState(
                        () {
                          // If the video is playing, pause it.
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                          } else {
                            // If the video is paused, play it.
                            _controller.play();
                          }
                        },
                      );
                    },
                    // Display the correct icon depending on the state of the player.
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
                  // Text(_controller.value.position as String)
                  ValueListenableBuilder(
                      valueListenable: _controller,
                      builder: (context, VideoPlayerValue value, child) {
                        return Text(
                          VideoDuration(value.position),
                        );
                      }),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 20,
                    width: 400,
                    child: VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                    ),
                  ),
                  Text(VideoDuration(_controller.value.duration)),
                ],
              ),
            )
          ],
        ),
      
    );

    // Use a FutureBuilder to display a loading spinner while waiting for the
    // VideoPlayerController to finish initializing.
  }
}
