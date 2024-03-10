import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var count = 0;
  var isTapped = true;
  var xTurn = true;
  var signArr = ['', '', '', '', '', '', '', '', ''];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('X'),
                SizedBox(width: 10),
                Text('Tic Tac Toe'),
                SizedBox(width: 10),
                Text('O')
              ],
            )),
        backgroundColor: Color.fromARGB(165, 119, 12, 138),
      ),
      backgroundColor: Color.fromARGB(255, 242, 220, 246),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Let\'s Start !',
            style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 119, 16, 137)),
          ),
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'Player1: X',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: xTurn ? FontWeight.bold : FontWeight.normal),
              ),
              SizedBox(height: 10),
              Text(
                'Player2: O',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: !xTurn ? FontWeight.bold : FontWeight.normal),
              ),
              SizedBox(height: 25),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: double.infinity,
              height: 353,
              color: Color.fromARGB(190, 167, 56, 187),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: GridView.builder(
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        count++;
                        tapped(index);
                      },
                      // onLongPress: () {   //change choice!
                      //   setState(() {
                      //     signArr[index] = '';
                      //   });
                      //   xTurn = !xTurn;
                      // },
                      child: Container(
                        color: Color.fromARGB(255, 242, 220, 246),
                        child: Center(
                          child: Text(
                            signArr[index],
                            style:
                                TextStyle(fontSize: 53, color: Colors.purple),
                          ),
                        ),
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 7,
                    mainAxisSpacing: 7,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          OutlinedButton(
            // style: ButtonStyle(side: ),
            onPressed: () {
              reset();
            },
            child: Text(
              'Reste',
              style: TextStyle(
                  fontSize: count == 0 ? 15 : 17,
                  color: count == 0 ? Colors.grey : Colors.purple),
            ),
            style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(Size(130, 40))),
          ),
          // ElevatedButton(
          //   onPressed: checkWinner,
          //   child: Text('Check'),
          // ),
        ],
      ),
    );
  }

  void tapped(int index) {
    setState(
      //State will be changed whenever tapped
      () {
        if (xTurn && signArr[index] == '') {
          signArr[index] = 'X';
          if (count >= 5) {
            checkWinner();
          }
        } else if (!xTurn && signArr[index] == '') {
          signArr[index] = 'O';
          if (count >= 5) {
            checkWinner();
          }
        }
      },
    );

    xTurn = !xTurn; //Updating turn each time
  }

  void reset() {
    for (int i = 0; i < signArr.length; i++) {
      signArr[i] = '';
    }
    count = 0;
    xTurn = true;
    setState(() {});
  }

  Future<void> showWinner(String win) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Container(
            child: AlertDialog(
              backgroundColor: Color.fromARGB(255, 247, 229, 251),
              title: Text('Congratulation!!!'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Winner :  $win',
                    style: TextStyle(fontSize: 22),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' Replay',
                        style: TextStyle(fontSize: 14),
                      ),
                      IconButton(
                        onPressed: () {
                          reset();
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.restart_alt_rounded),
                        color: Colors.purple,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> showTie() async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Container(
            child: AlertDialog(
              backgroundColor: Color.fromARGB(255, 247, 229, 251),
              title: Text('So Close!!!'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'It\'s A Draw',
                    style: TextStyle(fontSize: 22),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' Replay',
                        style: TextStyle(fontSize: 14),
                      ),
                      IconButton(
                        onPressed: () {
                          reset();
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.restart_alt_rounded),
                        color: Colors.purple,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  void checkWinner() {
    //if Tie
    if (count == 9) {
      showTie();
      return;
    }
    int i = 0;
    int j = 0;
    //for diags
    if (signArr[0] == signArr[4] && signArr[4] == signArr[8]) {
      if (signArr[0] == 'X') {
        showWinner('X');
        print('winner X');
      } else {
        showWinner('O');
        print('winner O');
      }
      return;
    }
    if (signArr[2] == signArr[4] && signArr[4] == signArr[6]) {
      if (signArr[2] == 'X') {
        print('winner X');
        showWinner('X');
      } else {
        print('winner O');
        showWinner('O');
      }
      return;
    }
    //for Columns
    while (j < 3) {
      if (signArr[j] != '' &&
          signArr[j] == signArr[j + 3] &&
          signArr[j] == signArr[j + 6]) {
        if (signArr[j] == 'X') {
          print('Winner X, c=$j');
          showWinner('X');
        } else {
          print('Winner O, c=$j');
          showWinner('O');
        }
        break;
      } else {
        j++;
      }
    }
    //for Rows
    if (j == 3)
      while (i < 9) {
        if (signArr[i] != '' &&
            signArr[i] == signArr[i + 1] &&
            signArr[i + 1] == signArr[i + 2]) {
          if (signArr[i] == 'X') {
            print('Winner X, r=$i');
            showWinner('X');
          } else {
            print('Winner O, r=$i');
            showWinner('O');
          }
          break;
        } else {
          i = i + 3;
        }
      }
  }
}
