// ignore_for_file: file_names

import 'package:rummy_school/components/playcard/PlayCardObj.dart';

class GroupValidationUtils {
  static final GroupValidationUtils _singleton =
   GroupValidationUtils._internal();

  factory GroupValidationUtils() {
    return _singleton;
  }

  GroupValidationUtils._internal() {
    // initialization logic here
  }

// rest of the class

  bool getGroupStatus(List<PlayCardObj> group, String jockerCard) {
    if (isGroup(group, jockerCard)) {
      if (excludingJokerIsThereAnyDuplicateCard(group, jockerCard)) {
        return false;
      }

      if (doesAllCardBelongsToSameGroup(group, jockerCard)) {
        if (isPureSequence(group, jockerCard)) {
          return true;
        }
      }

      if (isSequenceWithJoker(group, jockerCard)) {
        return true;
      }

      if (isTripletOrQuadruplet(group, jockerCard)) {
        return true;
      }
    }
    return false;
  }

  bool isGroup(List<PlayCardObj> group, String jockerCard) {
    if (group.length > 2) {
      return true;
    }
    return false;
  }

  bool isPureSequence(List<PlayCardObj> group, String jockerCard) {
    int previousCard = -1;
    int currentCard = -1;
    String groupID;
    List<PlayCardObj> cloneGroup = [];
    cloneGroup.addAll(group);
    cloneGroup.sort((a, b) => int.parse(a.cardSource.substring(1))
        .compareTo(int.parse(b.cardSource.substring(1))));
    for (int i = 0; i < cloneGroup.length; i++) {
      groupID = group[i].cardSource.split("")[0];
      if (i == 0) {
        previousCard = int.parse(cloneGroup[i].cardSource.split(groupID)[1]);
      } else {
        currentCard = int.parse(cloneGroup[i].cardSource.split(groupID)[1]);
        int difference = currentCard - previousCard;
        previousCard = currentCard;

        if (difference > 1) {
          return false;
        }
      }
    }

    return true;
  }

  bool isSequenceWithJoker(List<PlayCardObj> group, String jockerCard) {
    int gap = 0;
    int previousCard = -1;
    int currentCard = -1;
    String groupID;
    List<PlayCardObj> cloneGroup = [];
    cloneGroup.addAll(group);

    cloneGroup.sort((a, b) => int.parse(a.cardSource.substring(1))
        .compareTo(int.parse(b.cardSource.substring(1))));

    List<PlayCardObj> groupExcludingJoker =
    excludeJokerCardsFromGroup(cloneGroup, jockerCard);
    List<PlayCardObj> jokerCard =
    getListOfJokerCardsInGroup(cloneGroup, jockerCard);

    if (!doesAllCardBelongsToSameGroup(groupExcludingJoker, jockerCard)) {
      return false;
    }

    for (int i = 0; i < groupExcludingJoker.length; i++) {
      groupID = groupExcludingJoker[i].cardSource.split("")[0];
      if (i == 0) {
        previousCard =
            int.parse(groupExcludingJoker[i].cardSource.split(groupID)[1]);
      } else {
        currentCard =
            int.parse(groupExcludingJoker[i].cardSource.split(groupID)[1]);
        int difference = currentCard - previousCard;
        previousCard = currentCard;

        if (difference > 1) {
          gap += difference - 1;
        }
      }
    }

    print("gap $gap | jokerCard.length ${jokerCard.length}");
    if (gap == 0 || jokerCard.length >= gap) {
      return true;
    }
    return false;
  }

  List<PlayCardObj> getListOfJokerCardsInGroup(
      List<PlayCardObj> group, String jockerCard) {
    List<PlayCardObj> cloneGroup = [];
    int jokerCardNuber = -1;
    if (jockerCard.startsWith("j")) {
      jokerCardNuber = 1;
    } else {
      jokerCardNuber = int.parse(jockerCard.substring(1));
    }

    for (int i = group.length - 1; i >= 0; i--) {
      PlayCardObj playcard = group[i];
      if (playcard.cardSource.startsWith('j') ||
          int.parse(playcard.cardSource.substring(1)) == jokerCardNuber) {
        cloneGroup.add(playcard);
      }
    }

    return cloneGroup;
  }

