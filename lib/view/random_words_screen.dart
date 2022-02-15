import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import '../color/random_color.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rastgele Kelimeler"),
        actions: [
          IconButton(
            onPressed: _pushSaved,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, i) {
          final index = i ~/ 1;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          return _builderRow(_suggestions[index]);
        },
      ),
    );
  }

  Widget _builderRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair
        title: Text(
          pair.asPascalCase,
          style: const TextStyle(fontSize: 20),
        ),
        trailing: Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
          semanticLabel: alreadySaved ? 'Sil' : 'Kaydet',
        ),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        },
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (context) {
        final tiles = _saved.map(
          (pair) {
            return Card(
              color: randowColors(),
              child: ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            );
          },
        );
        final divided = tiles.isNotEmpty
            ? ListTile.divideTiles(
                context: context,
                tiles: tiles,
              ).toList()
            : <Widget>[];
        return Scaffold(
          appBar: AppBar(
            title: const Text("Kaydedilen Kelimeler"),
          ),
          body: ListView(children: divided),
        );
      }),
    );
  }
}
