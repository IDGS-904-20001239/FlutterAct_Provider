import 'package:acti_provider/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:acti_provider/widgets/pokemon_card_widget.dart';

import '../themes/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<PokemonProvider>(context, listen: false).getPokemons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pkProvider = Provider.of<PokemonProvider>(context);
    List pokemonsList = pkProvider.pokemons;
    print(pokemonsList);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppTheme.primaryColor,
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Container(
                alignment: Alignment.bottomCenter,
                width: double.infinity,
                child: const Text('Pokedex'),
              ),
              background: const FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: AssetImage('assets/loading2.gif'),
                  image: NetworkImage('assets/pokemon.png')),
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return PokemonCardWidget(
                    pokemonName: pokemonsList[index]['name']);
              },
              childCount: pokemonsList.length,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: ()async {
                    await UtilProvider.rtp.clearSession();
                    Navigator.pushNamed(context, '/Login');
                },
                
                child: Text('Cerrar Sesión'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
