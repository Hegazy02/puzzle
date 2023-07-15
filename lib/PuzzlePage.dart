import 'package:flutter/material.dart';
import 'package:puzzle/main.dart';

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({super.key});

  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

List numbers = [1, 2, 3, 4, 5, 6, 7, 8, 0];
List win = [1, 2, 3, 4, 5, 6, 7, 8, 0];
int moves = 0;

class _PuzzlePageState extends State<PuzzlePage> {
  @override
  void initState() {
    numbers.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              "Slide Puzzle",
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: mainColor),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Moves : $moves",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 60, vertical: 10)),
                onPressed: () {
                  setState(() {
                    numbers.shuffle();
                  });
                },
                child: Text(
                  "Again",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: GridView.builder(
                  itemBuilder: (context, index) {
                    print(numbers);

                    if (numbers[index] != 0) {
                      return GestureDetector(
                        onTap: () {
                          if (numbers == win) {
                            print("cccccccccccccc");
                          }
                          setState(() {
                            moves++;
                            int tempValue = numbers[index];
                            int zeroIndex = numbers.indexOf(0);
                            numbers[index] = 0;
                            numbers[zeroIndex] = tempValue;
                            if (numbers.toString() == win.toString()) {
                              print("xxxxxxxxxxxxxxxxx");
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Congrats"),
                                  content: Text("you did it!"),
                                ),
                              );
                            } else {
                              print("nnnnnnn $numbers");
                              print("ddd $win");
                            }
                            print(numbers);
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                              child: Text(
                            "${numbers[index]}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.white),
                          )),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                  itemCount: numbers.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
