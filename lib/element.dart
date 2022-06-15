import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'elementModel.dart';

class GridElement extends StatefulWidget {
  final ElementModel elementData;
  final Function callback;
  const GridElement({Key? key, required this.callback, required this.elementData}) : super(key: key);
  @override
  State<GridElement> createState() => _GridElementState();
}

class _GridElementState extends State<GridElement> {
  Map icons = {
    'player_one': 'assets/circle.svg',
    'player_two': 'assets/cross.svg'
  };

  bool touched=false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 26,
        height: 26,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            if(!touched){
              setState((){
                touched=true;
                widget.callback();
              });
            }
          },
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: touched ? 1.0 : 0.0,
            child: SvgPicture.asset(
              widget.elementData.player.isEmpty ? 'assets/dash.svg' : icons[widget.elementData.player],
              width: 26,
              height: 26,
            ),
          ),
        ),
      ),
    );
  }
}
