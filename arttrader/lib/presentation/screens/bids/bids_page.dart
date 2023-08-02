import 'package:arttrader/export.dart';

class BidsPage extends StatelessWidget {
  const BidsPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: BidsPage());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            //controller: _tabController,
            tabs: [
              Tab(text: context.strings.myArts),
              Tab(text: context.strings.myBids),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MyArtsPage(),
            MyBidsPage(),
          ],
        ),
      ),
    );
  }
}

class MyArtsPage extends StatelessWidget {
  const MyArtsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtBloc, ArtState>(
      builder: (context, state) {
        return state.status == ArtStatus.loading
            ? const Center(child: CircularProgressIndicator.adaptive())
            : ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: state.myCollection!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        state.myCollection![index].imageUrl!,
                      ),
                    ),
                    title: Text(state.myCollection![index].name.toString()),
                    trailing: Text('${state.myCollection![index].price} \$'),
                    contentPadding: const EdgeInsets.all(4),
                  );
                },
                // child: Center(
                //   child: Text('${myBidList.length}'),
                // ),
              );
      },
    );
  }
}

class MyBidsPage extends StatelessWidget {
  const MyBidsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Art> myBidList = context.read<ArtBloc>().state.bidsCollection!;
    debugPrint(myBidList.length.toString());
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: myBidList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              myBidList[index].imageUrl!,
            ),
          ),
          title: Text(myBidList[index].name.toString()),
          trailing: Text('${myBidList[index].price} \$'),
          contentPadding: const EdgeInsets.all(4),
        );
      },
      // child: Center(
      //   child: Text('${myBidList.length}'),
      // ),
    );
  }
}
