import 'package:ceit_alumni/core/request_fullscreen/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'image/image_fullscreen.dart';
import 'video/video_fullscreen.dart';

class GalleryMediaArguments {
  const GalleryMediaArguments({
    @required this.url,
    this.thumbnail,
    this.isImage = true,
  }) : assert(url != null);

  final String url;
  final String thumbnail;

  //todo: change to enum
  final bool isImage;
}

class GalleryMediaFullscreen extends StatefulWidget {
  GalleryMediaFullscreen({
    @required this.url,
    @required this.thumbnail,
    @required this.isImage,
  });

  final String url;
  final String thumbnail;
  final bool isImage;
  static const String mediaGalleryRoute = '/view';

  @override
  _GalleryMediaFullscreenState createState() => _GalleryMediaFullscreenState();
}

class _GalleryMediaFullscreenState extends State<GalleryMediaFullscreen> {
  bool _isFullscreen = false;
  RequestFullscreen _requestFullscreen;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    _requestFullscreen = RequestFullscreen(
      onExit: _onExit,
      onEnter: _onEnter,
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    RequestFullscreen().exitFullscreen();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isImage
        ? ImageFullscreen(url: widget.url)
        : VideoFullscreen(
            url: widget.url,
            thumbnail: widget.thumbnail,
            isFullscreen: _isFullscreen,
            handleFullscreenButton: _handleFullscreenButton,
          );
  }

  void _handleFullscreenButton() {
    if (_isFullscreen) {
      _requestFullscreen.exitFullscreen();
    } else {
      _requestFullscreen.requestFullscreen();
    }
  }

  void _onExit() {
    if (mounted) {
      setState(() => _isFullscreen = false);
    }
  }

  void _onEnter() {
    if (mounted) {
      setState(() => _isFullscreen = true);
    }
  }
}
