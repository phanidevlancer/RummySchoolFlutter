// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class PlayCardObj {
  int groupIndex = -1;
  int cardIndexInCurrentGroup = -1;
  bool isSelected = false;
  String cardSource;
  double cardLeftMargin = 0;
  bool isDraggedCard = false;
  GlobalKey key = GlobalKey();

  PlayCardObj(this.groupIndex, this.isSelected, this.cardSource,
      this.cardIndexInCurrentGroup);

  @override
  String toString() {
    return cardSource ;
  }
}
