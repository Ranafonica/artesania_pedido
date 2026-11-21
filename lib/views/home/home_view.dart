import 'package:material_ui/material_ui.dart' hide NavigationBar;
import 'package:the_newpage/widgets/navigation_bar/navigation_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          NavigationBar(),
          Expanded(
            child: Center(child: Text('Hola')),
          ),
        ],
      ),
    );
  }
}