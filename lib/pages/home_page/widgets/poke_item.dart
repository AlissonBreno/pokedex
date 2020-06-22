import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/consts/consts_app.dart';

class PokeItem extends StatelessWidget {
  final String name;
  final int index;
  final Color color;
  final String num;
  final List<String> types;

  const PokeItem(
      {Key key, this.name, this.index, this.color, this.num, this.types})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Stack(
            //alignment: Alignment.bottomRight,
            //Parei aqui
            children: <Widget>[
              Opacity(
                child: Image.asset(
                  ConstsApp.whitePokeball,
                  height: 100,
                  width: 100,
                ),
                opacity: 0.2,
              ),
              CachedNetworkImage(
                height: 100,
                width: 100,
                placeholder: (context, url) => new Container (
                  color: Colors.transparent,
                ),
                imageUrl: 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$num.png',
              ),
              Text(name),
            ],
          ),
        ),
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}
