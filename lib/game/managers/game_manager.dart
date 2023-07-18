// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../umbrella_jump.dart';

// It won't be a detailed section of the codelab, as its not Flame specific
class GameManager extends Component with HasGameRef<UmbrellaJump> {
  GameManager();

  String name = '익명';
  Character character = Character.minsub;
  ValueNotifier<int> score = ValueNotifier(0);
  GameState state = GameState.ready;

  bool get isPlaying => state == GameState.playing;
  bool get isGameOver => state == GameState.gameOver;
  bool get isIntro => state == GameState.intro;
  bool get isReady => state == GameState.ready;

  void reset() {
    score.value = 0;
    state = GameState.ready;
  }

  void increaseScore() {
    score.value++;
  }

  void selectCharacter(Character selectedCharacter) {
    character = selectedCharacter;
  }

  void insertedName(String insertedname) {
    name = insertedname;
  }
}

enum GameState { intro, playing, gameOver, ready }
