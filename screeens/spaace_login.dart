import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class SpaceLogin extends StatefulWidget {
  const SpaceLogin({super.key});

  @override
  State<SpaceLogin> createState() => _SpaceLoginState();
}

class _SpaceLoginState extends State<SpaceLogin> {
  final _emailController = TextEditingController();

  void _routeLogin() {
    String roleInput = _emailController.text.trim().toLowerCase();
    if (roleInput.contains("faculty")) {
      Navigator.pushReplacementNamed(context, '/admin');
    } else {
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF0D1117), Color(0xFF161B22)]),
        ),
        child: Center(
          child: GlassContainer(
            width: 340,
            blur: 15,
            borderRadius: BorderRadius.circular(25),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.meeting_room_rounded, size: 55, color: Colors.cyanAccent),
                  const SizedBox(height: 15),
                  const Text("SpaceShare", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  const Text("Campus Resource Allocation", style: TextStyle(color: Colors.white54, fontSize: 12)),
                  const SizedBox(height: 25),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: "Enter Email ('faculty' for Admin)",
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                    onPressed: _routeLogin,
                    child: const Text("ACCESS HUB", style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
