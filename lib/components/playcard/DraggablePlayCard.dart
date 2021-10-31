// ignore_for_file: file_names
import 'package:flutter/material.dart';

import 'PlayCard.dart';
import 'PlayCardObj.dart';
import 'TransperantPlayCard.dart';

class DraggablePlayCard extends StatelessWidget {
  final String imageName;
  final Function? onCardTap;
  final int? cardIndex;
  final PlayCardObj? playCardObj;
  final Function? onDragEndCallBack;

  const DraggablePlayCard(
      {required this.imageName,
      this.onCardTap,
      this.cardIndex,
      GlobalKey? key,
      this.playCardObj,
      this.onDragEndCallBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable(
      child: PlayCard(
        cardIndex: cardIndex,
        onCardTap: onCardTap,
        imageName: imageName,
        playCardObj: playCardObj,
      ),
      feedback: TransperantPlayCard(
        imageSource: imageName,
      ),
      onDraggableCanceled: (v, o) {
        onDragEndCallBack!(o, playCardObj);
      },
      onDragStarted: () {
        playCardObj!.isDraggedCard = true;
      },
    );
  }
}
