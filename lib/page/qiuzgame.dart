import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class QuizGame extends StatefulWidget {
  const QuizGame({Key? key}) : super(key: key);

  @override
  State<QuizGame> createState() => _QuizGameState();
}

class _QuizGameState extends State<QuizGame> {
  final List<Map<String, dynamic>> _gameData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: handleClickButton,
                child: Text('เริ่มเกม'),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _gameData.length,
                itemBuilder: (context,indek) => _buildListItem(context,indek),
              ),
            ),
          ],
        ),
      ),
    );
  }

  handleClickButton() async {
    final url = Uri.parse('https://cpsu-test-api.herokuapp.com/quizzes');
    var result = await http.get(url, headers: {'id': '620710669'});
    print(result.body);

    var json = jsonDecode(result.body);
    String status = json['status'];
    String? message = json['message'];
    List<dynamic> data = json['data'];
    var list = List<String>.from(json['data']) ;
    setState(() {
      for (var element in data) {
        _gameData.add(element);
      }
    });
  }

  Widget _buildListItem(BuildContext context,int indek) {
    var Quiz = _gameData[indek];
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(8.0),
      elevation: 5.0,
      shadowColor: Colors.black.withOpacity(0.2),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: <Widget>[
            Image.network(
              Quiz['image_url'],
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Quiz['choice_list'],
                        ),
                        Text(
                          Quiz['choice_list'],
                        ),
                        Text(
                          Quiz['choice_list'],
                        ),
                        Text(
                          Quiz['choice_list'],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
