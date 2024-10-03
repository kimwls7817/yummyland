import 'package:flutter/material.dart';

class BasicSurveyScreen extends StatefulWidget {
  @override
  _BasicSurveyScreenState createState() => _BasicSurveyScreenState();
}

class _BasicSurveyScreenState extends State<BasicSurveyScreen> {
  String _selectedGender = ''; // 선택된 성별을 저장하는 변수
  final TextEditingController _schoolController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색을 하얀색으로 설정
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
        title: Text(
          '기본정보수정',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 성별 선택
            Text(
              '1. 성별을 선택해주세요👦🏻👩🏻',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedGender = '남성'; // 남성 선택
                      });
                    },
                    child: Text('남성', style: TextStyle(color: _selectedGender == '남성' ? Colors.white : Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedGender == '남성' ? Colors.red : Colors.white, // 선택 시 빨간색
                      side: BorderSide(color: Colors.red), // 빨간색 테두리
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedGender = '여성'; // 여성 선택
                      });
                    },
                    child: Text('여성', style: TextStyle(color: _selectedGender == '여성' ? Colors.white : Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedGender == '여성' ? Colors.red : Colors.white, // 선택 시 빨간색
                      side: BorderSide(color: Colors.red), // 빨간색 테두리
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            // 생년월일 입력
            Text(
              '2. 생년월일을 입력해주세요🎂',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 8.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red), // 빨간색 테두리
                ),
                hintText: '예) 2003. 7. 15.',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 16.0),

            // 사용자 학교 입력
            Text(
              '3. 학교를 입력해주세요🏫',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _schoolController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red), // 빨간색 테두리
                ),
                hintText: '학교명을 입력하세요',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 16.0),

            // 저장하기 버튼
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // 저장하기 버튼을 누르면 profile_screen으로 이동
                    Navigator.pushReplacementNamed(context, '/userProfile');
                  },
                  child: Text('저장하기', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // 버튼 배경색 흰색
                    side: BorderSide(color: Colors.red), // 빨간색 테두리
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
