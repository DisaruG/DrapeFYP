import 'package:flutter/material.dart';

class AvatarScreen extends StatefulWidget {
  const AvatarScreen({super.key});

  @override
  State<AvatarScreen> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  // Steps: 0 = Gender, 1 = Method, 2 = Input
  int _currentStep = 0;

  // Store user choices
  String? _selectedGender;
  String? _selectedMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Avatar'),
        centerTitle: true,
        // Show Back button only if we are past the first step
        leading: _currentStep > 0
            ? IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _currentStep--;
            });
          },
        )
            : null,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Top Progress Bar
            LinearProgressIndicator(
              value: (_currentStep + 1) / 3,
              backgroundColor: Colors.grey[800],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),

            // Main Content Area (Expands to fill space)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: _buildCurrentStep(),
              ),
            ),

            // Bottom Navigation Area (Next Button)
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  // --- STEP BUILDERS ---

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildGenderStep();
      case 1:
        return _buildMethodStep();
      case 2:
        return _buildInputStep();
      default:
        return const Center(child: Text("Error"));
    }
  }

  // STEP 1: GENDER SELECTION (UPDATED)
  Widget _buildGenderStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "What is your gender?",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          "Used to personalize avatar creation and clothing suggestions.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 40),

        // Selection List
        _buildGenderOption("Male", Icons.male),
        const SizedBox(height: 15),
        _buildGenderOption("Female", Icons.female),
        const SizedBox(height: 15),
        _buildGenderOption("Other", Icons.transgender),
      ],
    );
  }

  // STEP 2: METHOD SELECTION
  Widget _buildMethodStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Choose a method",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          "How would you like to build your body model?",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 40),

        _buildMethodOption(
          id: 'photo',
          title: "Take a Photo",
          subtitle: "Quickest. Requires good lighting.",
          icon: Icons.camera_alt,
        ),
        const SizedBox(height: 15),
        _buildMethodOption(
          id: 'measurements',
          title: "Enter Measurements",
          subtitle: "More manual control (Height, Weight, etc).",
          icon: Icons.straighten,
        ),
      ],
    );
  }

  // STEP 3: INPUT (Placeholder)
  Widget _buildInputStep() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
              _selectedMethod == 'photo' ? Icons.camera_alt : Icons.straighten,
              size: 80,
              color: Colors.grey
          ),
          const SizedBox(height: 20),
          Text(
              _selectedMethod == 'photo'
                  ? "Camera Interface Here"
                  : "Measurements Form Here"
          ),
        ],
      ),
    );
  }

  // --- WIDGET HELPER FUNCTIONS ---

  // Custom Widget for Gender Choice
  Widget _buildGenderOption(String label, IconData icon) {
    bool isSelected = _selectedGender == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent.withOpacity(0.2) : Colors.grey[900],
          border: Border.all(
            color: isSelected ? Colors.blueAccent : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.blueAccent : Colors.white),
            const SizedBox(width: 15),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.blueAccent : Colors.white,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.blueAccent),
          ],
        ),
      ),
    );
  }

  // Custom Widget for Method Choice
  Widget _buildMethodOption({
    required String id,
    required String title,
    required String subtitle,
    required IconData icon
  }) {
    bool isSelected = _selectedMethod == id;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = id;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purpleAccent.withOpacity(0.2) : Colors.grey[900],
          border: Border.all(
            color: isSelected ? Colors.purpleAccent : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 30, color: isSelected ? Colors.purpleAccent : Colors.white),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Colors.purpleAccent),
          ],
        ),
      ),
    );
  }

  // The Bottom "Next" Button Bar
  Widget _buildBottomBar() {
    bool isNextEnabled = false;

    // Logic to decide if Next button is clickable
    if (_currentStep == 0 && _selectedGender != null) isNextEnabled = true;
    if (_currentStep == 1 && _selectedMethod != null) isNextEnabled = true;
    if (_currentStep == 2) isNextEnabled = true; // Always enabled for last step for now

    return Container(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity, // Full width button
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey[800],
            disabledForegroundColor: Colors.grey[500],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: isNextEnabled
              ? () {
            if (_currentStep < 2) {
              setState(() {
                _currentStep++;
              });
            } else {
              // Final step action
              print("Finished: Gender=$_selectedGender, Method=$_selectedMethod");
            }
          }
              : null, // Disable button if selection is null
          child: Text(
            _currentStep == 2 ? "Create Avatar" : "Next",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}