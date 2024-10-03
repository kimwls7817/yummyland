import 'package:flutter/material.dart';

class FoodSurveyScreen extends StatefulWidget {
  @override
  _FoodSurveyScreenState createState() => _FoodSurveyScreenState();
}

class _FoodSurveyScreenState extends State<FoodSurveyScreen> {
  List<String> answers = List.filled(10, ''); // 각 질문에 대한 답변을 저장
  final _formKey = GlobalKey<FormState>();

  // 설문조사 저장 함수
  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // 여기서 데이터베이스에 저장하는 로직을 추가할 수 있습니다.
      print('사용자 답변: $answers');
      // TODO: 데이터베이스 저장 로직 추가

      // 저장 후 profile_screen.dart로 이동
      Navigator.pushNamed(context, '/userProfile'); // profile_screen으로 이동
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로 가기 버튼 제거
        title: Text('음식 취향 설문조사'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white, // Scaffold 배경색을 하얀색으로 설정
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1부터 10까지의 질문을 생성
              for (int i = 1; i <= 10; i++) buildQuestion(i),
              SizedBox(height: 20),
              // 저장하기 버튼
              Center(
                child: ElevatedButton(
                  onPressed: _saveForm,
                  child: Text(
                    '저장하기',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black), // 검정색 텍스트
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // 하얀색 배경
                    side: BorderSide(color: Colors.red), // 빨간색 테두리
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 50.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 질문을 생성하는 함수
  Widget buildQuestion(int questionNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$questionNumber. 질문 내용 $questionNumber', // 질문 텍스트
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => setAnswer(questionNumber, '예'),
                child: Text(
                  '예',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black), // 검정색 텍스트
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: answers[questionNumber - 1] == '예' ? Colors.red : Colors.white, // 선택 시 빨간색 배경, 기본은 하얀색
                  side: BorderSide(color: Colors.red), // 빨간색 테두리
                  elevation: 0, // 그림자 제거
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () => setAnswer(questionNumber, '아니오'),
                child: Text(
                  '아니오',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black), // 검정색 텍스트
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: answers[questionNumber - 1] == '아니오' ? Colors.red : Colors.white, // 선택 시 빨간색 배경, 기본은 하얀색
                  side: BorderSide(color: Colors.red), // 빨간색 테두리
                  elevation: 0, // 그림자 제거
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }

  // 사용자의 답변을 저장하는 함수
  void setAnswer(int questionNumber, String answer) {
    setState(() {
      answers[questionNumber - 1] = answer;
    });
  }
}
