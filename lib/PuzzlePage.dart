import 'package:flutter/material.dart';
import 'package:puzzle/main.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({super.key});

  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  List numbers = [1, 2, 3, 4, 5, 6, 7, 8, 0];
  List win = [1, 2, 3, 4, 5, 6, 7, 8, 0];
  int moves = 0;
  final stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countUp);
  @override
  void initState() {
    numbers.shuffle();
    stopWatchTimer.onStartTimer();
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
            Text(
              "Moves : $moves",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SWatch(stopWatchTimer: stopWatchTimer),
                Icon(
                  Icons.alarm,
                  color: mainColor,
                )
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
                    moves = 0;
                    stopWatchTimer.onResetTimer();
                    stopWatchTimer.onStartTimer();
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
                          if (numbers == win) {}
                          setState(() {
                            moves++;
                            int tempValue = numbers[index];
                            int zeroIndex = numbers.indexOf(0);
                            numbers[index] = 0;
                            numbers[zeroIndex] = tempValue;
                            isWin(context);
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

  void isWin(BuildContext context) {
    if (numbers.toString() == win.toString()) {
      stopWatchTimer.onStopTimer();
      showPopupWindow(
        context,
        gravity: KumiPopupGravity.center,
        //curve: Curves.elasticOut,
        bgColor: Colors.grey.withOpacity(0.5),

        duration: Duration(milliseconds: 200),

        childFun: (pop) {
          return Container(
            key: GlobalKey(),
            padding: EdgeInsets.all(10),
            height: 100,
            width: 100,
            child: Image.asset("assets/images/accept.png"),
          );
        },
      );
    }
  }
}

class SWatch extends StatefulWidget {
  StopWatchTimer stopWatchTimer;
  SWatch({super.key, required this.stopWatchTimer});

  @override
  State<SWatch> createState() => _SWatchState();
}

class _SWatchState extends State<SWatch> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.stopWatchTimer.rawTime,
      initialData: 0,
      builder: (context, snapshot) {
        final value = snapshot.data;
        final displayTime = StopWatchTimer.getDisplayTime(value!);
        return Text(
          "${displayTime}",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: mainColor),
        );
      },
    );
  }
}
