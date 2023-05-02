import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Constant/constant.dart';

Future searchMovies(String query) async {
  final response = await http.get(Uri.parse(
      "$baseUrl/search/movie?api_key=$apiKey&language=en-US&query=$query&page=1&include_adult=false"));
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return data['results'];
  } else {
    throw Exception('Something went wrong!!');
  }
}
