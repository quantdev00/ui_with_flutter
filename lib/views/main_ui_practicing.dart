import 'package:flutter/material.dart';

class MainUi extends StatefulWidget {
  const MainUi({Key key}) : super(key: key);

  @override
  State<MainUi> createState() => _MainUiState();
}

class _MainUiState extends State<MainUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Home Page',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.account_circle_rounded,
                        color: Colors.grey,
                        size: 55,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.only(left: 10),
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                //?making the container adapt to the full width
                width: double.maxFinite,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                height: 190,

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 3, 7, 255),
                        Color.fromARGB(115, 64, 35, 133),
                      ]),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Jin A studio',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Tell me your dream',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Invite friends to sell 1000 red packets',
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    //!Button !details
                    const SizedBox(height: 18),
                    Container(
                      height: 40,
                      width: 95,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Details',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //?container with icons
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    myIcon(
                        widgetColor: Colors.orange,
                        widgetIcon: Icons.new_releases,
                        widgetText: 'New'),
                    myIcon(
                        widgetColor: Colors.blue,
                        widgetIcon: Icons.home,
                        widgetText: 'Skills'),
                    myIcon(
                        widgetColor: Color.fromARGB(255, 231, 50, 111),
                        widgetIcon: Icons.add_business,
                        widgetText: 'Easal'),
                    myIcon(
                        widgetColor: Colors.blue,
                        widgetIcon: Icons.room_service,
                        widgetText: 'Room'),
                    myIcon(
                        widgetColor: Colors.deepPurple,
                        widgetIcon: Icons.room_rounded,
                        widgetText: 'Project'),
                  ],
                ),
              ),
              //!Container
              Container(
                color: Colors.grey[300],
                height: 7,
                margin: const EdgeInsets.only(top: 18, bottom: 18),
              ),
              //!Curriculum box
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Container(
                      width: 5,
                      color: Colors.blue,
                      height: 30,
                    ),
                    const Text(
                      '   Curriculum',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              //!Card 1 blue one to purchase
              cardCurriculum(
                widgetColorGrandiant1: const Color.fromARGB(255, 3, 7, 255),
                widgetColorGrandiant2: const Color.fromARGB(115, 64, 35, 133),
                boxColorPurshase: Colors.deepPurple,
                widgetColorLeftBoxPrice: Colors.deepPurple,
                widgetLeftBoxName: 'Elite class',
                widgetRightBoxName: '\$53,000',
              ),
              //!Card 2 orange
              cardCurriculum(
                widgetColorGrandiant1: const Color.fromARGB(255, 230, 169, 90),
                widgetColorGrandiant2: const Color.fromARGB(255, 255, 115, 0),
                boxColorPurshase: Colors.orange,
                widgetColorLeftBoxPrice: Colors.orange,
                widgetLeftBoxName: 'Design class',
                widgetRightBoxName: '\$47,000',
              ),
              cardCurriculum(
                widgetColorGrandiant1: const Color.fromARGB(255, 3, 7, 255),
                widgetColorGrandiant2: const Color.fromARGB(115, 64, 35, 133),
                boxColorPurshase: Colors.deepPurple,
                widgetColorLeftBoxPrice: Colors.deepPurple,
                widgetLeftBoxName: 'Pros class',
                widgetRightBoxName: '\$35,000',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//*Function for the 5 little widgets after the Jin A studio

Widget myIcon({Color widgetColor, IconData widgetIcon, String widgetText}) {
  return Column(
    children: [
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: widgetColor,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Icon(
          widgetIcon,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 3),
      Text(
        widgetText,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    ],
  );
}

//*Function for creating Classe Elite, etc
Widget cardCurriculum({
  Color widgetColorGrandiant1,
  Color widgetColorGrandiant2,
  String widgetLeftBoxName,
  String widgetRightBoxName,
  Color widgetColorLeftBoxPrice,
  Color boxColorPurshase,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
    child: Row(
      children: [
        Container(
          height: 135,
          width: 110,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomLeft,
              colors: [widgetColorGrandiant1, widgetColorGrandiant2],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  size: 50,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widgetLeftBoxName,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 135,
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Central Quing elite class',
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                'Elite first choice rapid \nimprouvement of painting ability',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    widgetRightBoxName,
                    style: TextStyle(
                      color: widgetColorLeftBoxPrice,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 55),
                  Container(
                    height: 35,
                    width: 95,
                    decoration: BoxDecoration(
                      color: boxColorPurshase,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Purchashe',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}
