import 'package:flutter/material.dart';

// 필요한 파일들 임포트
import 'package:yummylandapp/app_screens/convenience_screen.dart';
import 'package:yummylandapp/app_screens/edit_userinfo_screen.dart';
import 'package:yummylandapp/app_screens/restaurant_screen.dart';
import 'package:yummylandapp/app_screens/todaysmenu_screen.dart';

import 'app_screens/home_screen.dart'; // HomeScreen을 정의한 파일 임포트
import 'app_screens/food_worldcup_screen.dart';
import 'app_screens/food_diary_screen.dart';
import 'app_screens/calorie_calculator_screen.dart';
import 'app_screens/loading_screen.dart';
import 'app_screens/alarm_screen.dart';
import 'app_screens/user_profile_screen.dart';
import 'app_screens/foodsurvey_screen.dart'; // 음식 취향 설문조사 페이지 임포트

// Firebase Core 패키지 추가
import 'package:firebase_core/firebase_core.dart';

//firebase를 위한 코드 추가
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 비동기 작업을 위해 Flutter 엔진 초기화
  await Firebase.initializeApp(); // Firebase 초기화
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yummy Land',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: '/loading', // Start with the loading screen
      routes: {
        '/home': (context) => HomeScreen(), // Home screen
        '/foodWorldCup': (context) => FoodWorldCupScreen(), // Food World Cup screen
        '/foodDiary': (context) => MyDiaryScreen(), // Food Diary screen
        '/calorieCalculator': (context) => CalorieCalculatorScreen(), // Calorie Calculator screen
        '/loading': (context) => LoadingScreen(), // Loading screen
        '/alarm': (context) => AlarmScreen(), // Alarm screen
        '/userProfile': (context) => UserProfileSurveyScreen(), // User profile screen
        '/foodsurveyScreen': (context) => FoodSurveyScreen(), // foodsurvey_screen으로 이동
        '/editUserInfo': (context) => BasicSurveyScreen(), // edit_userinfo_screen으로 이동

      },
    );
  }
}
