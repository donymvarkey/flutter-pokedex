import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import 'package:pokedex/pokemon.dart';
import 'package:pokedex/models/Generations.dart';
import 'package:pokedex/models/Pokemon.dart';
import 'package:pokedex/models/GenerationDetails.dart';


class GenDetails extends StatelessWidget {

  final GenerationDetails generations;
  GenDetails({this.generations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            (generations.name[0].toUpperCase() + generations.name.substring(1, 11).toLowerCase() + generations.name.substring(11).toUpperCase() + " Pokémon").replaceAll(RegExp("-"), " "),
          style: TextStyle(
            fontSize: 23.0,
            color: Colors.black,
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
        Center(child: CircularProgressIndicator()
        ) :
        GridView.count(
          crossAxisCount: 3,
          children: generations.pokemonSpecies.map((pokemon) => Padding(
            padding: const EdgeInsets.all(2.0),
            child: InkWell(
              onTap: () async {
                var data = await http.get("https://pokeapi.co/api/v2/pokemon/${pokemon.id}/");
                var decodedData = jsonDecode(data.body);

                var pokeDetails = Pokemon.fromJson(decodedData);
                print(pokeDetails.stats[0].stat.toJson());
                Navigator.push(context, MaterialPageRoute(builder: (context) => PokeDetails(
                  pokemonDetails: pokeDetails,
                )));
              },
              child: Container(
                child: Hero(
                  tag: pokemon.name,
                  child: Card(
                    color: const Color(0xfffff8e1),
                    elevation: 3.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 100.0,
                          width: 100.0,
                          child: Text(
                            pokemon.id
                          ),
                           decoration: BoxDecoration(
                             image: DecorationImage(
                               image: NetworkImage("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/" + pokemon.id + ".png"),
                             ),
                           ),
                        ),
                        Text(
                          (pokemon.name[0].toUpperCase() + pokemon.name.substring(1)),
                          style: TextStyle(
                              fontSize: 18.0,
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
        )
      ),
    );
  }
}
