import 'package:arttrader/export.dart';

class UserSection extends StatelessWidget {
  const UserSection({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green,
      child: ListTile(
        leading: CircleAvatar(
          child: user.photo == null
              ? const Icon(Icons.account_circle)
              : Image.network(user.photo!),
        ),
        title: user.name == null
            ? Text('${context.strings.hi} ${user.email}')
            : Text('${context.strings.hi} ${user.name}'),
        subtitle: Text('LOREM IPSUM'),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String title;
  final VoidCallback? onClick;
  final IconData icon;
  const CustomCard({
    required this.title,
    required this.icon,
    this.onClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
