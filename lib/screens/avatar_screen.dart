import 'package:flutter/material.dart';

class AvatarScreen extends StatefulWidget {
  const AvatarScreen({super.key});

  @override
  State<AvatarScreen> createState() => _AvatarScreenState();
}

class _AvatarScreenState extends State<AvatarScreen> {
  // Steps: 0 = Gender, 1 = Age, 2 = Method, 3 = Input
  int _currentStep = 0;

  // Store user choices
  String? _selectedGender;
  double _selectedAge = 22; // Default to target demographic (Gen Z)
  String? _selectedMethod;

  @override
  Widget build(BuildContext context) {
    // Calculate progress based on 4 steps
    double progress = (_currentStep + 1) / 4;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Avatar'),
        centerTitle: true,
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
              value: progress,
              backgroundColor: Colors.grey[800],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),

            // Main Content Area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: _buildCurrentStep(),
              ),
            ),

            // Bottom Navigation Area
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
        return _buildAgeStep();
      case 2:
        return _buildMethodStep();
      case 3:
        return _buildInputStep();
      default:
        return const Center(child: Text("Error"));
    }
  }

  // STEP 1: GENDER SELECTION (Icons Removed)
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

        // Selectable Rectangles (No Icons passed)
        _buildGenderTile("Male"),
        const SizedBox(height: 15),
        _buildGenderTile("Female"),
        const SizedBox(height: 15),
        _buildGenderTile("Other"),
      ],
    );
  }

  // STEP 2: AGE SELECTION
  Widget _buildAgeStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "How old are you?",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          "This helps us adjust the avatar's body proportions.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 60),

        Center(
          child: Column(
            children: [
              Text(
                "${_selectedAge.round()}",
                style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent
                ),
              ),
              const Text("years old"),
            ],
          ),
        ),
        const SizedBox(height: 40),

        Slider(
          value: _selectedAge,
          min: 13,
          max: 80,
          divisions: 67,
          activeColor: Colors.blueAccent,
          onChanged: (double value) {
            setState(() {
              _selectedAge = value;
            });
          },
        ),
      ],
    );
  }

  // STEP 3: METHOD SELECTION
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

  // STEP 4: INPUT (Placeholder)
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

  // RECTANGLE TILE BUILDER (Updated: Removed Icon Parameter)
  Widget _buildGenderTile(String label) {
    bool isSelected = _selectedGender == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.blueAccent : Colors.grey[700]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // REMOVED: Icon widget was here
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? Colors.blueAccent : Colors.white,
              ),
            ),
            const Spacer(),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? Colors.blueAccent : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  // Helper for Method Choice
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
          color: isSelected ? Colors.purpleAccent.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.purpleAccent : Colors.grey[700]!,
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

    if (_currentStep == 0 && _selectedGender != null) isNextEnabled = true;
    if (_currentStep == 1) isNextEnabled = true;
    if (_currentStep == 2 && _selectedMethod != null) isNextEnabled = true;
    if (_currentStep == 3) isNextEnabled = true;

    return Container(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            disabledBackgroundColor: Colors.grey[900],
            disabledForegroundColor: Colors.grey[600],
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: isNextEnabled
              ? () {
            if (_currentStep < 3) {
              setState(() {
                _currentStep++;
              });
            } else {
              print("Finished: Gender=$_selectedGender, Age=${_selectedAge.round()}, Method=$_selectedMethod");
            }
          }
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _currentStep == 3 ? "Create Avatar" : "Next",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_rounded, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}