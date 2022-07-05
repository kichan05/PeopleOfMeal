class Meal {
  String? educationCode; //시도교육청코드, ATPT_OFCDC_SC_CODE
  String? educationName; //시도교육청명, ATPT_OFCDC_SC_NM
  String? schoolCode; //표준학교코드, SD_SCHUL_CODE
  String? schoolName; //학교명, SCHUL_NM
  List<String>? mealList; //요리명, DDISH_NM
  String? countryOfOrigin; //원산지정보, ORPLC_INFO
  String? calorie; //칼로리정보, CAL_INFO
  String? nutrition; //영양정보, NTR_INFO
  String? date; //급식시작일자, MLSV_FROM_YMD

  Meal(
      {this.educationCode,
        this.educationName,
        this.schoolCode,
        this.schoolName,
        this.mealList,
        this.countryOfOrigin,
        this.calorie,
        this.nutrition,
        this.date,
      });

  Meal.fromJson(Map<String, dynamic> json) {
    educationCode = json['ATPT_OFCDC_SC_CODE'];
    educationName = json['ATPT_OFCDC_SC_NM'];
    schoolCode = json['SD_SCHUL_CODE'];
    schoolName = json['SCHUL_NM'];
    mealList = (json['DDISH_NM'] as String).split("<br/>");
    countryOfOrigin = json['ORPLC_INFO'];
    calorie = json['CAL_INFO'];
    nutrition = json['NTR_INFO'];
    date = json['MLSV_FROM_YMD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ATPT_OFCDC_SC_CODE'] = this.educationCode;
    data['ATPT_OFCDC_SC_NM'] = this.educationName;
    data['SD_SCHUL_CODE'] = this.schoolCode;
    data['SCHUL_NM'] = this.schoolName;
    data['DDISH_NM'] = this.mealList;
    data['ORPLC_INFO'] = this.countryOfOrigin;
    data['CAL_INFO'] = this.calorie;
    data['NTR_INFO'] = this.nutrition;
    data['MLSV_FROM_YMD'] = this.date;
    return data;
  }

  String get dateFormat => "${date!.substring(4, 6)}월 ${date!.substring(6, 8)}일";
}