import 'dart:developer';
import 'package:flutter/material.dart';

class SetStatePractice extends StatefulWidget {
  const SetStatePractice({super.key});

  @override
  State<SetStatePractice> createState() => _SetStatePracticeState();
}

class _SetStatePracticeState extends State<SetStatePractice> {
  final num1 = 1, num2 = 2;
  int number = 0;
  List<String> myList = [];
  var result = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey,
                ),
                child: Text(
                  '${myList.toList()}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey,
                ),
                child: Text(
                  '$result',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 40,
                width: 40,
                color: Colors.green,
                child: TextButton(
                  child: const Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      myList.add(num1.toString());
                    });
                  },
                ),
              ),
              Container(
                height: 40,
                width: 40,
                color: Colors.green,
                child: TextButton(
                  child: const Text(
                    '+',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    myList.add('+');
                    setState(() {});
                  },
                ),
              ),
              Container(
                height: 40,
                width: 40,
                color: Colors.green,
                child: TextButton(
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    myList.add(num2.toString());
                    setState(() {});
                  },
                ),
              ),
              Container(
                height: 40,
                width: 40,
                color: Colors.green,
                child: TextButton(
                  child: const Text(
                    '=',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      final cond = myList.any((element) =>
                          element == '+' ||
                          element == '-' ||
                          element == '*' ||
                          element == ':');
                      log(cond.toString());
                      if (cond) {
                        int index =
                            myList.indexWhere((element) => element == '+');
                        log('the index is ${index.toString()}');
                        Iterable<String> part1List =
                            myList.getRange(0, index - 1);

                        int sum1 = 0;
                        for (final element in part1List) {
                          sum1 += int.parse(element);
                        }
                        log('the sum is ${sum1.toString()}');
                      }
                      // final a = int.parse(myList[0]);
                      // final b = int.parse(myList[2]);
                      // result = a + b;
                    });
                  },
                ),
              ),
              Container(
                height: 40,
                width: 40,
                color: Colors.green,
                child: TextButton(
                  child: const Text(
                    'C',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    myList = [];
                    result = 0;
                    setState(() {});
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
