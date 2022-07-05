import 'dart:convert';
import 'dart:ui';

import 'package:http/http.dart' as http;

import '../models/mear_models.dart';
import '../models/school_models.dart';

class NiceApiService {
  static final NiceApiService _instance = NiceApiService._internal();

  factory NiceApiService() {
    return _instance;
  }

  NiceApiService._internal();

  final String _niceKey = "e1e65ed66ff54f03a10be7c0e716018a";

  Future<List<School>> searchSchool({required String key}) async {
    List<School> result = [];

    if (key.isNotEmpty) {
      var URL = Uri.parse(
          "https://open.neis.go.kr/hub/schoolInfo?KEY=${_niceKey}&Type=json&SCHUL_NM=${key}");
      var responce = await http.get(URL);

      if (responce.statusCode == 200) {
        var dataJson = jsonDecode(responce.body);
        var jsonList = dataJson["schoolInfo"][1]["row"];

        jsonList.forEach((e) {
          result.add(School.fromJson(e));
        });
      } else {
        throw Exception();
      }
    }

    return result;
  }

  Future<School> getSchoolByCode(String schoolCode) async {
    var url = "https://open.neis.go.kr/hub/schoolInfo?KEY=${_niceKey}&Type=json&SD_SCHUL_CODE=${schoolCode}";
    var URL = Uri.parse(url);

    var response = await http.get(URL);
    if(response.statusCode == 200){
      var dataJson = jsonDecode(response.body);
      return School.fromJson(dataJson);
    }
    else{
      print("getSchoolByCode ER : ${response.statusCode}");
      throw Exception();
    }
  }

  //String url_ = "https://schoolmenukr.ml/api/high/X123456789?date=23";

  Future<List<Meal>> getMeal(
      {required School schoolData,
        required DateTime startDate,
        required DateTime endDate}) async {

    String url = "https://open.neis.go.kr/hub/mealServiceDietInfo?"
        + "KEY=${_niceKey}&Type=json"
        + "&ATPT_OFCDC_SC_CODE=${schoolData.educationCode}"
        + "&SD_SCHUL_CODE=${schoolData.schoolCode}"
        + "&MLSV_FROM_YMD=${startDate.year}${startDate.month < 10 ? '0' : ''}${startDate.month}${startDate.day < 10 ? '0' : ''}${startDate.day}"
        + "&MLSV_TO_YMD=${endDate.year}${endDate.month < 10 ? '0' : ''}${endDate.month}${endDate.day < 10 ? '0' : ''}${endDate.day}";
    // print(url);

    var URL = Uri.parse(url);

    var responce = await http.get(URL);

    if (responce.statusCode == 200) {
      List<Meal> result = [];
      var json = jsonDecode(responce.body)["mealServiceDietInfo"][1]["row"];
      for (var i in json){
        // print("$i");
        result.add(Meal.fromJson(i));
      }

      // print(result);
      return result;
    } else {
      throw Exception();
    }
  }
}
