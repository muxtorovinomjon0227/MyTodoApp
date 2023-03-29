import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  IconData settingIcon;
  String settingTitle;
  VoidCallback onSettingTap;

  SettingItem(
      {Key? key,
      required this.settingIcon,
      required this.settingTitle,
      required this.onSettingTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSettingTap,
      child: Container(
        height: 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(settingIcon),
                SizedBox(width: 10),
                Text(settingTitle),
              ],
            ),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
