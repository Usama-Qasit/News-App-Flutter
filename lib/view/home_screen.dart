


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/news_channel_headlines_model.dart';
import 'package:news_app/view/category_screen.dart';
import 'package:news_app/view/news_detail_screen.dart';
import 'package:news_app/view/view_model/news_view_model.dart';

import '../models/Categories_news_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList{ bbcNews , aryNews,alJazeera,ansaNews}
class _HomeScreenState extends State<HomeScreen> {


  NewsViewModel  newsViewModel = NewsViewModel();
  FilterList ? selectedMenu;
  final format = DateFormat('MMM dd , yy');

  String name = 'bbc-news';
  @override
  Widget build(BuildContext context) {
    final width  = MediaQuery.sizeOf(context).width *1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const CategoriesScreen()));
            },
            icon: Image.asset('images/menu_icon.png',
              height: 30,
              width: 30,
            ),
        ),
        title: Text('News',style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.w700),),
        actions: [
          PopupMenuButton<FilterList>(
            initialValue: selectedMenu,
              icon: const Icon(Icons.more_vert,color: Colors.black),
              onSelected: (FilterList item){
              if(FilterList.bbcNews.name == item.name){
                name = 'bbc-news';
              }
              if(FilterList.aryNews.name == item.name){
                name = 'ary-news';
              }
              if(FilterList.ansaNews.name == item.name){
                name = 'ansa';
              }


              setState(() {
                selectedMenu = item;
              });
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>>[
                const PopupMenuItem<FilterList>(
                  value: FilterList.bbcNews,
                    child: Text('BBC News'),
                ),
                const PopupMenuItem<FilterList>(
                  value: FilterList.aryNews,
                    child:Text('Ary News'),
                ),
                const PopupMenuItem<FilterList>(
                  value: FilterList.ansaNews,
                    child: Text('Ansa News'))
              ]
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width:  width ,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelsHeadlinesAPi(name),
                builder: (BuildContext context ,snapshot ){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(
                    child: SpinKitCircle(
                      size: 40,
                      color: Colors.green,
                    ),
                  );
                }else{
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context , index){
                      DateTime  dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                      return  InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> NewsDetailScreen(
                              newImage: snapshot.data!.articles![index].urlToImage.toString(),
                              newsTitle: snapshot.data!.articles![index].title.toString(),
                              newsDate: snapshot.data!.articles![index].publishedAt.toString(),
                              author: snapshot.data!.articles![index].author.toString(),
                              description: snapshot.data!.articles![index].description.toString(),
                              content: snapshot.data!.articles![index].content.toString(),
                              source: snapshot.data!.articles![index].source!.name.toString()))
                          );
                        },
                        child: Container(
                          child: Stack(
                            alignment:  Alignment.center,
                            children: [
                              Container(
                                height : height * 0.6,
                                width: width * .9,
                                padding: EdgeInsets.symmetric(horizontal: height * .02),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                      imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Card(
                                  elevation: 5,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child:Container(
                                    padding: const EdgeInsets.all(15),
                                    alignment: Alignment.bottomCenter,
                                    height: height * .22,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width :width * 0.7,
                                          child: Text(snapshot.data!.articles![index].title.toString(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: width * 0.7,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(snapshot.data!.articles![index].source!.name.toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(fontSize: 16,color: Colors.blue,fontWeight: FontWeight.w600),
                                              ),
                                              Text(format.format(dateTime),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(fontSize: 13,fontWeight: FontWeight.w300),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      );
                      }
                      );
                  }
                },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder<CategoriesNewsModel>(
                future:newsViewModel.fetchCategoriesNewsApi('General'),
                builder:(BuildContext context ,snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: SpinKitCircle(
                        color: Colors.red,
                        size: 50,
                      ),
                    );
                  }
                  else{
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          DateTime dateTime =  DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());

                          return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl:snapshot.data!.articles![index].urlToImage.toString(),
                                      fit: BoxFit.cover,
                                      height: height * .18,
                                      width: width *.3,
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                        height: height * .18,
                                        child:Padding(
                                          padding: const EdgeInsets.only(left: 15),
                                          child: Column(
                                            children: [
                                              Text(snapshot.data!.articles![index].title.toString(),
                                                maxLines:4,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const Spacer(),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(snapshot.data!.articles![index].source!.name.toString(),
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 11,
                                                      color: Colors.blue,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(format.format(dateTime),
                                                    overflow: TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10,fontWeight: FontWeight.w300),
                                                    ),

                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            );


                        });
                  }
                }
            ),
          ),
        ],
      ),
    );
  }
}
