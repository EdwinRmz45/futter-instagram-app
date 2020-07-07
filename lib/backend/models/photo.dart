import'package:flutter/material.dart';

class Photo {
  int id;
  String url;

  Photo(this.id, this.url);

  Image get data{
    return Image.network('https://vignette.wikia.nocookie.net/sonic/images/2/2d/TSR_Sonic.png/revision/latest?cb=20200114015342&path-prefix=es');
  }

  set data(Image image){

  }
}