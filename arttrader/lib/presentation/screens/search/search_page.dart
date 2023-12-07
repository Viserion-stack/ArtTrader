import 'package:arttrader/export.dart';

import 'widgets/search_resutls_widget.dart';

//TODO need to be done with more efficient way
SearchController controller = SearchController();

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: SearchPage());

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<Art> artList;
  late List<Art> selectedArts = [];
  late List<String> searcHistory = [];

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //final user = context.select((AppBloc bloc) => bloc.state.user);
    searchController.addListener(queryListener);
    controller.addListener(searchListener);
  }

  @override
  void dispose() {
    searchController.removeListener(queryListener);
    searchController.dispose();
    controller.removeListener(searchListener);
    //controller.dispose();

    super.dispose();
  }

  void queryListener() {
    search(searchController.text);
  }

  void searchListener() {
    search(controller.text);
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        //selectedArts = artList;
        selectedArts = [];
      });
    } else {
      setState(() {
        selectedArts = artList
            .where((e) => e.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    artList = context.select((ArtBloc artBloc) => artBloc.state.artCollection!);
    final searcHistoryState = context.watch<SearcHistoryState>();
    searcHistory = searcHistoryState.searcHistory;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            context.read<AppBloc>().state.status.toString(),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                context.read<AppBloc>().state.status.toString(),
              ),
              SearchAnchor(
                isFullScreen: true,
                viewElevation: 100,
                // viewShape: const ContinuousRectangleBorder(
                //   borderRadius: BorderRadius.all(Radius.circular(20)),
                //   side: BorderSide(color: Colors.pinkAccent),
                // ),
                // viewConstraints: const BoxConstraints(
                //   maxHeight: 300,
                headerTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                // ),
                //viewLeading: Icon(Icons.arrow_back_ios, color: Colors.black54,),
                viewBackgroundColor: const Color(0xFF303030),
                dividerColor: Colors.black54,
                //viewSurfaceTintColor: Color.fromARGB(170, 172, 40, 51),
                searchController: controller,
                viewHintText: '${context.strings.search}...',
                viewTrailing: [
                  IconButton(
                    onPressed: () {
                      searcHistory.add(controller.text);
                      searcHistory = searcHistory.reversed.toSet().toList();
                      searcHistoryState.saveToPrefs(searcHistory);
                      controller.closeView(controller.text);
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black54,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      controller.clear();
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.black54,
                    ),
                  ),
                ],
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                    hintText: '${context.strings.search}...',
                    controller: controller,
                    leading: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black54,
                      ),
                    ),
                    trailing: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.mic,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                    onTap: () {
                      controller.openView();
                    },
                  );
                },
                suggestionsBuilder:
                    (BuildContext context, SearchController controller) {
                  return [
                    Wrap(
                      children: List.generate(searcHistory.length, (index) {
                        final item = searcHistory[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 4,
                            right: 4,
                          ),
                          child: ChoiceChip(
                            label: Text(item),
                            selected: item == controller.text,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24.0)),
                            ),
                            onSelected: (value) {
                              search(item);
                              controller.closeView(item);
                            },
                          ),
                        );
                      }),
                    ),
                    if (controller.text.isNotEmpty) ...[
                      searcHistory.isNotEmpty
                          ? const Divider()
                          : const SizedBox(),
                      SearchResutls(
                        artList: artList,
                        selectedArts: selectedArts,
                        isShrinkWrap: true,
                      ),
                    ]
                  ];
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: SearchResutls(
                  artList: artList,
                  selectedArts: selectedArts,
                  isShrinkWrap: false,
                ),
              ),
            ],
          ),
        ));
  }
}
