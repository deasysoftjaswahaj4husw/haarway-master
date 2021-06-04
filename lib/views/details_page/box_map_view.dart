import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:provider/provider.dart';
import 'package:haarway_app/global_variables.dart' as globals;

List<LatLng> latlngList = List<LatLng>();
class ServiceMapView extends StatefulWidget {

  @override
  _ServiceMapViewState createState() => _ServiceMapViewState();
}

class _ServiceMapViewState extends State<ServiceMapView> {
  bool _isCreatingLink = false;
  String _linkMessage;

  final String token =
      'pk.eyJ1IjoiaGFhcndheSIsImEiOiJja212ajVqZWMwNDA4MnZwOW9oYWdranNmIn0.HziiQNO71kdOtN72E7g1Qw';
  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: FlutterMap(
            options: new MapOptions(
                center: new LatLng(22.5702, 88.36421170902921),
                minZoom: 07.0),


            layers: [
              new TileLayerOptions(
                  urlTemplate: "https://api.mapbox.com/styles/v1/mapwahaj/ckp3u1sbu08z617l10uqu4mp5/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFwd2FoYWoiLCJhIjoiY2ttYWF4bjhuMXE4ZjJ4bzkxcjNpeWY1eiJ9.XSqp4zpmusuHU4HIUvlCkw",
                  additionalOptions: {
                    'accessToken': 'https://api.mapbox.com/styles/v1/mapwahaj/ckp3u1sbu08z617l10uqu4mp5/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWFwd2FoYWoiLCJhIjoiY2ttYWF4bjhuMXE4ZjJ4bzkxcjNpeWY1eiJ9.XSqp4zpmusuHU4HIUvlCkw',
                    'id': 'mapbox.mapbox-streets-v7'
                  }),

            ])

    );

  }
  Future<String> _createDynamicLink(
      bool short, title, imageUrl, shortDescription) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://haarway.page.link',
      link: Uri.parse('https://haarway.page.link/$shortDescription'),
      androidParameters: AndroidParameters(
        packageName: 'com.haarway.app',
        minimumVersion: 0,
      ),
      dynamicLinkParametersOptions: DynamicLinkParametersOptions(
        shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
      ),
      iosParameters: IosParameters(
        bundleId: 'com.google.FirebaseCppDynamicLinksTestApp.dev',
        minimumVersion: '0',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        imageUrl: Uri.parse(imageUrl),
        title: "$title",
        description: '$shortDescription',
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink = await parameters.buildShortLink();
      url = shortLink.shortUrl;
    } else {
      url = await parameters.buildUrl();
    }

    setState(() {
      _linkMessage = url.toString();
      _isCreatingLink = false;
    });

    return url.toString();
  }

/*void onMapCreated(MapboxMapController controller) {
    controller.addSymbol(SymbolOptions(
        geometry: LatLng(
          center.latitude,
          center.longitude,
        ),
        iconImage: "airport-15"));
    controller.addLine(
      LineOptions(
        geometry: [
          LatLng(-33.86711, 151.1947171),
          LatLng(-33.86711, 151.1947171),
          LatLng(-32.86711, 151.1947171),
          LatLng(-33.86711, 152.1947171),
        ],
        lineColor: "#ff0000",
        lineWidth: 7.0,
        lineOpacity: 0.5,
      ),
    );
  }*/
}