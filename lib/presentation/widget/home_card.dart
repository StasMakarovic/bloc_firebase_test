// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String name1;
  final String name2;
  final String num1;
  final String num2;
  final String img1;
  final String img2;

  const HomeCard({
    Key? key,
    required this.title,
    required this.name1,
    required this.name2,
    required this.num1,
    required this.num2,
    required this.img1,
    required this.img2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 22),
            ),
          ),
          ListTile(
            title: Text(name1),
            subtitle: Text(num1),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(img1),
            ),
          ),
          ListTile(
            title: Text(name2),
            subtitle: Text(num2),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(img2),
            ),
          ),
        ],
      ),
    );
  }
}
