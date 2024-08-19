# Countdown

A new Flutter project for implementing the letter portion of the British game show "Countdown."

## Overview

This application allows users to play the letter portion of the Countdown game. The game includes:
- A main menu screen
- A settings screen with difficulty options (Easy, Medium, Hard)
- A game screen with a timer and word submission
- A scoring system based on the length of the submitted word
- Word validation using a dictionary API
- An instructions screen
- A high scores screen

## Getting Started

This project is a starting point for a Flutter application. Follow the instructions below to set up and run the project.

### Installation Instructions

1. **Prerequisites**:
    - Ensure that you have Flutter installed. You can install it from the [Flutter official website](https://docs.flutter.dev/get-started/install).
    - Install Android Studio or Visual Studio Code with the Flutter and Dart plugins.

2. **Clone the Repository**:
    - Clone the project repository to your local machine using:
      ```bash
      git clone https://github.com/yourusername/countdown.git
      ```

3. **Navigate to the Project Directory**:
   ```bash
   cd countdown
   ```
   
4. **Install Dependencies:**:
   ```bash
   flutter pub get
   ```

5. **Run the App:**:
   ```bash
   flutter run
   ```

6. **Hardware Requirements:**:
    - Operating System: Windows 10/11, macOS Catalina or later, or Linux (latest stable release)
    - RAM: Minimum 8 GB (16 GB recommended for better performance)
    - Storage: At least 20 GB of free disk space for Flutter SDK, Android Studio, and project files
    - Processor: Intel Core i5 or equivalent (Core i7 or equivalent recommended)
    - Display: 1920 x 1080 or higher resolution monitor
    - Flutter SDK: Latest stable version
    - Android Studio/VS Code: Updated to the latest version with Flutter and Dart plugins.

7. **Login Requirements/Credentials for Testing:**:
    - No login is required to access the application. All features are available to users without authentication.

8. **Known Bugs:**:
    - Timer Inconsistency: On older devices or under heavy load, the timer may experience slight delays.
    - Words Issues: Not verifying or adding word to a list. When some of the letter are not present in the game a word can be scored.
    - UI Scaling Issues: On very small screens (less than 4 inches), some UI elements may overlap or not display correctly.
    - API Connectivity: If the dictionary API is unreachable due to network issues, word validation will fail, and the game will display an error message.

9. **Special Requirements:**:
    - Network Access: The application requires internet access for word validation using the dictionary API. Ensure your device is connected to a reliable network. 
    - Device Compatibility: The app is optimized for modern smartphones and tablets. Performance on older devices may vary. 
    - Flutter Version: Use the latest stable version of Flutter to avoid compatibility issues. Older versions may not support all features used in the app.