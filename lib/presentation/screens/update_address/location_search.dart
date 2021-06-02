// import 'package:eat_naija_vendor/view/signup/place_service.dart';
import './place_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LocationSearch extends SearchDelegate<Suggestion>{
  LocationSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  @override
  TextStyle get searchFieldStyle => TextStyle(
      color: Colors.white,
      fontSize: 18.0,
    );

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context).copyWith(
      textTheme: TextTheme(
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
        ),
      ),
    );
    assert(theme != null);
    return theme;
  }

  final sessionToken;
  PlaceApiProvider apiClient;


  // TextEditingController _addressController;

  // Widget build(BuildContext context){
  //   return SafeArea(
  //     child: Scaffold(
  //       body:  Container(
  //         height: MediaQuery.of(context).size.height,
  //         width: MediaQuery.of(context).size.width,
  //         child: Column(
  //           children: [
  //             Container(
  //               height: 50,
  //               width: MediaQuery.of(context).size.width,
  //               child: Row(
  //                 children: [
  //                   GestureDetector(
  //                     onTap: (){
  //                       Navigator.pop(context);
  //                     },
  //                      child:
  //                     SizedBox(
  //                       height: 40,
  //                       width:40,
  //                       child:
  //                       Icon(Icons.arrow_back, size: 25)
  //                     ),
  //                   ),
  //                   Expanded(
  //                     child:
  //                     TextField(
  //                       autofocus: true,
  //                       decoration: InputDecoration(
  //                             hintText: "Enter your location",
  //                             labelStyle: TextStyle(color: Colors.grey),
  //                             ),
  //                         controller: _addressController,
  //                     )
  //                   ),
  //                   GestureDetector(
  //                     onTap: (){
  //                         _addressController.text = "";
  //                     },
  //                     child:
  //                     SizedBox(
  //                       height: 40,
  //                       width:40,
  //                       child:
  //                       Icon(Icons.close, size: 25)
  //                     ),
  //                   ),
  //                 ],),
  //               ),
  //           ],)
  //         ),
  //     ),
  //   );
  // }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == ""
          ? null
          : apiClient.fetchSuggestions(
              query, Localizations.localeOf(context).languageCode),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Enter your address'),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    title:
                        Text((snapshot.data[index] as Suggestion).description),
                    onTap: () {
                      close(
                        context,
                        snapshot.data[index] as Suggestion
                        );
                    },
                  ),
                  itemCount: snapshot.data.length,
                )
              : Container(child: Text('Loading...')),
    );
  }
}