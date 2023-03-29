import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:up_todo/screens/theme_mode_item.dart';
import 'package:up_todo/screens/widgets/select_lang.dart';
import 'package:up_todo/screens/widgets/setting_item.dart';
import 'package:up_todo/service/storage_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String accountName = "";

  @override
  void initState() {
    super.initState();
    accountName = StorageService.getString("accountName");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        children: [
          SettingItem(
            onSettingTap: showLanguageChange,
            settingIcon: Icons.settings,
            settingTitle: "Change language".tr(),
          ),
          SettingItem(
            onSettingTap: showChangeAccountName,
            settingIcon: Icons.person_outline,
            settingTitle: "Change account name".tr(),
          ),
          ThemeModeItem()
        ],
      ),
    );
  }

  showLanguageChange() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SelectLang(),
    );
  }

  showChangeAccountName() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Change name"),
        content: TextFormField(
          initialValue: accountName,
          onChanged: (val) {
            setState(() {
              accountName = val;
            });
          },
        ),
        actions: [
          TextButton(
              onPressed: () {
                StorageService.saveString("accountName", accountName);
                Navigator.pop(context);
              },
              child: Text("Save")),
        ],
      ),
    );
  }
}
