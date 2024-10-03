import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CalorieCalculatorScreen extends StatefulWidget {
  @override
  _CalorieCalculatorScreenState createState() => _CalorieCalculatorScreenState();
}

class _CalorieCalculatorScreenState extends State<CalorieCalculatorScreen> {
  final List<double> weeklyCalories = [2175, 1983, 2050, 1900, 2100, 2200, 2000];
  final Map<String, double> nutritionData = {
    '탄수화물': 150,
    '단백질': 60,
    '지방': 80,
  };

  int _selectedIndex = 2; // Set the current index to Stats screen

  // Handle BottomNavigationBar item tap events
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushNamed(context, '/home'); // Navigate to Home
    } else if (index == 1) {
      Navigator.pushNamed(context, '/foodDiary'); // Navigate to Diary
    } else if (index == 2) {
      Navigator.pushNamed(context, '/calorieCalculator'); // Stay on Stats
    } else if (index == 3) {
      Navigator.pushNamed(context, '/userProfile'); // Navigate to Profile
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
            iconSize: 36.0,
            onPressed: () {
              Navigator.pushNamed(context, '/alarm'); // 알람 화면으로 이동
            },
          ),
        ],
      ),
      backgroundColor: Colors.white, // 배경색을 하얀색으로 설정
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 주간 칼로리 분석
              Text(
                '주간 칼로리 분석',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Container(
                height: 200.0,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.pink[50],
                ),
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const days = ['월', '화', '수', '목', '금', '토', '일'];
                            return Text(
                              days[value.toInt()],
                              style: TextStyle(fontSize: 12),
                            );
                          },
                        ),
                      ),
                    ),
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: weeklyCalories.asMap().entries.map((e) {
                          return FlSpot(e.key.toDouble(), e.value);
                        }).toList(),
                        isCurved: true,
                        barWidth: 3,
                        color: Colors.pink,
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.pink.withOpacity(0.3),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),

              // 일일 칼로리 분석 (영양소별 구성)
              Text(
                '일일 칼로리 분석',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Container(
                height: 200.0,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.pink[50],
                ),
                child: BarChart(
                  BarChartData(
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const nutrients = ['탄수화물', '단백질', '지방'];
                            return Text(nutrients[value.toInt()]);
                          },
                        ),
                      ),
                    ),
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: true),
                    barGroups: nutritionData.entries.map((e) {
                      return BarChartGroupData(
                        x: nutritionData.keys.toList().indexOf(e.key),
                        barRods: [
                          BarChartRodData(
                            toY: e.value,
                            color: Colors.pink,
                            width: 20.0,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 20.0),

              // 김예진
              // 식사 관련 그래프
              Text(
                '응답자 기본 정보 그래프',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_basic01.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_basic02.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_basic03.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_basic04.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_basic05.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_basic06.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_basic07.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                '끼니별 식사 형태',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_meal01.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_meal02.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_meal03.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_meal04.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_meal05.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_meal06.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_meal07.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_meal08.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_meal09.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_meal10.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                '외식 관련 인식 및 형태',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_restaurant01.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_restaurant02.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_restaurant03.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_restaurant04.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_restaurant05.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFFF16D5E), width: 2.0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset('assets/images/graph_restaurant06.png', height: 200.0, fit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Diary'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  // 선호 음식 타일
  Widget _buildFavoriteFoodTile(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        Container(
          height: 200.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.grey[300], // Placeholder color for image
          ),
          child: Center(
            child: Text(
              'Image Placeholder',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ),
      ],
    );
  }
}
