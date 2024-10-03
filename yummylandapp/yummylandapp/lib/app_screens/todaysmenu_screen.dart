import 'package:flutter/material.dart';
import 'package:yummylandapp/app_screens/calorie_calculator_screen.dart';
import 'package:yummylandapp/app_screens/food_diary_screen.dart';
import 'package:yummylandapp/app_screens/home_screen.dart';
import 'package:yummylandapp/app_screens/user_profile_screen.dart'; // 프로필 화면 임포트

void main() {
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
      home: TodaysMenuCategoryScreen(),
    );
  }
}

class TodaysMenuCategoryScreen extends StatefulWidget {
  @override
  _TodaysMenuCategoryScreenState createState() =>
      _TodaysMenuCategoryScreenState();
}

class _TodaysMenuCategoryScreenState extends State<TodaysMenuCategoryScreen> {
  int _selectedIndex = 0;

  // 네비게이션 바에서 선택된 페이지에 따라 다른 화면으로 이동
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), // home_screen.dart로 이동
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyDiaryScreen()), // diary_screen.dart로 이동
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CalorieCalculatorScreen()), // calorie_calculator_screen.dart로 이동
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserProfileSurveyScreen()), // user_profile_screen.dart로 이동
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색을 하얀색으로 설정
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent, // 배경색 투명
        elevation: 0, // 그림자 제거
        title: Row(
          children: [
            Image.asset(
              'assets/images/yummy_icon.png', // 로고 이미지 경로
              width: 40.0,
              height: 40.0,
            ),
            SizedBox(width: 10.0),
            Text(
              'Yummy Land',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // 검정색 텍스트
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            iconSize: 36.0, // 알림 아이콘 크기 설정
            onPressed: () {
              // 알림 페이지로 이동
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // 시작 부분으로 정렬
          children: [
            SizedBox(height: 70.0), // 텍스트를 약간 아래로 위치하게 여백 조정
            Text(
              '" 오늘 뭐 먹지? "',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              '메뉴 카테고리를 골라보세요!',
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            SizedBox(height: 30.0), // 여백 추가
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // 버튼들이 화면 중간에 오도록 조정
                children: [
                  Expanded(
                    child: _buildCategoryButton(context, '한식🍚🫕', '김치찌개, 7,300원'),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: _buildCategoryButton(context, '양식🍝🍕', '스테이크, 15,000원'),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: _buildCategoryButton(context, '중식🍜', '짜장면, 6,000원'),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: _buildCategoryButton(context, '일식🍣🍛', '초밥, 5,500원'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Diary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, String category, String menuName) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TodaysMenuScreen(category: category, menuName: menuName),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(color: Colors.red, width: 2.0), // 빨간색 테두리
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        minimumSize: Size(double.infinity, 70), // 버튼 높이를 키워서 전체 너비로 설정
      ),
      child: Text(
        category,
        style: TextStyle(
          fontSize: 24.0, // 버튼 텍스트 크기 증가
          color: Colors.black, // 검정색 글자
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class TodaysMenuScreen extends StatelessWidget {
  final String category;
  final String menuName;

  TodaysMenuScreen({required this.category, required this.menuName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경을 흰색으로 설정
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent, // AppBar 배경 투명
        elevation: 0, // 그림자 제거
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.grey,
            ),
            SizedBox(width: 10.0),
            Text(
              'Yummy Land',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // 검정색 텍스트
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            iconSize: 36.0, // 알림 아이콘 크기 설정
            onPressed: () {
              // 알림 페이지로 이동
            },
          ),
        ],
      ),
      body: Center( // 내용이 중앙에 오도록 Center 위젯 사용
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 텍스트가 가운데 위치하도록 설정
          children: [
            Text(
              '오늘은 $category!',
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              menuName,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Diary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.pink,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()), // home_screen.dart로 이동
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyDiaryScreen()), // diary_screen.dart로 이동
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalorieCalculatorScreen()), // calorie_calculator_screen.dart로 이동
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserProfileSurveyScreen()), // user_profile_screen.dart로 이동
            );
          }
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
