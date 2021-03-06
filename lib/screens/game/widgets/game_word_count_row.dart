// Copyright (c) 2018, The Bnoggles Team.
// Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a MIT-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:bnoggles/screens/game/widgets/provider.dart';

import 'package:bnoggles/utils/gamelogic/solution.dart';

const int _maxLength = 8;

class WordCountOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Solution solution = Provider.of(context).solution;

    return GridView.builder(
      itemCount: ((_maxLength - 1) * 2),
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (_maxLength - 1),
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration:
              new BoxDecoration(border: new Border.all(color: Colors.black)),
          child: fromIndex(index, solution),
        );
      },
    );
  }

  Widget fromIndex(int index, Solution solution) {
    int rowSize = (_maxLength - 1);
    int lastIndexRow1 = rowSize - 1;

    int length = (index % (_maxLength - 1)) + 2;

    if (index <= lastIndexRow1) {
      String text = length.toString();
      if (length == _maxLength) {
        text = ">= " + text;
      }
      return NumberInfo(text);
    }
    if (length < solution.minimalLength) {
      return NoNumberInfo();
    }
    return UserAnswerNumberInfo(length);
  }
}

class NumberInfo extends StatelessWidget {
  final String number;
  NumberInfo(this.number);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Center(
        child: Text(
          number,
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}

class NoNumberInfo extends StatelessWidget {
  NoNumberInfo();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Center(child: Text('x', style: TextStyle(color: Colors.white70))),
    );
  }
}

class UserAnswerNumberInfo extends StatelessWidget {
  final int length;

  UserAnswerNumberInfo(this.length);

  @override
  Widget build(BuildContext context) {
    var gameInfo = Provider.of(context);
    Solution solution = gameInfo.solution;
    Answer answer = gameInfo.userAnswer.value;

    var todo = solution.histogram - answer.histogram;
    int remaining = length == _maxLength ? todo.atLeast(length) : todo[length];

    return Container(
      color: Colors.blue,
      child: Center(
        child: Text(
          remaining.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
