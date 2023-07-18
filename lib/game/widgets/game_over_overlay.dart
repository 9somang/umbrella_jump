// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../umbrella_jump.dart';
import 'widgets.dart';

// Overlay that pops up when the game ends
class GameOverOverlay extends StatefulWidget {
  const GameOverOverlay(this.game, {super.key});

  final Game game;

  @override
  State<GameOverOverlay> createState() => _GameOverOverlayState();
}

class _GameOverOverlayState extends State<GameOverOverlay> {
  CollectionReference ranks = FirebaseFirestore.instance.collection('ranks');

  @override
  Widget build(BuildContext context) {
    UmbrellaJump game = widget.game as UmbrellaJump;
    int score = game.gameManager.score.value;
    String name = game.gameManager.name;
    int level = game.levelManager.selectedLevel;
    Future<void> _resultcreate() async {
      await ranks.add({'name': name, 'score': score, 'level': level});
    }

    return Material(
      color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Game Over',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(),
              ),
              const WhiteSpace(height: 50),
              ScoreDisplay(
                game: game,
                isLight: true,
              ),
              const WhiteSpace(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async {
                  game.restartGame();
                  print(name);
                  print(score);
                  print(level);
                  _resultcreate();
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                    const Size(200, 75),
                  ),
                  textStyle: MaterialStateProperty.all(
                      Theme.of(context).textTheme.titleLarge),
                ),
                child: const Text('Reset game'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
