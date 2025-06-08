import 'package:flutter/material.dart';

class PermissionItem extends StatefulWidget {
  final String duration;
  final String date;
  final String fromTime;
  final String toTime;
  final String reason;
  final String status;

  const PermissionItem({
    super.key,
    required this.duration,
    required this.date,
    required this.fromTime,
    required this.toTime,
    required this.reason,
    required this.status,
  });

  @override
  State<PermissionItem> createState() => _PermissionItemState();
}

class _PermissionItemState extends State<PermissionItem> {
  bool isExpanded = false;

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green.shade100;
      case 'pending':
        return Colors.yellow.shade100;
      case 'rejected':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  Color getStatusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green.shade700;
      case 'pending':
        return Colors.orange.shade800;
      case 'rejected':
        return Colors.red.shade700;
      default:
        return Colors.grey.shade800;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Icons.check_circle;
      case 'pending':
        return Icons.access_time_filled_rounded;
      case 'rejected':
        return Icons.cancel;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT SIDE DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Show leave type beside duration with tag style
                Row(
                  children: [
                    Text(
                      widget.duration,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 5),
                    // Display leave type with tag style
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${widget.date}, ${widget.fromTime} - ${widget.toTime}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),

                // Animated expanding reason text
                AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded =
                            !isExpanded; // Toggle expansion on text click
                      });
                    },
                    child: Text(
                      widget.reason,
                      maxLines: isExpanded ? null : 1,
                      // Show more lines when expanded
                      overflow: isExpanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.deepPurple.shade400,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // RIGHT SIDE: STATUS + ARROW
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: getStatusColor(widget.status),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      getStatusIcon(widget.status),
                      size: 16,
                      color: getStatusTextColor(widget.status),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.status,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: getStatusTextColor(widget.status),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Toggle expand icon (iOS rounded down arrow)
              Material(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  splashColor: Colors.grey.shade300,
                  onTap: () {
                    setState(() {
                      isExpanded =
                          !isExpanded; // Toggle expansion on arrow click
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      isExpanded
                          ? Icons
                              .keyboard_arrow_down_rounded // Down arrow (iOS-style)
                          : Icons.keyboard_arrow_right_rounded,
                      // Right arrow (iOS-style)
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
