import 'package:camp_leader/models/user.dart';
import 'package:camp_leader/services/admin_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:test/test.dart';

void main() {
  group('AdminService', () {
    test('invites and accepts users', () async {
      final firestore = FakeFirebaseFirestore();
      final service = AdminService(firestore: firestore);

      final invite = await service.inviteUser('test@example.com', roles: {UserRole.leader});
      expect(invite.email, 'test@example.com');

      await service.acceptInvitation(invite.id, 'Tester');
      final usersSnap = await firestore.collection('users').get();
      expect(usersSnap.docs.length, 1);
      final data = usersSnap.docs.first.data();
      expect(data['name'], 'Tester');
      expect((data['roles'] as List).contains('leader'), isTrue);
      final invites = await firestore.collection('invitations').get();
      expect(invites.docs.isEmpty, isTrue);
    });

    test('assigns and removes roles', () async {
      final firestore = FakeFirebaseFirestore();
      final service = AdminService(firestore: firestore);
      final userRef = firestore.collection('users').doc('u1');
      await userRef.set({'name': 'Tester', 'roles': []});

      await service.assignRole('u1', UserRole.admin);
      var snap = await userRef.get();
      expect(List<String>.from(snap.data()!['roles']).contains('admin'), isTrue);

      await service.removeRole('u1', UserRole.admin);
      snap = await userRef.get();
      expect(List<String>.from(snap.data()!['roles']).contains('admin'), isFalse);
    });
  });
}
