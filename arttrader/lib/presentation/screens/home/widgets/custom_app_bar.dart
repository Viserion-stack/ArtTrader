import 'package:arttrader/export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userEmail;
  final String userPhotoUrl;

  const CustomAppBar({
    Key? key,
    required this.userEmail,
    required this.userPhotoUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(5.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage(userPhotoUrl),
        ),
      ),
      title: Text(userEmail),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            context.read<AppBloc>().add(
                const AppLogoutRequested()); // Trigger the logout event in your BLoC
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
