import 'package:flutter/material.dart';
import 'package:super_comics_app/dao/super_hero_dao.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  List favorites = [];

  initialize() async {
    favorites = await SuperHeroDao().fetchAll();
    if (mounted) {
      setState(() {
        favorites = favorites;
      });
    }
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void deleteFavorite(String id) async {
    await SuperHeroDao().deleteById(id);
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            title: Text(favorites[index].name),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => deleteFavorite(favorites[index].id),
            ),
          ),
        ),
      ),
    );
  }
}