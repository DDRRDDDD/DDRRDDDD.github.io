import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '김용민 | 플러터 개발자',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() => _counter++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('askdlasdklaskdlaaksdlkalsdkl'),
      ),
      body: ListView.separated(
        padding: const .symmetric(horizontal: 500),
        itemCount: 50,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.blueAccent,
            height: 200,
            width: double.infinity,
            child: Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 20),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: '음매',
        child: const Icon(Icons.add),
      ),
    );
  }
}
