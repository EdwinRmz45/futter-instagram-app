import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_instagram_app/backend/models/photo.dart';
import 'package:pinch_zoom_image/pinch_zoom_image.dart';

class ImageSlider extends StatefulWidget {
  final List<Photo> photosList;

  const ImageSlider(
    this.photosList, {
    Key key,
  }) : super(key: key);

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  @override
  Widget build(BuildContext context) {
    // Getting the aspect ratio of every photo
    // Aspect ratio = hight / width
    // hight mayor = numeros más altos
    // width mayor = numeros más bajos
    double aspectRatio = 0;
    for (var photo in widget.photosList) {
      if (photo.height / photo.width > aspectRatio) {
        aspectRatio = photo.height / photo.width;
      }
    }

    // Setting the width of the images...
    var sizedBoxWidth = MediaQuery.of(context).size.width;
    var sizedBoxHeight = sizedBoxWidth * aspectRatio;

    List<Widget> pinchZoomImages = [];
    for (var photo in widget.photosList) {
      pinchZoomImages.add(SizedBox(
        width: sizedBoxWidth,
        child: Center(
          child: PinchZoomImage(
            image: photo.data,
          ),
        ),
      ));
    }

    return Container(
      height: sizedBoxHeight,
      color: Colors.white,
      child: Stack(
        children: [
          PageView(
            physics: BouncingScrollPhysics(),
            children: pinchZoomImages,
          ),
          Positioned(
            top: 10,
            right: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                color: Colors.black.withAlpha(200),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "1/2",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
