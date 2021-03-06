// Copyright (c) 2018, The Bnoggles Team.
// Please see the AUTHORS file for details.
// All rights reserved. Use of this source code is governed by a MIT-style
// license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class ToggleSetting {
  static List<Widget> create(ValueNotifier<bool> notifier, IconData icon) =>
      <Widget>[
        Icon(icon, size: 40.0),
        Container(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Switch(
              value: notifier.value,
              onChanged: (bool value) => notifier.value = value,
            ),
          ],
        ),
      ];
}
