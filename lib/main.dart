// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/Header.dart';
import 'components/cardlayout/CardLayout.dart';
import 'components/cardlayout/OpenJokerDeckContainer.dart';
import 'components/footer/Footer.dart';
import 'components/utils/HexColor.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]).then((_){
    runApp(MyApp());
  });
}


class MyApp extends StatelessWidget{
  final GlobalKey<CardLayoutState> cardLayoutGlobalKey = GlobalKey();


  MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/tablethemered.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 13,
                  child: Header(
                    onDealAnotherHandClikc: onDealAnotherHandClick,
                  ),
                ),
                Expanded(
                    flex: 75,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.only(bottom: 4),
                              decoration: const BoxDecoration(
                                color: Colors
                                    .yellow, //new Color.fromRGBO(255, 0, 0, 0.0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4.0),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        margin:  const EdgeInsets.all(4),
                                        decoration:  BoxDecoration(
                                          color: HexColor("#3D0508"), //new Color.fromRGBO(255, 0, 0, 0.0),
                                          borderRadius:  const BorderRadius.all(
                                            Radius.circular(3.0),
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        child: Column(
                                          children: const <Widget>[
                                             Text(
                                              "Show\nTime",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        child: Text(
                                          "Please arrange your groups and submit.",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          const Align(
                            child: OpenJokerDeckContainer(),
                            alignment: Alignment.bottomCenter,
                          ),
                          Align(
                            child: CardLayout(
                              key: cardLayoutGlobalKey,
                            ),
                            alignment: Alignment.bottomCenter,
                          ),
                        ],
                      ),
                    )),
                Expanded(
                  flex: 12,
                  child: Container(
                    child: Footer(
                      sortBtnClickListener: onSortButtonClick,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void onDealAnotherHandClick() {
    print("onDealAnotherHandClikc");
    cardLayoutGlobalKey.currentState?.dealAnotherHand();
  }

  void onSortButtonClick() {
    print("onSortButtonClick");
    cardLayoutGlobalKey.currentState?.createGroups();
  }



}