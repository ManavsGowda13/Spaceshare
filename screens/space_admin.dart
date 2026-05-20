import 'package:flutter/material.dart';
import '../models/resource_model.dart';

class SpaceAdmin extends StatefulWidget {
  const SpaceAdmin({super.key});

  @override
  State<SpaceAdmin> createState() => _SpaceAdminState();
}

class _SpaceAdminState extends State<SpaceAdmin> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amenitiesController = TextEditingController();
  final _nodesController = TextEditingController();
  String _selectedType = "LABS";

  void _createNewSpace() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF161B22),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Provision New Resource", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
              const SizedBox(height: 15),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Room Identifier *"),
                validator: (val) => val!.isEmpty ? "Required field" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _amenitiesController,
                decoration: const InputDecoration(labelText: "Equipment Specs (Comma separated values) *"),
                validator: (val) => val!.isEmpty ? "Required field" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _nodesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Total Hardware Nodes / Desktops *"),
                validator: (val) => val!.isEmpty ? "Required field" : null,
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: const InputDecoration(labelText: "Resource Type Category"),
                dropdownColor: const Color(0xFF161B22),
                items: ["LABS", "SEMINAR HALLS", "PROJECT ROOMS"].map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) _selectedType = value;
                },
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    int nodeCount = int.tryParse(_nodesController.text) ?? 10;
                    setState(() {
                      mockRooms.add(ResourceRoom(
                        roomName: _nameController.text,
                        location: "Allocated Campus Block",
                        type: _selectedType,
                        tags: _amenitiesController.text.split(','),
                        activeTime: "09:00 AM - 05:00 PM",
                        totalNodes: nodeCount,
                        activeNodes: nodeCount,
                        capacity: nodeCount,
                      ));
                    });
                    _nameController.clear();
                    _amenitiesController.clear();
                    _nodesController.clear();
                    Navigator.pop(context);
                  }
                },
                child: const Text("PUBLISH SPACE", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Faculty Space Controls"),
        actions: [
          IconButton(icon: const Icon(Icons.add_circle_outline, size: 28), onPressed: _createNewSpace),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: mockRooms.length,
        itemBuilder: (context, i) => Card(
          color: Colors.white10,
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            title: Text(mockRooms[i].roomName, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Category: ${mockRooms[i].type}\nHardware Nodes: ${mockRooms[i].activeNodes}/${mockRooms[i].totalNodes} Live"),
            isThreeLine: true,
            trailing: Icon(
                mockRooms[i].isBooked ? Icons.lock : Icons.lock_open,
                color: mockRooms[i].isBooked ? Colors.redAccent : Colors.greenAccent
            ),
          ),
        ),
      ),
    );
  }
}
