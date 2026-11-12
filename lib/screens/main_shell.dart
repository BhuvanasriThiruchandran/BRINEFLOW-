import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'pond_monitoring_screen.dart';
import 'weather_screen.dart';
import 'yield_prediction_screen.dart';
import 'profit_prediction_screen.dart';
import 'ai_assistant_screen.dart';
import 'alert_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;

  // Desktop sidebar open/closed state
  bool sidebarExpanded = true;

  // ============================================================
  // ALL APPLICATION PAGES
  // ============================================================

  final List<Widget> pages = const [
    DashboardScreen(),          // 0
    PondMonitoringScreen(),     // 1
    WeatherScreen(),            // 2
    YieldPredictionScreen(),    // 3
    ProfitPredictionScreen(),   // 4
    AIAssistantScreen(),        // 5
    AlertScreen(),              // 6
    ProfileScreen(),            // 7
    SettingsScreen(),           // 8
  ];

  // ============================================================
  // NAVIGATION ITEMS
  // ============================================================

  final List<_NavItem> navigationItems = const [
    _NavItem(
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard_rounded,
      label: 'Dashboard',
    ),

    _NavItem(
      icon: Icons.water_drop_outlined,
      selectedIcon: Icons.water_drop_rounded,
      label: 'Pond Monitoring',
    ),

    _NavItem(
      icon: Icons.cloud_outlined,
      selectedIcon: Icons.cloud_rounded,
      label: 'Weather',
    ),

    _NavItem(
      icon: Icons.auto_graph_outlined,
      selectedIcon: Icons.auto_graph_rounded,
      label: 'Yield Prediction',
    ),

    _NavItem(
      icon: Icons.account_balance_wallet_outlined,
      selectedIcon: Icons.account_balance_wallet_rounded,
      label: 'Profit Prediction',
    ),

    _NavItem(
      icon: Icons.smart_toy_outlined,
      selectedIcon: Icons.smart_toy_rounded,
      label: 'AI Assistant',
    ),

    _NavItem(
      icon: Icons.notifications_none_rounded,
      selectedIcon: Icons.notifications_rounded,
      label: 'Alerts',
      hasBadge: true,
    ),

    _NavItem(
      icon: Icons.person_outline_rounded,
      selectedIcon: Icons.person_rounded,
      label: 'Profile',
    ),

    _NavItem(
      icon: Icons.settings_outlined,
      selectedIcon: Icons.settings_rounded,
      label: 'Settings',
    ),
  ];

  // ============================================================
  // SELECT PAGE
  // ============================================================

  void _selectPage(int value) {
    setState(() {
      index = value;
    });
  }

  // ============================================================
  // TOGGLE SIDEBAR
  // ============================================================

  void _toggleSidebar() {
    setState(() {
      sidebarExpanded = !sidebarExpanded;
    });
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    // DESKTOP
    if (width >= 1100) {
      return _DesktopShell(
        index: index,
        pages: pages,
        items: navigationItems,
        sidebarExpanded: sidebarExpanded,
        onSelect: _selectPage,
        onToggleSidebar: _toggleSidebar,
      );
    }

    // TABLET
    if (width >= 700) {
      return _TabletShell(
        index: index,
        pages: pages,
        items: navigationItems,
        onSelect: _selectPage,
      );
    }

    // MOBILE
    return _MobileShell(
      index: index,
      pages: pages,
      items: navigationItems,
      onSelect: _selectPage,
    );
  }
}

// ============================================================
// DESKTOP SHELL
// ============================================================

class _DesktopShell extends StatelessWidget {
  final int index;
  final List<Widget> pages;
  final List<_NavItem> items;
  final bool sidebarExpanded;
  final ValueChanged<int> onSelect;
  final VoidCallback onToggleSidebar;

