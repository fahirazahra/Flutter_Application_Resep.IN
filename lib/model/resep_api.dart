import 'dart:convert';
import 'package:recipe_apps/model/resep_api.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_apps/model/resep.dart';

class ResepApi {
/* const req = unirest("GET", "https://yummly2.p.rapidapi.com/feeds/list");

req.query({
	"limit": "24",
	"start": "0"
});

req.headers({
	"X-RapidAPI-Key": "924186bbd8msh5c9da84c5415c6fp13a9cejsn8cfcf506bb8e",
	"X-RapidAPI-Host": "yummly2.p.rapidapi.com",
	"useQueryString": true
}); */

  static Future<List<Resep>> getResep() async {
    var uri = Uri.https('tasty.p.rapidapi.com', '/recipes/list',
        {"from": "0", "size": "20", "tags": "under_30_minutes"});

    final reponse = await http.get(uri, headers: {
      "X-RapidAPI-Key": "924186bbd8msh5c9da84c5415c6fp13a9cejsn8cfcf506bb8e",
      "X-RapidAPI-Host": "tasty.p.rapidapi.com",
      "useQueryString": "true",
    });

    Map data = jsonDecode(reponse.body);

    List _temp = [];

    for (var i in data['results']) {
      _temp.add(i);
    }
    return Resep.resepFromSnapshot(_temp);
  }
}
