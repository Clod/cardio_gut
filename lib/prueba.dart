import 'dart:convert' as convert;
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

void main(List<String> arguments) async {
  // This example uses the Google Books API to search for books about http.
  // https://developers.google.com/books/docs/overview

  //https://stackoverflow.com/questions/64104688/can-i-use-custom-environment-variables-in-flutter
  // var pindonga = const String.fromEnvironment('JAVA_HOME');
  // print("Pindonga:" + pindonga);

  Map<String, String> envVars = Platform.environment;
  debugPrint(envVars['PATH']);

  var url = Uri.http('localhost:8080', '/patients');

  // Await the http get response, then decode the json-formatted response.
  var response = await http.get(url);
  if (response.statusCode == 200) {
    debugPrint(response.body);
    var jsonResponse =
    convert.jsonDecode(response.body) as Map<String, dynamic>;
    var itemCount = jsonResponse['totalItems'];
    debugPrint('Number of books about http: $itemCount.');
  } else {
    debugPrint('Request failed with status: ${response.statusCode}.');
  }
}