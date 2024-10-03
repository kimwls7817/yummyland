import 'package:flutter/material.dart';

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  // 알림 리스트 예시
  List<Map<String, dynamic>> alarms = [
    {'message': '알림 1: 새로운 이벤트가 있습니다!', 'timestamp': DateTime.now().subtract(Duration(minutes: 5))},
    {'message': '알림 2: 오늘의 식단이 업데이트 되었습니다.', 'timestamp': DateTime.now().subtract(Duration(hours: 1))},
    {'message': '알림 3: 쿠폰이 발행되었습니다!', 'timestamp': DateTime.now().subtract(Duration(days: 1))},
    {'message': '알림 4: 새로운 메시지가 도착했습니다.', 'timestamp': DateTime.now().subtract(Duration(days: 2))},
    {'message': '알림 5: 공지가 등록되었습니다.', 'timestamp': DateTime.now().subtract(Duration(hours: 12))},
  ];

  String _selectedSortOption = 'latest'; // 기본 정렬 방식은 최신순

  // 정렬 방식 변경 시 호출되는 함수
  void _sortAlarms(String option) {
    setState(() {
      _selectedSortOption = option;
      if (option == 'latest') {
        alarms.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));
      } else {
        alarms.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경을 흰색으로 설정
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
        backgroundColor: Colors.white, // 앱바 배경 흰색
        elevation: 0, // 그림자 제거
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              children: [
                // "알림" 텍스트를 가운데 정렬
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '알림',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 50.0), // 알림 리스트 아래로 간격 추가

                // 알림 리스트를 보여주는 ListView
                Expanded(
                  child: ListView.builder(
                    itemCount: alarms.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white, // 흰색 배경
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.red), // 빨간색 테두리
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.campaign, size: 40.0, color: Colors.orange), // 알림 아이콘
                              SizedBox(width: 10.0),
                              Expanded(
                                child: Text(
                                  alarms[index]['message'],
                                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20.0),

                // Exit 버튼
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home'); // Home 화면으로 이동
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white, // 흰 배경
                    side: BorderSide(color: Colors.red), // 빨간색 테두리
                    padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0), // 버튼 크기 축소
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    'Exit',
                    style: TextStyle(
                      fontSize: 16.0, // 글씨 크기 줄임
                      color: Colors.black, // 검은색 글씨
                    ),
                  ),
                ),
              ],
            ),

            // 드롭다운 메뉴를 오른쪽 아래에 위치
            Positioned(
              top: 45.0,
              right: 0.0,
              child: DropdownButton<String>(
                value: _selectedSortOption,
                underline: SizedBox(), // 밑줄 제거
                icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                items: <String>['latest', 'oldest'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value == 'latest' ? '최신순' : '오래된 순',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    _sortAlarms(newValue);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
