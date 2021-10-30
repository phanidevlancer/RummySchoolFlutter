// ignore_for_file: file_names

import 'package:rummy_school/components/playcard/PlayCardObj.dart';
import 'package:rummy_school/components/utils/GroupValidationUtils.dart';

class GroupInfo {
  List<PlayCardObj> cards = [];
  int? groupIndex = -1;
  double? groupWidth = -1;
  double groupStartOffsetPos = -1;
  double groupEndOffsetPos = -1;
  bool isValidGroup = false;

  GroupInfo({required this.cards});

  double getGroupWidth() {
    return groupEndOffsetPos - groupEndOffsetPos;
  }

  bool isGroupValid() {
    isValidGroup = false;
    if (cards.length > 2 &&
        GroupValidationUtils().getGroupStatus(cards, "c9")) {
      return true;
    }
    return false;
  }

  bool checkValidGroup() {
    int counter = -1;
    List<PlayCardObj> cloneCards = [];
    cloneCards.addAll(cards);
    cloneCards.sort((a, b) => int.parse(a.cardSource.split("d")[1])
        .compareTo(int.parse(b.cardSource.split("d")[1])));

    for (int i = 0; i < cloneCards.length; i++) {
      // print("counter ${cloneCards[i].cardSource.substring(1)}");
      if (i == 0) {
        counter = int.parse(cloneCards[i].cardSource.split("d")[1]);
      } else {
        if (counter == int.parse(cloneCards[i].cardSource.split("d")[1])) {
        } else {
          return false;
        }
      }
      // print("counter $counter");
      counter++;
    }
    return true;
  }
}