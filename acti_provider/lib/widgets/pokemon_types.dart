import 'package:flutter/material.dart';

class PokemonTypes extends StatelessWidget {
  final Map pokemon;

  const PokemonTypes({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> types = pokemon['types'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: types
          .map((type) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.blue, width: 2),
                ),
                child: Text(
                  type['type']['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ))
          .toList(),
    );
  }
}
