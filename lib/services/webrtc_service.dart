import 'package:flutter_webrtc/flutter_webrtc.dart';

class WebRtcService {
  RTCPeerConnection? peerConnection;
  MediaStream? localStream;

  // Google Free Public STUN Configuration (₹0 Server Cost)
  final Map<String, dynamic> configuration = {
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'},
      {'urls': 'stun:stun1.l.google.com:19302'},
    ]
  };

  // Initialize Local Audio & Video Stream
  Future<MediaStream> initLocalStream({bool video = true, bool audio = true}) async {
    final Map<String, dynamic> mediaConstraints = {
      'audio': audio,
      'video': video
          ? {
              'facingMode': 'user',
              'width': {'ideal': 640},
              'height': {'ideal': 480}
            }
          : false,
    };

    localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);
    return localStream!;
  }

  // Create P2P Peer Connection
  Future<RTCPeerConnection> createPeerConnectionInstance({
    required Function(MediaStream stream) onRemoteStreamAdded,
  }) async {
    peerConnection = await createPeerConnection(configuration);

    // Add local tracks to connection
    if (localStream != null) {
      localStream!.getTracks().forEach((track) {
        peerConnection!.addTrack(track, localStream!);
      });
    }

    // Listen for remote peer audio/video streams
    peerConnection!.onTrack = (RTCTrackEvent event) {
      if (event.streams.isNotEmpty) {
        onRemoteStreamAdded(event.streams[0]);
      }
    };

    return peerConnection!;
  }

  // Toggle Microphone
  void toggleMic(bool enabled) {
    if (localStream != null) {
      for (var track in localStream!.getAudioTracks()) {
        track.enabled = enabled;
      }
    }
  }

  // Toggle Camera
  void toggleCamera(bool enabled) {
    if (localStream != null) {
      for (var track in localStream!.getVideoTracks()) {
        track.enabled = enabled;
      }
    }
  }

  // Clean Up & Close Session
  Future<void> dispose() async {
    localStream?.getTracks().forEach((track) => track.stop());
    await localStream?.dispose();
    await peerConnection?.close();
    peerConnection = null;
    localStream = null;
  }
}

