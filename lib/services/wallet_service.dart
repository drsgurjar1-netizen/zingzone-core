import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class WalletService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 100 Coins = ₹1
  static const int coinsPerRupee = 100;
  static const int squadUnlockFeeCoins = 500; // ₹5
  static const int privateRoomFeeCoins = 100; // ₹1
  static const int withdrawalFeeCoins = 200;  // Flat ₹2 platform fee

  // Squad Hub Lifetime Unlock Gateway (₹5 charge)
  Future<bool> unlockSquadHub(UserModel user) async {
    if (user.squadUnlocked) return true;
    if (user.coins < squadUnlockFeeCoins) return false;

    await _firestore.collection('users').doc(user.uid).update({
      'coins': FieldValue.increment(-squadUnlockFeeCoins),
      'squadUnlocked': true,
    });
    return true;
  }

  // Check & Consume Private Room Pass (5 Free, then ₹1)
  Future<bool> consumePrivateRoomPass(UserModel user) async {
    if (user.freePrivateRoomsLeft > 0) {
      // 5 Free me se 1 kam karo
      await _firestore.collection('users').doc(user.uid).update({
        'freePrivateRoomsLeft': FieldValue.increment(-1),
      });
      return true;
    } else {
      // Free khatam! ₹1 (100 Coins) charge lagega
      if (user.coins < privateRoomFeeCoins) return false;

      await _firestore.collection('users').doc(user.uid).update({
        'coins': FieldValue.increment(-privateRoomFeeCoins),
      });
      return true;
    }
  }

  // Create UPI Withdrawal Request with Flat ₹2 Platform Fee Deducted
  Future<bool> requestUpiWithdrawal({
    required UserModel user,
    required double requestedRupees,
    required String upiId,
  }) async {
    int totalCoinsNeeded = (requestedRupees * coinsPerRupee).toInt() + withdrawalFeeCoins;

    if (user.coins < totalCoinsNeeded || requestedRupees <= 0) {
      return false;
    }

    // Deduct total balance immediately
    await _firestore.collection('users').doc(user.uid).update({
      'coins': FieldValue.increment(-totalCoinsNeeded),
    });

    // Add request to Admin Queue
    await _firestore.collection('withdrawals').add({
      'uid': user.uid,
      'name': user.name,
      'upiId': upiId,
      'requestedRupees': requestedRupees,
      'feeDeductedRupees': 2.0,
      'status': 'pending', // 'pending', 'approved', 'rejected'
      'createdAt': FieldValue.serverTimestamp(),
    });

    return true;
  }
}

