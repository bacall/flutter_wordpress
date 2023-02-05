import 'dart:convert';
import 'package:http/http.dart' as http;

const String domain="https://www.webprogramadorbarcelona.com";

const domainUrlPosts= '$domain/wp-json/wp/v2/posts?_embed&?status=publish';
const domainUrlPageInitial= '$domain/wp-json/wp/v2/pages?slug=Inicio&_embed&status=publish';
const domainUrlCategories='$domain/wp-json/wp/v2/categories';
const domainUrlCategoriesById='$domain/wp-json/wp/v2/posts?categories=';


Future<List> getPageInitial() async{
  final response= await http.get(Uri.parse(domainUrlPageInitial), headers: {'Accept':'application/json'});
  var convertirjson= jsonDecode(response.body);
  return convertirjson;
}

Future<List> getPosts() async{
  final response= await http.get(Uri.parse(domainUrlPosts), headers: {'Accept':'application/json'});
  var convertirjson= jsonDecode(response.body);
  return convertirjson;
}

Future<List> getCategories() async{
  final response= await http.get(Uri.parse(domainUrlCategories), headers: {'Accept':'application/json'});
  var convertirjson= jsonDecode(response.body);
  return convertirjson;
}

Future<List> getCategoryById(id) async{
  
  final response= await http.get(Uri.parse(domainUrlCategoriesById + id) , headers: {'Accept':'application/json'});
  var convertirjson= jsonDecode(response.body);
  return convertirjson;
}

