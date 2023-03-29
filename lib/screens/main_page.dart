import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:up_todo/screens/home_page.dart';
import 'package:up_todo/screens/profile_page.dart';
import 'package:up_todo/screens/widgets/add_task_widget.dart';
import 'package:up_todo/theme_provider.dart';
import 'package:up_todo/utils/colors.dart';
import 'package:up_todo/utils/images.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<String> titles = [
      "HomePage".tr(),
      "Calendar".tr(),
      "Add Screen".tr(),
      "Focus".tr(),
      "Profile".tr(),
    ];

    final List<Widget> pages = [
      HomePage(),
      Container(),
      Container(),
      Container(),
      ProfilePage(),
    ];

    Future<bool> _onWillPop() async {
      if (_selectedIndex != 0) {
        setState(() {
          _selectedIndex = 0;
        });
        return false;
      }

      return (await showDialog(
            context: context,
            builder: (context) => new AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit an App'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    }

    var isLight = context.watch<ThemeProvider>().getIsLight();

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: pages[_selectedIndex],
        backgroundColor: isLight ? Colors.white : Colors.black,
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.all(24),
                      height: 350,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        color: AppColors.C_363636,
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(AppImages.ic_fingerprint),
                          SizedBox(height: 12),
                          Text(
                            "Please hold your finger at "
                            "the fingerprint scanner to verify your identity",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.87),
                                fontSize: 20),
                          ),
                          SizedBox(height: 48),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(150, 48),
                                  primary: AppColors.C_363636,
                                  shadowColor: null,
                                  elevation: 0,
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontSize: 16, color: AppColors.C_8875FF),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(150, 48),
                                  primary: AppColors.C_8687E7,
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "Use Password",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            },
            icon: SvgPicture.asset(AppImages.ic_menu),
          ),
          backgroundColor: Colors.black,
          title: Text(titles[_selectedIndex]),
          actions: [
            SizedBox(width: 12),
          ],
        ),
        floatingActionButton: Stack(children: [
          Positioned(
            bottom: 34,
            left: 155.9,
            child: Container(
              width: 90,
              height: 45.5,
              decoration: const BoxDecoration(
                  color: Color(0xff121212),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(76, 80),
                      bottomRight: Radius.elliptical(76, 80))),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 165,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: AppColors.C_363636,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: AddTaskWidget(
                          onNewTask: () {
                            setState(() {
                              _selectedIndex = 0;
                            });
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.C_8687E7,
                  ),
                  child: Center(
                    child: Text(
                      "+",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  )),
            ),
          ),
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: SizedBox(
          height: 80,
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            iconSize: 28,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(0.50),
            backgroundColor: AppColors.C_363636,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Index',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(null),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.watch_later_outlined),
                label: 'Focus',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
