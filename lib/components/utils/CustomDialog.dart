// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'HexColor.dart';


class CustomDialog extends StatelessWidget {

  final String title;

  const CustomDialog({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: HexColor("#202123"),
      child: Container(
        height: 200,
        width: 500,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: HexColor("#41484F"),
                  borderRadius:  const BorderRadius.only(
                    topLeft:  Radius.circular(10.0),
                    topRight:  Radius.circular(10.0),
                  )),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'images/logo.png',
                    height: 30,
                    width: 0,
                  ),
                  const Text(
                    "Alert",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Are you sure you want to submit?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                  padding: EdgeInsets.zero,
                  height: 30,
                  minWidth: 90,
                  color: HexColor("#51A1C5"),
                  child: const Text('Stay',
                      style:
                      TextStyle(fontSize: 16.0, color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(
                  width: 60,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0)),
                  padding: EdgeInsets.zero,
                  height: 30,
                  minWidth: 90,
                  color: HexColor("#616161"),
                  child: const Text('Leave',
                      style:
                       TextStyle(fontSize: 16.0, color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
