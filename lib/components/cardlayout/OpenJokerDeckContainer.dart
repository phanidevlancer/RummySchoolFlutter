// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:rummy_school/components/playcard/PlayCard.dart';

class OpenJokerDeckContainer extends StatelessWidget {
  final String? jokerCardSource;
  final String? deckCardSource;
  final String? openCardSource;

  const OpenJokerDeckContainer(
      {Key? key, this.jokerCardSource, this.deckCardSource, this.openCardSource})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(left: 10),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
         const Positioned(
            child: RotationTransition(
              turns:   AlwaysStoppedAnimation(-90 / 360),
              child: PlayCard(
                imageName: "c9",
              ),
            ),
          ),
          const Positioned(
            left: 30,
            child: PlayCard(
              imageName: "deck",
            ),
          ),
          const Positioned(
            left: 120,
            child: PlayCard(
              imageName: "empty",
            ),
          ),
          Positioned(
              left: 220,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                   SizedBox(
                    height: 18,
                  ),
                  Text(
                    "Score",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "80",
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
