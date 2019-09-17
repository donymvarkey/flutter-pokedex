import 'package:flutter/material.dart';
import 'package:pokedex/models/Pokemon.dart';

class PokeDetails extends StatelessWidget {
  final Pokemon pokemonDetails;
  PokeDetails({this.pokemonDetails});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            ),
        ),
        child: bodyWidget(context),
      ),
    );
  }

  bodyWidget(BuildContext context) => Stack(
    children: <Widget>[
      Positioned(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width - 20,
        left: 10.0,
        top: MediaQuery.of(context).size.height * 0.2,
        child: Card(
          elevation: 3.0,
          color: const Color(0xff673ab7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  pokemonDetails.name[0].toUpperCase() + pokemonDetails.name.substring(1),
                  style: TextStyle(
                    fontSize: 60.0,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Container(
                              margin: EdgeInsets.only(left: 12.0),
                              width: 20.0,
                              child: Center(
                                child: Text(
                                  "Height",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: const Color(0xff90caf9),
                                    fontSize: 3.0,
                                    fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Container(
                              margin: EdgeInsets.only(right: 12.0),
                              width: 20.0,
                              child: Center(
                                child: Text(
                                  pokemonDetails.height.toString() + "m",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: const Color(0xff90caf9),
                                    fontSize: 3.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Container(
                              margin: EdgeInsets.only(left: 12.0),
                              width: 20.0,
                              child: Center(
                                child: Text(
                                  "Weight",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: const Color(0xff90caf9),
                                    fontSize: 3.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.contain,
                            child: Container(
                              margin: EdgeInsets.only(right: 12.0),
                              width: 20.0,
                              child: Center(
                                child: Text(
                                  pokemonDetails.weight.toString() + "kg",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: const Color(0xff90caf9),
                                    fontSize: 3.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                      ),
                      TableRow(
                          children: [
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Container(
                                margin: EdgeInsets.only(left: 12.0),
                                width: 20.0,
                                child: Center(
                                  child: Text(
                                    "Base Exp.",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: const Color(0xff90caf9),
                                      fontSize: 3.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.contain,
                              child: Container(
                                margin: EdgeInsets.only(right: 12.0),
                                width: 20.0,
                                child: Center(
                                  child: Text(
                                    pokemonDetails.baseExperience.toString(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: const Color(0xff90caf9),
                                      fontSize: 3.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Types",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0, color: const Color(0xffeeff41)),
                        ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: pokemonDetails.types.map((t) => FilterChip(
                              backgroundColor: Colors.lightBlue,
                              label: Text(
                                t.type.name[0].toUpperCase() + t.type.name.substring(1),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              onSelected: (b) {},
                            )).toList(),
                        ),
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35.0, bottom: 20.0),
                  child: Text(
                    "Stats",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0, color: const Color(0xff76ff03)),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Center(
                      child: Wrap(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: pokemonDetails.stats.map((s) => FilterChip(
                          backgroundColor: Colors.yellow,
                          label: Text(
                            s.stat.name[0].toUpperCase() + s.stat.name.substring(1) + ": " + s.baseStat.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                            ),
                          ),
                          onSelected: (b) {},
                        )).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      Align(
        alignment: Alignment.topCenter,
        child: Hero(
          tag: pokemonDetails.name,
          child: Container(
            margin: const EdgeInsets.only(top: 90.0),
            height: 150.0,
            width: 150.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(pokemonDetails.sprites.frontDefault),
              )
            ),
          ),
        ),
      ),
    ],
  );
}
