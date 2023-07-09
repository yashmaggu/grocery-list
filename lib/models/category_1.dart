
import 'package:flutter/widgets.dart';


enum Categories{
   vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other
}

class Category{
Category({required this.title,required this.color});

final String title;
final Color color; 

}