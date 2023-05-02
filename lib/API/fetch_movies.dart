import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Constant/constant.dart';

Future fetchMovies() async {
  final response =
      await http.get(Uri.parse("${baseUrl}movie/top_rated?api_key=$apiKey"));
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    return data['results'];
  } else {
    throw Exception('Something went wrong!!');
  }
}
