import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:people_of_meal/services/nice_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/school_models.dart';

class SchoolDataProvider with ChangeNotifier {
  SchoolDataProvider() {
   _initializer();
  }

  static const String _schoolCodeKey = "schoolCodeKey";
  static const String _lastScoreDateKey = "lastScoreDateKey";

  Future<void> _initializer() async {
    // 디스크 읽기를 위한 객체 생성
    final prefs = await SharedPreferences.getInstance();

    // 디스크 읽기
    _schoolCode = await prefs.getString(_schoolCodeKey);
    _lastScoreDate = await prefs.getString(_lastScoreDateKey);

    if(_schoolCode != null){
      _schoolData = await NiceApiService().getSchoolByCode(_schoolCode!);
    }
  }

  String? _schoolCode;
  School? _schoolData;
  TimeOfDay? _startTime;
  String? _lastScoreDate;

  String? get schoolCode => _schoolCode;

  School? get schoolData => _schoolData;
  Future<void> updateSchoolData({String? schoolCode, School? schoolData}) async {
    _schoolCode = schoolCode;
    _schoolData = schoolData;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_schoolCodeKey, _schoolCode!);

    notifyListeners();
  }


  TimeOfDay? get startTime => _startTime;
  void updateStartTime({TimeOfDay? startTime}){
    _startTime = startTime;
    notifyListeners();
  }

  String? get lastScoreDate => _lastScoreDate;
  Future<void> updateLastScoreDate(DateTime now) async {
    var date = "${now.year}/${now.month}/${now.day}";
    _lastScoreDate = date;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastScoreDateKey, date);

    notifyListeners();
  }

  bool get isLastDayIsToDay => _lastScoreDate == "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}";
}