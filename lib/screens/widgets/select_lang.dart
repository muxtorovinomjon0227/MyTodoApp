import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SelectLang extends StatefulWidget {
  const SelectLang({Key? key}) : super(key: key);

  @override
  State<SelectLang> createState() => _SelectLangState();
}

class _SelectLangState extends State<SelectLang> {
  int selectedLang = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          RadioListTile(
            title: Text("Uzbek"),
            value: 0,
            groupValue: selectedLang,
            onChanged: (value) {
              setState(() {
                selectedLang = value as int;
                context.setLocale(Locale('uz','UZ'));
              });
            },
          ),
          RadioListTile(
            title: Text("English"),
            value: 1,
            groupValue: selectedLang,
            onChanged: (value) {
              setState(() {
                selectedLang = value as int;
                context.setLocale(Locale('en','US'));
              });
            },
          ),
          RadioListTile(
            title: Text("Russian"),
            value: 2,
            groupValue: selectedLang,
            onChanged: (value) {
              setState(() {
                selectedLang = value as int;
                context.setLocale(Locale('ru','RU'));
              });
            },
          ),
        ],
      ),
    );
  }
}
