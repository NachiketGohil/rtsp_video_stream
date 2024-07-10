import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class VideoStreamScreen extends StatefulWidget {
  const VideoStreamScreen({
    super.key,
    required this.source,
  });

  final String source;

  @override
  State<VideoStreamScreen> createState() => _VideoStreamScreenState();
}

class _VideoStreamScreenState extends State<VideoStreamScreen> {
  late VlcPlayerController _vlcController;
  bool isVideoPlay = true;

  @override
  void initState() {
    super.initState();
    _vlcController = VlcPlayerController.network(
      widget.source,
      hwAcc: HwAcc.full,
      autoPlay: true,
      allowBackgroundPlayback: false,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _vlcController.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (isVideoPlay) {
        _vlcController.pause();
      } else {
        _vlcController.play();
      }
      isVideoPlay = !isVideoPlay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RTSP Video Streaming'),
        elevation: 6,
        shadowColor: Colors.purple[50],
      ),
      body: Column(
        children: [
          Expanded(
            child: VlcPlayer(
              controller: _vlcController,
              aspectRatio: 16 / 9,
              placeholder: SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.8,
                child: const Center(
                  child: Text(
                    "Loading...",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _togglePlayPause,
                  icon: Icon(
                    isVideoPlay ? Icons.pause : Icons.play_arrow,
                    color: isVideoPlay ? Colors.blueAccent : Colors.orangeAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
