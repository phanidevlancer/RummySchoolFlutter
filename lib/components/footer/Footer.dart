// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../utils//CustomDialog.dart';


class Footer extends StatelessWidget {
  final Function() sortBtnClickListener;

  const Footer({Key? key,required this.sortBtnClickListener}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87.withAlpha(180),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(
              child: const Text("1"),
              alignment: Alignment.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Stack(children: <Widget>[
                Image.asset('images/male_active_glow_themered.png'),
                const Positioned(
                  child: Text(
                    "Phanindra",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                  ),
                  top: 15,
                  left: 35,
                ),
                const Positioned(
                  child: Text(
                    "124.45",
                    style: TextStyle(

                      color: Colors.white,
                      fontSize: 8,
                    ),
                  ),
                  top: 25,
                  left: 35,
                ),
              ]),
              alignment: Alignment.center,
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Row(
                children: <Widget>[
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0)),
                    padding: EdgeInsets.zero,
                    height: 30,
                    minWidth: 70,
                    color: Colors.blue,
                    child: const Text('Sort',
                        style:
                         TextStyle(fontSize: 16.0, color: Colors.white)),
                    onPressed: sortBtnClickListener,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  MaterialButton(
                    height: 30,
                    minWidth: 70,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0)),
                    padding: EdgeInsets.zero,
                    color: Colors.blue,
                    child: const Text('Submit',
                        style:
                         TextStyle(fontSize: 16.0, color: Colors.white)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => const CustomDialog(
                            title: "Success",
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

