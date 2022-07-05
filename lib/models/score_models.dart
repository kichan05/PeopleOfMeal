class SchoolScore {
  int? schoolCode;
  int? allDayAvg;
  List<Score>? scoreList;

  SchoolScore({this.schoolCode, this.allDayAvg, this.scoreList});

  SchoolScore.fromJson(Map<String, dynamic> json) {
    schoolCode = json['schoolCode'];
    allDayAvg = json['allDayAvg'];
    if (json['scoreList'] != null) {
      scoreList = <Score>[];
      json['scoreList'].forEach((v) {
        scoreList!.add(new Score.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['schoolCode'] = this.schoolCode;
    data['allDayAvg'] = this.allDayAvg;
    if (this.scoreList != null) {
      data['scoreList'] = this.scoreList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Score {
  int? id;
  String? schoolCode;
  int? score;
  String? date;

  Score({this.id, this.schoolCode, this.score, this.date});

  Score.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schoolCode = json['schoolCode'];
    score = json['score'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['schoolCode'] = this.schoolCode;
    data['score'] = this.score;
    data['date'] = this.date;
    return data;
  }
}