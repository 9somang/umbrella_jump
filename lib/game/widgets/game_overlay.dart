// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flame/game.dart';

import 'package:flutter/material.dart';

import '../umbrella_jump.dart';
import 'widgets.dart';

class GameOverlay extends StatefulWidget {
  const GameOverlay(this.game, {super.key});

  final Game game;

  @override
  State<GameOverlay> createState() => GameOverlayState();
}

class GameOverlayState extends State<GameOverlay> {
  bool isPaused = false;

  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              top: 30,
              left: 30,
              child: ScoreDisplay(game: widget.game),
            ),
            Positioned(
              top: 30,
              right: 30,
              child: ElevatedButton(
                child: isPaused
                    ? const Icon(
                        Icons.play_arrow,
                        size: 36,
                      )
                    : const Icon(
                        Icons.pause,
                        size: 36,
                      ),
                onPressed: () {
                  print('${MediaQuery.of(context).size.width}');
                  (widget.game as UmbrellaJump).togglePauseState();
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Column(
                          children: <Widget>[
                            Text('일시중지'),
                          ],
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('확인 버튼을 누르는 즉시\n 이어서 플레이합니다.'),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              (widget.game as UmbrellaJump).togglePauseState();
                              Navigator.pop(context);
                            },
                            child: Text('확인'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 8,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: GestureDetector(
                        onTapDown: (details) {
                          (widget.game as UmbrellaJump).player.moveLeft();
                        },
                        onTapUp: (details) {
                          (widget.game as UmbrellaJump).player.resetDirection();
                        },
                        child: Material(
                          color: Colors.transparent,
                          elevation: 3.0,
                          shadowColor: Theme.of(context).colorScheme.background,
                          child: const Icon(Icons.arrow_left, size: 84),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: GestureDetector(
                        onTapDown: (details) {
                          (widget.game as UmbrellaJump).player.moveRight();
                        },
                        onTapUp: (details) {
                          (widget.game as UmbrellaJump).player.resetDirection();
                        },
                        child: Material(
                          color: Colors.transparent,
                          elevation: 3.0,
                          shadowColor: Theme.of(context).colorScheme.background,
                          child: const Icon(Icons.arrow_right, size: 84),
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
}
