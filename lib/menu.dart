import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'game.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  Color _color = Colors.white;
  Color _color1 = Colors.white;
  Color _userIconColor0 = const Color(0xFFCCCCCC);
  Color _userIconColor1 = const Color(0xFFCCCCCC);
  bool _visible0 = false;
  bool _visible1 = false;

  _navigateToHome()async{
    await Future.delayed(const Duration(milliseconds: 800));
    initializeVar();
    _openMyPage();
  }

  void _openMyPage() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => const Game(),
        transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 10),
        reverseTransitionDuration: const Duration(milliseconds: 10),
      ),
    );
  }

  initializeVar(){
    setState((){
      _visible0 = false;
      _visible1 = false;
      _color = Colors.white;
      _color1 = Colors.white;
      _userIconColor0 = const Color(0xFFCCCCCC);
      _userIconColor1 = const Color(0xFFCCCCCC);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery. of(context). size. width;
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                setState((){
                  _visible0 = true;
                  _color = const Color(0xFFF8A426);
                  _userIconColor0 = Colors.white;
                });
                _navigateToHome();
              },
              child: RepaintBoundary(
                child: AnimatedContainer(
                  height: 70,
                  width: width*0.8,
                  decoration: BoxDecoration(
                    color: _color,  //        // has to change
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x29000000),
                        blurRadius: 10,
                        offset: Offset(0, 0), // Shadow position
                      ),
                    ],
                  ),
                  duration: const Duration(milliseconds: 500),
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        key: const Key("one_player"),
                        left: _visible0 ? width*0.8/4-25 : width*0.8/2-13,
                        top: 70/2-13,
                        duration: _visible0 ? const Duration(milliseconds: 900) : const Duration(milliseconds: 400),
                        curve: _visible0 ? Curves.bounceOut : Curves.linear,
                        child: SvgPicture.asset(
                          'assets/user.svg',
                          color: _userIconColor0,     // has to change
                          semanticsLabel: 'User Icon',
                          width: 26,
                          height: 26,
                        ),
                      ),        // has to change
                      Positioned(
                        left: 150-45,
                        top: 70/2-10,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: _visible0 ? 1.0 : 0.0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Container(
                              key: const Key("loading"),
                              child: const Text(
                                'One player',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white
                                ),
                              )
                            ),
                          )
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: GestureDetector(
                onTap: (){
                  setState((){
                    _visible1 = true;
                    _color1 = const Color(0xFFF8A426);
                    _userIconColor1 = Colors.white;
                  });
                  _navigateToHome();
                },
                child: RepaintBoundary(
                  child: AnimatedContainer(
                    height: 70,
                    width: width*0.8,
                    decoration: BoxDecoration(
                      color: _color1,  //        // has to change
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x29000000),
                          blurRadius: 10,
                          offset: Offset(0, 0), // Shadow position
                        ),
                      ],
                    ),
                    duration: const Duration(milliseconds: 500),
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          key: const Key("two_players0"),
                          left: _visible1 ?  width*0.8/4-25 :  width*0.8/2-35,
                          top: 70/2-13,
                          duration: _visible1 ? const Duration(milliseconds: 900) : const Duration(milliseconds: 400),
                          curve: _visible1 ? Curves.bounceOut : Curves.linear,
                          child: SvgPicture.asset(
                            'assets/user.svg',
                            color: _userIconColor1,     // has to change
                            semanticsLabel: 'User Icon',
                            width: 26,
                            height: 26,
                          ),
                        ),        // has to change
                        Positioned(
                          left: 150-50,
                          top: 70/2-10,
                          child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: _visible1 ? 1.0 : 0.0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Container(
                                    key: const Key("loading"),
                                    child: const Text(
                                      'Two players',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white
                                      ),
                                    )
                                ),
                              )
                          ),
                        ),
                        AnimatedPositioned(
                          key: const Key("two_players1"),
                          right: _visible1 ? width*0.8/4-25 :  width*0.8/2-35,
                          top: 70/2-13,
                          duration: _visible1 ? const Duration(milliseconds: 900) : const Duration(milliseconds: 400),
                          curve: _visible1 ? Curves.bounceOut : Curves.linear,
                          child: SvgPicture.asset(
                            'assets/user.svg',
                            color: _userIconColor1,     // has to change
                            semanticsLabel: 'User Icon',
                            width: 26,
                            height: 26,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
