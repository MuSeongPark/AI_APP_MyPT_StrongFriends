import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoWidget extends StatefulWidget {
  final String? videoId;

  VideoWidget(this.videoId);

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: '${widget.videoId}',
      params: const YoutubePlayerParams(
        autoPlay: false,
        startAt: const Duration(minutes: 0, seconds: 0),
        showControls: true,
        showFullscreenButton: true,
        desktopMode: false,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    _controller.onExitFullscreen = () {
      log('Exited Fullscreen');
    };
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      // Passing controller to widgets below.
      controller: _controller,
      child: Container(
        height: 150,
        width: 200,
        child: Stack(
            children: [
              player,
              Positioned.fill(
                child: YoutubeValueBuilder(
                  controller: _controller,
                  builder: (context, value) {
                    return AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: Material(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                YoutubePlayerController.getThumbnail(
                                  videoId: _controller.initialVideoId,
                                  quality: ThumbnailQuality.medium,
                                ),
                              ),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                      crossFadeState: value.isReady
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 300),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}