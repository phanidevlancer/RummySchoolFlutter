// ignore_for_file: file_names, duplicate_ignore, avoid_print, non_constant_identifier_names, empty_catches

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rummy_school/components/playcard/DraggablePlayCard.dart';
import 'package:rummy_school/components/playcard/PlayCardObj.dart';
import 'package:rummy_school/components/utils/RandomCards.dart';
import 'package:rummy_school/dto/GroupInfo.dart';

// ignore: file_names
class CardLayout extends StatefulWidget {
  const CardLayout({Key? key}) : super(key: key);
  @override
  CardLayoutState createState() => CardLayoutState();
}

class CardLayoutState extends State<CardLayout> {
  double cardLayoutWidth = double.infinity;

  List<PlayCardObj> selectedCards = [];
  final int MAX_GROUPS = 5;

  final List<PlayCardObj> cardsList = [
    PlayCardObj(0, false, "d1", 1),
    PlayCardObj(0, false, "d2", 2),
    PlayCardObj(0, false, "d3", 3),
    PlayCardObj(0, false, "d4", 4),
    PlayCardObj(0, false, "d5", 5),
    PlayCardObj(0, false, "d6", 6),
    PlayCardObj(0, false, "d7", 7),
    PlayCardObj(0, false, "d8", 8),
    PlayCardObj(0, false, "d9", 9),
    PlayCardObj(0, false, "d10", 10),
    PlayCardObj(0, false, "d11", 11),
    PlayCardObj(0, false, "d12", 12),
    PlayCardObj(0, false, "d13", 13),
  ];

  List<GroupInfo> groupsInfoArray = [
    GroupInfo(cards: [
      PlayCardObj(0, false, "d1", 0),
      PlayCardObj(0, false, "d2", 1),
      PlayCardObj(0, false, "d3", 2),
    ]),
    GroupInfo(cards: [
      PlayCardObj(1, false, "d4", 0),
      PlayCardObj(1, false, "d5", 1),
      PlayCardObj(1, false, "d6", 2),
      PlayCardObj(1, false, "d7", 3),
      PlayCardObj(1, false, "d8", 4),
    ]),
    GroupInfo(cards: [
      PlayCardObj(2, false, "d9", 0),
      PlayCardObj(2, false, "d10", 1),
      PlayCardObj(2, false, "d11", 2),
      PlayCardObj(2, false, "d12", 3),
      PlayCardObj(2, false, "d13", 4),
    ])
  ];

