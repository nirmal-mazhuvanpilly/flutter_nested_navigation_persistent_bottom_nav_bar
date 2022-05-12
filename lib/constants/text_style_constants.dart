import 'package:flutter/material.dart';

class TextStyleConsts {
  static const TextStyle white = TextStyle(color: Colors.white);

  static const TextStyle bold30White = TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bold15 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle normal20 = TextStyle(fontSize: 20);

  static final TextStyle strike12GreyShade900 = TextStyle(
    color: Colors.grey.shade900,
    fontSize: 12,
    decoration: TextDecoration.lineThrough,
  );

  static final TextStyle boldGreenShade900 =
      TextStyle(color: Colors.green.shade900, fontWeight: FontWeight.bold);

  static final TextStyle boldStrikeGreyShade600 = TextStyle(
    color: Colors.grey.shade600,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.lineThrough,
  );

  static final TextStyle boldStrikeGreyShade800 =
      TextStyle(color: Colors.grey.shade800, fontWeight: FontWeight.bold);
}
