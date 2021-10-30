// ignore_for_file: file_names

import 'package:flutter/material.dart';
import './PlayCardObj.dart';

class PlayCard extends StatelessWidget {
  final String? imageName;

  final Function? onCardTap;

  final int? cardIndex;
  final PlayCardObj? playCardObj;

  const PlayCard(
      { this.imageName,
        this.onCardTap,
        this.cardIndex,
        GlobalKey? key,
        this.playCardObj})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      disabledColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      textColor: Colors.transparent,
      disabledTextColor: Colors.transparent,
      minWidth: 0,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      clipBehavior: Clip.none,
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      color: Colors.transparent,
      child: Image(
        image: AssetImage('images/$imageName.png'),
        height: 80,
        fit: BoxFit.fill,
      ),
      onPressed: () => onCardTap!(playCardObj),
    );
  }
}