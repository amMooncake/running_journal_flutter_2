import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyLockIcon extends StatelessWidget {
  const MyLockIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Icon(
        CupertinoIcons.lock_fill,
        size: 20,
        color: Theme.of(context).colorScheme.onSurface.withAlpha(100),
      ),
    );
  }
}
