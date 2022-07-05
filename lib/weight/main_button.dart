import'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/design.dart';
import '../utils/font_family.dart';

class MainButton extends StatelessWidget {
  final String text;
  final Function() clickEvent;
  final bool enable;

  const MainButton({
    Key? key,
    required this.text,
    required this.clickEvent,
    this.enable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>{
        if(enable) clickEvent()
      },
      child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: mainColor, width: 2),
            borderRadius: BorderRadius.circular(12),
            color: enable ? mainColor : unableColor,
          ),
          width: MediaQuery.of(context).size.width - 24 * 2,
          padding: const EdgeInsets.symmetric(
              vertical: 12, horizontal: 32),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 24,
                fontFamily: FontFamily.pretendard,
              ),
            ),
          )),
    );
  }
}
