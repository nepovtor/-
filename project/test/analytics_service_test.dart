import 'package:camp_leader/models/user.dart';
import 'package:camp_leader/services/analytics_service.dart';
import 'package:test/test.dart';

void main() {
  group('AnalyticsService', () {
    test('buildUserStats counts roles including senior leaders', () {
      final service = AnalyticsService();
      final users = [
        User(id: '1', name: 'A', roles: {UserRole.admin}),
        User(id: '2', name: 'B', roles: {UserRole.leader}),
        User(id: '3', name: 'C', roles: {UserRole.seniorLeader}),
        User(id: '4', name: 'D', roles: {UserRole.assistant}),
        User(id: '5', name: 'E', roles: {UserRole.admin, UserRole.seniorLeader}),
      ];
      final stats = service.buildUserStats(users);
      expect(stats.totalUsers, 5);
      expect(stats.adminCount, 2);
      expect(stats.leaderCount, 3);
      expect(stats.seniorLeaderCount, 2);
      expect(stats.assistantCount, 1);
    });
  });
}
