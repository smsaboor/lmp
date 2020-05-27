import 'package:http/http.dart' as http;
import 'package:lakhimpur_kheri/screens/news/models/article.dart';
import 'package:lakhimpur_kheri/screens/news/models/news_article.dart';
import 'package:lakhimpur_kheri/screens/news/models/news_model.dart';
import 'dart:convert';
import 'package:lakhimpur_kheri/screens/news/secret.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' show Client;

import 'dart:async';
import '../models/news_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class NewsApiProvider2 {
  Client client = Client();
  final _prefs = SharedPreferences.getInstance();
  String cntry = 'in';
  String lang='en';
  List<Article> news  = [];
  Future<void> getNews() async{
    final SharedPreferences pref = await _prefs;
    cntry = pref.getString('countryIsoCode');
    lang=pref.getString('languageIsoCode');
    String url = "http://newsapi.org/v2/top-headlines?country=$cntry&language=$lang&apiKey=${apiKey}";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }

  Future<NewsModel> fetchNewsList() async {
    String url = "https://newsapi.org/v2/top-headlines?country=in&apiKey=${apiKey}";
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return NewsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Faild to post!");
    }
  }
  Future<NewsModel> fetchSearchNews() async {
    final SharedPreferences prefs = await _prefs;
    String priorityTheme = prefs.getString("priorityTheme");
    String url = "https://newsapi.org/v2/everything?q=$priorityTheme&apiKey=$apiKey";
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return NewsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Faild to post!");
    }
  }

  Future<NewsModel> getFavoriteNews() async {
    final NewsModel nm = NewsModel();
    List<Articles> list = List<Articles>();
    var articles = await Firestore.instance
        .collection("users")
        .document(await getMyUID())
        .get();
    if (articles.data != null) {
      for (int i = 0; i < articles.data.length; i++)
        list.add(Articles.fromJson(articles.data.values.toList()[i]));
    }
    nm.articles = list;
    return nm;
  }

  generateUID() async {
    final myUID = Uuid().v4();
    (await _prefs).setString('id', myUID);
  }

  getMyUID() async {
    String uid = (await _prefs).getString('id');
    return uid ?? generateUID();
  }

  addToFiresstore(val) async {
    final String key =
    val['url'].toString().replaceAll('/', '').replaceAll('.', '');
    Firestore.instance
        .collection('users')
        .document(await getMyUID())
        .setData({key: val}, merge: true);
  }

  deliteFromFirestore(val) async {
    final String key =
    val['url'].toString().replaceAll('/', '').replaceAll('.', '');
    Firestore.instance
        .collection('users')
        .document(await getMyUID())
        .updateData({key: FieldValue.delete()});
  }
}

class NewsSearch {
  List<Article> news  = [];
  Future<void> getNews(String searchQuery) async{
    String url = "https://newsapi.org/v2/everything?q=$searchQuery&sortBy=popularity'&apiKey=${apiKey}";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}


class NewsForCategorie {
  List<Article> news  = [];
  Future<void> getNewsForCategory(String category) async{
    /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
    String url = "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=${apiKey}";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }
      });
    }
  }
}


class NewsForKeyword {
  List<Article> news  = [];
  Future<void> getNewsForKeyword(String keyword) async{
    String url = "https://newsapi.org/v2/everything?q=$keyword&apiKey=${apiKey}";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){
        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            publshedAt: DateTime.parse(element['publishedAt']),
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }

      });
    }


  }


}


