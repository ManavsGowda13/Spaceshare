class ResourceRoom {
  final String roomName;
  final String location;
  final String type;
  final List<String> tags;
  final String activeTime;
  final int totalNodes;
  int activeNodes;
  final int capacity;
  bool isBooked;
  bool isVerifiedCheckIn;

  ResourceRoom({
    required this.roomName,
    required this.location,
    required this.type,
    required this.tags,
    required this.activeTime,
    required this.totalNodes,
    required this.activeNodes,
    required this.capacity,
    this.isBooked = false,
    this.isVerifiedCheckIn = false,
  });
}

List<ResourceRoom> mockRooms = [
  ResourceRoom(
    roomName: "ISE Advanced Lab",
    location: "3rd Floor, Block A",
    type: "LABS",
    tags: ["Wi-Fi", "PCs", "Projector"],
    activeTime: "09:00 AM - 11:00 AM",
    totalNodes: 30,
    activeNodes: 28,
    capacity: 30,
  ),
  ResourceRoom(
    roomName: "Main Seminar Hall",
    location: "Ground Floor, Central Block",
    type: "SEMINAR HALLS",
    tags: ["AC", "Audio", "Stage"],
    activeTime: "02:00 PM - 04:30 PM",
    totalNodes: 1,
    activeNodes: 1,
    capacity: 150,
  ),
  ResourceRoom(
    roomName: "Project Room 102",
    location: "1st Floor, Tech Block",
    type: "PROJECT ROOMS",
    tags: ["Whiteboard", "LAN Ports"],
    activeTime: "11:30 AM - 01:00 PM",
    totalNodes: 8,
    activeNodes: 7,
    capacity: 8,
  ),
];
