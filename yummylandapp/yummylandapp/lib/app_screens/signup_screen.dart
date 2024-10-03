import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign Up',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _name, _email, _id, _password;
  DateTime _selectedDate = DateTime(2003, 11, 14);

  // 전화번호 컨트롤러
  TextEditingController _phoneController1 = TextEditingController();
  TextEditingController _phoneController2 = TextEditingController();
  TextEditingController _phoneController3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20),
                Icon(Icons.person_add, size: 80),
                SizedBox(height: 20),
                Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                // Name Input
                _buildLabel('Name'),
                _buildTextField(
                  onSaved: (value) => _name = value,
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter your name' : null,
                ),
                SizedBox(height: 20),
                // Birthday Input
                _buildLabel('Birthday'),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<int>(
                        value: _selectedDate.year,
                        items: List.generate(
                          100,
                              (index) => DropdownMenuItem(
                            value: 2003 - index,
                            child: Text((2003 - index).toString()),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedDate = DateTime(value!, _selectedDate.month, _selectedDate.day);
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButton<int>(
                        value: _selectedDate.month,
                        items: List.generate(
                          12,
                              (index) => DropdownMenuItem(
                            value: index + 1,
                            child: Text((index + 1).toString()),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedDate = DateTime(_selectedDate.year, value!, _selectedDate.day);
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButton<int>(
                        value: _selectedDate.day,
                        items: List.generate(
                          31,
                              (index) => DropdownMenuItem(
                            value: index + 1,
                            child: Text((index + 1).toString()),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedDate = DateTime(_selectedDate.year, _selectedDate.month, value!);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Tel Input
                _buildLabel('Tel'),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController1,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        decoration: InputDecoration(hintText: '010'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController2,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        decoration: InputDecoration(hintText: '____'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _phoneController3,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        decoration: InputDecoration(hintText: '____'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Email Input
                _buildLabel('E-mail'),
                _buildTextField(
                  onSaved: (value) => _email = value,
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter your email' : null,
                ),
                SizedBox(height: 20),
                // ID Input
                _buildLabel('ID'),
                _buildTextField(
                  onSaved: (value) => _id = value,
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter your ID' : null,
                ),
                SizedBox(height: 20),
                // Password Input
                _buildLabel('Password'),
                _buildTextField(
                  obscureText: true,
                  onSaved: (value) => _password = value,
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter your password' : null,
                ),
                SizedBox(height: 40),
                // Next Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // 다음 화면으로 이동할 동작 추가
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[300],  // primary -> backgroundColor
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method for TextField
  Widget _buildTextField({
    required FormFieldSetter<String> onSaved,
    required FormFieldValidator<String> validator,
    bool obscureText = false,
  }) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
      ),
    );
  }

  // Helper method for labels
  Widget _buildLabel(String label) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber),
        SizedBox(width: 10),
        Text(
          label,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
