import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:people_of_meal/main.dart';
import 'package:people_of_meal/provider/school_data_provider.dart';
import 'package:people_of_meal/screen/login_page.dart';
import 'package:people_of_meal/screen/main_page.dart';
import 'package:people_of_meal/screen/scrool_search_page.dart';
import 'package:provider/provider.dart';

class RoutePage extends StatelessWidget {
  const RoutePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("sad");
    // return Consumer<SchoolDataProvider>(
    //     builder:(context, schoolProvider){
    //       if(schoolProvider.schoolCode != null){
    //         Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
    //       }
    //       else{
    //         Navigator.push(context, MaterialPageRoute(builder: (context) => SchoolSearchPage()));
    //       }
    //     }
    // )
  }
}

class MainPage2 extends StatelessWidget {
  const MainPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("메인");
  }
}
