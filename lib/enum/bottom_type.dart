enum BottomType { listDevice, networkControl, wifiSetting }

extension BottomTypeExt on BottomType {
  int get index {
    switch (this) {
      case BottomType.listDevice:
        return 0;
      case BottomType.networkControl:
        return 1;
      case BottomType.wifiSetting:
        return 2;
      default:
        return 0;
    }
  }
}
