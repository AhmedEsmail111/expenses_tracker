import 'package:flutter/material.dart';

const kAddTextFieldInputDecoration = InputDecoration(
  hintText: 'The Price',
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide(
      width: 1.0,
      color: Colors.purpleAccent,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide(
      width: 2.0,
      color: Colors.purpleAccent,
    ),
  ),
);
