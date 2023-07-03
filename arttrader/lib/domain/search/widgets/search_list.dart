import 'package:flutter/material.dart';

class ArtList extends StatelessWidget {
  final List<dynamic> artList;
  const ArtList({
    Key? key,
    required this.artList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: artList.length,
      itemBuilder: (context, index) {
        //final item = artList[index];
        return Card(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Image.network(artList[index]['imageUrl']),
                title: Text(artList[index]['name']),
                subtitle:
                    Text('\$${artList[index]['price'].toStringAsFixed(2)}'),
              ),
            ],
          ),
        );
      },
    );
  }
}
