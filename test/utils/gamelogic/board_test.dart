// Copyright (c) 2018, The Bnoggles Team.
// Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a MIT-style
// license that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:bnoggles/utils/gamelogic/board.dart';
import 'package:bnoggles/utils/gamelogic/coordinate.dart';

import 'package:bnoggles/utils/gamelogic/lettter_frequency.dart';

class MockRandomLetterGenerator extends Mock implements LetterGenerator {}

void main() {
  test('all characters', () {
    var rlg = MockRandomLetterGenerator();
    var letters = ['a', 'b', 'c', 'd'];

    when(rlg.next())
        .thenAnswer((s) => letters.removeAt(0));

    Board b = Board(2, rlg);

    var allChars = Set<String>();
    allChars.add(b.characterAt(Coordinate(0, 0)));
    allChars.add(b.characterAt(Coordinate(0, 1)));
    allChars.add(b.characterAt(Coordinate(1, 0)));
    allChars.add(b.characterAt(Coordinate(1, 1)));

    expect(allChars, Set.of(['a', 'b', 'c', 'd']));
  });

  test('mapNeighbours', () {
    var rlg = MockRandomLetterGenerator();
    when(rlg.next()).thenAnswer((s) => 'a');

    Board b = Board(3, rlg);
    var neighbours = b.mapNeighbours();

    void e(Coordinate actual, List<Coordinate> expected) {
      expect(neighbours[actual].toSet(), expected.toSet());
    }

    Coordinate c(int x, int y) => Coordinate(x, y);

    e(c(0, 0), [c(1, 0), c(0, 1), c(1, 1)]);
    e(c(1, 0), [c(0, 0), c(2, 0), c(0, 1), c(1, 1), c(2, 1)]);
    e(c(2, 0), [c(1, 0), c(1, 1), c(2, 1)]);

    e(c(0, 1), [c(0, 0), c(1, 0), c(1, 1), c(0, 2), c(1, 2)]);
    e(c(1, 1), [
      c(0, 0),
      c(1, 0),
      c(2, 0),
      c(0, 1),
      c(2, 1),
      c(0, 2),
      c(1, 2),
      c(2, 2)
    ]);
    e(c(2, 1), [c(1, 0), c(2, 0), c(1, 1), c(1, 2), c(2, 2)]);

    e(c(0, 2), [c(0, 1), c(1, 1), c(1, 2)]);
    e(c(1, 2), [c(0, 1), c(1, 1), c(2, 1), c(0, 2), c(2, 2)]);
    e(c(2, 2), [c(1, 1), c(2, 1), c(1, 2)]);
  });
}
