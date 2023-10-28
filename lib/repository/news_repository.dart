
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/news_channel_headlines_model.dart';

import '../models/Categories_news_model.dart';

class NewsRepository {

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesAPi(String channelName)async{

    String url = 'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=5aeb8414a64f4f3ea265295e067f5701';

    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){

      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);

    }
    throw Exception('Error');
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category)async{

    String url  = 'https://newsapi.org/v2/everything?q=${category}&apiKey=5aeb8414a64f4f3ea265295e067f5701';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode ==  200){
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    }
    throw Exception('Error');
  }

}