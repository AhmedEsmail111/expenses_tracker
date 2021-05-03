import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextButton extends StatelessWidget {
  final String _text;
  final Function _onTapHandler;
  AdaptiveTextButton(this._text, this._onTapHandler);
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: _onTapHandler,
            child: Text(
              _text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 16.0,
              ),
            ),
          )
        : TextButton(
            onPressed: _onTapHandler,
            child: Text(
              _text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 16.0,
              ),
            ),
          );
  }
}
