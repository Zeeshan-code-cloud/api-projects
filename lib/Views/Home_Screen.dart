
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Home_screen extends StatefulWidget {
  const Home_screen({Key? key}) : super(key: key);

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  
  List<Photo> photoList = [];
  Future<List<Photo>> getphotoApi () async {
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for(Map i in data){
        Photo photo = Photo(id: i["id"], title: i["title"], url: i["url"]);
        photoList.add(photo);
      }
      return photoList;
    }else{

      return photoList;

    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API Course"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getphotoApi (),
              builder: (BuildContext context, AsyncSnapshot<List<Photo>> snapshot) {
              return ListView.builder(
                itemCount: photoList.length,
                  itemBuilder: (context,index){
                return ListTile(
                  title:  Text(snapshot.data![index].title.toString()),
                );
              });
            },
            ),
          ),
        ],
      ),
    );
  }
}


class Photo{
  late String id;
  late String title;
  late String url;
  Photo({required this.id,required this.title, required this.url});
}
