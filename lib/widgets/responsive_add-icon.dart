import 'package:flutter/material.dart';

class ResponsiveAddIcon extends StatelessWidget {
  final Function _onTapHandler;
  ResponsiveAddIcon(this._onTapHandler);
  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 450
        ? GestureDetector(
            onTap: // launch the add transaction window
                _onTapHandler,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add a Transaction',
                  style: TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.add,
                  ),
                ),
              ],
            ),
          )
        : IconButton(
            icon: Icon(Icons.add),
            // launch the add transaction window
            onPressed: _onTapHandler,
          );
  }
}
