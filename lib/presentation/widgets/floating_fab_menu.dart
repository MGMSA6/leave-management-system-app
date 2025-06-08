import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:manam_leave_management/presentation/bloc/request/new_request_bloc.dart';

import '../../core/theme/app_colors.dart';
import '../bloc/request/new_request_event.dart';
import '../navigation/app_routes.dart';

class FloatingFabMenu extends StatefulWidget {
  const FloatingFabMenu({Key? key}) : super(key: key);

  @override
  State<FloatingFabMenu> createState() => _FloatingFabMenuState();
}

class _FloatingFabMenuState extends State<FloatingFabMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  bool isOpen = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.125).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleOpen() {
    setState(() => isOpen = true);
    _controller.forward();
  }

  void _handleClose() {
    setState(() => isOpen = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      overlayOpacity: 0.1,
      spacing: 10,
      spaceBetweenChildren: 12,
      onOpen: _handleOpen,
      onClose: _handleClose,
      backgroundColor: Colors.transparent,
      elevation: 0,
      children: [
        SpeedDialChild(
          labelWidget:
              _buildFabButton('Leave', Icons.beach_access, Colors.blue),
          onTap: () {
            _handleClose();
            context.read<NewRequestBloc>().add(InitializeNewRequest());
            AppRoutes.navigateTo(context, AppRoutes.newLeave);
          },
        ),
        SpeedDialChild(
          labelWidget: _buildFabButton('WFH', Icons.home_work, Colors.green),
          onTap: () {
            _handleClose();
            AppRoutes.navigateTo(context, AppRoutes.workFromHome);
          },
        ),
        SpeedDialChild(
          labelWidget: _buildFabButton(
              'Permission', Icons.lock_clock, Colors.deepPurple),
          onTap: () {
            _handleClose();
            AppRoutes.navigateTo(context, AppRoutes.newPermission);
          },
        ),
      ],
      child: AnimatedBuilder(
        animation: _rotationAnimation,
        builder: (_, child) {
          return Transform.rotate(
            angle: _rotationAnimation.value * 2 * pi,
            child: child,
          );
        },
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [AppColors.gradient1, AppColors.gradient2]),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IgnorePointer(
              child:
                  const Icon(Icons.add_rounded, color: Colors.white, size: 35)),
        ),
      ),
    );
  }

  Widget _buildFabButton(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
