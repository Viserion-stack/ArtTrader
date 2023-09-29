import 'package:arttrader/export.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    // ignore: invalid_use_of_protected_member
    if (controller.hasListeners) {
      controller.closeView(controller.text);
      controller.removeListener(() {});
    }
    AppStatus status = AppStatus.authenticated;
    switch (index) {
      case 0:
        //context.read<ArtBloc>().add(const GetArtsRequested());
        status = AppStatus.home;
      case 1:
        status = AppStatus.search;

      case 2:
        status = AppStatus.add;
      case 3:
        context.read<ArtBloc>().add(const GetMyArtList());
        context.read<ArtBloc>().add(const GetMyBidList());
        status = AppStatus.bids;
      case 4:
        status = AppStatus.settings;
    }
    setState(() {
      _selectedIndex = index;
    });
    context.read<AppBloc>().add(AppPageChanged(status));
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        //splashFactory: NoSplash.splashFactory,
      ),
      child: BottomNavigationBar(
        //type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: context.strings.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: context.strings.search,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add),
            label: context.strings.add,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list),
            label: context.strings.bids,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: context.strings.settings,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,

        onTap: _onItemTapped,
      ),
    );
  }
}
