import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/screens/game.dart';
import 'package:tic_tac_toe_game/constant.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String player1;
  late String player2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 150.0),
            const Text(
              'Enter Player Names',
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
            const SizedBox(height: 50.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Player 1 Name',
                ),
                onChanged: (value) {
                  print(player1 = value);
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Player 2 Name',
                ),
                onChanged: (value) {
                  print(player2 = value);
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: const Size(double.infinity, 60.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Game(
                              player1: player1,
                              player2: player2,
                            )),
                  );
                },
                child: const Text(
                  'Start',
                  style: kStartButton,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
