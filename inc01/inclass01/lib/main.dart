import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4, // Changed from 3 to 4
        child: _TabsNonScrollableDemo(),
      ),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 4, // Changed from 3 to 4
      vsync: this,
    );

    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabs Demo'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [for (final tab in tabs) Tab(text: tab)],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // TAB 1 - Alert Dialog
          Container(
            color: Colors.lightBlue.shade100,
            child: Center(
              child: ElevatedButton(
                child: const Text('Show Alert'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Alert'),
                      content: const Text('This is an AlertDialog from Tab 1.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // TAB 2 - Card Widget
          Container(
            color: Colors.green.shade100,
            child: Center(
              child: Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'This is a Card widget.',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ),

          // TAB 3 - SnackBar
          Container(
            color: Colors.orange.shade100,
            child: Center(
              child: ElevatedButton(
                child: const Text('Show SnackBar'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Hello from Tab 3!')),
                  );
                },
              ),
            ),
          ),

          // TAB 4 - ListView
          Container(
            color: Colors.purple.shade100,
            child: ListView(
              children: const [
                ListTile(leading: Icon(Icons.school), title: Text('MAD 4360')),
                ListTile(
                  leading: Icon(Icons.code),
                  title: Text('Flutter Development'),
                ),
                ListTile(
                  leading: Icon(Icons.book),
                  title: Text('Assignment 1'),
                ),
                ListTile(
                  leading: Icon(Icons.check_circle),
                  title: Text('Complete Lab'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
