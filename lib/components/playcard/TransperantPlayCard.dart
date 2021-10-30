// ignore_for_file: file_names
import 'package:flutter/material.dart';

class TransperantPlayCard extends StatelessWidget {
  final String imageSource;

  const TransperantPlayCard({required this.imageSource,GlobalKey? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
          Colors.transparent.withOpacity(0.65), BlendMode.dstIn),
      child: MaterialButton(
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
        onPressed: () {},
        child: Image(
          image: AssetImage('images/${imageSource}.png'),
          height: 80,
        ),
      ),
    );
  }
}
