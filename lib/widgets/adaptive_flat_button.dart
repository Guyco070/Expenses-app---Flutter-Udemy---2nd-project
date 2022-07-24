import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function handler;

  // ignore: use_key_in_widget_constructors
  const AdaptiveFlatButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: handler,
            child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
            color: Theme.of(context).primaryColor,
          )
        : FlatButton(
            onPressed: handler,
            textColor: Theme.of(context).primaryColor,
            child:
                Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
          );
  }
}
