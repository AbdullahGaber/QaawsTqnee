import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String imageUrl;
  final String labelName;
  CategoryItem({
    this.labelName,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        width: double.infinity,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
      Text(labelName),
    ]);
  }
}
