import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yummylandapp/app_screens/todaysmenu_screen.dart';
import 'package:yummylandapp/app_screens/user_profile_screen.dart'; // 프로필 화면 임포트
import 'package:yummylandapp/app_screens/calorie_calculator_screen.dart'; // 칼로리 계산기 화면 임포트
import 'package:yummylandapp/app_screens/food_worldcup_screen.dart'; // 음식 월드컵 화면 임포트
import 'package:yummylandapp/app_screens/convenience_screen.dart'; // 편의점 화면 임포트
import 'package:yummylandapp/app_screens/restaurant_screen.dart'; // 맛집 화면 임포트

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentMealIndex = 1; // 기본 오늘로 설정
  int _selectedIndex = 0; // 선택된 페이지 인덱스
  String userName = '윤다해'; // 사용자의 이름
  String userSchool = '한양여자대학교'; // 사용자의 학교명

  // _selectedOption 필드 추가
  String _selectedOption = ''; // 선택된 메뉴 추천 옵션 (초기화)
  String _selectedHotOption = ''; // 선택된 핫한 음식점 옵션 (초기화)

  final PageController _pageController = PageController(initialPage: 1); // PageController 추가

  // 학식 정보 - 어제, 오늘, 내일 학식 정보 및 이미지 경로 추가
  final List<Map<String, String>> _mealPlans = [
    {
      'date': '어제',
      'meal': '2024-09-19: 카레라이스, 샐러드',
      'image': 'assets/images/curry.jpg', // 학식 이미지 경로 추가
    },
    {
      'date': '오늘',
      'meal': '2024-09-20: 돈까스, 밥',
      'image': 'assets/images/pork_cutlet.jpg', // 학식 이미지 경로 추가
    },
    {
      'date': '내일',
      'meal': '2024-09-21: 김치찌개, 밥',
      'image': 'assets/images/kimchi_stew.jpg', // 학식 이미지 경로 추가
    },
  ];

  final List<String> _menuOptions = ['오늘 뭐 먹지?', '음식 월드컵'];
  final List<String> _hotOptions = ['편의점', '맛집'];

  // 네비게이션 바에서 선택된 페이지에 따라 다른 화면을 표시
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushNamed(context, '/home'); // 홈 페이지로 이동
    } else if (index == 1) {
      Navigator.pushNamed(context, '/foodDiary'); // 다이어리 페이지로 이동
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CalorieCalculatorScreen()), // CalorieCalculatorScreen으로 이동
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserProfileSurveyScreen()), // ProfileScreen으로 이동
      );
    }
  }

  // 오늘 뭐 먹지, 음식 월드컵, 편의점, 맛집 버튼 클릭 시 화면 이동
  void _onMenuOptionSelected(String option) {
    if (option == '오늘 뭐 먹지?') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TodaysMenuCategoryScreen()), // todaymenu_screen.dart로 이동
      );
    } else if (option == '음식 월드컵') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FoodWorldCupScreen()), // food_worldcup_screen.dart로 이동
      );
    }
  }

  void _onHotOptionSelected(String option) {
    if (option == '편의점') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ConvenienceStoreScreen()), // convenience_screen.dart로 이동
      );
    } else if (option == '맛집') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BestRestaurantScreen()), // restaurant_screen.dart로 이동
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 앱 전체 배경색을 하얀색으로 설정
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
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
                color: Colors.black, // 검은색 텍스트
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white, // 앱바 배경색 하얀색으로 설정
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            iconSize: 36.0, // 알림 아이콘 크기 설정
            onPressed: () {
              Navigator.pushNamed(context, '/alarm'); // 알람 화면으로 이동
            },
          ),
        ],
      ),
      body: SingleChildScrollView( // 스크롤
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 사용자 환영 메시지
            Text(
              '$userName님, 안녕하세요!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              '메뉴를 추천받고 메뉴를 기록 해보세요!',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 20.0),

            // PageView를 사용하여 학식 정보 표시
            Container(
              height: 300.0, // 학식 정보 카드 크기 증가
              child: PageView.builder(
                controller: _pageController, // PageController 추가
                itemCount: _mealPlans.length, // 어제, 오늘, 내일
                onPageChanged: (int index) {
                  setState(() {
                    _currentMealIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final currentMeal = _mealPlans[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: [
                            Colors.white, // 하얀색 시작
                            Colors.red.withOpacity(0.1), // 빨간색 그라데이션 추가
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$userSchool 학식 정보 (${currentMeal['date']})',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Image.asset(
                            currentMeal['image']!, // 학식 이미지 표시
                            height: 120.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            currentMeal['meal'] ?? '메뉴 정보가 없습니다.', // null이면 기본 메시지 표시
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            '이 정보는 $userSchool의 학식에 관한 내용입니다.',
                            style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 16.0),

            // 페이지 인디케이터 추가
            Center(
              child: SmoothPageIndicator(
                controller: _pageController,  // PageController 연결
                count: _mealPlans.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: Colors.red[800]!, // 활성화된 점의 색상을 빨간색으로 변경
                  dotColor: Colors.grey,
                  dotHeight: 8.0,
                  dotWidth: 8.0,
                  expansionFactor: 3, // 활성화된 dot 크기 확대
                ),
              ),
            ),

            SizedBox(height: 30.0), // 카드와 버튼 사이 간격

            // "오늘의 밥 메뉴를 추천받고 싶다면?"
            Text(
              '오늘의 밥 메뉴를 추천받고 싶다면?',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: _menuOptions.map((option) {
                return ChoiceChip(
                  label: Text(option),
                  selected: false, // 선택되지 않도록 설정
                  onSelected: (bool selected) {
                    _onMenuOptionSelected(option); // 메뉴 선택 시 해당 화면으로 이동
                  },
                  backgroundColor: Colors.white, // 내부 색상 하얀색
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: Colors.red[800]!, // 테두리 색상을 빨간색으로 변경
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 30.0),

            // "지금 핫한 음식점을 추천받고 싶다면?"
            Text(
              '지금 핫한 음식점을 추천받고 싶다면?',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: _hotOptions.map((option) {
                return ChoiceChip(
                  label: Text(option),
                  selected: false, // 선택되지 않도록 설정
                  onSelected: (bool selected) {
                    _onHotOptionSelected(option); // 핫한 음식점 선택 시 해당 화면으로 이동
                  },
                  backgroundColor: Colors.white, // 내부 색상 하얀색
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: Colors.red[800]!, // 테두리 색상을 빨간색으로 변경
                    ),
                  ),
                );
              }).toList(),
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
            icon: Icon(Icons.bar_chart),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, // 현재 선택된 인덱스
        selectedItemColor: Colors.pink,
        onTap: _onItemTapped, // 선택된 페이지로 이동
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
