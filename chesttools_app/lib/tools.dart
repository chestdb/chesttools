import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data.dart';
import 'overview.dart';
import 'performance.dart';
import 'storage.dart';

class ToolsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: CustomAppBar(),
        body: TabBarView(
          children: <Widget>[
            DataPage(),
            PerformancePage(),
            StoragePage(),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      child: Row(
        children: [
          SizedBox(width: 16),
          Text(
            'Chest',
            style: GoogleFonts.rajdhani(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Spacer(),
          TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            labelColor: Colors.black,
            tabs: <Widget>[
              Tab(text: 'Data'),
              Tab(text: 'Performance'),
              Tab(text: 'Storage'),
            ],
          ),
          Spacer(),
          IconButton(
            onPressed: () => print('Help'),
            icon: Icon(Icons.info_outline),
          ),
          IconButton(
            onPressed: () => print('Settings'),
            icon: Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () => print('Help'),
            icon: Icon(Icons.help_outline),
          ),
          SizedBox(width: 16),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
