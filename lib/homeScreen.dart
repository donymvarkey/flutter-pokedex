import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "dart:convert";

import 'package:pokedex/models/Generations.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:pokedex/models/GenerationDetails.dart';
import 'package:pokedex/generation_detail.dart';
import 'package:pokedex/pokemon.dart';
import 'package:pokedex/popup.dart';
import 'package:pokedex/popup_content.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var genUrl = "https://pokeapi.co/api/v2/generation/";
  Generations generations;

  final searchController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  fetchData() async {
    var gen = await http.get(genUrl);
    var decodedGen =  jsonDecode(gen.body);

    generations = Generations.fromJson(decodedGen);
    setState(() {

    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Pokédex',
            style: TextStyle(
                fontSize: 28.0,
                color: Colors.black
            ),
          ),
        ),
        backgroundColor: const Color(0xffffc107),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFffc107),
                  const Color(0xFFff9800),
                  const Color(0xFFe65100)
                ],
                stops: [0.0, 0.5, 1.0]
            )
        ),
        child: generations == null ?
        Center(child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
        )
        ) :
        GridView.count(
          crossAxisCount: 2,
          children: generations.results.map((generation) => Padding(
            padding: const EdgeInsets.all(2.0),
            child: InkWell(
              onTap: () async {
                var genIDetails = await http.get(generation.url);
                var decodedGenDetails = jsonDecode(genIDetails.body);

                var genI = GenerationDetails.fromJson(decodedGenDetails);
                Navigator.push(context, MaterialPageRoute(builder: (context) => GenDetails(
                  generations: genI,
                )));
              },
              child: Container(
                child: Hero(
                  tag: generation.name,
                  child: Card(
                    elevation: 3.0,
                    color: const Color(0xfffff8e1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          (generation.name[0].toUpperCase() + generation.name.substring(1, 11).toLowerCase() + generation.name.substring(11).toUpperCase()).replaceAll(RegExp("-"), " "),
                          style: TextStyle(
                              fontSize: 20.0,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )).toList(),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 80.0,
        height: 80.0,
        child: FloatingActionButton(
          backgroundColor: const Color(0xffffc107),
          onPressed: () {
            showPopup(context, _popupBody(), 'Search Pokemon');
          },
          tooltip: 'Search Pokemon',
          child: Icon(Icons.search, color: Colors.black, size: 30.0,),
        ),
      ),
    );
  }
  showPopup(BuildContext context, Widget widget, String title,
      {BuildContext popupContext}) {
    Navigator.push(
      context,
      PopupLayout(
        top: 300,
        left: 30,
        right: 30,
        bottom: 370,
        child: Container(
          child: Card(
            elevation: 0.0,
            child: PopupContent(
              content: Scaffold(
                floatingActionButton: Padding(
                  padding: const EdgeInsets.only(top:55.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right:8.0),
                        child: SizedBox(
                          width: 60.0,
                          height: 60.0,
                          child: FloatingActionButton(
                            backgroundColor: Colors.amber,
                            onPressed: () async {
                              try {
                                  var pokemonName = searchController.text.toLowerCase();
                                  String pokemonUrl = "https://pokeapi.co/api/v2/pokemon/"+pokemonName+"/";
                                  var data = await http.get(pokemonUrl);
                                  var decodedData = jsonDecode(data.body);

                                  var pokeDetails = Pokemon.fromJson(decodedData);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PokeDetails(
                                    pokemonDetails: pokeDetails,
                                  )));
                                } catch (e) {}
                            },
                            tooltip: 'Search',
                            child: Icon(Icons.search, color: Colors.black, size: 30.0,),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left:8.0),
                        child: SizedBox(
                          width: 60.0,
                          height: 60.0,
                          child: FloatingActionButton(
                            backgroundColor: Colors.amber,
                            onPressed: () {
                              try {
                                  Navigator.pop(context); //close the popup
                                } catch (e) {}
                            },
                            tooltip: 'Close',
                            child: Icon(Icons.close, color: Colors.black, size: 30.0,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                resizeToAvoidBottomPadding: false,
                body: widget,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _popupBody() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0, bottom: 10.0),
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            labelText: "Search Pokemon",
          ),
        ),
      ),
    );
  }




}