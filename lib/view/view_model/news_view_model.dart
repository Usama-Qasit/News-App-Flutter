

import 'package:http/http.dart' as http;
import 'package:news_app/repository/news_repository.dart';

import '../../models/Categories_news_model.dart';
import '../../models/news_channel_headlines_model.dart';

class NewsViewModel {

  final _rep = NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesAPi(String channelName)async{

    final response = await _rep.fetchNewsChannelHeadlinesAPi(channelName);
    return response;

  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category)async{

    final response = await _rep.fetchCategoriesNewsApi(category);
    return response;


  }
}