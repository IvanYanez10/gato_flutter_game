import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'elementModel.dart';
import 'element.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);
  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {

  int playerOneScore = 0;
  int playerTwoScore = 1;
  List<ElementModel> elements=[];
  bool isThinking=false;
  int touches=0;

  void touchedChangePlayer(int i){
    setState((){
      elements[i] = ElementModel(
        id: touches,
        player: touches%2==0 ? 'player_one' : 'player_two',
        position: i
      );
      touches++;
      isThinking=!isThinking;
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
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 5.0, left: 5.0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                        itemBuilder: (BuildContext ctx, i){
                          if(elements.isEmpty){
                            elements.insert(i, ElementModel(
                              position: i,
                            ));
                          }
                          if(elements.length < i+1){
                            elements.insert(i, ElementModel(
                              position: i,
                            ));
                          }
                          return GridElement(
                            callback:() => touchedChangePlayer(i),
                            elementData: elements[i]
                          );
                        },
                      ),
                    ),
                  )
                ],
              )
            ),
            Positioned( //TODO: notification widget isolated
              bottom: height/8,
              left: width/2-25,
              child: Visibility(
                visible: true,  ///TODO: when its visible isThinking
                child: Text(
                  touches%2==0 ? '' : 'thinking...', //TODO: animate dots
                  style: const TextStyle(
                      fontSize: 18,
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
class OnePlayer{
  /// user vs algorithm
  /// notification: your turn?
  /// start random icon
  /// space model: touched, icon, step, player
  /// game over when someone wins or no more white spaces
}

class TwoPlayers{
  /// user vs user
  /// notification: your turn?
  /// start random icon
  /// space model: touched, icon, step, player
  /// who wins: notification player or symbol name - display line gray showing the winner path
  /// game over when someone wins or no more white spaces
}
