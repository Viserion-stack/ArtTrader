import 'package:arttrader/export.dart';

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
                    leading: CachedNetworkImage(
                      imageUrl: state.myCollection![index].imageUrl!,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                        color: Colors.transparent,
                      ),
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 50,
                        backgroundImage: imageProvider,
                      ),
                    ),
                    title: Text(state.myCollection![index].name.toString()),
                    trailing: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text('${state.myCollection![index].price} \$'),
                    ),
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
          leading: CachedNetworkImage(
            imageUrl: myBidList[index].imageUrl!,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            placeholder: (context, url) => const CircularProgressIndicator(
              color: Colors.transparent,
            ),
            imageBuilder: (context, imageProvider) => CircleAvatar(
              radius: 50,
              backgroundImage: imageProvider,
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

class MySavedPage extends StatefulWidget {
  const MySavedPage({super.key});

  @override
  State<MySavedPage> createState() => _MySavedPageState();
}

class _MySavedPageState extends State<MySavedPage> {
  List<String> _savedListIds = [];
  List<Art> _savedList = [];

  void getMatchedArts(List<String> idList) {
    List<Art> matchedArts = [];
    var artList = context.read<ArtBloc>().state.artCollection!;

    for (Art art in artList) {
      if (idList.contains(art.id)) {
        matchedArts.add(art);
      }
    }
    _savedList = matchedArts;
  }

  Future<void> _getSavedList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _savedListIds = prefs.getStringList('userSavedList') ?? [];
    getMatchedArts(_savedListIds);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getSavedList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong while loading saved list'),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text('Something went wrong wile loading saved list'),
            );
          }
          return ListView.separated(
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: _savedList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CachedNetworkImage(
                  imageUrl: _savedList[index].imageUrl!,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(
                    color: Colors.transparent,
                  ),
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 50,
                    backgroundImage: imageProvider,
                  ),
                ),
                title: Text(_savedList[index].name.toString()),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Text('${_savedList[index].price} \$'),
                ),
                contentPadding: const EdgeInsets.all(4),
              );
            },
          );
        });
  }
}
