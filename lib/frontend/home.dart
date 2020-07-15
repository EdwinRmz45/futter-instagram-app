import 'package:carousel_slider/carousel_slider.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_app/backend/models/photo.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widgets/image_slider.dart';
import 'widgets/post_upper_barr.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    void _onRefresh() async {
      // monitor network fetch
      await Future.delayed(Duration(milliseconds: 1000));
      // if failed,use refreshFailed()
      _refreshController.refreshCompleted();
    }

    // Cambio de modo light a modo dark
    void changeBrightness() {
      DynamicTheme.of(context).setBrightness(
          Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark);

      setState(() {});
    }

    final CarouselController _controller = CarouselController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.photo_camera),
          onPressed: null,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Theme.of(context).brightness == Brightness.light
                ? Icons.brightness_3
                : Icons.brightness_7),
            onPressed: changeBrightness,
          ),
        ],
        title: Text(
          "Instagram",
          style: TextStyle(fontFamily: 'Billabong', fontSize: 28),
        ),
        centerTitle: true,
      ),
      body: SmartRefresher(
        enablePullDown: true,
        header: MaterialClassicHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              PostUpperBar(),
              ImageSlider([
                Photo(
                    null,
                    "https://media.ed.edmunds-media.com/toyota/tacoma/2020/oem/2020_toyota_tacoma_crew-cab-pickup_trd-off-road_fq_oem_4_1600.jpg",
                    1600,
                    1067),
                Photo(
                    null,
                    "https://hips.hearstapps.com/hmg-prod/amv-prod-cad-assets/wp-content/uploads/2016/11/2017-Toyota-Tacoma-TRD-Pro-4x4.jpg",
                    2250,
                    1375),
              ]),
              // SizedBox(
              //   height: 400,
              //   child: ListView(
              //     physics: BouncingScrollPhysics(),
              //     children: <Widget>[
              //       SizedBox(
              //         width: MediaQuery.of(context).size.width,
              //         child: PinchZoomImage(
              //           image: Image.network(
              //               'https://media.ed.edmunds-media.com/toyota/tacoma/2020/oem/2020_toyota_tacoma_crew-cab-pickup_trd-off-road_fq_oem_4_1600.jpg'),
              //         ),
              //       ),
              //       SizedBox(
              //         width: MediaQuery.of(context).size.width,
              //         child: PinchZoomImage(
              //           image: Image.network(
              //               'https://media.ed.edmunds-media.com/toyota/tacoma/2020/oem/2020_toyota_tacoma_crew-cab-pickup_trd-off-road_fq_oem_4_1600.jpg'),
              //         ),
              //       ),
              //       SizedBox(
              //         width: MediaQuery.of(context).size.width,
              //         child: PinchZoomImage(
              //           image: Image.network(
              //               'https://media.ed.edmunds-media.com/toyota/tacoma/2020/oem/2020_toyota_tacoma_crew-cab-pickup_trd-off-road_fq_oem_4_1600.jpg'),
              //         ),
              //       ),
              //     ],
              //     scrollDirection: Axis.horizontal,
              //   ),
              // ),
              // SingleChildScrollView(
              //   primary: true,
              //   physics: BouncingScrollPhysics(),
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: <Widget>[
              //       SizedBox(
              //         width: MediaQuery.of(context).size.width,
              //         child: PinchZoomImage(
              //           image: Image.network(
              //               'https://media.ed.edmunds-media.com/toyota/tacoma/2020/oem/2020_toyota_tacoma_crew-cab-pickup_trd-off-road_fq_oem_4_1600.jpg'),
              //         ),
              //       ),
              //       SizedBox(
              //         width: MediaQuery.of(context).size.width,
              //         child: PinchZoomImage(
              //           image: Image.network(
              //               'https://media.ed.edmunds-media.com/toyota/tacoma/2020/oem/2020_toyota_tacoma_crew-cab-pickup_trd-off-road_fq_oem_4_1600.jpg'),
              //         ),
              //       ),
              //       SizedBox(
              //         width: MediaQuery.of(context).size.width,
              //         child: PinchZoomImage(
              //           image: Image.network(
              //               'https://media.ed.edmunds-media.com/toyota/tacoma/2020/oem/2020_toyota_tacoma_crew-cab-pickup_trd-off-road_fq_oem_4_1600.jpg'),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 400,
              //   width: double.infinity,
              //   child: Carousel(

              //     autoplay: false,
              //     showIndicator: false,
              //     images: <Widget>[
              //       PinchZoomImage(
              //         image: Image.network(
              //             'https://media.ed.edmunds-media.com/toyota/tacoma/2020/oem/2020_toyota_tacoma_crew-cab-pickup_trd-off-road_fq_oem_4_1600.jpg'),
              //       ),
              //       PinchZoomImage(
              //         image: Image.network(
              //             'https://media.ed.edmunds-media.com/toyota/tacoma/2020/oem/2020_toyota_tacoma_crew-cab-pickup_trd-off-road_fq_oem_4_1600.jpg'),
              //       ),
              //       PinchZoomImage(
              //         image: Image.network(
              //             'https://media.ed.edmunds-media.com/toyota/tacoma/2020/oem/2020_toyota_tacoma_crew-cab-pickup_trd-off-road_fq_oem_4_1600.jpg'),
              //       ),
              //     ],
              //   ),
              // ),
              // CarouselSlider(
              //   options: CarouselOptions(
              //     reverse: false,
              //     enableInfiniteScroll: false,
              //     scrollPhysics: BouncingScrollPhysics(),
              //     viewportFraction: 1.0,
              //   ),
              //   items: <Widget>[
              //     PinchZoomImage(
              //       image: Image.network(
              //           'https://media.ed.edmunds-media.com/toyota/tacoma/2020/oem/2020_toyota_tacoma_crew-cab-pickup_trd-off-road_fq_oem_4_1600.jpg'),
              //     ),
              //     PinchZoomImage(
              //       image: Image.network(
              //           'https://media.ed.edmunds-media.com/toyota/tacoma/2020/oem/2020_toyota_tacoma_crew-cab-pickup_trd-off-road_fq_oem_4_1600.jpg'),
              //     ),
              //     PinchZoomImage(
              //       image: Image.network(
              //           'https://media.ed.edmunds-media.com/toyota/tacoma/2020/oem/2020_toyota_tacoma_crew-cab-pickup_trd-off-road_fq_oem_4_1600.jpg'),
              //     ),
              //   ],
              // ),
              Container(
                height: 250,
                width: double.infinity,
                color: Colors.purpleAccent,
              ),
              Container(
                height: 250,
                width: double.infinity,
                color: Colors.redAccent,
              ),
              Container(
                height: 250,
                width: double.infinity,
                color: Colors.teal,
              ),
              Container(
                height: 250,
                width: double.infinity,
                color: Colors.green,
              ),
              Container(
                height: 250,
                width: double.infinity,
                color: Colors.lightBlue,
              ),
              Container(
                height: 250,
                width: double.infinity,
                color: Colors.lime,
              ),
              Container(
                height: 250,
                width: double.infinity,
                color: Colors.orange,
              ),
              Container(
                height: 250,
                width: double.infinity,
                color: Colors.yellow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
