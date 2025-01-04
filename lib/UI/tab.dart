import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Status_page extends StatefulWidget {
  const Status_page({Key? key}) : super(key: key);

  @override
  State<Status_page> createState() => _Status_pageState();
}

class _Status_pageState extends State<Status_page>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: TabBar(controller: _tabController, tabs: [
                    Tab(
                      text: 'Status',
                    ),
                    Tab(
                      text: 'Inspection',
                    ),
                  ]),
                ),
              ),
            ]),
            Flexible(
              child: TabBarView(controller: _tabController, children: [
                Container(child: Text('ini')),
                Container(child: Text('ini')),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
