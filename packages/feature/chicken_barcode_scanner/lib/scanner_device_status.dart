enum ScannerDeviceStatus {
  /// Scanner is ready to be triggered
  waiting,

  /// Scanner is emitting a scanner beam
  scanning,

  /// Scanner is in one of the following states:
  /// enabled but not yet in the waiting state,
  /// in the suspended state by an intent (e.g. SUSPEND_PLUGIN)
  /// or disabled due to the hardware trigger
  idle,

  /// Scanner is disabled
  disabled,

  /// An external (Bluetooth or serial) scanner is connected
  connected,

  /// The external scanner is disconnected
  disconnected
}
