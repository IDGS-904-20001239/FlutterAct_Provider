import 'dart:convert';
import 'dart:io';
import 'package:acti_provider/providers/util_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class PokemonProvider extends ChangeNotifier {
    final String _urlBase = 'https://pokeapi.co/api/v2/';

  PokemonProvider() {  
    print('Pokemon Provider');
  }

  List<dynamic> pokemons = [];

  Future getPokemons() async{
    final String url = '${_urlBase}pokemon?limit=17&offset=0';
    final response = await UtilProvider.rtp.responseHttp(urlBase: url);
    if(response.statusCode==200){
      var jResponse = jsonDecode(response.body) as Map;
      pokemons = jResponse['results'];
      notifyListeners();
    }else if(response.statusCode==408){
      print('No hay datos');
    }
  }

  Future<Map<String, dynamic>> getPokemonByName(final String name) async {
  final String url = '${_urlBase}pokemon/$name';
  final response = await UtilProvider.rtp.responseHttp(urlBase: url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> pokemonData = jsonDecode(response.body);
    return pokemonData;
  } else {
    throw Exception('No hay datos');
  }
}

Future responseHTTP({required String urlbase}) async
{
  try {
    var response = await http.get(Uri.parse(urlbase)).timeout(
      const Duration(seconds: 10),
      onTimeout: () => http.Response('Error', 408)); 
    
    print('Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response;
  } on SocketException{
    return http.Response('Error', 502);
  } on HttpException{
    return http.Response('Error', 404);
  } on FormatException{
    return http.Response('Error', 400);
  } catch (e) {
    print(e);
  }
}
}
