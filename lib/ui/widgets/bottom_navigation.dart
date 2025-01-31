import 'package:flutter/material.dart';
import 'package:harmonia/ui/pages/app_page.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.onSelectTab,
    required this.tabs,
  });

  final ValueChanged<int> onSelectTab;
  final List<TabItem> tabs;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomNavigationBar(
          currentIndex: AppPageState.selectedIndex,
          type: BottomNavigationBarType.fixed,
          items: tabs
              .map((e) => _buildItem(
                    context: context,
                    index: e.index,
                    icon: e.icon,
                    label: e.title,
                  ))
              .toList(),
          onTap: onSelectTab,
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        width: 40,
        decoration: BoxDecoration(
          color: index == 1 // Player
              ? Colors.transparent
              : _tabBgColor(index, context),
          borderRadius: BorderRadius.circular(10.0),
        ),
        height: 30.0,
        child: Icon(
          icon,
          color: _tabColor(index, context),
          size: _tabSize(index),
        ),
      ),
      label: label,
      tooltip: label,
      //activeIcon: Icon(icon, color: Colors.cyan, size: 30.0),
    );
  }

  Color _tabColor(int index, BuildContext context) {
    return (AppPageState.selectedIndex == index)
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;
  }

  Color _tabBgColor(int index, BuildContext context) {
    return (AppPageState.selectedIndex != index)
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.primaryContainer;
  }

  double? _tabSize(int index) {
    return AppPageState.selectedIndex == index ? 30 : 20;
  }
}
