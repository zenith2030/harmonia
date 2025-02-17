import 'package:flutter/material.dart';
import 'package:harmonia/app/dependencies.dart';
import '../widgets/bottom_navigation.dart';
import '../../../player/data/repositories/trilha_sonora_repository.dart';
import 'player_page.dart';
import 'minhas_trilhas_page.dart';
import '../../settings/pages/settings_page.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key, this.page = 1});

  final int? page;

  @override
  State<AppPage> createState() => AppPageState();
}

class AppPageState extends State<AppPage> with SingleTickerProviderStateMixin {
  late List<TabItem> _tabs;
  late TrilhaSonoraRepository repository;
  static int selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    repository = injector.get<TrilhaSonoraRepository>();
    selectedIndex = widget.page ?? 1;

    _tabs = [
      TabItem(
        icon: Icons.queue_music_outlined,
        title: 'Trilhas Musicais',
        widget: const MinhasTrilhasPage(),
      ),
      TabItem(
        icon: Icons.play_circle_rounded,
        title: 'Player',
        widget: const PlayerPage(),
      ),
      TabItem(
        icon: Icons.settings,
        title: 'Configurações',
        widget: const SettingsPage(),
      ),
    ];

    _tabs.asMap().forEach((index, tab) {
      tab.setindex(index);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabs.asMap().forEach((index, tab) {
      tab.setindex(index);
    });
  }

  void selecTab(int index) {
    if (index == selectedIndex) {
      _tabs[index].key.currentState!.popUntil((route) => route.isFirst);
    } else {
      selectedIndex = index;
      setState(() {});
    }
  }

  @override
  void dispose() {
    for (var tab in _tabs) {
      tab.key.currentState?.dispose();
    }
    super.dispose();
  }

  Future<bool> willCanPop() async {
    if (_tabs[selectedIndex].key.currentState == null) return true;
    final isFirstRouteinSelectedtab =
        await _tabs[selectedIndex].key.currentState!.maybePop();
    if (isFirstRouteinSelectedtab) {
      if (selectedIndex != 0) {
        selecTab(0);
        return false;
      } else {
        return true;
      }
    }
    return isFirstRouteinSelectedtab;
  }

  @override
  Widget build(BuildContext context) {
    final sizeButton = 60.0;
    return Material(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Scaffold(
            body: IndexedStack(
              index: selectedIndex,
              children: _tabs.map((e) => e.page).toList(),
            ),
            bottomNavigationBar: BottomNavigation(
              onSelectTab: selecTab,
              tabs: _tabs,
            ),
          ),
          Positioned(
            bottom: 24,
            left: MediaQuery.sizeOf(context).shortestSide * 0.5 -
                (sizeButton / 2),
            child: InkWell(
              onTap: () => selecTab(1),
              child: PlayerGrande(
                size: sizeButton,
                selectedTab: selectedIndex,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerGrande extends StatelessWidget {
  const PlayerGrande({
    super.key,
    required this.size,
    required this.selectedTab,
  });

  final int selectedTab;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5.0,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.all(5),
        width: size - 10,
        height: size - 10,
        decoration: BoxDecoration(
          color: selectedTab == 1
              ? Theme.of(context).colorScheme.primaryContainer
              : Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(50.0),
          ),
        ),
        child: Icon(
          Icons.play_arrow,
          color: selectedTab != 1
              ? Theme.of(context).colorScheme.primaryContainer
              : Colors.red,
          size: size - 10,
        ),
      ),
    );
  }
}

class TabItem {
  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  final String title;
  final IconData icon;
  final Widget widget;

  late int _index;
  late Widget _page;

  TabItem({
    required this.title,
    required this.icon,
    required this.widget,
  }) {
    _page = widget;
  }

  int get index => _index;
  void setindex(int index) => _index = index;
  bool get isActive => index == _index;

  Widget get page {
    return Visibility(
      visible: isActive,
      maintainState: true,
      child: Navigator(
        key: key,
        onGenerateRoute: (route) =>
            MaterialPageRoute(builder: (context) => _page),
      ),
    );
  }
}
