import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final Function handler;

  AdaptiveFlatButton(this.text, this.handler);

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
            child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
            textColor: Theme.of(context).primaryColor,
          );
  }
}