  GlobalKey cardLayoutKey = GlobalKey();
  double cardLayoutHeight = 140;
  double playCardHeight = 80;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    _landscapeModeOnly();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    calculateGroupsStartEndWidth();
    calculateCardLayoutWidth();
    return Container(
        margin: const EdgeInsets.only(bottom: 0),
        key: cardLayoutKey,
        color: Colors.transparent,
        width: cardLayoutWidth,
        height: cardLayoutHeight,
        child: Container(
          child: getCards(),
        ));
  }

  void _landscapeModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  void onCardTapped(PlayCardObj playCardObj) {
    setState(() {
      playCardObj.isSelected = !playCardObj.isSelected;
      if (playCardObj.isSelected) {
        selectedCards.add(playCardObj);
      } else {
        selectedCards.remove(playCardObj);
      }
    });
  }

  Widget getCards() {
    print("getCards called now");
    int cardLeftMargin = 0;
    int cardGapInSameGroup = 25;
    int groupMargin = 50;
    int cardIndexCounter = 0;

    List<Widget> list = <Widget>[];
    for (var i = 0; i < groupsInfoArray.length; i++) {
      List<PlayCardObj> group = groupsInfoArray[i].cards;
      if (i != 0) {
        cardLeftMargin += groupMargin;
      }

      for (var i = 0; i < group.length; i++) {
        GlobalKey playCardKey = GlobalKey();
        PlayCardObj playCardObj = group[i];

        playCardObj.key = playCardKey;
        playCardObj.cardLeftMargin = cardLeftMargin.toDouble();
        list.add(
          Positioned(
            left: (cardLeftMargin).toDouble(),
            top: playCardObj.isSelected
                ? cardLayoutHeight - playCardHeight - 25
                : cardLayoutHeight - playCardHeight,
            child: DraggablePlayCard(
              onDragEndCallBack: onDragEndCallBack,
              key: playCardKey,
              playCardObj: playCardObj,
              cardIndex: cardIndexCounter,
              onCardTap: onCardTapped,
              imageName: group[i].cardSource,
            ),
          ),
        );

        cardLeftMargin += cardGapInSameGroup;
        cardIndexCounter++;
      }

      if (selectedCards.length > 1) {
        PlayCardObj playCard = selectedCards[selectedCards.length - 1];
        list.add(
          Positioned(
            top: 2,
            height: 30,
            left: playCard.cardLeftMargin,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0)),
              padding: EdgeInsets.zero,
              color: Colors.blue,
              child: const Text('Group',
                  style: TextStyle(fontSize: 16.0, color: Colors.white)),
              onPressed: () {
                groupCard();
              },
            ),
          ),
        );
      }

      for (var groupInfo in groupsInfoArray) {
        list.add(
          Positioned(
            left: groupInfo.groupStartOffsetPos,
            top: cardLayoutHeight - 15,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: groupInfo.isGroupValid() ? Colors.green : Colors.red,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  )),
              width:
                  groupInfo.groupEndOffsetPos - groupInfo.groupStartOffsetPos,
              height: 15,
              child: Text(
                "Group ${groupInfo.cards[0].groupIndex}",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5),
                textAlign: TextAlign.center,
              ),
              // color: Colors.red,
            ),
          ),
        );
      }
    }
    calculateCardLayoutWidth();
    return Stack(
      clipBehavior: Clip.none,
      children: list,
    );
  }

  void calculateCardLayoutWidth() {
    try {
      double cardLeftMargin = 0;
      int cardGapInSameGroup = 25;
      int groupMargin = 50;
      for (var i = 0; i < groupsInfoArray.length; i++) {
        if (i != 0) {
          cardLeftMargin += groupMargin;
        }
        List<PlayCardObj> group = groupsInfoArray[i].cards;
        for (var i = 0; i < group.length; i++) {
          cardLeftMargin += cardGapInSameGroup;
        }
      }

      double cardLayoutW = cardLeftMargin - 25;
      cardLayoutW = cardLayoutW + 62;
      cardLayoutWidth = cardLayoutW;
    } catch (err) {}
  }

  void onDragEndCallBack(Offset offset, PlayCardObj draggedPlayCardObj) {
    double leftMarginOfDraggedCard = offset.dx;
    int groupIndex = -1;
    int cardAddPosInTheGroup = -1;
    OUTER:
    for (var group in groupsInfoArray) {
      List<PlayCardObj> groupInfo = group.cards;
      for (int i = 0; i < groupInfo.length; i++) {
        PlayCardObj playCard = groupInfo[i];
        double playcardLeftMargin =
            getPositionByKey(cardLayoutKey).dx + playCard.cardLeftMargin;

        // print(
        //     "leftMarginOfDraggedCard : ${leftMarginOfDraggedCard} | ${playCard.cardSource} | ${playcardLeftMargin}");

        if (i == groupInfo.length - 1 &&
            (leftMarginOfDraggedCard - playcardLeftMargin) < 35 &&
            (leftMarginOfDraggedCard - playcardLeftMargin) > 0) {
          groupIndex = playCard.groupIndex;
          if (groupIndex != draggedPlayCardObj.groupIndex) {
            cardAddPosInTheGroup = playCard.cardIndexInCurrentGroup + 1;
          } else {
            cardAddPosInTheGroup = playCard.cardIndexInCurrentGroup;
          }

          break OUTER;
        } else if (leftMarginOfDraggedCard < playcardLeftMargin) {
          groupIndex = playCard.groupIndex;
          if (groupIndex != draggedPlayCardObj.groupIndex) {
            cardAddPosInTheGroup = playCard.cardIndexInCurrentGroup;
          } else {
            if (draggedPlayCardObj.cardIndexInCurrentGroup <
                playCard.cardIndexInCurrentGroup) {
              cardAddPosInTheGroup = playCard.cardIndexInCurrentGroup - 1;
            } else {
              cardAddPosInTheGroup = playCard.cardIndexInCurrentGroup;
            }
          }

          break OUTER;
        }
      }
    }

    GroupInfo groupInfo = groupsInfoArray.last;
    PlayCardObj lastCardInLastGroup = groupInfo.cards.last;

    if (groupIndex == -1 ||
        cardAddPosInTheGroup == -1 &&
            leftMarginOfDraggedCard > lastCardInLastGroup.cardLeftMargin) {
      groupIndex = lastCardInLastGroup.groupIndex;

      if (groupIndex == draggedPlayCardObj.groupIndex) {
        cardAddPosInTheGroup = lastCardInLastGroup.cardIndexInCurrentGroup;
      } else {
        cardAddPosInTheGroup = lastCardInLastGroup.cardIndexInCurrentGroup + 1;
      }

      print(
          "groupIndex $groupIndex cardAddPosInTheGroup $cardAddPosInTheGroup");
    }

    if (groupIndex == -1 || cardAddPosInTheGroup == -1) {
      return;
    }

    if (groupsInfoArray[draggedPlayCardObj.groupIndex].cards.length == 1 &&
        groupIndex > draggedPlayCardObj.groupIndex) {
      groupIndex = groupIndex - 1;
    }

    resetCardSelections();

    PlayCardObj removedCard = groupsInfoArray[draggedPlayCardObj.groupIndex]
        .cards
        .removeAt(draggedPlayCardObj.cardIndexInCurrentGroup);

    // resetCardSelections();

    clearEmptyGroups();
    setState(() {
      groupsInfoArray[groupIndex]
          .cards
          .insert(cardAddPosInTheGroup, removedCard);
    });

    rearrangeCardIndex();
    calculateGroupsStartEndWidth();
  }

  clearEmptyGroups() {
    for (int i = groupsInfoArray.length - 1; i >= 0; i--) {
      List<PlayCardObj> group = groupsInfoArray[i].cards;
      if (group.isEmpty) {
        groupsInfoArray.remove(groupsInfoArray[i]);
      }
    }
  }

  resetCardSelections() {
    for (var groupInfo in groupsInfoArray) {
      List<PlayCardObj> group = groupInfo.cards;
      selectedCards.clear();
      for (var playCard in group) {
        playCard.isSelected = false;
        playCard.isDraggedCard = false;
      }
    }
  }

  // Size getWidgetSizeByKey(GlobalKey globalKey) {
  //   final RenderBox renderBoxRed = globalKey.currentContext.findRenderObject();
  //   final size = renderBoxRed.size;
  //   return size;
  // }

  Offset getPositionByKey(GlobalKey globalKey) {
    final RenderBox renderBoxRed =
        globalKey.currentContext!.findRenderObject() as RenderBox;
    final offset = renderBoxRed.localToGlobal(Offset.zero);
    return offset;
  }

  void rearrangeCardIndex() {
    for (int i = 0; i < groupsInfoArray.length; i++) {
      List<PlayCardObj> group = groupsInfoArray[i].cards;
      for (int j = 0; j < group.length; j++) {
        PlayCardObj playCardObj = group[j];
        playCardObj.cardIndexInCurrentGroup = j;
        playCardObj.groupIndex = i;
      }
    }
  }

  void calculateGroupsStartEndWidth() {
    // clearEmptyGroups();

    int cardLeftMargin = 0;
    int cardGapInSameGroup = 25;
    int groupMargin = 50;

    for (var i = 0; i < groupsInfoArray.length; i++) {
      List<PlayCardObj> group = groupsInfoArray[i].cards;
      if (i != 0) {
        cardLeftMargin += groupMargin;
      }
      for (var i = 0; i < group.length; i++) {
        PlayCardObj playCardObj = group[i];
        playCardObj.cardLeftMargin = cardLeftMargin.toDouble();
        cardLeftMargin += cardGapInSameGroup;
      }
    }

    for (int i = 0; i < groupsInfoArray.length; i++) {
      GroupInfo groupInfo = groupsInfoArray[i];
      List<PlayCardObj> cards = groupInfo.cards;
      if (cards.isNotEmpty) {
        groupInfo.groupStartOffsetPos = cards[0].cardLeftMargin;
        groupInfo.groupEndOffsetPos =
            cards[cards.length - 1].cardLeftMargin + 61;
      }
    }
  }

  void groupCard() {
    if (selectedCards.isNotEmpty) {
      bool allSelectedCardAreOfSameGroup = isAllSelectedCardAreOfSameGroup();
      setState(() {
        if (allSelectedCardAreOfSameGroup) {
          resetCardSelections();
        } else {
          createGroupWithSelectedCards();
          resetCardSelections();
        }
      });
    }
  }

  bool isAllSelectedCardAreOfSameGroup() {
    Set<int> cardGroupIndex = {};
    for (var item in selectedCards) {
      cardGroupIndex.add(item.groupIndex);
    }
    if (cardGroupIndex.length == 1 &&
        selectedCards.length ==
            groupsInfoArray[cardGroupIndex.first].cards.length) {
      return true;
    }

    return false;
  }

  void createGroupWithSelectedCards() {
    print("createGroupWithSelectedCards 1");
    removeCardsFromRespectiveGroups();
    print("createGroupWithSelectedCards 2");
    if (groupsInfoArray.length == MAX_GROUPS) {
      GroupInfo groupInfoLast = groupsInfoArray.last;
      GroupInfo groupInfoLastButOne =
          groupsInfoArray[groupsInfoArray.length - 2];
      List<PlayCardObj> playCardObj = [];
      playCardObj.addAll(groupInfoLast.cards);
      playCardObj.addAll(groupInfoLastButOne.cards);
      groupsInfoArray.remove(groupInfoLast);
      groupsInfoArray.remove(groupInfoLastButOne);
      GroupInfo newGroupInfo = GroupInfo(cards: playCardObj);
      groupsInfoArray.insert(3, newGroupInfo);
      createGroupAtIndex(0);
    } else {
      createGroupAtIndex(getNewGroupIndex());
    }
  }

  void removeCardsFromRespectiveGroups() {
    List<PlayCardObj> selectedCardsClone = [];
    selectedCardsClone.addAll(selectedCards);
    selectedCardsClone.sort((a, b) =>
        b.cardIndexInCurrentGroup.compareTo(a.cardIndexInCurrentGroup));
    for (var item in selectedCardsClone) {
      print("item.groupIndex ${item.groupIndex}");
      GroupInfo groupInfo = groupsInfoArray[item.groupIndex];
      List<PlayCardObj> group = groupInfo.cards;
      group.removeAt(item.cardIndexInCurrentGroup);
    }
    clearEmptyGroups();
    rearrangeCardIndex();
  }

  void createGroupAtIndex(int groupIndex) {
    print("My groupIndex $groupIndex");
    GroupInfo newGroupInfo = GroupInfo(cards: []);
    newGroupInfo.cards = [];
    newGroupInfo.cards.addAll(selectedCards);
    groupsInfoArray.insert(groupIndex, newGroupInfo);
    selectedCards.clear();
    // for (var item in groupsInfoArray) {
    //   List<PlayCardObj> group = item.cards;
    //   print("group ${group}");
    // }
    resetCardSelections();
    rearrangeCardIndex();
  }

  // bool isAnyGroupRemovingCompletely() {
  //   for (var item in selectedCards) {
  //     int groupIndex = item.groupIndex;
  //   }
  // }

  int getNewGroupIndex() {
    int index = 100;
    for (var item in selectedCards) {
      if (item.groupIndex < index) {
        index = item.groupIndex;
      }
    }
    if (index == 100) {
      index = 0;
    }
    return index;
  }

  void dealAnotherHand() {
    // groupsInfoArray.clear();
    try {
      List cards = RandomCards().get13Cards();
      print("cards $cards");
      groupsInfoArray.clear();
      print("cards 1");
      int counter = 0;
      print("cards 2");
      GroupInfo groupInfo = GroupInfo(cards: []);
      print("cards 3");
      List<PlayCardObj> playCards = [];
      print("cards 4");
      for (var item in cards) {
        // print("cards 5");
        PlayCardObj playcard = PlayCardObj(0, false, item, counter);
        // print("cards 6");
        playCards.add(playcard);
        // print("cards 7");
        counter++;
      }
      print("cards 8");
      groupInfo.cards = [];
      print("cards 9");
      groupInfo.cards.addAll(playCards);
      print("cards 10");
      setState(() {
        print("cards 11");
        groupsInfoArray.add(groupInfo);
      });
    } catch (err) {}
  }

  void createGroups() {
    GroupInfo spades = GroupInfo(cards: <PlayCardObj>[]);
    GroupInfo hearts = GroupInfo(cards: <PlayCardObj>[]);
    GroupInfo clubs = GroupInfo(cards: <PlayCardObj>[]);
    GroupInfo diamonds = GroupInfo(cards: <PlayCardObj>[]);
    GroupInfo jokers = GroupInfo(cards: <PlayCardObj>[]);

    if (groupsInfoArray.length == 1) {
      List<PlayCardObj> cards = groupsInfoArray[0].cards;
      for (int i = 0; i < cards.length; i++) {
        if (cards[i].cardSource.startsWith("s")) {
          spades.cards.add(cards[i]);
        } else if (cards[i].cardSource.startsWith("h")) {
          hearts.cards.add(cards[i]);
        } else if (cards[i].cardSource.startsWith("c")) {
          clubs.cards.add(cards[i]);
        } else if (cards[i].cardSource.startsWith("d")) {
          diamonds.cards.add(cards[i]);
        } else if (cards[i].cardSource.startsWith("j")) {
          jokers.cards.add(cards[i]);
        }
      }
      groupsInfoArray.clear();
      setState(() {
        if (spades.cards.isNotEmpty) {
          groupsInfoArray.add(spades);
        }
        if (diamonds.cards.isNotEmpty) {
          groupsInfoArray.add(diamonds);
        }
        if (clubs.cards.isNotEmpty) {
          groupsInfoArray.add(clubs);
        }
        if (hearts.cards.isNotEmpty) {
          groupsInfoArray.add(hearts);
        }
        if (jokers.cards.isNotEmpty) {
          groupsInfoArray.add(jokers);
        }
        resetCardSelections();
        clearEmptyGroups();
        rearrangeCardIndex();
      });
    }
  }
}
