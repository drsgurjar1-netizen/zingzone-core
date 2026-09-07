import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  // Official Test Ad Unit IDs (Testing ke liye 100% safe)
  static String get bannerAdUnitId {
    return 'ca-app-pub-3940256099942544/6300978111';
  }

  static String get interstitialAdUnitId {
    return 'ca-app-pub-3940256099942544/1033173712';
  }

  static String get rewardedAdUnitId {
    return 'ca-app-pub-3940256099942544/5224354917';
  }

  static InterstitialAd? _interstitialAd;
  static int _reelsViewCount = 0;

  // SDK Initialize
  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
    loadInterstitialAd();
  }

  // Pre-load Interstitial Ad
  static void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          debugPrint('Interstitial Ad failed: $error');
          _interstitialAd = null;
        },
      ),
    );
  }

  // Check every 5th Reel to show Ad
  static void checkAndShowReelAd() {
    _reelsViewCount++;
    if (_reelsViewCount >= 5) {
      _reelsViewCount = 0;
      if (_interstitialAd != null) {
        _interstitialAd!.show();
        _interstitialAd = null;
        loadInterstitialAd(); // Next ad pre-load
      } else {
        loadInterstitialAd();
      }
    }
  }

  // Show Rewarded Video Ad for Task / Free Coins
  static void showRewardedAd({required Function(int coinsEarned) onRewardEarned}) {
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          ad.show(onUserEarnedReward: (adWithoutView, reward) {
            onRewardEarned(reward.amount.toInt());
          });
        },
        onAdFailedToLoad: (error) {
          debugPrint('Rewarded Ad failed to load: $error');
        },
      ),
    );
  }
}

