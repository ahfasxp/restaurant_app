import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({
    Key? key,
  }) : super(key: key);

  get greenColor => null;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 27),
        fillColor: searchColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
        ),
        prefixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        hintText: 'Search',
      ),
    );
  }
}