  List<PlayCardObj> excludeJokerCardsFromGroup(
      List<PlayCardObj> group, String jockerCard) {
    List<PlayCardObj> cloneGroup = [];
    cloneGroup.addAll(group);
    int jokerCardNuber = -1;
    if (jockerCard.startsWith("j")) {
      jokerCardNuber = 1;
    } else {
      jokerCardNuber = int.parse(jockerCard.substring(1));
    }

    for (int i = cloneGroup.length - 1; i >= 0; i--) {
      PlayCardObj playcard = cloneGroup[i];
      if (playcard.cardSource.startsWith('j') ||
          int.parse(playcard.cardSource.substring(1)) == jokerCardNuber) {
        cloneGroup.remove(playcard);
      }
    }

    return cloneGroup;
  }

  bool doesAllCardBelongsToSameGroup(
      List<PlayCardObj> group, String jockerCard) {
    String? suiteID;
    for (int i = 0; i < group.length; i++) {
      if (suiteID == null) {
        suiteID = group[i].cardSource.split("")[0];
      } else {
        if (!equalsIgnoreCase(suiteID, group[i].cardSource.split("")[0])) {
          return false;
        }
      }
    }
    return true;
  }

  bool isTripletOrQuadruplet(List<PlayCardObj> group, String jockerCard) {
    List<PlayCardObj> cloneGroup = [];
    cloneGroup.addAll(group);

    cloneGroup.sort((a, b) => int.parse(a.cardSource.substring(1))
        .compareTo(int.parse(b.cardSource.substring(1))));

    List<PlayCardObj> groupExcludingJoker =
    excludeJokerCardsFromGroup(cloneGroup, jockerCard);
    List<PlayCardObj> jokerCard =
    getListOfJokerCardsInGroup(cloneGroup, jockerCard);
    if (doesGroupHasAllDifferentSuits(groupExcludingJoker)) {
      if (allCardNumbersSame(groupExcludingJoker)) {
        int groupSize = groupExcludingJoker.length + jokerCard.length;
        if (groupSize == 4 || groupSize == 3) {
          return true;
        }
      }
    }
    return false;
  }

  bool allCardNumbersSame(List<PlayCardObj> group) {
    String? cardNumber;
    for (var item in group) {
      if (cardNumber == null) {
        cardNumber = item.cardSource.substring(1);
      } else if (cardNumber != item.cardSource.substring(1)) {
        return false;
      }
    }
    return true;
  }

  bool doesGroupHasAllDifferentSuits(List<PlayCardObj> group) {
    int c = 0, s = 0, h = 0, d = 0;
    for (var item in group) {
      if (item.cardSource.split("")[0] == "c") {
        c += 1;
      } else if (item.cardSource.split("")[0] == "s") {
        s += 1;
      } else if (item.cardSource.split("")[0] == "h") {
        h += 1;
      } else if (item.cardSource.split("")[0] == "d") {
        d += 1;
      }
    }
    if (c < 2 && s < 2 && h < 2 && d < 2) {
      return true;
    }

    return false;
  }

  bool excludingJokerIsThereAnyDuplicateCard(
      List<PlayCardObj> group, String jockerCard) {
    List<PlayCardObj> cloneGroup = [];
    cloneGroup.addAll(group);

    cloneGroup.where((element) => !element.cardSource.startsWith("j"));

    cloneGroup.sort((a, b) => int.parse(a.cardSource.substring(1))
        .compareTo(int.parse(b.cardSource.substring(1))));

    List<PlayCardObj> groupExcludingJoker =
    excludeJokerCardsFromGroup(cloneGroup, jockerCard);
    List<String> allCardsList = [];
    Set<String> uniqueCardsList = {};

    for (var item in groupExcludingJoker) {
      allCardsList.add(item.cardSource);
      uniqueCardsList.add(item.cardSource);
    }

    if (allCardsList.length != uniqueCardsList.length) {
      return true;
    }

    return false;
  }

  bool equalsIgnoreCase(String? string1, String? string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }
}
