import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:yummylandapp/app_screens/calorie_calculator_screen.dart';
import 'package:yummylandapp/app_screens/home_screen.dart';
import 'package:yummylandapp/app_screens/user_profile_screen.dart';

class MyDiaryScreen extends StatefulWidget {
  @override
  _MyDiaryScreenState createState() => _MyDiaryScreenState();
}

class _MyDiaryScreenState extends State<MyDiaryScreen> {
  DateTime _focusedDay = DateTime.now(); // 캘린더의 포커스 날짜
  DateTime? _selectedDay; // 선택된 날짜
  int _selectedIndex = 1; // 현재 선택된 네비게이션 바 인덱스
  String userName = '윤다해'; // 사용자 이름

  // 선택된 날짜별로 아침, 점심, 저녁, 간식 정보를 저장하는 맵
  Map<DateTime, Map<String, String>> _mealsByDay = {};

  // 텍스트 필드 컨트롤러 (아침, 점심, 저녁, 간식, 추가 정보)
  TextEditingController _breakfastController = TextEditingController();
  TextEditingController _lunchController = TextEditingController();
  TextEditingController _dinnerController = TextEditingController();
  TextEditingController _snackController = TextEditingController();
  TextEditingController _additionalInfoController = TextEditingController(); // 추가 정보

  // 네비게이션 바에서 선택된 페이지에 따라 다른 화면을 표시
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushNamed(context, '/home'); // 홈 페이지로 이동
    } else if (index == 1) {
      Navigator.pushNamed(context, '/diary'); // 다이어리 페이지로 이동
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CalorieCalculatorScreen()), // 칼로리 계산기 페이지로 이동
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserProfileSurveyScreen()), // 프로필 페이지로 이동
      );
    }
  }

  // 팝업 창 및 기타 로직 구현
  void _showMealDetails(DateTime selectedDay) {
    // 기존 식사 정보 로드, 없으면 빈 문자열로 처리
    _breakfastController.text = _mealsByDay[selectedDay]?['breakfast'] ?? '';
    _lunchController.text = _mealsByDay[selectedDay]?['lunch'] ?? '';
    _dinnerController.text = _mealsByDay[selectedDay]?['dinner'] ?? '';
    _snackController.text = _mealsByDay[selectedDay]?['snack'] ?? '';
    _additionalInfoController.text = _mealsByDay[selectedDay]?['additional'] ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              insetPadding: EdgeInsets.all(10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.8,
                padding: EdgeInsets.all(16.0),
                color: Colors.white, // 팝업 배경색을 하얀색으로 설정
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 팝업 상단 닫기 버튼
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      Text(
                        '${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일',
                        style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),

                      // 기존 저장된 정보를 표시하는 부분
                      if (_mealsByDay[selectedDay] != null) ...[
                        if (_mealsByDay[selectedDay]!['breakfast']!.isNotEmpty) ...[
                          Text("아침: ${_mealsByDay[selectedDay]!['breakfast']!}", style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                        if (_mealsByDay[selectedDay]!['lunch']!.isNotEmpty) ...[
                          Text("점심: ${_mealsByDay[selectedDay]!['lunch']!}", style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                        if (_mealsByDay[selectedDay]!['dinner']!.isNotEmpty) ...[
                          Text("저녁: ${_mealsByDay[selectedDay]!['dinner']!}", style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                        if (_mealsByDay[selectedDay]!['snack']!.isNotEmpty) ...[
                          Text("간식: ${_mealsByDay[selectedDay]!['snack']!}", style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                        if (_mealsByDay[selectedDay]!['additional']!.isNotEmpty) ...[
                          Text("추가 정보: ${_mealsByDay[selectedDay]!['additional']!}", style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ],
                      SizedBox(height: 20),

                      // 입력할 수 있는 필드들
                      _buildMealInput("아침🍚", _breakfastController),
                      _buildMealInput("점심🍚", _lunchController),
                      _buildMealInput("저녁🍚", _dinnerController),
                      _buildMealInput("간식🍽️", _snackController),
                      _buildAdditionalInfoInput("추가 정보✍️", _additionalInfoController),
                      SizedBox(height: 20),

                      // 저장 버튼 - 흰 배경, 빨간 테두리, 검정색 텍스트
                      OutlinedButton(
                        onPressed: () {
                          // 입력된 식사 정보를 팝업 내에서 업데이트
                          setStateDialog(() {
                            _mealsByDay[selectedDay] = {
                              'breakfast': _breakfastController.text,
                              'lunch': _lunchController.text,
                              'dinner': _dinnerController.text,
                              'snack': _snackController.text,
                              'additional': _additionalInfoController.text,
                            };
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('식사 정보가 저장되었습니다.')),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white, // 흰색 배경
                          side: BorderSide(color: Colors.red, width: 2.0), // 빨간색 테두리
                          foregroundColor: Colors.black, // 텍스트 색상 검정색
                        ),
                        child: Text('저장'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMealInput(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16.0)),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "$label 식사 메뉴를 입력하세요",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildAdditionalInfoInput(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16.0)),
        TextField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "추가 정보를 입력하세요",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            iconSize: 36.0, // 알림 아이콘 크기 설정// 검은색 알림 아이콘
            onPressed: () {
              Navigator.pushNamed(context, '/alarm'); // 알림 페이지로 이동
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // 사용자 이름과 다이어리 문구를 왼쪽 정렬
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$userName의 음식 다이어리',
              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16.0),
          // TableCalendar 위젯
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime(2010, 1, 1),
            lastDay: DateTime(2030, 12, 31),
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.red.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              defaultTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              weekendTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: Colors.black),
              weekendStyle: TextStyle(color: Colors.black),
            ),
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              _showMealDetails(selectedDay);
            },
          ),
        ],
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
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyDiaryScreen(),
    routes: {
      '/home': (context) => HomeScreen(),
      '/diary': (context) => MyDiaryScreen(),
      '/stats': (context) => CalorieCalculatorScreen(),
      '/profile': (context) => UserProfileSurveyScreen(),
    },
  ));
}
