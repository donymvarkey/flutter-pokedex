class GenerationDetails {
  int id;
  MainRegion mainRegion;
  String name;
  List<PokemonSpecies> pokemonSpecies;

  GenerationDetails(
      {
        this.id,
        this.mainRegion,
        this.name,
        this.pokemonSpecies,
      });

  GenerationDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mainRegion = json['main_region'] != null
        ? new MainRegion.fromJson(json['main_region'])
        : null;
    name = json['name'];
    if (json['pokemon_species'] != null) {
      pokemonSpecies = new List<PokemonSpecies>();
      json['pokemon_species'].forEach((v) {
        pokemonSpecies.add(new PokemonSpecies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.mainRegion != null) {
      data['main_region'] = this.mainRegion.toJson();
    }
    data['name'] = this.name;
    if (this.pokemonSpecies != null) {
      data['pokemon_species'] =
          this.pokemonSpecies.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MainRegion {
  String name;
  String url;

  MainRegion({this.name, this.url});

  MainRegion.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class PokemonSpecies {
  String name;
  String url;
  String id;

  PokemonSpecies({this.name, this.url});

  PokemonSpecies.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    var res = url.split('/');
    int len = res.length;
    this.id = res[len-2];

  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    data['id']  = this.id;
    return data;
  }
}