import 'package:flutter/material.dart';
import 'package:yummylandapp/app_screens/calorie_calculator_screen.dart';
import 'package:yummylandapp/app_screens/user_profile_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yummylandapp/webview/convenience_store_webview.dart'; // WebView 추가

class ConvenienceStoreScreen extends StatefulWidget {
  @override
  _ConvenienceStoreScreenState createState() => _ConvenienceStoreScreenState();
}

class _ConvenienceStoreScreenState extends State<ConvenienceStoreScreen> {
  int _selectedIndex = 0; // 네비게이션 바 인덱스
  int _selectedButtonIndex = -1; // 선택된 버튼 인덱스

  // 모바일 브라우저 User-Agent 설정
  final String mobileUserAgent =
      'Mozilla/5.0 (Linux; Android 10; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.79 Mobile Safari/537.36';

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
        MaterialPageRoute(builder: (context) => CalorieCalculatorScreen()), // 칼로리 계산기 화면으로 이동
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserProfileSurveyScreen()), // 프로필 화면으로 이동
      );
    }
  }

  // 버튼 선택 처리
  void _onButtonPressed(int index) {
    setState(() {
      _selectedButtonIndex = index;
    });

    String url;
    String title;

    // 각 인덱스에 맞는 URL과 타이틀 설정
    if (index == 0) {
      url = 'https://cu.bgfretail.com/product/product.do?category=product&depth2=4&sf=N';
      title = 'CU';
    } else if (index == 1) {
      url = 'http://gs25.gsretail.com/gscvs/en/products/event-goods';
      title = 'GS25';
    } else if (index == 2) {
      url = 'https://www.emart24.co.kr/goods/ff';
      title = 'Emart24';
    } else if (index == 3) {
      url = 'http://m.7-eleven.co.kr/product/productList.asp';
      title = '7-Eleven';
    } else {
      return;
    }

    // WebView 화면으로 이동
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConvenienceStoreWebView(url: url, title: title, mobileUserAgent: mobileUserAgent), // User-Agent 전달
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색을 하얀색으로 설정
      appBar: AppBar(
        automaticallyImplyLeading: false, // 되돌아가기 화살표 제거
        backgroundColor: Colors.transparent, // 상단 바 배경 투명 설정
        elevation: 0, // 상단 바 그림자 제거
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center( // "편의점" 텍스트를 화면 중앙에 위치
              child: Column(
                children: [
                  Text(
                    '편의점',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0), // 간격 추가
                  Text(
                    '편의점 신상품을 만나보세요!',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black, // 작은 검정색 텍스트
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            // 편의점 버튼들 - 가로로 나열, 크기 조절
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 버튼들을 화면에 맞춰 균등 배치
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _onButtonPressed(0); // CU 버튼 액션 추가
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedButtonIndex == 0 ? Colors.red : Colors.white,
                      side: BorderSide(color: Colors.red), // Red border
                      padding: EdgeInsets.symmetric(vertical: 12.0), // 버튼 크기 축소
                    ),
                    child: FittedBox( // 글씨 크기 버튼에 맞게 자동 조정
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'CU',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black, // 검정색 텍스트
                          fontWeight: FontWeight.bold, // Bold text
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _onButtonPressed(1); // GS25 버튼 액션 추가
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedButtonIndex == 1 ? Colors.red : Colors.white,
                      side: BorderSide(color: Colors.red), // Red border
                      padding: EdgeInsets.symmetric(vertical: 12.0), // 버튼 크기 축소
                    ),
                    child: FittedBox( // 글씨 크기 버튼에 맞게 자동 조정
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'GS25',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black, // 검정색 텍스트
                          fontWeight: FontWeight.bold, // Bold text
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _onButtonPressed(2); // EMART24 버튼 액션 추가
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedButtonIndex == 2 ? Colors.red : Colors.white,
                      side: BorderSide(color: Colors.red), // Red border
                      padding: EdgeInsets.symmetric(vertical: 12.0), // 버튼 크기 축소
                    ),
                    child: FittedBox( // 글씨 크기 버튼에 맞게 자동 조정
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'EMART24',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black, // 검정색 텍스트
                          fontWeight: FontWeight.bold, // Bold text
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _onButtonPressed(3); // 7-ELEVEN 버튼 액션 추가
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedButtonIndex == 3 ? Colors.red : Colors.white,
                      side: BorderSide(color: Colors.red), // Red border
                      padding: EdgeInsets.symmetric(vertical: 12.0), // 버튼 크기 축소
                    ),
                    child: FittedBox( // 글씨 크기 버튼에 맞게 자동 조정
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '7-ELEVEN',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black, // 검정색 텍스트
                          fontWeight: FontWeight.bold, // Bold text
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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

class ConvenienceStoreWebView extends StatelessWidget {
  final String url;
  final String title;
  final String mobileUserAgent; // User-Agent 추가

  ConvenienceStoreWebView({required this.url, required this.title, required this.mobileUserAgent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
        userAgent: mobileUserAgent, // 여기서 User-Agent를 설정
      ),
    );
  }
}

