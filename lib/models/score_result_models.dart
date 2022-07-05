class ScoreResult {
  int? schoolCode;
  String? score;
  String? resultCode;

  ScoreResult({this.schoolCode, this.score, this.resultCode});

  ScoreResult.fromJson(Map<String, dynamic> json) {
    schoolCode = json['schoolCode'];
    score = json['score'];
    resultCode = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schoolCode'] = this.schoolCode;
    data['score'] = this.score;
    data['result'] = this.resultCode;
    return data;
  }
}