  const _DesktopShell({
    required this.index,
    required this.pages,
    required this.items,
    required this.sidebarExpanded,
    required this.onSelect,
    required this.onToggleSidebar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FC),
      body: Row(
        children: [
          // ======================================================
          // SIDEBAR
          // ======================================================

          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            width: sidebarExpanded ? 248 : 76,
            child: sidebarExpanded
                ? _DesktopSidebarExpanded(
                    index: index,
                    items: items,
                    onSelect: onSelect,
                    onToggleSidebar: onToggleSidebar,
                  )
                : _DesktopSidebarCollapsed(
                    index: index,
                    items: items,
                    onSelect: onSelect,
                    onToggleSidebar: onToggleSidebar,
                  ),
          ),

          // ======================================================
          // MAIN CONTENT
          // ======================================================

          Expanded(
            child: IndexedStack(
              index: index,
              children: pages,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// EXPANDED DESKTOP SIDEBAR
// ============================================================

class _DesktopSidebarExpanded extends StatelessWidget {
  final int index;
  final List<_NavItem> items;
  final ValueChanged<int> onSelect;
  final VoidCallback onToggleSidebar;

  const _DesktopSidebarExpanded({
    required this.index,
    required this.items,
    required this.onSelect,
    required this.onToggleSidebar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 248,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(
            color: Color(0xFFE6ECF3),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
          child: Column(
            children: [
              // ==================================================
              // TOP HEADER
              // ==================================================

              Row(
                children: [
                  const Expanded(
                    child: _Brand(),
                  ),

                  IconButton(
                    tooltip: 'Collapse sidebar',
                    onPressed: onToggleSidebar,
                    icon: const Icon(
                      Icons.menu_rounded,
                      color: Color(0xFF536277),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              const _ConnectionCard(),

              const SizedBox(height: 24),

              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'MAIN MENU',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                      color: Color(0xFF9AA7B8),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: items.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: 4),
                  itemBuilder: (context, i) {
                    return _DesktopNavigationItem(
                      item: items[i],
                      selected: index == i,
                      onTap: () => onSelect(i),
                    );
                  },
                ),
              ),

              const SizedBox(height: 10),

              Container(
                height: 1,
                color: const Color(0xFFE7ECF2),
              ),

              const SizedBox(height: 14),

              // Profile = INDEX 7
              _UserCard(
                onTap: () => onSelect(7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// COLLAPSED DESKTOP SIDEBAR
// ============================================================

class _DesktopSidebarCollapsed extends StatelessWidget {
  final int index;
  final List<_NavItem> items;
  final ValueChanged<int> onSelect;
  final VoidCallback onToggleSidebar;

  const _DesktopSidebarCollapsed({
    required this.index,
    required this.items,
    required this.onSelect,
    required this.onToggleSidebar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(
            color: Color(0xFFE6ECF3),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18),

            // ==================================================
            // THREE LINE MENU BUTTON
            // ==================================================

            IconButton(
              tooltip: 'Open sidebar',
              onPressed: onToggleSidebar,
              icon: const Icon(
                Icons.menu_rounded,
                size: 25,
                color: Color(0xFF536277),
              ),
            ),

            const SizedBox(height: 8),

            // ==================================================
            // BRAND ICON
            // ==================================================

            Container(
              width: 43,
              height: 43,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1677FF),
                    Color(0xFF12B8A6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(
                Icons.water_drop_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // COLLAPSED NAVIGATION
            // ==================================================

            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, i) {
                  return _CollapsedNavigationItem(
                    item: items[i],
                    selected: index == i,
                    onTap: () => onSelect(i),
                  );
                },
              ),
            ),

            // ==================================================
            // PROFILE
            // ==================================================

            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: InkWell(
                onTap: () => onSelect(7),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: index == 7
                        ? const Color(0xFFEAF2FF)
                        : const Color(0xFFF3F6FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'A',
                      style: TextStyle(
                        color: Color(0xFF1677FF),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// BRAND
// ============================================================

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF1677FF),
                Color(0xFF12B8A6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1677FF)
                    .withValues(alpha: 0.18),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.water_drop_rounded,
            color: Colors.white,
            size: 23,
          ),
        ),

        const SizedBox(width: 11),

        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BrineFlow',
              style: TextStyle(
                color: Color(0xFF14213D),
                fontSize: 19,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
            ),

            SizedBox(height: 2),

            Text(
              'INTELLIGENT SALTPAN',
              style: TextStyle(
                color: Color(0xFF718096),
                fontSize: 8,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ============================================================
// CONNECTION CARD
// ============================================================

class _ConnectionCard extends StatelessWidget {
  const _ConnectionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF1FBF7),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFD9F1E7),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 9,
            height: 9,
            decoration: const BoxDecoration(
              color: Color(0xFF16A765),
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 10),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'IOT CONNECTED',
                  style: TextStyle(
                    color: Color(0xFF168A58),
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),

                SizedBox(height: 3),

                Text(
                  'ESP32 • All sensors online',
                  style: TextStyle(
                    color: Color(0xFF718096),
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.wifi_rounded,
            color: Color(0xFF16A765),
            size: 17,
          ),
        ],
      ),
    );
  }
}

// ============================================================
// DESKTOP NAVIGATION ITEM
// ============================================================

class _DesktopNavigationItem extends StatelessWidget {
  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  const _DesktopNavigationItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(
            horizontal: 11,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFFEAF2FF)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFFDCEAFF)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  selected
                      ? item.selectedIcon
                      : item.icon,
                  size: 19,
                  color: selected
                      ? const Color(0xFF1677FF)
                      : const Color(0xFF68778D),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  item.label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: selected
                        ? const Color(0xFF1677FF)
                        : const Color(0xFF536277),
                    fontSize: 11.5,
                    fontWeight: selected
                        ? FontWeight.w800
                        : FontWeight.w600,
                  ),
                ),
              ),

              if (item.hasBadge)
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),

              if (selected && !item.hasBadge)
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF1677FF),
                  size: 17,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// COLLAPSED NAVIGATION ITEM
// ============================================================

class _CollapsedNavigationItem extends StatelessWidget {
  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  const _CollapsedNavigationItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 4,
      ),
      child: Tooltip(
        message: item.label,
        preferBelow: false,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xFFEAF2FF)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  selected
                      ? item.selectedIcon
                      : item.icon,
                  size: 21,
                  color: selected
                      ? const Color(0xFF1677FF)
                      : const Color(0xFF718096),
                ),

                if (item.hasBadge)
                  Positioned(
                    right: 7,
                    top: 7,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// USER CARD
// ============================================================

class _UserCard extends StatelessWidget {
  final VoidCallback onTap;

  const _UserCard({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(13),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 7,
        ),
        child: Row(
          children: [
            Container(
              width: 39,
              height: 39,
              decoration: BoxDecoration(
                color: const Color(0xFFE5EEFF),
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Center(
                child: Text(
                  'A',
                  style: TextStyle(
                    color: Color(0xFF1677FF),
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 10),

            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Admin',
                    style: TextStyle(
                      color: Color(0xFF17233C),
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  SizedBox(height: 3),

                  Text(
                    'Saltpan Manager',
                    style: TextStyle(
                      color: Color(0xFF8A96A8),
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.more_horiz_rounded,
              color: Color(0xFF8793A5),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// TABLET SHELL
// ============================================================

class _TabletShell extends StatelessWidget {
  final int index;
  final List<Widget> pages;
  final List<_NavItem> items;
  final ValueChanged<int> onSelect;

  const _TabletShell({
    required this.index,
    required this.pages,
    required this.items,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FC),
      body: Row(
        children: [
          _TabletSidebar(
            index: index,
            items: items,
            onSelect: onSelect,
          ),

          Expanded(
            child: IndexedStack(
              index: index,
              children: pages,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// TABLET SIDEBAR
// ============================================================

class _TabletSidebar extends StatelessWidget {
  final int index;
  final List<_NavItem> items;
  final ValueChanged<int> onSelect;

  const _TabletSidebar({
    required this.index,
    required this.items,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(
            color: Color(0xFFE6ECF3),
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 18),

            Container(
              width: 43,
              height: 43,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF1677FF),
                    Color(0xFF12B8A6),
                  ],
                ),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(
                Icons.water_drop_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),

            const SizedBox(height: 18),

            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, i) {
                  return _TabletNavigationItem(
                    item: items[i],
                    selected: index == i,
                    onTap: () => onSelect(i),
                  );
                },
              ),
            ),

            // Profile = INDEX 7
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: InkWell(
                onTap: () => onSelect(7),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: index == 7
                        ? const Color(0xFFEAF2FF)
                        : const Color(0xFFF3F6FA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'A',
                      style: TextStyle(
                        color: Color(0xFF1677FF),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// TABLET NAV
// ============================================================

class _TabletNavigationItem extends StatelessWidget {
  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  const _TabletNavigationItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 4,
      ),
      child: Tooltip(
        message: item.label,
        preferBelow: false,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: selected
                  ? const Color(0xFFEAF2FF)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  selected
                      ? item.selectedIcon
                      : item.icon,
                  size: 21,
                  color: selected
                      ? const Color(0xFF1677FF)
                      : const Color(0xFF718096),
                ),

                if (item.hasBadge)
                  Positioned(
                    right: 7,
                    top: 7,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// MOBILE SHELL
// ============================================================
// ============================================================
// MOBILE SHELL
// ============================================================

class _MobileShell extends StatelessWidget {
  final int index;
  final List<Widget> pages;
  final List<_NavItem> items;
  final ValueChanged<int> onSelect;

  const _MobileShell({
    required this.index,
    required this.pages,
    required this.items,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FC),

      // ==========================================================
      // HAMBURGER MENU
      // ==========================================================

      drawer: _MobileDrawer(
        index: index,
        items: items,
        onSelect: onSelect,
      ),

      // ==========================================================
      // MAIN CONTENT
      // ==========================================================

      body: Stack(
        children: [
          IndexedStack(
            index: index,
            children: pages,
          ),

          // ========================================================
          // TOP LEFT HAMBURGER BUTTON
          // ========================================================

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,
                top: 8,
              ),
              child: Builder(
                builder: (context) {
                  return Material(
                    color: Colors.white,
                    elevation: 3,
                    borderRadius: BorderRadius.circular(13),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(13),
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                          border: Border.all(
                            color: const Color(0xFFE4EAF1),
                          ),
                        ),
                        child: const Icon(
                          Icons.menu_rounded,
                          color: Color(0xFF536277),
                          size: 25,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),

      // IMPORTANT:
      // No bottomNavigationBar here.
    );
  }
}

// ============================================================
// MOBILE DRAWER
// ============================================================

class _MobileDrawer extends StatelessWidget {
  final int index;
  final List<_NavItem> items;
  final ValueChanged<int> onSelect;

  const _MobileDrawer({
    required this.index,
    required this.items,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 285,
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // ======================================================
            // DRAWER HEADER
            // ======================================================

            Padding(
              padding: const EdgeInsets.fromLTRB(
                18,
                18,
                12,
                18,
              ),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF1677FF),
                          Color(0xFF12B8A6),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: const Icon(
                      Icons.water_drop_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),

                  const SizedBox(width: 12),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BrineFlow',
                          style: TextStyle(
                            color: Color(0xFF14213D),
                            fontSize: 19,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.5,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'INTELLIGENT SALTPAN',
                          style: TextStyle(
                            color: Color(0xFF718096),
                            fontSize: 8,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    tooltip: 'Close menu',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      color: Color(0xFF68778D),
                    ),
                  ),
                ],
              ),
            ),

            // ======================================================
            // CONNECTION STATUS
            // ======================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1FBF7),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFD9F1E7),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(
                        color: Color(0xFF16A765),
                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 9),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'IOT CONNECTED',
                            style: TextStyle(
                              color: Color(0xFF168A58),
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'ESP32 • All sensors online',
                            style: TextStyle(
                              color: Color(0xFF718096),
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Icon(
                      Icons.wifi_rounded,
                      color: Color(0xFF16A765),
                      size: 17,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ======================================================
            // MENU TITLE
            // ======================================================

            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'MAIN MENU',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                    color: Color(0xFF9AA7B8),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ======================================================
            // ALL MODULES
            // ======================================================

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: 3),
                itemBuilder: (context, i) {
                  final item = items[i];

                  return _MobileDrawerItem(
                    item: item,
                    selected: index == i,
                    onTap: () {
                      Navigator.pop(context);
                      onSelect(i);
                    },
                  );
                },
              ),
            ),

            // ======================================================
            // USER PROFILE
            // ======================================================

            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(
                horizontal: 18,
              ),
              color: const Color(0xFFE7ECF2),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                0,
                16,
                16,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  onSelect(7);
                },
                borderRadius: BorderRadius.circular(13),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE5EEFF),
                          borderRadius:
                              BorderRadius.circular(11),
                        ),
                        child: const Center(
                          child: Text(
                            'A',
                            style: TextStyle(
                              color: Color(0xFF1677FF),
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Admin',
                              style: TextStyle(
                                color: Color(0xFF17233C),
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Saltpan Manager',
                              style: TextStyle(
                                color: Color(0xFF8A96A8),
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Icon(
                        Icons.chevron_right_rounded,
                        color: Color(0xFF8793A5),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// MOBILE DRAWER ITEM
// ============================================================

class _MobileDrawerItem extends StatelessWidget {
  final _NavItem item;
  final bool selected;
  final VoidCallback onTap;

  const _MobileDrawerItem({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(13),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFFEAF2FF)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFFDCEAFF)
                      : const Color(0xFFF5F7FA),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  selected
                      ? item.selectedIcon
                      : item.icon,
                  size: 20,
                  color: selected
                      ? const Color(0xFF1677FF)
                      : const Color(0xFF68778D),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  item.label,
                  style: TextStyle(
                    color: selected
                        ? const Color(0xFF1677FF)
                        : const Color(0xFF536277),
                    fontSize: 13,
                    fontWeight: selected
                        ? FontWeight.w800
                        : FontWeight.w600,
                  ),
                ),
              ),

              if (item.hasBadge)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),

              if (selected)
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF1677FF),
                  size: 19,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// MOBILE NAVIGATION
// ============================================================

class _MobileNavigation extends StatelessWidget {
  final List<_NavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const _MobileNavigation({
    required this.items,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: NavigationBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          height: 72,
          selectedIndex: selectedIndex,
          onDestinationSelected: onSelect,
          indicatorColor: const Color(0xFFEAF2FF),
          destinations: items.map((item) {
            return NavigationDestination(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(item.icon),

                  if (item.hasBadge)
                    Positioned(
                      right: -2,
                      top: -2,
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEF4444),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),

              selectedIcon: Icon(item.selectedIcon),

              label: _mobileLabel(item.label),
            );
          }).toList(),
        ),
      ),
    );
  }

  String _mobileLabel(String value) {
    switch (value) {
      case 'Pond Monitoring':
        return 'Ponds';

      case 'Yield Prediction':
        return 'Yield';

      case 'Profit Prediction':
        return 'Profit';

      case 'AI Assistant':
        return 'AI';

      default:
        return value;
    }
  }
}

// ============================================================
// NAVIGATION DATA
// ============================================================

class _NavItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool hasBadge;

  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    this.hasBadge = false,
  });
}