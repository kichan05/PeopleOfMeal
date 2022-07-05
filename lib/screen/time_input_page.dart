import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/school_data_provider.dart';
import '../utils/design.dart';
import '../utils/font_family.dart';
import '../weight/main_button.dart';
import 'route_page.dart';
import 'main_page.dart';

class TimeInputPage extends StatefulWidget {
  const TimeInputPage({Key? key}) : super(key: key);

  @override
  State<TimeInputPage> createState() => _TimeInputPageState();
}

class _TimeInputPageState extends State<TimeInputPage> {
  TimeOfDay? selectedTime = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child:
          Consumer<SchoolDataProvider>(builder: (context, schoolData, child) {
        return Column(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${schoolData.schoolData!.schoolName}의",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              fontFamily: FontFamily.pretendard)),
                      Text("점심시간 시작 시간을 선택해주세요.",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontFamily.pretendard)),
                    ],
                  ),
                  SizedBox(height: 76),
                  _clock(selectedTime),
                  SizedBox(height: 76),
                  MainButton(text: "시간 선택하기", clickEvent: _openTimePicker)
                ],
              ),
            ),
            _buildNextButton(selectedTime != null, clickNextButton)
          ],
        );
      }),
    );
  }

  Widget _clock(TimeOfDay? timeData) {
    if (timeData == null) {
      return Text("아래 버튼을 눌러서 시간을 선택해주세요.",
          style: TextStyle(
              fontFamily: FontFamily.pretendard,
              fontSize: 18,
              color: Color(0xff6c6c6c),
              fontWeight: FontWeight.w300
          )
      );
    }

    return Text("${timeData.hour}시 ${timeData.minute}분",
        style: TextStyle(
          fontSize: 64,
          fontWeight: FontWeight.w800,
          fontFamily: FontFamily.pretendard,
        ));
  }

  void _openTimePicker() {
    Future<TimeOfDay?> timePicker =
        showTimePicker(context: context, initialTime: TimeOfDay.now());

    timePicker.then((value) {
      setState(() {
        selectedTime = value as TimeOfDay?;
      });
    });
  }

  void clickNextButton(){
    SchoolDataProvider s = context.read<SchoolDataProvider>();
    s.updateStartTime(startTime: selectedTime);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainPage())
    );
  }

  Widget _buildNextButton(bool enable, Function clickEvent) {
    return GestureDetector(
      onTap: () {
        if(enable) clickEvent();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: enable ? mainColor : unableColor,
        child: Center(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                "다음",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
              )
          ),
            )
        ),
      ),
    );
  }
}
