import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yummylandapp/app_screens/todaysmenu_screen.dart';
import 'package:yummylandapp/app_screens/user_profile_screen.dart';
import 'package:yummylandapp/app_screens/calorie_calculator_screen.dart';
import 'package:yummylandapp/app_screens/food_worldcup_screen.dart';
import 'package:yummylandapp/app_screens/convenience_screen.dart';
import 'package:yummylandapp/app_screens/restaurant_screen.dart';

class FoodWorldCupScreen extends StatefulWidget {
  @override
  _FoodWorldCupScreenState createState() => _FoodWorldCupScreenState();
}

class _FoodWorldCupScreenState extends State<FoodWorldCupScreen> {
  bool _showSelectionScreen = false; // 두 번째 화면 여부를 제어하는 변수
  int _selectedIndex = 0;
  int _currentRound = 0;

  String _firstSelection = ''; // 첫 번째 라운드에서 선택한 음식
  String _firstSelectionImage = ''; // 첫 번째 라운드에서 선택한 음식 이미지
  String _secondSelection = ''; // 두 번째 라운드에서 선택한 음식
  String _secondSelectionImage = ''; // 두 번째 라운드에서 선택한 음식 이미지
  String _finalSelection = ''; // 최종 선택된 음식
  String _finalSelectionImage = ''; // 최종 선택된 음식 이미지

  // 음식 선택지
  List<Map<String, String>> _foodOptions = [
    {'name': '음식 이름1', 'image': 'assets/food1.png'},
    {'name': '음식 이름2', 'image': 'assets/food2.png'},
    {'name': '음식 이름3', 'image': 'assets/food3.png'},
    {'name': '음식 이름4', 'image': 'assets/food4.png'},
  ];

