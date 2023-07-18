// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:doodle_dash/rank.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../umbrella_jump.dart';

// Overlay that appears for the main menu
class MainMenuOverlay extends StatefulWidget {
  MainMenuOverlay(this.game, {super.key});

  final Game game;

  @override
  State<MainMenuOverlay> createState() => _MainMenuOverlayState();
}

class _MainMenuOverlayState extends State<MainMenuOverlay> {
  Character character = Character.minsub;

  @override
  Widget build(BuildContext context) {
    UmbrellaJump game = widget.game as UmbrellaJump;

    return LayoutBuilder(builder: (context, constraints) {
      final characterWidth = constraints.maxWidth / 10;

      final TextStyle titleStyle = (constraints.maxWidth > 830)
          ? Theme.of(context).textTheme.displayLarge!
          : Theme.of(context).textTheme.displaySmall!;

      // 760 is the smallest height the browser can have until the
      // layout is too large to fit.
      final bool screenHeightIsSmall = constraints.maxHeight < 760;

      return Material(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    width: 250,
                    height: 250,
                    image: AssetImage(
                      'assets/images/game/umbrellajump.png',
                    ),
                  ),
                  WhiteSpace(height: 30),
                  Text(
                    'Umbrella Jump',
                    style: titleStyle.copyWith(
                      height: .8,
                      fontSize: 65,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '꿈을 향해 끊임없이 올라갈 멤버를 선택해주세요.\n(옆으로 스크롤 가능)',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (!screenHeightIsSmall) const WhiteSpace(height: 30),
                  WhiteSpace(height: 30),
                  Container(
                    height: 160,
                    child: ScrollConfiguration(
                      behavior: MyCustomScrollBehavior(),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Row(
                            children: [
                              CharacterButton(
                                character: Character.minsub,
                                selected: character == Character.minsub,
                                onSelectChar: () {
                                  setState(() {
                                    character = Character.minsub;
                                  });
                                },
                                characterWidth: characterWidth,
                              ),
                              const SizedBox(width: 10),
                              CharacterButton(
                                character: Character.hyojung,
                                selected: character == Character.hyojung,
                                onSelectChar: () {
                                  setState(() {
                                    character = Character.hyojung;
                                  });
                                },
                                characterWidth: characterWidth,
                              ),
                              const SizedBox(width: 10),
                              CharacterButton(
                                character: Character.minjae,
                                selected: character == Character.minjae,
                                onSelectChar: () {
                                  setState(() {
                                    character = Character.minjae;
                                  });
                                },
                                characterWidth: characterWidth,
                              ),
                              const SizedBox(width: 10),
                              CharacterButton(
                                character: Character.somang,
                                selected: character == Character.somang,
                                onSelectChar: () {
                                  setState(() {
                                    character = Character.somang;
                                  });
                                },
                                characterWidth: characterWidth,
                              ),
                              const SizedBox(width: 10),
                              CharacterButton(
                                character: Character.hyunsik,
                                selected: character == Character.hyunsik,
                                onSelectChar: () {
                                  setState(() {
                                    character = Character.hyunsik;
                                  });
                                },
                                characterWidth: characterWidth,
                              ),
                              const SizedBox(width: 10),
                              CharacterButton(
                                character: Character.junsub,
                                selected: character == Character.junsub,
                                onSelectChar: () {
                                  setState(() {
                                    character = Character.junsub;
                                  });
                                },
                                characterWidth: characterWidth,
                              ),
                              const SizedBox(width: 10),
                              CharacterButton(
                                character: Character.doyun,
                                selected: character == Character.doyun,
                                onSelectChar: () {
                                  setState(() {
                                    character = Character.doyun;
                                  });
                                },
                                characterWidth: characterWidth,
                              ),
                              const SizedBox(width: 10),
                              CharacterButton(
                                character: Character.hyesung,
                                selected: character == Character.hyesung,
                                onSelectChar: () {
                                  setState(() {
                                    character = Character.hyesung;
                                  });
                                },
                                characterWidth: characterWidth,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (!screenHeightIsSmall) const WhiteSpace(height: 50),
                  const WhiteSpace(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('난이도 :',
                          style: Theme.of(context).textTheme.bodyLarge!),
                      LevelPicker(
                        level: game.levelManager.selectedLevel.toDouble(),
                        label: game.levelManager.selectedLevel.toString(),
                        onChanged: ((value) {
                          setState(() {
                            game.levelManager.selectLevel(value.toInt());
                          });
                        }),
                      ),
                    ],
                  ),
                  if (!screenHeightIsSmall) const WhiteSpace(height: 50),
                  const WhiteSpace(height: 20),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // TextEditingController
                        ElevatedButton(
                          onPressed: () async {
                            game.gameManager.selectCharacter(character);

                            game.startGame();
                            print('start game');
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                              const Size(100, 70),
                            ),
                            textStyle: MaterialStateProperty.all(
                                Theme.of(context).textTheme.titleLarge),
                          ),
                          child: const Text(
                            'Start',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RankOverlay(game),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(
                              const Size(100, 70),
                            ),
                            textStyle: MaterialStateProperty.all(
                                Theme.of(context).textTheme.titleLarge),
                          ),
                          child: Text(
                            'Rank',
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class LevelPicker extends StatelessWidget {
  const LevelPicker({
    super.key,
    required this.level,
    required this.label,
    required this.onChanged,
  });

  final double level;
  final String label;
  final void Function(double) onChanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Slider(
      value: level,
      max: 5,
      min: 1,
      divisions: 4,
      label: label,
      onChanged: onChanged,
    ));
  }
}

class CharacterButton extends StatelessWidget {
  const CharacterButton(
      {super.key,
      required this.character,
      this.selected = false,
      required this.onSelectChar,
      required this.characterWidth});

  final Character character;
  final bool selected;
  final void Function() onSelectChar;
  final double characterWidth;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: (selected)
          ? ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Color.fromARGB(129, 64, 195, 255)))
          : null,
      onPressed: onSelectChar,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/game/${character.name}.png',
              height: characterWidth,
              width: characterWidth,
            ),
            const WhiteSpace(height: 4),
            Text(
              character.name,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class WhiteSpace extends StatelessWidget {
  const WhiteSpace({super.key, this.height = 100});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
