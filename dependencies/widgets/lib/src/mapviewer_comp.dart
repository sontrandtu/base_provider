import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:widgets/src/button/elevated_button_comp.dart';

class MapViewerComp extends StatefulWidget {
  final List value;
  final bool hasPicker;
  final double zoom;
  final ValueChanged? onChanged;

  const MapViewerComp(this.value, {Key? key, this.hasPicker = false, this.onChanged, this.zoom = 7.0})
      : super(key: key);

  @override
  State<MapViewerComp> createState() => _MapViewerCompState();
}

class _MapViewerCompState extends State<MapViewerComp> {
  late MapController controller;
  late LatLng _latLng;
  double markerSize = 35;
  late ValueNotifier<LatLng?> pickLatLng;

  @override
  void initState() {
    pickLatLng = ValueNotifier(null);
    controller = MapController();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark));
    _initLatlng();
    super.initState();
  }

  void _initLatlng() {
    if (widget.value.isNotEmpty) {
      _latLng = LatLng(widget.value[0], widget.value[1]);
    } else {
      /// Ha Noi
      _latLng = LatLng(21.030653, 105.847130);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> _maps = [
      {
        'assets': 'assets/images/hoang_sa.png',
        'pos': [16.534722, 111.608333]
      },
      {
        'assets': 'assets/images/truong_sa.png',
        'pos': [8.641667, 111.931944]
      },
    ];
    return Scaffold(
      // appBar: AppBarComp(
      //   title: 'Mapviewer',
      // ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          FlutterMap(
            options: MapOptions(
              center: _latLng,
              controller: controller,
              // zoom: 10.0,
              maxZoom: widget.zoom + 1,
              minZoom: widget.zoom - 1,
              onTap: _tapAction,
              onPositionChanged: _onPositionChanged,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://server.arcgisonline.com/arcgis/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}",
                subdomains: ['a', 'b', 'c'],
                attributionBuilder: (_) => const SizedBox.shrink(),
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: markerSize,
                    height: markerSize,
                    point: _latLng,
                    builder: (ctx) => Icon(
                      // Icons.my_location_rounded,
                      Icons.accessibility,
                      size: markerSize,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  ..._maps
                      .map<Marker>((e) => Marker(
                            width: 140,
                            height: 140,
                            point: LatLng(e['pos'][0], e['pos'][1]),
                            builder: (ctx) => Image.asset(e['assets']),
                          ))
                      .toList(),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.only(top: 10, right: 15),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(50)),
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
          // if (widget.hasPicker)
          ValueListenableBuilder(
            valueListenable: pickLatLng,
            builder: (_, _val, __) {
              if (pickLatLng.value != null) {
                return SafeArea(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButtonComp(
                      title: 'Xác nhận',
                      onPressed: () => _onPickMap(_val),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  void _onPositionChanged(post, val) {}

  void _tapAction(post, val) {
    setState(() {
      _latLng = LatLng(val.latitude, val.longitude);
    });
    pickLatLng.value = _latLng;
  }

  void _onPickMap(dynamic val) {
    if (widget.onChanged != null) widget.onChanged!(val);
  }

  @override
  void dispose() {
    pickLatLng.dispose();
    super.dispose();
  }
}
