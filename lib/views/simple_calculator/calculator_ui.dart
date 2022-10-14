import 'package:flutter/material.dart';

class CalculatorUi extends StatefulWidget {
  const CalculatorUi({super.key});

  @override
  State<CalculatorUi> createState() => _CalculatorUiState();
}

class _CalculatorUiState extends State<CalculatorUi> {
  late final TextEditingController _controllerTextField1;
  late final TextEditingController _controllerTextField2;

  @override
  void initState() {
    _controllerTextField1 = TextEditingController();
    _controllerTextField2 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controllerTextField1.dispose();
    _controllerTextField2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('RAD'),
                    Icon(
                      Icons.menu,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50),
              //* TextField 1
              Container(
                color: Colors.grey[300],
                height: 75,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextField(
                    controller: _controllerTextField1,
                    cursorColor: Colors.orange,
                    style: TextStyle(
                      fontSize: 45,
                      color: Colors.grey[700],
                    ),
                    readOnly: true,
                    autofocus: false,
                    textAlign: TextAlign.end,
                    autocorrect: false,
                    cursorHeight: 50,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              //*TextField 2

              Container(
                color: Colors.grey[300],
                height: 75,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextField(
                    controller: _controllerTextField2,
                    readOnly: true,
                    autofocus: false,
                    textAlign: TextAlign.end,
                    autocorrect: false,
                    cursorHeight: 50,
                    cursorColor: Colors.orange,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey[500],
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),

              Row(children: [
                Column(
                  children: [
                    calcButton(text: '7'),
                    calcButton(text: '4'),
                    calcButton(text: '1'),
                    calcButton(text: '.'),
                  ],
                ),
                Column(
                  children: [
                    calcButton(text: '8'),
                    calcButton(text: '5'),
                    calcButton(text: '2'),
                    calcButton(text: '0'),
                  ],
                ),
                Column(
                  children: [
                    calcButton(text: '9'),
                    calcButton(text: '6'),
                    calcButton(text: '3'),
                    calcButton(text: '='),
                  ],
                ),
                Column(
                  children: [
                    signButton(text: 'DEL'),
                    // signButton(text: '÷'),
                    signButton(text: ':'),
                    signButton(text: '×'),
                    signButton(text: '−'),
                    signButton(text: '+'),
                  ],
                ),
                Expanded(
                  child: Container(
                    height: 525,
                    width: 20,
                    color: Colors.orange,
                  ),
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

Widget calcButton({
  required text,
}) {
  return Container(
    height: 131,
    width: 90,
    decoration: const BoxDecoration(
      color: Colors.grey,
    ),
    child: TextButton(
      onPressed: () {
        // final controllerSend = _
      },
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      ),
    ),
  );
}

Widget signButton({
  required text,
}) {
  return Container(
    height: 105,
    width: 90,
    decoration: const BoxDecoration(
      color: Colors.grey,
    ),
    child: TextButton(
      onPressed: () {},
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
      ),
    ),
  );
}
