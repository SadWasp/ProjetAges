import 'dart:async';
import 'dart:convert';
import 'package:ages_app/Commande/commande.dart';
import 'package:http/http.dart' as http;
import 'package:ages_app/Module/Exceptions.dart';
import 'package:ages_app/Module/constants.dart';

Future<Map<String, dynamic>> postRequest(
    {required String api, dynamic body, Map<String, String>? header}) async {
  if (header == null) header = {'Content-Type': 'application/json'};
  var res = await http.post(Uri.parse(siteweb + api),
      headers: header, body: json.encode(body));
  if (res.statusCode == 404) throw Exception("Page not found");
  if (res.statusCode == 405) throw Exception("Method not allowed");
  if (res.body == "false") throw UIException("Authentifiants incorrectes");
  if (res.statusCode == 200) {
    return json.decode(utf8.decode(res.bodyBytes));
  }
  throw Exception(json.decode(utf8.decode(res.bodyBytes))['message']);
  
}
Future<String> singlePostRequest(
    {required String api, dynamic body, Map<String, String>? header}) async {
  if (header == null) header = {'Content-Type': 'application/json'};

  var res = await http.post(Uri.parse(siteweb + api),
      headers: header, body: jsonEncode(body));
  print(res);
  if (res.statusCode == 404) throw Exception("Page not found");
  if (res.statusCode == 405) throw Exception("Method not allowed");
  if (res.body == "false") throw UIException("Authentifiants incorrectes");
  if (res.statusCode == 200) {
    return res.body;
  }
  throw Exception(json.decode(utf8.decode(res.bodyBytes))['message']);
}



Future<List<dynamic>> getRequestList({required String api}) async {
  var res = await http.get(Uri.parse(siteweb + api));
  if (res.statusCode == 404) throw Exception("Page not found");
  if (res.body == "false") throw UIException("Erreur fatale");
  if (res.statusCode == 200) {
    var list = json.decode(res.body);
    return list;
  }
  throw Exception(json.decode(utf8.decode(res.bodyBytes))['message']);
}
Future<List<dynamic>> getRequestListCommande({required String api, required int idUser}) async {
  var res = await http.get(Uri.parse(siteweb + api + idUser.toString()));
  if (res.statusCode == 404) throw Exception("Page not found");
  if (res.body == "false") throw UIException("Erreur fatale");
  if (res.statusCode == 200) {
    var list = json.decode(res.body);
    return list;
  }
  throw Exception(json.decode(utf8.decode(res.bodyBytes))['message']);
}

Future getRequest({required String api}) async {
  var res = await http.get(Uri.parse(siteweb + api));
  if (res.statusCode == 404) throw Exception("Page not found");
  if (res.body == "false") throw UIException("Erreur fatale");
  if (res.statusCode == 200) {
    var list = json.decode(res.body);
    return list;
  }
  throw Exception(json.decode(utf8.decode(res.bodyBytes))['message']);
}

Future<Map<String,dynamic>> deleteRequest({required String api}) async {
  var res = await http.delete(Uri.parse(siteweb + api));
  if (res.statusCode == 404) throw Exception("Page not found");
  if (res.statusCode == 405) throw Exception("Method not allowed");
  if (res.body == "false") throw UIException("Erreur fatale");
  if (res.statusCode == 200) {
    var list = json.decode(res.body);
    return list;
  }
  throw Exception(json.decode(utf8.decode(res.bodyBytes))['message']);
}


Future<List<Commande>> getListItems() async{
    var res = await getRequestList(api: "items");
    List<Commande> listItem = [];
    for (var i = 0; i < res.length; i++) {
      listItem.add(Commande.fromJson(res[i]));
    }
    return listItem;
  }
