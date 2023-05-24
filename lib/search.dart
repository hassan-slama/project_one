import 'package:flutter/material.dart';

class Search extends SearchDelegate{
  List items = ["pizza","eggs","meat","chicken","pasta","fish","milk","cheese","tomato"];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query = "";
      }, icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, null);
    }, icon: Icon(Icons.arrow_back));
  }

  @override


  Widget buildResults(BuildContext context) {
    return Text("$query");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List itemFiltered = items.where((element) => element.startsWith(query)).toList();
    return ListView.builder(
        itemCount: query == ""?items.length:itemFiltered.length ,
        itemBuilder: (context,index){
        return InkWell(
          onTap: (){
            query = query == ""?items[index]:itemFiltered[index];
            showResults(context);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child:
           query == ""? Text("${items[index]}",style: TextStyle(fontSize: 20),):
           Text("${itemFiltered[index]}",style: TextStyle(fontSize: 20),)
          ),
        );

    });
  }

}