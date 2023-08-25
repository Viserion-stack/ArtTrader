import 'package:arttrader/export.dart';

class BidsPage extends StatelessWidget {
  const BidsPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: BidsPage());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            //controller: _tabController,
            tabs: [
              Tab(text: context.strings.myArts),
              Tab(text: context.strings.myBids),
              Tab(text: context.strings.mySaved),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MyArtsPage(),
            MyBidsPage(),
            MySavedPage(),
          ],
        ),
      ),
    );
  }
}

