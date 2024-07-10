import 'package:flutter/material.dart';
import 'package:stream_video/video_stream_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class StreamList extends StatefulWidget {
  StreamList({super.key});

  @override
  State<StreamList> createState() => _StreamListState();
}

class _StreamListState extends State<StreamList> {
  final List<String> _defStream = [
    'rtsp://guardnet.selfip.com:7100',
  ];

  final List<String> _streamList = [
    'http://pendelcam.kip.uni-heidelberg.de/mjpg/video.mjpg',
    'http://webcam01.ecn.purdue.edu/mjpg/video.mjpg',
    'http://61.211.241.239/nphMotionJpeg?Resolution=320x240',
    'http://namesti.mestovm.cz/mjpg/video.mjpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Stream Sources'),
        elevation: 6,
        shadowColor: Colors.purple[50],
        actions: [
          IconButton(
            onPressed: () {
              /// Go to Github
              ///
            },
            icon: const Icon(Icons.code),
            iconSize: 36,
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            section("Given Data Source"),
            ListTile(
              title: Text(
                _defStream[0],
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const Divider(
              height: 1,
              color: Colors.black,
              thickness: 2,
            ),
            section("Other Explored Data Sources"),
            Expanded(
              child: ListView.builder(
                itemCount: _streamList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => VideoStreamScreen(
                            source: _streamList[index],
                          ),
                        ),
                      );
                    },
                    title: Text(
                      _streamList[index],
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget section(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 10,
            decoration: BoxDecoration(
              color: Colors.purpleAccent[100],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

final Uri _url = Uri.parse('https://flutter.dev');

Future<void> launchGitHub() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
