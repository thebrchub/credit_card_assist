import 'package:flutter/material.dart';

void main() {
  runApp(CreditCardAssistApp());
}

class CreditCardAssistApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Credit Card Assist',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Card Recommendation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Paste the product link below:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _linkController,
              decoration: InputDecoration(
                hintText: 'https://example.com/product...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  String enteredLink = _linkController.text;
                  if (enteredLink.isNotEmpty) {
                    print('Link submitted: $enteredLink');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Link sent for analysis!'),
                      ),
                    );
                  }
                },
                child: Text('Analyze and Recommend Card'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
