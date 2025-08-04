import '../models/admin_stats.dart';
import '../models/user.dart';

/// Provides basic analytics for administrators.
class AnalyticsService {
  /// Builds statistics about user roles.
  AdminStats buildUserStats(List<User> users) {
    int admins = 0;
    int leaders = 0;
    int seniorLeaders = 0;
    int assistants = 0;
    for (final u in users) {
      if (u.roles.contains(UserRole.admin)) admins++;
      if (u.roles.contains(UserRole.seniorLeader)) {
        seniorLeaders++;
        leaders++; // senior leaders are also leaders
      } else if (u.roles.contains(UserRole.leader)) {
        leaders++;
      }
      if (u.roles.contains(UserRole.assistant)) assistants++;
    }
    return AdminStats(
      totalUsers: users.length,
      adminCount: admins,
      leaderCount: leaders,
      seniorLeaderCount: seniorLeaders,
      assistantCount: assistants,
    );
  }
}

