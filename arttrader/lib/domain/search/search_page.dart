import 'package:arttrader/app/bloc/app_bloc.dart';
import 'package:arttrader/domain/home/bloc/art_bloc.dart';
import 'package:arttrader/domain/models/art/art.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  static Page<void> page() => const MaterialPage<void>(child: SearchPage());

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<Art> artList;
  late List<Art> selectedArts = [];

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //final user = context.select((AppBloc bloc) => bloc.state.user);
    searchController.addListener(searchListener);
  }

  @override
  void dispose() {
    searchController.removeListener(searchListener);
    searchController.dispose();
    super.dispose();
  }

  void searchListener() {
    search(searchController.text);
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        selectedArts = artList;
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
    return Scaffold(
      appBar: CustomSearchBar(controller: searchController),
      body: Column(
        children: [
          Text(
            context.read<AppBloc>().state.status.toString(),
          ),
          Expanded(
            child: ListView.builder(
                itemCount:
                    artList.isEmpty ? artList.length : selectedArts.length,
                itemBuilder: (BuildContext context, int index) {
                  selectedArts.isEmpty ? artList[index] : selectedArts[index];

                  return Card(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Hero(
                            tag: artList[index].id!,
                            child: Image.network(artList[index].imageUrl!),
                          ),
                          title: Text(artList[index].name!),
                          subtitle: Text(
                              '\$${artList[index].price!.toStringAsFixed(2)}'),
                          trailing: IconButton(
                            onPressed: () {
                              context
                                  .read<ArtBloc>()
                                  .add(GetSelectedArt(artList[index].id!));
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
                }),
          ),
        ],
      ),
    );
  }
}
