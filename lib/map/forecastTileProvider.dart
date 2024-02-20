import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/mapData.dart';

class ForecastTileProvider implements TileProvider {
  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    Uint8List tileBytes = Uint8List(0);

    try {
      final url =
          'https://tile.openweathermap.org/map/pressure_new/$zoom/$x/$y.png?appid=${mapApikey}';
      final uri = Uri.parse(url);
      final imageData = await NetworkAssetBundle(uri).load("");
      tileBytes = imageData.buffer.asUint8List();
    } catch (e) {
      print(e.toString());
      print('error displaying tile');
    }
    return Tile(256, 256, tileBytes);
  }
}
