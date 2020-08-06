import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, FLTApi2Host {
  var team : Array<FLTPlayer>? = nil
  var engine : FlutterEngine? = nil
  var api2flutter : FLTApi2Flutter? = nil
  
  private func loadLines(resourceName : String) throws -> Array<String> {
    let battersPath : String? = Bundle.main.path(forResource: resourceName, ofType: "csv")
    let battersText = try String(contentsOfFile: battersPath!, encoding: .utf8)
    let batters = battersText.split(whereSeparator: { $0.isNewline }).map { String($0) }
    return batters
  }
  
  func loadPlayers() -> Array<FLTPlayer>? {
    var result = Array<FLTPlayer>()
    do {
      var count = 0
      let batters = try loadLines(resourceName: "giants_batters_8_5_20")
      for batter in batters {
        let fields = batter.split(separator: ",")
        let player = FLTPlayer()
        player.name = String(fields[0])
        let battingStats = FLTBattingStats();
        player.number = NSNumber(value: count)
        count += 1
        battingStats.pa = NSNumber(value: Int(fields[1])!)
        battingStats.avg = NSNumber(value: Double(fields[2])!)
        battingStats.obp = NSNumber(value: Double(fields[3])!)
        battingStats.slg = NSNumber(value: Double(fields[4])!)
        battingStats.woba = NSNumber(value: Double(fields[5])!)
        battingStats.fld = NSNumber(value: Double(fields[8])!)
        player.war = NSNumber(value: Double(fields[9])!)
        player.battingStats = battingStats
        result.append(player)
      }
      let pitchers = try loadLines(resourceName: "giants_pitchers_8_5_20")
      for pitcher in pitchers {
        let fields = pitcher.split(separator: ",")
        let player = FLTPlayer()
        player.name = String(fields[0])
        player.pitchingStats = FLTPitchingStats()
        player.number = NSNumber(value: count)
        player.war = NSNumber(value: Double(fields[9])!)
        count += 1
        result.append(player)
      }
    }
    catch {
      NSLog("unable to open the players files")
    }
    return result
  }
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    engine = FlutterEngine(name: "baseball")
    engine?.run()
    api2flutter = FLTApi2Flutter(binaryMessenger: engine!.binaryMessenger)
    FLTApi2HostSetup(engine!.binaryMessenger, self)
    // GeneratedPluginRegistrant.register(with: self)
    team = loadPlayers()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  func likePlayer(_ input: FLTLikeMessage, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
    if let number = input.number {
      NSLog("liked: %d", number.intValue)
    }
    for player in team! {
      if player.number == input.number {
        if let isLiked = player.isLiked {
          player.isLiked = NSNumber(booleanLiteral: !isLiked.boolValue)
        } else {
          player.isLiked = NSNumber(booleanLiteral: true)
        }
      }
    }
  }
}
