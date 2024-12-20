import 'package:flutter/material.dart';
import 'package:quan_ly_ci_co/gen/assets.gen.dart';
import 'package:quan_ly_ci_co/presentation/navigation/app_navigation.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key, required this.child});
  final Widget child;
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  static const List<String> _navigationPath = [
    'user',
    'logger',
    'bangcong'
  ];

  void _onItemTapped(int index) {
    NavigationApp.routeTo(context, _navigationPath[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Row(
        children: [
          Drawer(
            child: Container(
              decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.grey[300]!))),
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const SizedBox(height: 24),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Assets.svg.logo.svg(width: 120, height: 24))),
                  const SizedBox(height: 24),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('User'),
                    onTap: () => _onItemTapped(0),
                  ),
                  ListTile(
                    leading: Icon(Icons.list),
                    title: Text('Logger'),
                    onTap: () => _onItemTapped(1),
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_month_rounded),
                    title: Text('Bang Cong'),
                    onTap: () => _onItemTapped(2),
                  ),
                ],
              ),
            ),
          ),
          Expanded(child: Center(child: widget.child)),
        ],
      ),
    );
  }
}
