import 'package:flutter/material.dart';
import 'package:super_comics_app/screens/super_heroes/hero_list.dart';

class SuperHeroes extends StatefulWidget {
  const SuperHeroes({super.key});

  @override
  State<SuperHeroes> createState() => _SuperHeroesState();
}

class _SuperHeroesState extends State<SuperHeroes> {
  final TextEditingController _controller = TextEditingController();
  String _search = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: SafeArea(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(0, 5),
                        blurRadius: 12.0,
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        hintText: "Search hero by name"),
                    onChanged: (value) {
                      setState(() {
                        _search = value;
                      });
                    },
                  ),
                ),
              ),
            ]),
          )),
      body: HeroList(query: _search),
    );
  }
}
