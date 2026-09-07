import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Realtime User Stream (Live Coins & Squad Unlock Status)
  Stream<UserModel?> streamUser(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) return null;
      return UserModel.fromMap(doc.data()!, doc.id);
    });
  }

  // Auto-Delete Secret Messages older than 10 minutes
  Future<void> purgeOldSecretMessages(String roomId) async {
    final tenMinutesAgo = DateTime.now().subtract(const Duration(minutes: 10));
    final oldMessagesSnapshot = await _firestore
        .collection('chat_rooms')
        .doc(roomId)
        .collection('messages')
        .where('isSecret', isEqualTo: true)
        .where('createdAt', isLessThan: Timestamp.fromDate(tenMinutesAgo))
        .get();

    WriteBatch batch = _firestore.batch();
    for (var doc in oldMessagesSnapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  // Fetch Live Dynamic Banners (Game, Loot99, Cinema, etc.)
  Stream<List<Map<String, dynamic>>> streamBanners() {
    return _firestore
        .collection('banners')
        .where('isActive', isEqualTo: true)
        .orderBy('order')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => {'id': doc.id, ...doc.data()})
            .toList());
  }

  // Fetch Video Hub Feed (Reels / Long / Live)
  Stream<List<Map<String, dynamic>>> streamVideos(String type) {
    return _firestore
        .collection('videos')
        .where('type', isEqualTo: type) // 'reels', 'long', 'live'
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => {'id': doc.id, ...doc.data()})
            .toList());
  }
}
