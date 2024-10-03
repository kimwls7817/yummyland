import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:yummylandapp/app_screens/calorie_calculator_screen.dart';
import 'package:yummylandapp/app_screens/foodsurvey_screen.dart'; // foodsurvey_screen 임포트
import 'package:yummylandapp/app_screens/edit_userinfo_screen.dart'; // edit_userinfo_screen 임포트
import 'package:yummylandapp/services/auth_service.dart'; // AuthService 추가
import 'package:firebase_auth/firebase_auth.dart';

//구글 로그인 적용

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
        scaffoldBackgroundColor: Colors.white, // 전체 배경색을 흰색으로 설정
      ),
      initialRoute: '/userProfile', // 기본적으로 프로필 페이지로 시작
      routes: {
        '/userProfile': (context) => UserProfileSurveyScreen(), // User profile screen
        '/foodsurveyScreen': (context) => FoodSurveyScreen(), // foodsurvey_screen으로 이동
        '/editUserInfo': (context) => BasicSurveyScreen(), // edit_userinfo_screen 추가
      },
    );
  }
}

// UserProfileScreen 수정
class UserProfileSurveyScreen extends StatefulWidget {
  @override
  _UserProfileSurveyScreenState createState() =>
      _UserProfileSurveyScreenState();
}

class _UserProfileSurveyScreenState extends State<UserProfileSurveyScreen> {
  File? _profileImage; // 프로필 이미지 저장할 변수
  final ImagePicker _picker = ImagePicker(); // ImagePicker 인스턴스
  final AuthService _authService = AuthService(); // AuthService 인스턴스 추가

  int _selectedIndex = 3; // 기본적으로 프로필 페이지가 선택된 상태

  // 이미지 선택 함수
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path); // 선택된 이미지를 File로 저장
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            icon: Icon(Icons.notifications,color: Colors.black),
            iconSize: 36.0, // 알림 아이콘 크기 설정
            onPressed: () {
              Navigator.pushNamed(context, '/alarm'); // 알람 화면으로 이동
            },
          ),
        ],
      ),
      backgroundColor: Colors.white, // Scaffold 배경색을 하얀색으로 설정
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0), // 패딩을 줄여서 간격을 좁게 설정
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 사용자 환영 메시지
            Text(
              '윤다해님, 안녕하세요!',
              style: TextStyle(
                fontSize: 22.0, // 텍스트 크기를 약간 줄임
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15), // 간격을 줄임

            // 내 정보 섹션
            _buildSectionTitle('내 정보👤'),
            _buildListTile(
              icon: Icons.account_circle,
              text: '내 정보 변경',
              onTap: () {
                Navigator.pushNamed(context, '/editUserInfo'); // EditUserInfoScreen으로 이동
              },
            ),
            SizedBox(height: 15), // 간격을 줄임

            // 구글 로그인 추가
            _buildListTile(
              icon: Icons.login,
              text: '구글 로그인하기',
              onTap: () {
                _handleGoogleLogin(); // 실제 구글 로그인 핸들러를 호출
              },
            ),
            SizedBox(height: 15), // 간격을 줄임

            // 음식 취향 설문조사 섹션
            _buildSectionTitle('음식 취향 분석🥄'),
            _buildListTile(
              icon: Icons.food_bank,
              text: '음식 취향 분석하기', // 텍스트를 음식 취향 분석하기로 변경
              onTap: () {
                Navigator.pushNamed(context, '/foodsurveyScreen'); // 올바른 네비게이션 설정
              },
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

  // 구글 로그인 핸들링 함수
  void _handleGoogleLogin() async {
    User? user = await _authService.signInWithGoogle(); // AuthService를 통한 Google 로그인 시도
    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 성공: ${user.displayName}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그인 실패')),
      );
    }
  }

  // 섹션 타이틀 스타일
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // 패딩을 줄여서 간격을 좁게 설정
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black), // 텍스트 크기를 줄임
      ),
    );
  }

  // 목록 아이템 스타일 (연한 빨간색 그라데이션 적용)
  Widget _buildListTile({required IconData icon, required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0), // 패딩을 줄여서 간격을 좁게 설정
        margin: const EdgeInsets.only(bottom: 8.0), // 목록 사이의 마진을 줄임
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: LinearGradient(
            colors: [Colors.red[100]!, Colors.redAccent.withOpacity(0.3)], // 연한 빨간색 그라데이션
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 22, color: Colors.black), // 아이콘 크기를 약간 줄임
            SizedBox(width: 8),
            Text(text, style: TextStyle(fontSize: 14, color: Colors.black)), // 텍스트 크기를 약간 줄임
          ],
        ),
      ),
    );
  }

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
        MaterialPageRoute(builder: (context) => CalorieCalculatorScreen()), // 칼로리 계산기로 이동
      );
    } else if (index == 3) {
      // 이미 프로필 화면이므로 아무 작업도 하지 않음
    }
  }
}
