# Flutter FCM Notification System

Flutter FCM Notification System is a Flutter project that integrates Firebase Cloud Messaging (FCM) and Awesome Notifications to handle and display push notifications for calls and messages. 

## Features
- **Firebase Initialization**: Set up and initialize Firebase in a Flutter app with platform-specific options.
- **Message Handling**: Handle background and foreground messages using Firebase Messaging.
- **Custom Notifications**: Create customizable notifications for calls and messages with action buttons using the Awesome Notifications package.
- **Sample UI**: A simple user interface for testing notification functionalities.

## Getting Started

### Prerequisites
- Flutter SDK
- Firebase project
- Awesome Notifications package

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/your-username/flutter-fcm-notification-system.git
    cd flutter-fcm-notification-system
    ```

2. Install dependencies:
    ```sh
    flutter pub get
    ```

3. Set up Firebase:
    - Follow the instructions to set up Firebase for your Flutter project: https://firebase.flutter.dev/docs/overview
    - Replace the placeholders in `firebase_options.dart` with your actual Firebase project values.

4. Run the app:
    ```sh
    flutter run
    ```

## Usage

- **Get Token**: Click the "Get Token" button to print the FCM token to the console.
- **Send Message Notification**: Click the "Send Message Notification" button to send a message notification.
- **Send Call Notification**: Click the "Send Call Notification" button to send a call notification.

## Code Overview

### Main Application (`main.dart`)

- **Firebase Initialization**: Initializes Firebase with platform-specific options.
- **Awesome Notifications Setup**: Sets up notification channels for calls and messages.
- **Background Message Handler**: Handles background messages from Firebase.
- **runApp**: Starts the Flutter application.

### Home Page (`home_page.dart`)

- **Notification Handling**: Listens for foreground messages and handles notification clicks.
- **UI**: Provides buttons for testing notification functionalities.

## License
[MIT](LICENSE)

