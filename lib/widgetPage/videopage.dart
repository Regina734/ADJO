import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDemoPage extends StatefulWidget {
  const VideoDemoPage({Key? key}) : super(key: key);

  @override
  State<VideoDemoPage> createState() => _VideoDemoPageState();
}

class _VideoDemoPageState extends State<VideoDemoPage> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    // Option 1 : Vidéo depuis les assets
    // _controller = VideoPlayerController.asset('assets/videos/demo.mp4')

    // Option 2 : Vidéo depuis internet (URL)
    _controller =
        VideoPlayerController.network(
            'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          )
          ..initialize().then((_) {
            setState(() {
              _isInitialized = true;
            });
          })
          ..setLooping(true); // La vidéo se répète
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Demo Video', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFFDB834),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: _isInitialized
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Lecteur vidéo
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  const SizedBox(height: 20),

                  // Contrôles
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Bouton Play/Pause
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            } else {
                              _controller.play();
                            }
                          });
                        },
                        icon: Icon(
                          _controller.value.isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled,
                          color: const Color(0xFFFDB834),
                          size: 64,
                        ),
                      ),
                      const SizedBox(width: 20),

                      // Bouton Stop/Restart
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _controller.seekTo(Duration.zero);
                            _controller.pause();
                          });
                        },
                        icon: const Icon(
                          Icons.stop_circle,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                    ],
                  ),

                  // Barre de progression
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                        playedColor: Color(0xFFFDB834),
                        bufferedColor: Colors.grey,
                        backgroundColor: Colors.white24,
                      ),
                    ),
                  ),
                ],
              )
            : const CircularProgressIndicator(color: Color(0xFFFDB834)),
      ),
    );
  }
}
