import 'package:pigeon/pigeon.dart';

class BattingStats {
  int pa;
  double avg;
  double obp;
  double slg;
  double woba;
  double fld;
  double war;
}

class PitchingStats {
  int ip;
  double k9;
  double bb9;
  double babip;
  double era;
}

class Player {
  String name;
  int number;
  String position;
  double war;
  BattingStats battingStats;
  PitchingStats pitchingStats;
  bool isLiked;
}

class LikeMessage {
  int number;
}

@FlutterApi()
abstract class Api2Flutter {
  void showPlayer(Player player);
}

@HostApi()
abstract class Api2Host {
  void likePlayer(LikeMessage message);
}

void configurePigeon(PigeonOptions opts) {
  opts.dartOut = 'lib/messages.dart';
  opts.objcHeaderOut = '../GiantsA2A/messages.h';
  opts.objcSourceOut = '../GiantsA2A/messages.m';
  opts.objcOptions.prefix = 'FLT';
}
