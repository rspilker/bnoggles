import 'package:flutter/material.dart';

class RadioSetting {
  static List<Widget> create(ValueNotifier<int> notifier, IconData icon) {
    return <Widget>[
      Icon(icon, size: 40.0),
      Container(),
      _LanguageOptions(notifier: notifier),
    ];
  }
}

class _LanguageOptions extends StatefulWidget {
  final ValueNotifier<int> notifier;
  _LanguageOptions({Key key, this.notifier}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LanguageOptionsState();
}

class _LanguageOptionsState extends State<_LanguageOptions> {
  void change(int option) {
    setState(() {
      widget.notifier.value = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> options = createRadio('nl', 0)..addAll(createRadio('en', 1));

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: options,
    );
  }

  List<Widget> createRadio(String country, int value) {
    return [
      Opacity(
        opacity: widget.notifier.value == value ? 1.0 : 0.3,
        child: Image.asset(
          'assets/' + country + '/flag.png',
          width: 50.0,
        ),
      ),
      Radio(
        value: value,
        onChanged: change,
        groupValue: widget.notifier.value,
      ),
    ];
  }
}