import 'package:flutter/material.dart';
import 'package:tic_tac_toe_game/constant.dart';

class Game extends StatefulWidget {
  final String player1;
  final String player2;

  const Game({
    Key? key,
    required this.player1,
    required this.player2,
  }) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  bool getPlayerMove = true;
  List<String> playerMoves = ['', '', '', '', '', '', '', '', ''];
  String currentWinner = '';
  String playButtonText = 'Play';
  int scoreO = 0;
  int scoreX = 0;
  int filledBoxes = 0;
  bool winnerFound = false;
  List<int> isMatchIndexes = [];

  @override
  Widget build(BuildContext context) {
    String player1 = widget.player1;
    String player2 = widget.player2;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 30.0,
        ),
        backgroundColor: Colors.indigo,
        elevation: 0.0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(top: 2.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 50,
                            height: 100.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(player1, style: kPlayers),
                                const SizedBox(height: 10.0),
                                const Text(
                                  '1st Player',
                                  style: kWhiteText,
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  'Score $scoreO',
                                  style: kYellowText,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 50,
                            height: 100.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(player2, style: kPlayers),
                                const SizedBox(height: 10.0),
                                const Text(
                                  '2nd Player',
                                  style: kWhiteText,
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  'Score $scoreX',
                                  style: kYellowText,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
                itemCount: playerMoves.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    //This widget disables all the children
                    child: AbsorbPointer(
                      //set absorbing to false, but if there is a winner then set absorbing to true
                      absorbing: _gameLock(),
                      child: GestureDetector(
                        onTap: () {
                          _moveTracker(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 3.0,
                                style: BorderStyle.solid,
                                color: Colors.black54),
                            borderRadius: BorderRadius.circular(10.0),
                            color: isMatchIndexes.contains(index)
                                ? Colors.lightGreen
                                : Colors.transparent,
                          ),
                          child: Center(
                            child: Text(
                              playerMoves[index],
                              style: kPlayers,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(top: 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Text(
                          currentWinner,
                          style: kPlayers,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 128.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 60.0),
                        ),
                        onPressed: () {
                          _clearBoxes();
                          isMatchIndexes = [];
                        },
                        child: Text(
                          playButtonText,
                          style: kStartButton,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _moveTracker(int index) {
    setState(() {
      if (getPlayerMove && playerMoves[index] == '') {
        playerMoves[index] = 'O';
        filledBoxes++;
        getPlayerMove = false;
      } else if (!getPlayerMove && playerMoves[index] == '') {
        playerMoves[index] = 'X';
        filledBoxes++;
        getPlayerMove = true;
      }
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (playerMoves[0] == playerMoves[1] &&
        playerMoves[0] == playerMoves[2] &&
        playerMoves[0] != '') {
      setState(() {
        isMatchIndexes.addAll([0, 1, 2]);
        currentWinner = 'Player ${playerMoves[0]} won the game';
        winnerFound = true;
        playButtonText = "Play again";
        _updateScore(playerMoves[0]);
      });
    }

    if (playerMoves[3] == playerMoves[4] &&
        playerMoves[3] == playerMoves[5] &&
        playerMoves[3] != '') {
      setState(() {
        isMatchIndexes.addAll([3, 4, 5]);
        currentWinner = 'Player ${playerMoves[3]} won the game';
        winnerFound = true;
        playButtonText = "Play again";
        _updateScore(playerMoves[3]);
      });
    }

    if (playerMoves[6] == playerMoves[7] &&
        playerMoves[6] == playerMoves[8] &&
        playerMoves[6] != '') {
      setState(() {
        isMatchIndexes.addAll([6, 7, 8]);
        currentWinner = 'Player ${playerMoves[6]} won the game';
        winnerFound = true;
        playButtonText = "Play again";
        _updateScore(playerMoves[6]);
      });
    }

    if (playerMoves[0] == playerMoves[3] &&
        playerMoves[0] == playerMoves[6] &&
        playerMoves[0] != '') {
      setState(() {
        isMatchIndexes.addAll([0, 3, 6]);
        currentWinner = 'Player ${playerMoves[0]} won the game';
        winnerFound = true;
        playButtonText = "Play again";
        _updateScore(playerMoves[0]);
      });
    }

    if (playerMoves[1] == playerMoves[4] &&
        playerMoves[1] == playerMoves[7] &&
        playerMoves[1] != '') {
      setState(() {
        isMatchIndexes.addAll([1, 4, 7]);
        currentWinner = 'Player ${playerMoves[1]} won the game';
        winnerFound = true;
        playButtonText = "Play again";
        _updateScore(playerMoves[1]);
      });
    }

    if (playerMoves[2] == playerMoves[5] &&
        playerMoves[2] == playerMoves[8] &&
        playerMoves[2] != '') {
      setState(() {
        isMatchIndexes.addAll([2, 5, 8]);
        currentWinner = 'Player ${playerMoves[2]} won the game';
        winnerFound = true;
        playButtonText = "Play again";
        _updateScore(playerMoves[2]);
      });
    }

    if (playerMoves[0] == playerMoves[4] &&
        playerMoves[0] == playerMoves[8] &&
        playerMoves[0] != '') {
      setState(() {
        isMatchIndexes.addAll([0, 4, 8]);
        currentWinner = 'Player ${playerMoves[0]} won the game';
        winnerFound = true;
        playButtonText = "Play again";
        _updateScore(playerMoves[0]);
      });
    }

    if (playerMoves[2] == playerMoves[4] &&
        playerMoves[2] == playerMoves[6] &&
        playerMoves[2] != '') {
      setState(() {
        isMatchIndexes.addAll([2, 4, 6]);
        currentWinner = 'Player ${playerMoves[2]} won the game';
        winnerFound = true;
        playButtonText = "Play again";
        _updateScore(playerMoves[2]);
      });
    }

    if (!winnerFound && filledBoxes == 9) {
      setState(() {
        currentWinner = "It's a tie";
        playButtonText = "Play again";
      });
    }
  }

  void _updateScore(String winner) {
    setState(() {
      if (winner == 'O') {
        scoreO++;
      } else if (winner == 'X') {
        scoreX++;
      }
    });
  }

  void _clearBoxes() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        playerMoves[i] = '';
      }
      currentWinner = '';
      filledBoxes = 0;
      winnerFound = false;
      playButtonText = 'Play';
    });
  }

  bool _gameLock() {
    if (currentWinner != '') {
      return true;
    }
    return false;
  }
}
