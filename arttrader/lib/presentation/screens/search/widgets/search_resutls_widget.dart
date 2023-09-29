import '../../../../export.dart';

class SearchResutls extends StatelessWidget {
  const SearchResutls({
    super.key,
    required this.artList,
    required this.selectedArts,
    required this.isShrinkWrap,
  });

  final List<Art> artList;
  final List<Art> selectedArts;
  final bool isShrinkWrap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: isShrinkWrap,
        itemCount: artList.isEmpty ? artList.length : selectedArts.length,
        itemBuilder: (BuildContext context, int index) {
          selectedArts.isEmpty ? artList[index] : selectedArts[index];

          return Card(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Hero(
                    tag: selectedArts[index].id!,
                    child: CachedNetworkImage(
                      imageUrl: selectedArts[index].imageUrl!,
                      width: 50,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  title: Text(selectedArts[index].name!),
                  subtitle: Text(
                      '\$${selectedArts[index].price!.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    onPressed: () {
                      context
                          .read<ArtBloc>()
                          .add(GetSelectedArt(selectedArts[index].id!));
                      context
                          .read<AppBloc>()
                          .add(const AppPageChanged(AppStatus.details));
                    },
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
