class School {
  String? educationCode; //시도교육청코드
  String? educationName; //시도교육청명
  String? schoolCode; //표준학교코드
  String? schoolName; //학교명
  String? schoolType; //학교종류명
  String? location; //소재지명
  String? hMPGADRES; //홈페이지주소

  School(
      {this.educationCode,
        this.educationName,
        this.schoolCode,
        this.schoolName,
        this.schoolType,
        this.location,
        this.hMPGADRES,
      });

  School.fromJson(Map<String, dynamic> json) {
    educationCode = json['ATPT_OFCDC_SC_CODE'];
    educationName = json['ATPT_OFCDC_SC_NM'];
    schoolCode = json['SD_SCHUL_CODE'];
    schoolName = json['SCHUL_NM'];
    schoolType = json['SCHUL_KND_SC_NM'];
    location = json['LCTN_SC_NM'];
    hMPGADRES = json['HMPG_ADRES'];
  }

  String str(){
    return schoolName!;
  }
}