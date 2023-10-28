

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailScreen extends StatefulWidget {
  final String newImage,newsTitle,newsDate,author,description,content ,source;
  const NewsDetailScreen({Key? key,
    required this.newImage,
    required this.newsTitle,
    required this.newsDate,
    required this.author,
    required this.description,
    required this.content,
    required this.source,
  }) : super(key: key);

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {

  final format = DateFormat('MMM dd , yy');
  

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    DateTime dateTime = DateTime.parse(widget.newsDate);

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            height: height * .45,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(40),
              ),
              child: CachedNetworkImage(
                  imageUrl: widget.newImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: height * .6 ,
            margin: EdgeInsets.only(top: height * .4),
            padding: const EdgeInsets.only(top: 20,right: 20,left: 20,),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft:Radius.circular(30),
                topRight:Radius.circular(40),
              ),
              color: Colors.white
            ),
            child: ListView(
              children: [
                Text(widget.newsTitle),
                SizedBox(height: height * .02,),
                Row(
                  children: [
                    Expanded(child: Text(widget.source,style: GoogleFonts.poppins(fontSize: 13,color:Colors.black,fontWeight: FontWeight.w600))),
                    Text(format.format(dateTime),style: GoogleFonts.poppins(fontSize: 13,color:Colors.black,fontWeight: FontWeight.w600),),
                  ],
                ),
                SizedBox(height: height * .02,),
                Text(widget.description,style: GoogleFonts.poppins(fontSize: 13,color:Colors.black,fontWeight: FontWeight.w400),),
              ],
            ),

          ),

        ],

      ),

    );
  }
}
