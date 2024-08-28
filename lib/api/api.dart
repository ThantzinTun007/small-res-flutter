import 'dart:convert';
//dart convert for json
import 'package:small_res/models/menuItem.model.dart';
import 'package:http/http.dart' as http;

class Api {
  static const _menuItemUrl = 'http://localhost:8080/api/res/menuitems';

  Future<List<MenuItem>>getTrendingMovies() async {

    final response = await http.get(Uri.parse(_menuItemUrl));

    if(response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((menuItem) => MenuItem.fromJson(menuItem)).toList();
    }else {
      throw Exception('Something happended');
    }
  }
}
