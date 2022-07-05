import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:people_of_meal/models/school_models.dart';
import 'package:people_of_meal/models/score_models.dart';
import 'package:people_of_meal/services/meal_score_services.dart';
import 'package:people_of_meal/utils/design.dart';
import 'package:provider/provider.dart';

import '../models/mear_models.dart';
import '../provider/school_data_provider.dart';
import '../services/nice_api_service.dart';
import '../utils/font_family.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final NiceApiService _niceApiService = NiceApiService();
  final MealScoreServices _mealScoreServices = MealScoreServices();

  double inputScore = 5;

  var manuDecoration = BoxDecoration(
    color: Color(0xffEAEAEA),
    borderRadius: BorderRadius.circular(12),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(child:
        Consumer<SchoolDataProvider>(builder: (context, schoolProvider, child) {
      return FutureBuilder(
        future: _niceApiService.getMeal(
            schoolData: schoolProvider.schoolData!,
            startDate: DateTime.now(),
            endDate: DateTime.now().add(const Duration(days: 10))
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildMainUi(schoolProvider, snapshot.data as List<Meal>);
          } else {
            return _buildErrorUi();
          }
        },
      );
    }));
  }

  SingleChildScrollView _buildMainUi(
      SchoolDataProvider schoolProvider, List<Meal> allDayMealList) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(schoolProvider.schoolData!.schoolName!,
                style: const TextStyle(
                    fontSize: 24,
                    fontFamily: FontFamily.pretendard,
                    fontWeight: FontWeight.w600)), //학교 이름
            const SizedBox(height: 20),

            !schoolProvider.isLastDayIsToDay
                ? _buildScoreInput()
                : const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                    child: Center(
                        child: Text(
                      "오늘 급식은 별점을 이미 주었습니다.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontFamily.pretendard
                      ),
                    )),
                  ),

            const SizedBox(height: 20),
            Row(
              children: [
                _buildTodayMealMenu(allDayMealList),
                const SizedBox(width: 16),
                _buildSchoolScore(schoolProvider.schoolData!),
              ],
            ),

            const SizedBox(height: 20),

            menuTitle("요주의 급식"),
            _buildAllDayMealList(allDayMealList),
          ],
        ),
      ),
    );
  }

  Column _buildScoreInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            menuTitle("오늘의 평점 주기"),
            TextButton(
                onPressed: sendScore,
                child: Text(
                  "입력 완료",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ))
          ],
        ),
        const SizedBox(height: 12),
        Center(
            child: Column(
          children: [
            RatingBar.builder(
              initialRating: inputScore,
              minRating: 0.5,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: mainColor,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  inputScore = rating;
                });
              },
            ),
            Text(
              "${inputScore}점",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            )
          ],
        ))
      ],
    );
  }

  Text menuTitle(String title) {
    return Text(title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700));
  }

  Expanded _buildTodayMealMenu(List<Meal> mealList) {
    return Expanded(
        child: Column(
      children: [
        menuTitle("오늘의 급식"),
        const SizedBox(height: 6),
        Container(
          width: 150,
          decoration: manuDecoration,
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: mealList[0]
                  .mealList!
                  .map((e) => Column(
                        children: [
                          Text(e.split(" (")[0],
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              )),
                          const SizedBox(height: 8)
                        ],
                      ))
                  .toList(),
            ),
          ),
        )
      ],
    ));
  }

  Column _buildTimerMenu() {
    return Column(
      children: [
        menuTitle("남은 시간"),
        Container(
          decoration: manuDecoration,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              "1시간 30분 ${60 - 10}초",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                fontFamily: FontFamily.pretendard,
              ),
            ),
          ),
        )
      ],
    );
  }

  FutureBuilder _buildSchoolScore(School schoolData) {
    return FutureBuilder(
        future: _mealScoreServices.getScore(schoolData),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            SchoolScore scoreData = snapshot.data;
            print(scoreData);
            return Column(
              children: [
                menuTitle("우리 학교 평점"),
                const SizedBox(height: 6),
                Container(
                  decoration: manuDecoration,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        _scoreListItem(
                            title: "전체 평점",
                            score: scoreData.allDayAvg!.toDouble()),
                      ],
                    ),
                  ),
                )
              ],
            );
          } else {
            return Text("ㅠㅠ 에러");
          }
        });
  }

  Container _mealListItem(Meal mealList) {
    return Container(
      width: 150,
      decoration: manuDecoration,
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(mealList.dateFormat,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                )),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: mealList.mealList!
                  .map((e) => Column(
                        children: [
                          Text(e.split(" (")[0],
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              )),
                          const SizedBox(height: 8)
                        ],
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildErrorUi() => Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text("급식 데이터를 불러오고 있습니다.",
                  style: TextStyle(fontSize: 16, color: Colors.grey))
            ]),
      );

  Widget _buildAllDayMealList(List<Meal> allDayMealList) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: allDayMealList
            .map((e) =>
                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  _mealListItem(e),
                  const SizedBox(width: 24),
                ]))
            .toList(),
      ),
    );
  }

  Row _scoreListItem({required String title, required double score}) {
    return Row(
      children: [
        Text(title + " : ",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        Text("${score}점",
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: mainColor))
      ],
    );
  }

  void sendScore() async {
    SchoolDataProvider s = context.read<SchoolDataProvider>();

    await _mealScoreServices.sendScore(s.schoolData!, inputScore);

    s.updateLastScoreDate(new DateTime.now());

    Fluttertoast.showToast(
        msg: "평점 추가",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0x4F525252),
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
