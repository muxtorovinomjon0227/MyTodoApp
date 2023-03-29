import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_todo/service/storage_service.dart';
import 'package:up_todo/theme_provider.dart';

class ThemeModeItem extends StatefulWidget {
  const ThemeModeItem({Key? key}) : super(key: key);

  @override
  State<ThemeModeItem> createState() => _ThemeModeItemState();
}

class _ThemeModeItemState extends State<ThemeModeItem> {
  bool isLight = StorageService.getBool("isLight");

  @override
  Widget build(BuildContext context) {
    var themeChanger = Provider.of<ThemeProvider>(context);

    return InkWell(
      onTap: () {},
      child: Container(
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.light_mode),
                SizedBox(width: 10),
                Text("Ligth mode"),
              ],
            ),
            Switch(
              value: isLight,
              onChanged: (val) {
                setState(() {
                  isLight = !isLight;
                });
                themeChanger.setIsLight(isLight);
              },
            )
          ],
        ),
      ),
    );
  }
}
