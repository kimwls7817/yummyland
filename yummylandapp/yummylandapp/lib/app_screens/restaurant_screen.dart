import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Google Maps 패키지 import

class BestRestaurantScreen extends StatefulWidget {
  @override
  _BestRestaurantScreenState createState() => _BestRestaurantScreenState();
}

class _BestRestaurantScreenState extends State<BestRestaurantScreen> {
  int _selectedIndex = 0;

  // GoogleMapController 변수 추가
  late GoogleMapController mapController;

  // 초기 지도 위치 설정 (샘플 좌표: 서울)
  final LatLng _center = const LatLng(37.5665, 126.9780);

  // 지도 생성 시 호출되는 함수
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색을 하얀색으로 설정
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
                color: Colors.black,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white, // 앱바 배경색을 하얀색으로 설정
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
          children: [
            Text(
              '맛집',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.0),

            // Google Maps 위젯으로 대체
            Expanded(
              child: GoogleMap(
                onMapCreated: _onMapCreated, // 지도 생성 시 콜백 함수
                initialCameraPosition: CameraPosition(
                  target: _center, // 초기 지도 위치
                  zoom: 14.0,      // 줌 레벨 설정
                ),
              ),
            ),
            SizedBox(height: 20.0),
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  // 네비게이션 바에서 페이지 선택 시 호출되는 함수
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/foodDiary');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/calorieCalculator');
    } else if (index == 3) {
      Navigator.pushNamed(context, '/userProfile');
    }
  }
}
