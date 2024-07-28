import 'package:first_app/add_money_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double balance = 0;
  void addMoney() async {
    setState(() {
      balance = balance + 500;
    });
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setDouble('balance', balance);
  }

  void loadMoney() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      balance = prefs.getDouble('balance') ?? 0;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    loadMoney();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Billionaire"),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.blueGrey[500],
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Balance"),
                    const SizedBox(
                      height: 10,
                    ),
                    Text('$balance'),
                  ],
                ),
              ),
              AddMoneyButton(addMoneyFunction: addMoney)
              // Text("Account Balance"),
            ],
          ),
        ),
      ),
    );
  }
}
