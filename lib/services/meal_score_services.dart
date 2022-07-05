import 'dart:convert';

import 'package:people_of_meal/models/school_models.dart';
import 'package:people_of_meal/models/score_models.dart';
import 'package:http/http.dart' as http;
import 'package:people_of_meal/models/score_result_models.dart';

class MealScoreServices{
  static final MealScoreServices _instance = MealScoreServices._internal();

  factory MealScoreServices() {
    return _instance;
  }

  MealScoreServices._internal();

  String BASE_URL = "https://peopleofmeal-vyvzr.run.goorm.io";

  Future<void> sendScore(School schoolData, double score) async {
    var url = "${BASE_URL}/score/${schoolData.schoolCode}?score=${score.toInt()}";
    print(url);
    var URL = Uri.parse(url);
    var response = await http.get(URL);

    if(response.statusCode == 200){
      print("서버 통신 성공");
    }
    else{
      print("점수 입력 에러 : ${response.statusCode}");
      throw Exception();
    }
  }

  Future<SchoolScore> getScore(School schoolData) async{
    var url = "${BASE_URL}/score/schoolInfo/${schoolData.educationCode}/${schoolData.schoolCode}";
    var URL = Uri.parse(url);
    var response = await http.get(URL);

    if(response.statusCode == 200){
      var dataJson = jsonDecode(response.body);
      return SchoolScore.fromJson(dataJson);
    }
    else{
      print(response.statusCode);
      throw Exception();
    }
  }
}