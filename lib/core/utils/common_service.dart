import 'package:manam_leave_management/core/utils/session_manager.dart';
import 'package:manam_leave_management/core/utils/toast_helper.dart';
import 'package:manam_leave_management/data/models/leave_matrices.dart';

import '../../data/models/response/balance_model.dart';

class CommonService {
  /// A map of all supported input‐labels → the exact balanceType key
  static const Map<String, String> _labelToKey = {
    'wfh': 'WFH',
    'casual': 'CASUAL_LEAVE',
    'casual_leave': 'CASUAL_LEAVE',
    'sick': 'SICK_LEAVE',
    'sick_leave': 'SICK_LEAVE',
  };

  /// Normalize incoming label (trim, lowercase, collapse spaces/underscores)
  /// then look it up in [_labelToKey], or fall back to an uppercase passthrough.
  static String _keyFor(String rawLabel) {
    final norm = rawLabel
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[\s_]+'), '_'); // e.g. "Sick Leave" → "sick_leave"
    return _labelToKey[norm] ?? norm.toUpperCase();
  }

  /// Public API: returns a LeaveMatrics for the given label.
  /// If the user has no matching balance, returns zeros.
  static LeaveMatrices getBalanceModel(String rawLabel) {
    print("Common Service : $rawLabel");
    final key = _keyFor(rawLabel);

    final user = SessionManager().user;
    if (user == null) {
      // no session → empty metrics
      return const LeaveMatrices(
        leaveBalance: '',
        allocated: 0,
        used: 0,
        pending: 0,
        percentage: '0%',
      );
    }

    // Find the matching BalanceModel (or default to zeros)
    final balance = user.balances.firstWhere(
      (b) => b.balanceType == key,
      orElse: () => BalanceModel(
        balanceType: key,
        allocated: 0,
        used: 0,
        pending: 0,
      ),
    );

    final allocated = balance.allocated;
    final used = balance.used;
    final pending = balance.pending;

    // Compute percentage string
    final pct =
        allocated > 0 ? ((used / allocated) * 100).toStringAsFixed(0) : '0';

    return LeaveMatrices(
      leaveBalance: '$pending/$allocated days remaining',
      allocated: allocated,
      used: used,
      pending: pending,
      percentage: '$pct%',
    );
  }
}
