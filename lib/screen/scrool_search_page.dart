import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:people_of_meal/screen/time_input_page.dart';
import 'package:provider/provider.dart';

import '../models/school_models.dart';
import '../provider/school_data_provider.dart';
import '../services/nice_api_service.dart';
import '../utils/font_family.dart';

class SchoolSearchPage extends StatefulWidget {
  SchoolSearchPage({Key? key}) : super(key: key);

  @override
  State<SchoolSearchPage> createState() => _SchoolSearchPageState();
}

class _SchoolSearchPageState extends State<SchoolSearchPage> {
  final NiceApiService _niceApiService = NiceApiService();
  List<School> schoolList = [];

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "현재 재학중인 학교를",
                style: TextStyle(
                    fontFamily: FontFamily.pretendard,
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
              Text(
                "검색해주세요",
                style: TextStyle(
                    fontFamily: FontFamily.pretendard,
                    fontWeight: FontWeight.w600,
                    fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 47),
          TextField(
            controller: searchController,
            onChanged: (text) async {
              var a = await _niceApiService.searchSchool(key: text);
              setState(() {
                schoolList = a;
              });
            },
            decoration: const InputDecoration(
              hintText: "학교를 검색 해주세요.",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 47),
          Expanded(
            child: ListView(
              children: schoolList.map((e) => _schoolListItem(e)).toList(),
            )
          )
        ],
      ),
    ));
  }

  GestureDetector _schoolListItem(School e) {
    return GestureDetector(
      onTap: () => {_searchSchool(e)},
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 24),
        decoration: BoxDecoration(
            border: Border.all(color: Color(0xffC6C6C6), width: 2),
            borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                e.schoolName!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.pretendard
                )
              ),
              Text(
                e.educationName!,
                style: TextStyle(
                    color: Color(0xff9b9b9b),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.pretendard),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _searchSchool(School school){
    SchoolDataProvider s = context.read<SchoolDataProvider>();
    s.updateSchoolData(schoolData: school);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TimeInputPage())
    );
  }
}
