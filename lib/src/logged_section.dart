import 'package:flutter/material.dart';
import 'package:gtk_flutter/src/news.dart';

class LoggedPage extends StatefulWidget {
  const LoggedPage(
  );

  @override
  _LoggedPageState createState() => _LoggedPageState();
}

class _LoggedPageState extends State<LoggedPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AddNewNew(),
        News()
      ],
    );
  }
}
