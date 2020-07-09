import 'package:flutter/material.dart';
import 'package:pokedex/consts/consts_api.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:pokedex/stores/pokeapi_store.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokeDetailPage extends StatelessWidget {
  final int index; 
  final String name;

  Color _colorPokemon;
 
  PokeDetailPage({
    Key key,
    this.index,
    this.name
  });

  @override
  Widget build(BuildContext context) {
    final _pokemonStore = Provider.of<PokeApiStore>(context);

    Pokemon _pokemon = _pokemonStore.getPokemon(index: this.index);

    _colorPokemon = ConstsAPI.getColorType(type: _pokemon.type[0]);

    return Scaffold(
      appBar: AppBar(
        title: Opacity(
            opacity: 0.0,
            child: Text(
            _pokemon.name,
            style: TextStyle(
              fontFamily: 'Google',
              fontWeight: FontWeight.bold,
              fontSize: 24
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: _colorPokemon,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () { 
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () { 

            },
          ),
        ],
      ),
      backgroundColor: _colorPokemon,
      body: Stack(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 2.5,
        ),
        SlidingSheet(
          elevation: 0,
          cornerRadius: 16,
          snapSpec: const SnapSpec(
            snap: true,
            snappings: [0.6, 1.0],
            positioning: SnapPositioning.relativeToAvailableSpace,
          ),
          builder: (context, state) {
            return Container(
              height: MediaQuery.of(context).size.height,
            );
          },
        ),
      ],),
    );
  }
}