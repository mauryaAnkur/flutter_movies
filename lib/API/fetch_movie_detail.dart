import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Constant/constant.dart';

Future fetchMovieDetail(String movieId) async {
  final response = await http.get(
      Uri.parse("${baseUrl}movie/$movieId?api_key=$apiKey&language=en-US"));
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception('not able to Fetch the Top Rated Movies');
  }
}
