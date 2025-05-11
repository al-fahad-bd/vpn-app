class VpnStatus {
  String? byteIn;
  String? byteOut;
  String? durationTime;
  String? lastPacketReceive;

  VpnStatus({
    this.byteIn,
    this.byteOut,
    this.durationTime,
    this.lastPacketReceive,
  });

  factory VpnStatus.fromJson(Map<String, dynamic> jsonData) => VpnStatus(
        byteIn: jsonData['byte_in'],
        byteOut: jsonData['byte_out'],
        durationTime: jsonData['duration'],
        lastPacketReceive: jsonData['last_packet_receive'],
      );

  Map<String, dynamic> toJson() => {
        'byte_in': byteIn,
        'byte_out': byteOut,
        'duration': durationTime,
        'last_packet_receive': lastPacketReceive
      };
}
