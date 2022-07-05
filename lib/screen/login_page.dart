import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:people_of_meal/provider/school_data_provider.dart';
import 'package:people_of_meal/screen/main_page.dart';
import 'package:people_of_meal/screen/scrool_search_page.dart';
import 'package:people_of_meal/utils/design.dart';
import 'package:provider/provider.dart';

import '../weight/main_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
        child: Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Text("급식의 민족",
                      style: TextStyle(
                          color: mainColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w700)),
                  const Text("에", style: TextStyle(fontSize: 24)),
                ],
              ),
              const Text("오신분들을을 환영합니다.", style: TextStyle(fontSize: 24)),
              const SizedBox(height: 30),
              const Text(
                "급식의 민족은 전국의 모든 학교의 급식에 대한 평점을 줄수 있는 학교 급식 평점앱입니다.",
                style: TextStyle(
                    color: Color(0xffa1a1a1)
                ),
              ),
              const SizedBox(height: 100),
              MainButton(
                  text: "급식의 민족 시작하기",
                  clickEvent: () {
                    SchoolDataProvider s = context.read<SchoolDataProvider>();
                    print("코드 : ${s.schoolCode}");
                    if (s.schoolCode != null) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MainPage()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SchoolSearchPage()));
                    }
                  }),
            ]),
      ),
    ));
  }
}
