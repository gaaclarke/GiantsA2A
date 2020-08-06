// Autogenerated from Pigeon (v0.1.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import
import 'dart:async';
import 'package:flutter/services.dart';

class Player {
  String name;
  int number;
  String position;
  double war;
  BattingStats battingStats;
  PitchingStats pitchingStats;
  bool isLiked;
  // ignore: unused_element
  Map<dynamic, dynamic> _toMap() {
    final Map<dynamic, dynamic> pigeonMap = <dynamic, dynamic>{};
    pigeonMap['name'] = name;
    pigeonMap['number'] = number;
    pigeonMap['position'] = position;
    pigeonMap['war'] = war;
    pigeonMap['battingStats'] = battingStats._toMap();
    pigeonMap['pitchingStats'] = pitchingStats._toMap();
    pigeonMap['isLiked'] = isLiked;
    return pigeonMap;
  }
  // ignore: unused_element
  static Player _fromMap(Map<dynamic, dynamic> pigeonMap) {
    final Player result = Player();
    result.name = pigeonMap['name'];
    result.number = pigeonMap['number'];
    result.position = pigeonMap['position'];
    result.war = pigeonMap['war'];
    result.battingStats = pigeonMap['battingStats'] == null ? null : BattingStats._fromMap(pigeonMap['battingStats']);
    result.pitchingStats = pigeonMap['pitchingStats'] == null ? null : PitchingStats._fromMap(pigeonMap['pitchingStats']);
    result.isLiked = pigeonMap['isLiked'];
    return result;
  }
}

class BattingStats {
  int pa;
  double avg;
  double obp;
  double slg;
  double woba;
  double fld;
  double war;
  // ignore: unused_element
  Map<dynamic, dynamic> _toMap() {
    final Map<dynamic, dynamic> pigeonMap = <dynamic, dynamic>{};
    pigeonMap['pa'] = pa;
    pigeonMap['avg'] = avg;
    pigeonMap['obp'] = obp;
    pigeonMap['slg'] = slg;
    pigeonMap['woba'] = woba;
    pigeonMap['fld'] = fld;
    pigeonMap['war'] = war;
    return pigeonMap;
  }
  // ignore: unused_element
  static BattingStats _fromMap(Map<dynamic, dynamic> pigeonMap) {
    final BattingStats result = BattingStats();
    result.pa = pigeonMap['pa'];
    result.avg = pigeonMap['avg'];
    result.obp = pigeonMap['obp'];
    result.slg = pigeonMap['slg'];
    result.woba = pigeonMap['woba'];
    result.fld = pigeonMap['fld'];
    result.war = pigeonMap['war'];
    return result;
  }
}

class PitchingStats {
  int ip;
  double k9;
  double bb9;
  double babip;
  double era;
  // ignore: unused_element
  Map<dynamic, dynamic> _toMap() {
    final Map<dynamic, dynamic> pigeonMap = <dynamic, dynamic>{};
    pigeonMap['ip'] = ip;
    pigeonMap['k9'] = k9;
    pigeonMap['bb9'] = bb9;
    pigeonMap['babip'] = babip;
    pigeonMap['era'] = era;
    return pigeonMap;
  }
  // ignore: unused_element
  static PitchingStats _fromMap(Map<dynamic, dynamic> pigeonMap) {
    final PitchingStats result = PitchingStats();
    result.ip = pigeonMap['ip'];
    result.k9 = pigeonMap['k9'];
    result.bb9 = pigeonMap['bb9'];
    result.babip = pigeonMap['babip'];
    result.era = pigeonMap['era'];
    return result;
  }
}

class LikeMessage {
  int number;
  // ignore: unused_element
  Map<dynamic, dynamic> _toMap() {
    final Map<dynamic, dynamic> pigeonMap = <dynamic, dynamic>{};
    pigeonMap['number'] = number;
    return pigeonMap;
  }
  // ignore: unused_element
  static LikeMessage _fromMap(Map<dynamic, dynamic> pigeonMap) {
    final LikeMessage result = LikeMessage();
    result.number = pigeonMap['number'];
    return result;
  }
}

abstract class Api2Flutter {
  void showPlayer(Player arg);
  static void setup(Api2Flutter api) {
    {
      const BasicMessageChannel<dynamic> channel =
          BasicMessageChannel<dynamic>('dev.flutter.pigeon.Api2Flutter.showPlayer', StandardMessageCodec());
      channel.setMessageHandler((dynamic message) async {
        final Map<dynamic, dynamic> mapMessage = message as Map<dynamic, dynamic>;
        final Player input = Player._fromMap(mapMessage);
        api.showPlayer(input);
      });
    }
  }
}

class Api2Host {
  Future<void> likePlayer(LikeMessage arg) async {
    final Map<dynamic, dynamic> requestMap = arg._toMap();
    const BasicMessageChannel<dynamic> channel =
        BasicMessageChannel<dynamic>('dev.flutter.pigeon.Api2Host.likePlayer', StandardMessageCodec());
    
    final Map<dynamic, dynamic> replyMap = await channel.send(requestMap);
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
        details: null);
    } else if (replyMap['error'] != null) {
      final Map<dynamic, dynamic> error = replyMap['error'];
      throw PlatformException(
          code: error['code'],
          message: error['message'],
          details: error['details']);
    } else {
      // noop
    }
    
  }
}

