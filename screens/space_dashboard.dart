import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import '../models/resource_model.dart';

class SpaceDashboard extends StatefulWidget {
  const SpaceDashboard({super.key});

  @override
  State<SpaceDashboard> createState() => _SpaceDashboardState();
}

class _SpaceDashboardState extends State<SpaceDashboard> {
  String _searchQuery = "";
  String _selectedCategory = "ALL";

  final List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  final List<String> _hours = ['9AM', '11AM', '1PM', '3PM'];

  final List<List<int>> _densityMatrix = [
    [3, 1, 2, 0],
    [1, 3, 0, 2],
    [2, 2, 3, 1],
    [0, 1, 2, 3],
    [3, 0, 1, 2],
  ];

  Color _getHeatmapColor(int density) {
    switch (density) {
      case 3: return Colors.redAccent.withValues(alpha: 0.7);
      case 2: return Colors.orangeAccent.withValues(alpha: 0.6);
      case 1: return Colors.teal.withValues(alpha: 0.5);
      default: return Colors.white10;
    }
  }

  void _bookSlot(ResourceRoom room) {
    setState(() {
      room.isBooked = !room.isBooked;
      if (!room.isBooked) {
        room.isVerifiedCheckIn = false;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(room.isBooked ? "Reserved ${room.roomName}! Scan QR code to verify entry." : "Booking Released."),
        backgroundColor: room.isBooked ? Colors.cyan : Colors.blueGrey,
      ),
    );
  }

  void _simulateQRScan(BuildContext context, ResourceRoom room) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF161B22),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Scan Lab Entry QR Code", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 20),
            Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.cyanAccent, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.qr_code_scanner_rounded, size: 70, color: Colors.white54),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent, foregroundColor: Colors.black),
              onPressed: () {
                setState(() => room.isVerifiedCheckIn = true);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Identity Verified. Session Activated!"), backgroundColor: Colors.green),
                );
              },
              child: const Text("Simulate Device Authentication Scan", style: TextStyle(fontWeight: FontWeight.bold)),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<ResourceRoom> filteredRooms = mockRooms.where((room) {
      bool matchesSearch = room.roomName.toLowerCase().contains(_searchQuery.toLowerCase());
      bool matchesCategory = _selectedCategory == "ALL" || room.type == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("SpaceShare Hub"), centerTitle: true, elevation: 0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: "Search lab or room identifiers...",
                prefixIcon: const Icon(Icons.search, color: Colors.cyanAccent),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: ["ALL", "LABS", "SEMINAR HALLS", "PROJECT ROOMS"].map((category) {
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category, style: TextStyle(color: isSelected ? Colors.black : Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                    selected: isSelected,
                    selectedColor: Colors.cyanAccent,
                    backgroundColor: Colors.white10,
                    onSelected: (bool selected) {
                      setState(() => _selectedCategory = category);
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GlassContainer(
              blur: 10,
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.analytics_outlined, size: 16, color: Colors.cyanAccent),
                        SizedBox(width: 6),
                        Text("Weekly Lab Load Matrix (Heatmap)", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Table(
                      children: List.generate(_days.length, (rowIndex) {
                        return TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(_days[rowIndex], style: const TextStyle(fontSize: 10, color: Colors.white38)),
                            ),
                            ...List.generate(_hours.length, (colIndex) {
                              int densityValue = _densityMatrix[rowIndex][colIndex];
                              return Container(
                                margin: const EdgeInsets.all(2),
                                height: 18,
                                decoration: BoxDecoration(
                                  color: _getHeatmapColor(densityValue),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                      _hours[colIndex],
                                      style: const TextStyle(fontSize: 7, color: Colors.white54, fontWeight: FontWeight.bold)
                                  ),
                                ),
                              );
                            }),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text("Resources Found", style: TextStyle(color: Colors.white54, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: filteredRooms.isEmpty
                ? const Center(child: Text("No spaces match search queries.", style: TextStyle(color: Colors.white38)))
                : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.95,
              ),
              itemCount: filteredRooms.length,
              itemBuilder: (context, index) {
                final room = filteredRooms[index];
                Color accentColor = Colors.greenAccent;
                if (room.isBooked) {
                  accentColor = room.isVerifiedCheckIn ? Colors.orangeAccent : Colors.redAccent;
                }

                return GlassContainer(
                  blur: 14,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: accentColor.withValues(alpha: 0.25), width: 1),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(color: accentColor.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
                              child: Text(
                                room.isBooked
                                    ? (room.isVerifiedCheckIn ? "ACTIVE USE" : "PENDING SCAN")
                                    : "AVAILABLE",
                                style: TextStyle(color: accentColor, fontSize: 8, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text("Nodes: ${room.activeNodes}/${room.totalNodes}", style: const TextStyle(color: Colors.white38, fontSize: 9)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(room.roomName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 2),
                            Text(room.location, style: const TextStyle(color: Colors.white38, fontSize: 10)),
                          ],
                        ),
                        Wrap(
                          spacing: 4,
                          runSpacing: 2,
                          children: room.tags.map((tag) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(4)),
                            child: Text(tag, style: const TextStyle(color: Colors.cyanAccent, fontSize: 8)),
                          )).toList(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(room.activeTime, style: const TextStyle(color: Colors.white54, fontSize: 9)),
                            Row(
                              children: [
                                if (room.isBooked && !room.isVerifiedCheckIn)
                                  IconButton(
                                    constraints: const BoxConstraints(),
                                    padding: const EdgeInsets.only(right: 8),
                                    icon: const Icon(Icons.qr_code_2_rounded, size: 20, color: Colors.cyanAccent),
                                    onPressed: () => _simulateQRScan(context, room),
                                  ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(60, 28),
                                    padding: const EdgeInsets.symmetric(horizontal: 8),
                                    backgroundColor: room.isBooked ? Colors.white10 : Colors.cyanAccent,
                                    foregroundColor: room.isBooked ? Colors.white38 : Colors.black,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                    elevation: 0,
                                  ),
                                  onPressed: () => _bookSlot(room),
                                  child: Text(room.isBooked ? "Release" : "Book", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
