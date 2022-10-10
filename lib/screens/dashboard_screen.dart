import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double temperature = 0;
  double humidity = 0;
  late DatabaseReference databaseReferenceTemperature;
  late DatabaseReference databaseReferenceHumidity;

  @override
  void initState() {
    super.initState();
    databaseReferenceTemperature = FirebaseDatabase.instance.ref().child('DHT11/Temperature');
    databaseReferenceHumidity = FirebaseDatabase.instance.ref().child('DHT11/Humidity');
    getDatabaseData();
  }

  getDatabaseData() {
    print('Get data method called!');
    databaseReferenceTemperature.onValue.listen((event) {
      print('Temperature method called!');
      setState(() {
        humidity = double.parse(event.snapshot.value.toString());
      });
    });
    databaseReferenceHumidity.onValue.listen((event) {
      print('Humidity method called!');
      setState(() {
        temperature = double.parse(event.snapshot.value.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 58, 0),
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Poultry Pro',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 18, 58, 0),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    getDatabaseData();
                  },
                  child: const Text('Refresh'),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 241, 246, 255),
                    ),
                    color: const Color.fromARGB(255, 114, 114, 114).withOpacity(0.37),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/humidity.png',
                                  color: Colors.white,
                                  scale: 5,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  'Humidity ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  humidity.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                                const Text(
                                  "%",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 150,
                          width: 60,
                          child: LiquidLinearProgressIndicator(
                            value: humidity / 100,
                            valueColor: AlwaysStoppedAnimation(
                              humidity >= 75.0 && humidity <= 90.0 ? Colors.green : Colors.red,
                            ),
                            backgroundColor: Colors.white,
                            borderWidth: 3.8,
                            borderColor: Colors.white,
                            borderRadius: 20,
                            direction: Axis.vertical,
                            center: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  humidity.toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  '%',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 241, 246, 255),
                      ),
                      color: const Color.fromARGB(255, 114, 114, 114).withOpacity(0.37),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/temp.png',
                                    color: Colors.white,
                                    scale: 20,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    'Temperature',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white70,
                                      fontFamily: 'poppins',
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    temperature.toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                    ),
                                  ),
                                  const Text(
                                    "°C",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 150,
                            width: 60,
                            child: LiquidLinearProgressIndicator(
                              value: temperature / 100,
                              valueColor: AlwaysStoppedAnimation(
                                temperature >= 25.0 && temperature <= 35.0 ? Colors.green : Colors.red,
                              ),
                              backgroundColor: Colors.white,
                              borderWidth: 3.8,
                              borderColor: Colors.white,
                              borderRadius: 20,
                              direction: Axis.vertical,
                              center: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    temperature.toString(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    '%',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
