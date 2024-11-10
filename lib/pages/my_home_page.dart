import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> displayXO = ["", "", "", "", "", "", "", "", ""];

  var nextWhoseTurn = 'X';

  bool isXTurn = true; // the first player to start the move

  int filledGrid = 0;

  void _gridTapped(int index) {
    setState(() {
      if (isXTurn && displayXO[index] == "") {
        displayXO[index] = "X";
        filledGrid++;
        nextWhoseTurn = 'O';
      } else if (!isXTurn && displayXO[index] == "") {
        displayXO[index] = "O";
        filledGrid++;
        nextWhoseTurn = 'X';
      }

      isXTurn = !isXTurn;
      _checkwinner();
    });
  }

  void _checkwinner() {
    // check for 1st row
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != "") {
      _showWonDialog(displayXO[0]);
    }

    // check for 2nd row
    else if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != "") {
      _showWonDialog(displayXO[3]);
    }

    // check for 3rd row
    else if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != "") {
      _showWonDialog(displayXO[6]);
    }

    // check for 1st column
    else if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != "") {
      _showWonDialog(displayXO[0]);
    }

    // check for 2nd column
    else if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != "") {
      _showWonDialog(displayXO[1]);
    }

    // check for 3rd column
    else if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != "") {
      _showWonDialog(displayXO[2]);
    }

    // check for diagonal -> topleft - bottomright
    else if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != "") {
      _showWonDialog(displayXO[0]);
    }

    // check for diagonal -> topright - bottomleft
    else if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != "") {
      _showWonDialog(displayXO[2]);
    }

    // check for draw match
    else if (filledGrid == 9) {
      _showDrawDialog();
    }
  }

  void _showWonDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext contxet) {
        return AlertDialog(
          title: Text("$winner Won the match!"),
          actions: [
            TextButton(
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
              child: const Text("Play Again :)"),
            ),
          ],
        );
      },
      barrierDismissible: false,
    );

    if (winner == "X") {
      xScore++;
    } else if (winner == "O") {
      oScore++;
    }
  }

  void _showDrawDialog() {
    showDialog(
      context: context,
      builder: (BuildContext contxet) {
        return AlertDialog(
          title: const Text("Oops! It's a DRAW"),
          actions: [
            TextButton(
              onPressed: () {
                _clearBoard();
                Navigator.of(context).pop();
              },
              child: const Text("Play Again :)"),
            ),
          ],
        );
      },
      barrierDismissible: false,
    );
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = "";
      }
    });

    filledGrid = 0;
  }

  // TextStyle? myTextStyle = TextStyle(color: Colors.white, fontSize: 30);
  TextStyle? myTextStyle = GoogleFonts.pressStart2p(
    color: Colors.white,
    letterSpacing: 3,
    fontSize: 15,
  );

  int xScore = 0;
  int oScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Player X",
                        style: myTextStyle,
                      ),
                      Text(
                        xScore.toString(),
                        style: myTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Player O",
                        style: myTextStyle,
                      ),
                      Text(
                        oScore.toString(),
                        style: myTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _gridTapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade700),
                      ),
                      child: Center(
                        child: Text(
                          displayXO[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$nextWhoseTurn 's Turn",
                  style: myTextStyle,
                ),
                const SizedBox(
                  height: 70,
                ),
                Text(
                  "TIC TAC TOE",
                  style: myTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
