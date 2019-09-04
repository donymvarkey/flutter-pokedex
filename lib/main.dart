import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "dart:convert";

import 'package:pokedex/models/Generations.dart';
import 'package:pokedex/models/GenerationDetails.dart';
import 'package:pokedex/generation_detail.dart';

void main () => runApp(MaterialApp(
  title: "Pokedex",
  home: HomePage(
  ),
  debugShowCheckedModeBanner: false,
));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var genUrl = "https://pokeapi.co/api/v2/generation/";
  Generations generations;

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
      body: Row(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                TextFormField()
              ],
            ),
          ),
          Container(
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
              Center(child: CircularProgressIndicator()
              ) :
              GridView.count(
                crossAxisCount: 3,
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
        ],
      ),
    );
  }


}
