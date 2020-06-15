import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pokedex/consts/consts_app.dart';
import 'package:pokedex/models/pokeapi.dart';
import 'package:pokedex/pages/home_page/widgets/app_bar_home.dart';
import 'package:pokedex/stores/pokeapi_store.dart';


class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokeApiStore pokeApiStore;

  @override
  void initState(){
    super.initState();
    pokeApiStore = PokeApiStore();
    pokeApiStore.fetchPokemonList();
  }

  @override 
  Widget build(BuildContext context){
    double screenWidth = MediaQuery.of(context).size.width;
    double statusWidth = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            top: -(240/4.7),
            left: screenWidth - (240/1.5),
            child: Opacity(
              child: Image.asset(
                ConstsApp.blackPokeball,
                height: 240,
                width: 240,
              ),
              opacity: 0.1,
            ),
          ),
          Container(
            child: Column (
              children: <Widget>[
                Container(
                  height: statusWidth,
                ),
                AppBarHome(),
                Expanded(
                  child: Container(
                    child: Observer(
                      name: 'ListaHomePage',
                      builder: (BuildContext context) {
                        return (pokeApiStore.pokeAPI != null)
                          ? AnimationLimiter(
                            child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.all(12),
                              addAutomaticKeepAlives: false,
                              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2
                              ),
                              itemCount: pokeApiStore.pokeAPI.pokemon.length,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: const Duration (microseconds: 375),
                                  columnCount: 2,
                                  child: ScaleAnimation(
                                    child: ScaleAnimation(
                                      child: GestureDetector(
                                        child: Padding(
                                          // parei aqui
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            color: Colors.red,
                                          ),
                                        ),
                                        /*child: PokeItem(
                                          cor: _pokemonStore.getColorPokemon(
                                            type: _pokemonStore.pokeApi.pokemon[index].type[0]
                                          ),
                                          tipos: _pokemonStore.pokeApi.pokemon[index].type,
                                          nome: _pokemonStore.pokeApi.pokemon[index].name,
                                          image: Hero(
                                            tag: _pokemonStore.pokeApi.pokemon[index].numero,
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                left: 40,
                                                top: 40
                                              ),
                                              child: _pokemonStore.getImage(
                                                numero: _pokemonStore.pokeAPI.pokemon[index].numero,  
                                              ),
                                            ),
                                          ),*/
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                Container(),
                                                //PokeDetailPage(index: index),
                                                //fullscreenDialog: true,
                                            ),
                                          );
                                        }
                                      ),
                                    ),
                                  ),
                                );
                              }, 
                            ),
                          )
                          : Center(
                            child: CircularProgressIndicator(),
                          );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}