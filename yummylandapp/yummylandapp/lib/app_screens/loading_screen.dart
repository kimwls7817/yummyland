import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // 로딩 화면에서 3초 후에 홈 화면으로 이동
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home'); // HomeScreen으로 이동
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색을 흰색으로 설정
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 이미지 파일을 CircleAvatar에 로드
            Image.asset(
              'assets/images/yummy_icon.png', // 로고 이미지 경로
              width: 200.0,
              height: 200.0,
            ),
            SizedBox(height: 30), // 원과 텍스트 사이 간격
            Text(
              'Yummy Land',
              style: TextStyle(
                fontSize: 36.0, // 텍스트 크기 조정
                fontWeight: FontWeight.bold, // 굵은 글씨체
                fontFamily: 'Comic Sans MS', // 텍스트 폰트 패밀리 지정
                color: Colors.black, // 텍스트 색상
              ),
            ),
          ],
        ),
      ),
    );
  }
}
