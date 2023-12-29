# Vonette Schools Mobile Application

The Vonette Schools Mobile Application is a Flutter-based mobile application that provides a platform for students to interact with each other, their counselors, and their clubs. The application is integrated with Firebase for the backend and utilizes C++ and Cmake to properly integrate Dart with Firebase.

## Features

The Vonette Schools Mobile Application offers the following features:

- Authentication using Google or Vonette account credentials
- Homepage to view all registered clubs and announcements
- Club pages to contribute to group discussions
- Messaging page to communicate with students
- Calendar page to add personalized to-do lists and events
- Settings page to create clubs, report bugs or users, logout, and personalize account


## Authentication

Users can sign in to the application using their Google or Vonette account credentials. Once authenticated, users can access all the features of the application.

## Homepage

The homepage is the first page that users see when they open the application. The homepage displays all registered clubs and announcements. Users can click on a club or an announcement to view more details about it.

## Club Pages

Each club has its own page where users can contribute to group discussions. Users can post messages, images, and videos, and they can also reply to messages posted by other users.

## Messaging Page

The messaging page is where users can communicate with each other. Users can search for other students by name or username and add them to their contacts list. Once added, users can send and receive direct messages with each other.

## Calendar Page

The calendar page allows users to add personalized to-do lists and events. Users can also view events added by clubs they are a part of. Clubs can add events to the calendar on a certain day, and all students who are part of that club can view those events.

## Settings Page

The settings page is where users can create their own clubs, report bugs or users, logout, and personalize their account. Users can create a club by providing basic information about the club, such as its name and description. Users can also report bugs or users if they encounter any issues with the application. Finally, users can personalize their account by updating their profile picture and other details.

## Installation

In order to run the Vonette Schools Mobile Application on your local computer, you will need to follow these steps:

## Prerequisites

- Flutter SDK installed on your local computer
- Android Studio or Xcode installed on your local computer
- Firebase account and project created
- Flutter and Dart plugins installed in Android Studio or Xcode
- Google services configuration file for Firebase

# Installation Steps

1. Clone the repository from GitHub:

```
git clone https://github.com/<username>/<repository>.git
```

2. Change directory to the project directory:

```
cd <repository>
```

3. Download the required dependencies:

```
flutter pub get
```

4. Add the Google services configuration file to the project:
  - For Android: Add the **google-services.json** file to the **<project-root>/android/app directory**.
  - For iOS: Add the **GoogleService-Info.plist** file to the **<project-root>/ios/Runner directory**.
5. Run the application using the following command:
  - For Android:
  ```
  flutter run
  ```
  - For iOS:
  ```
  flutter run -d <device-id>
  ```
 
>Note: Replace **<device-id>** with the identifier of the iOS device or simulator that you want to run the application on.



##Usage

Once the application is running on your local computer, you can use it by following these steps:

1. Open the application on your mobile device or emulator.
2. Sign in using your Google or Vonette account credentials.
3. Navigate to the homepage to view all registered clubs and announcements.
4. Navigate to a club page to contribute to group discussions.
5. Navigate to the messaging page to communicate with students.
6. Navigate to the calendar page to add personalized to-do lists and events.
7. Navigate to the settings page to create clubs, report bugs or users, logout, and personalize your account.

## Contributing

If you want to contribute to the Vonette Schools Mobile Application, please follow these steps:

1. Fork the repository from GitHub.
2. Create a new branch for your changes.
3. Make your changes and commit them to your branch.
4. Push your changes to your forked repository.
5. Submit a pull request to the original repository.

## License

The Vonette Schools Mobile Application is licensed under the LLC Vonette Schools Inc.

