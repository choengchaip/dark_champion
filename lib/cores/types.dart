class EventType {
  EventType();

  static get player => "player";
}

class IEventData {
  final String eventType;
  final dynamic payload;

  IEventData({
    required this.eventType,
    required this.payload,
  });
}

class IPlayerPayloadData {
  final String playerId;
  final String skillId;

  IPlayerPayloadData({
    required this.playerId,
    required this.skillId,
  });
}