  // 네비게이션 바에서 선택된 페이지에 따라 다른 화면을 표시
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/foodDiary');
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CalorieCalculatorScreen()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserProfileSurveyScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 앱 배경색을 하얀색으로 설정
      appBar: AppBar(
        automaticallyImplyLeading: false, // 되돌아가기 화살표 제거
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
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            iconSize: 36.0, // 알림 아이콘 크기 설정
            onPressed: () {
              // 알림 페이지로 이동할 수 있는 액션 추가
            },
          ),
        ],
        backgroundColor: Colors.transparent, // 상단 바 배경색을 투명하게 설정
        elevation: 0, // 상단 바의 그림자 제거
      ),
      body: _currentRound < 3
          ? buildFoodComparisonScreen(context)
          : buildFinalSelectionScreen(context),
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  // 첫 번째 라운드 화면 (음식 비교)
  Widget buildFoodComparisonScreen(BuildContext context) {
    if (_currentRound == 0) {
      // 1번과 2번 비교
      return buildRoundComparison(context, 0, 1);
    } else if (_currentRound == 1) {
      // 3번과 4번 비교
      return buildRoundComparison(context, 2, 3);
    } else if (_currentRound == 2) {
      // 선택한 2개 음식(첫 번째 라운드에서 선택된 것과 두 번째 라운드에서 선택된 것) 비교
      return buildRoundComparison(
        context,
        null,
        null,
        isFinalRound: true,
      );
    }
    return Container();
  }

  // 각 라운드에서 음식 비교
  Widget buildRoundComparison(
      BuildContext context,
      int? firstIndex,
      int? secondIndex, {
        bool isFinalRound = false,
      }) {
    String firstImage = isFinalRound ? _firstSelectionImage : _foodOptions[firstIndex!]['image']!;
    String secondImage = isFinalRound ? _secondSelectionImage : _foodOptions[secondIndex!]['image']!;
    String firstFoodName = isFinalRound ? _firstSelection : _foodOptions[firstIndex!]['name']!;
    String secondFoodName = isFinalRound ? _secondSelection : _foodOptions[secondIndex!]['name']!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 화면 가운데 배치
          children: [
            // 음식 월드컵 텍스트와 음식 이미지가 들어가는 부분에만 빨간 그라데이션 배경 추가
            Container(
              width: double.infinity, // 화면에 맞게 가로 길이 설정
              height: 650.0, // 높이 설정 (세로 크기 증가)
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red.withOpacity(0.1),
                    Colors.red.withOpacity(0.4),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // 세로로 중앙 배치
                children: [
                  Text(
                    isFinalRound ? '최종 선택' : '음식 월드컵🏆',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32.0, // 텍스트 크기 증가
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Column( // Column으로 변경하여 세로로 나열
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 첫 번째 음식 선택
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_currentRound == 0) {
                              _firstSelection = _foodOptions[firstIndex!]['name']!;
                              _firstSelectionImage = _foodOptions[firstIndex]['image']!;
                            } else if (_currentRound == 1) {
                              _secondSelection = _foodOptions[secondIndex!]['name']!;
                              _secondSelectionImage = _foodOptions[secondIndex]['image']!;
                            } else if (_currentRound == 2) {
                              _finalSelection = _firstSelection;
                              _finalSelectionImage = _firstSelectionImage;
                            }
                            _currentRound++;
                          });
                        },
                        child: _buildFoodOption(
                          context,
                          firstImage,
                          firstFoodName,
                        ),
                      ),
                      SizedBox(height: 20), // 이미지 사이에 간격 추가

                      // 두 번째 음식 선택
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_currentRound == 0) {
                              _firstSelection = _foodOptions[secondIndex!]['name']!;
                              _firstSelectionImage = _foodOptions[secondIndex]['image']!;
                            } else if (_currentRound == 1) {
                              _secondSelection = _foodOptions[secondIndex!]['name']!;
                              _secondSelectionImage = _foodOptions[secondIndex]['image']!;
                            } else if (_currentRound == 2) {
                              _finalSelection = _secondSelection;
                              _finalSelectionImage = _secondSelectionImage;
                            }
                            _currentRound++;
                          });
                        },
                        child: _buildFoodOption(
                          context,
                          secondImage,
                          secondFoodName,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 최종 결과 화면
  Widget buildFinalSelectionScreen(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 화면 가운데 배치
          children: [
            Text(
              '" 당신의 최종 선택 "',
              style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold), // 텍스트 크기 증가
            ),
            SizedBox(height: 20.0),
            Container(
              height: 300.0, // 이미지 크기 증가
              width: 300.0, // 이미지 크기 증가
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                border: Border.all(width: 2.0, color: Colors.black), // 테두리
              ),
              child: Center(
                child: Image.asset(_finalSelectionImage), // 선택된 음식 이미지 표시
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              _finalSelection,
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold), // 텍스트 크기 증가
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentRound = 0; // 다시 첫 번째 음식 비교 화면으로 돌아가기
                  _firstSelection = '';
                  _firstSelectionImage = '';
                  _secondSelection = '';
                  _secondSelectionImage = '';
                  _finalSelection = '';
                  _finalSelectionImage = '';
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // 버튼 배경을 흰색으로 설정
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                side: BorderSide(color: Colors.red, width: 2.0), // 빨간 테두리
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // 둥근 모서리
                ),
              ),
              child: Text(
                '다시하기',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold, // 텍스트 굵게
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 음식 선택 버튼을 생성하는 함수
  Widget _buildFoodOption(BuildContext context, String imagePath, String foodName) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 200.0, // 이미지 크기 증가
            width: 300.0, // 이미지 크기 증가
            decoration: BoxDecoration(
              color: Colors.white, // 배경색 흰색으로 설정
              border: Border.all(width: 2.0, color: Colors.red), // 빨간색 테두리로 변경
              borderRadius: BorderRadius.circular(20.0), // 둥근 모서리
            ),
            child: Center(
              child: Image.asset(imagePath), // 음식 이미지를 넣을 위치
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            foodName,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold), // 텍스트 크기 증가
          ),
        ],
      ),
    );
  }
}
