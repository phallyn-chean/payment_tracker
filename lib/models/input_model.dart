import 'package:flutter/material.dart';

class InputModel {
  late int id;

  late String type;

  late double amount;

  late String category;

  late String description;

  late String date;

  late String time;

  Color? color;

  InputModel({
    this.id = 0,
    this.type = '',
    this.amount = 0.0,
    this.category = '',
    this.description = '',
    this.date = '',
    this.time = '',
    this.color,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'type': type,
      'amount': amount,
      'category': category,
      'description': description,
      'date': date,
      'time': time,
    };

    // ignore: unnecessary_null_comparison
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  static InputModel fromMap(Map<String, dynamic> map) {
    return InputModel(
      id: map['id'],
      type: map['type'],
      amount: map['amount'],
      category: map['category'],
      description: map['description'],
      date: map['date'],
      time: map['time'],
    );
  }
}
