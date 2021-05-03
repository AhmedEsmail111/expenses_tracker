import 'package:flutter/cupertino.dart';

class DatabaseTransaction {
  final int id;
  final String title;
  final double price;
  final int sqLiteTime;

  DatabaseTransaction({
    this.id,
    @required this.sqLiteTime,
    @required this.title,
    @required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'price': this.price,
      'sqLiteTime': this.sqLiteTime
    };
  }
}
