import 'package:flutter/material.dart';
import 'package:mypt/components/video.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoListView extends StatefulWidget {
  final List<String>? urlList;

  VideoListView({this.urlList});

  @override
  _VideoListViewState createState() => _VideoListViewState();
}

class _VideoListViewState extends State<VideoListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 170,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(widget.urlList!.length, (index) {
          final String videoId =
              YoutubePlayerController.convertUrlToId(widget.urlList![index])!;
          return Container(
            margin: EdgeInsets.only(right: 10),
            child: VideoWidget(videoId),
          );
        }),
      ),
    );
  }
}
