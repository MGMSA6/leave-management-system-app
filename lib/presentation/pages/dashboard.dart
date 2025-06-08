import 'package:flutter/material.dart';
import 'package:manam_leave_management/core/utils/app_strings.dart';

import '../../core/theme/app_colors.dart';
import '../widgets/floating_fab_menu.dart';
import 'home_screen.dart';
import 'logs_screen.dart';
import 'calendar_screen.dart';
import 'profile_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    LogsScreen(),
    CalendarScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Configurable Gradient
  final LinearGradient _gradient = const LinearGradient(
    colors: [AppColors.gradient1, AppColors.gradient2], // Purple-Pink Gradient
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => isSelected
              ? _gradient.createShader(bounds)
              : LinearGradient(colors: [Colors.grey, Colors.grey])
                  .createShader(bounds), // Gray shader for unselected
          child: Icon(
            icon,
            size: 28,
            color: isSelected ? Colors.white : Colors.grey.shade400,
          ),
        ),
        const SizedBox(height: 4),
        ShaderMask(
          shaderCallback: (bounds) => isSelected
              ? _gradient.createShader(bounds)
              : LinearGradient(colors: [Colors.grey, Colors.grey])
                  .createShader(bounds), // Gray shader for unselected
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey.shade400,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],

      // Floating Action Button with Gradient Background
      floatingActionButton: const FloatingFabMenu(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      // Bottom Navigation Bar (Gradient only on selected icons & text)
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1), // Shadow color
              blurRadius: 8, // How soft the shadow is
              offset: const Offset(0, -2), // Upward shadow
            ),
          ],
        ),
        child: BottomAppBar(
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          elevation: 8,
          child: SizedBox(
            height: 65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _onItemTapped(0),
                      splashColor: Colors.grey.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(30),
                      highlightColor: Colors.transparent,
                      // optional: avoid darker overlay
                      child: SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: Center(
                          child: _buildNavItem(
                            icon: Icons.home_rounded,
                            label: AppStrings.home,
                            isSelected: _selectedIndex == 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _onItemTapped(1),
                      splashColor: Colors.grey.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        child: _buildNavItem(
                          icon: Icons.list_rounded,
                          label: AppStrings.logs,
                          isSelected: _selectedIndex == 1,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _onItemTapped(2),
                      splashColor: Colors.grey.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        child: _buildNavItem(
                          icon: Icons.calendar_month_rounded,
                          label: AppStrings.calender,
                          isSelected: _selectedIndex == 2,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _onItemTapped(3),
                      splashColor: Colors.grey.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        child: _buildNavItem(
                          icon: Icons.person_rounded,
                          label: AppStrings.profile,
                          isSelected: _selectedIndex == 3,
                        ),
                      ),
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
