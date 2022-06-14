import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  int playerOneScore = 0;
  int playerTwoScore = 1;
  bool isThinking=false;
  int touches=0;
  List<bool> _playerOne = [true, false, true, false, true, false, true, false, false];

  void touchedChangePlayer(){
    setState((){
      touches++;
      isThinking=_playerOne[touches];
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width;
    double height = MediaQuery. of(context). size. height;
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        Navigator.of(context).pop();
        return willLeave;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: height/8,
              left: width/2-20,
              child: Text(
                '$playerOneScore | $playerTwoScore',
                style: const TextStyle(
                  fontSize: 30,
                  color: Color(0xFFD4D4D4)
                ),
              )
            ),
            Align( //TODO: isolate widget
              alignment: Alignment.center,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    'assets/board.svg',
                    color: const Color(0xFFCDCDCD),     // has to change
                    semanticsLabel: 'User Icon',
                    width: width*0.6,
                  ),
                  Positioned(
                    child: SizedBox(
                      width: width*0.6,
                      height: width*0.6,
                      child: GridView.builder(
                        itemCount: 9,
                        itemBuilder: (BuildContext ctx, i){
                          return IconSelected(callback: () => touchedChangePlayer(), playerOne: _playerOne[touches]);
                        },
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 5.0, left: 5.0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                      ),
                    ),
                  )
                ],
              )
            ),
            Positioned(
              bottom: height/8,
              left: width/2-20,
              child: Visibility(
                visible: isThinking,
                child: const Text(
                  'Thinking...', //TODO: animate dots
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFD4D4D4)
                  ),
                )
              ),
            ),
          ],
        ),
      )
    );
  }
}

class IconSelected extends StatefulWidget {
  final Function callback;
  final bool playerOne;
  const IconSelected({Key? key, required this.callback, required this.playerOne}) : super(key: key);
  @override
  State<IconSelected> createState() => _IconSelected();
}

class _IconSelected extends State<IconSelected> {
  bool _touched=false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: (){
          setState((){
            if(!_touched){
              _touched=true;
              widget.callback();
            }
          });
        },
        child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: _touched ? 1.0 : 0.0,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SvgPicture.asset(
                widget.playerOne ? 'assets/circle.svg' : 'assets/cross.svg',
                width: 26,
                height: 26,
              ),
            )
        ),
      ),
    );
  }
}
