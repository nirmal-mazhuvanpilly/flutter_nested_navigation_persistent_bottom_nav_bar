import 'package:flutter/material.dart';
import 'package:flutter_test_application/constants/border_constants.dart';
import 'package:flutter_test_application/constants/padding_constants.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: PaddingConsts.padding10,
      padding: PaddingConsts.horizontal5,
      decoration: BoxDecoration(
          color: Colors.grey.shade300,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderConts.border5),
      child: Row(
        children: const [
          Icon(Icons.search),
          Expanded(
              child: TextField(
            decoration: InputDecoration(
              contentPadding: PaddingConsts.horizontal10,
              hintText: "Search",
              errorBorder: InputBorder.none,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
            ),
          )),
          Icon(Icons.sort),
        ],
      ),
    );
  }
}
