import 'package:flutter/material.dart';
import 'package:super_comics_app/dao/super_hero_dao.dart';
import 'package:super_comics_app/models/super_hero.dart';
import 'package:super_comics_app/services/super_hero_service.dart';

class HeroList extends StatefulWidget {
  const HeroList({super.key, required this.query});

  final String query;
  @override
  State<HeroList> createState() => _HeroListState();
}

class _HeroListState extends State<HeroList> {
  final _heroService = SuperHeroService();
  List _heros = [];

  @override
  Widget build(BuildContext context) {
    if (widget.query.isEmpty) {
      return Container();
    }
    return FutureBuilder<List>(
        future: _heroService.getSuperHeroesByName(widget.query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            _heros = snapshot.data ?? [];
            return ListView.builder(
              itemCount: _heros.length,
              itemBuilder: (context, index) {
                return SuperHeroItem(hero: _heros[index]);
              },
            );
          }
        });
  }
}


class SuperHeroItem extends StatefulWidget {
  const SuperHeroItem({super.key, required this.hero});
  final SuperHero hero;

  @override
  State<SuperHeroItem> createState() => _SuperHeroItemState();
}

class _SuperHeroItemState extends State<SuperHeroItem> {
  bool _isFavorite = false;
  final SuperHeroDao _heroDao = SuperHeroDao();

  initialize() async {
    _isFavorite = await _heroDao.isFavorite(widget.hero);
    if (mounted) {
      setState(() {
        _isFavorite = _isFavorite;
      });
    }
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        child: ListTile(
          title: Text(widget.hero.name),
          subtitle: Text(widget.hero.gender),
          leading: Hero(
            tag: widget.hero.id,
            child: Image.network(widget.hero.img)),
          trailing: IconButton(
            icon: Icon(
              Icons.favorite,
              color: _isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
              _isFavorite
                  ? _heroDao.insert(widget.hero)
                  : _heroDao.delete(widget.hero);
            },
          ),
        ),
      ),
    );
  }
}