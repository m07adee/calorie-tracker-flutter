import 'package:flutter/material.dart';

import '../../core/widgets/language_switcher_button.dart';
import '../../l10n/app_localizations.dart';
import '../add_meal/add_meal_sheet.dart';
import '../dashboard/dashboard_screen.dart';
import '../onboarding/onboarding_screen.dart';
import '../tips/tips_screen.dart';

/// الواجهة الرئيسية بثلاثة تبويبات مع شريط تنقل سفلي
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  static const _homeTab = 0;
  static const _tipsTab = 1;

  int _index = _homeTab;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appName),
        actions: const [LanguageSwitcherButton(), SizedBox(width: 12)],
      ),
      body: IndexedStack(
        index: _index,
        children: [
          DashboardScreen(onOpenTips: () => setState(() => _index = _tipsTab)),
          const TipsScreen(),
          const OnboardingScreen(embedded: true),
        ],
      ),
      floatingActionButton: AnimatedScale(
        scale: _index == _homeTab ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: FloatingActionButton.extended(
          onPressed: _index == _homeTab ? () => showAddMealSheet(context) : null,
          icon: const Icon(Icons.add),
          label: Text(l10n.addMealTitle),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index) => setState(() => _index = index),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: l10n.navHome,
          ),
          NavigationDestination(
            icon: const Icon(Icons.lightbulb_outline),
            selectedIcon: const Icon(Icons.lightbulb),
            label: l10n.navTips,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            label: l10n.navProfile,
          ),
        ],
      ),
    );
  }
}
