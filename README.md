# task_manager

## User Authentication:

    Secure user login functionality using a dummy API (https://reqres.in/api/login) please use a user account from the website.

## Task Management (CRUD):

    Users can view, add, edit, and delete tasks retrieved from a dummy endpoint (https://reqres.in/api/tasks).
    Pagination: Efficiently handles large datasets with pagination capabilities using the provided API endpoint (https://dummyjson.com/todos?limit=10&skip=10).

## State Management (Bloc):

    Employs Bloc for effective state management, ensuring state updates are reflected throughout the app.

## Local Storage (Hive):

    Leverages Hive for persistent data storage, allowing tasks to be retained even after app closure and relaunch.

# Project Structure:

## bloc:

    Contains Bloc classes for managing application state related to tasks and authentication (planned).

## data:

    Houses models representing task data and API interaction classes(local data source not implemented).

## repository:

    Provides an abstraction layer for interacting with the data source.

## ui:

    Encompasses UI components for displaying tasks, adding new tasks, and editing existing ones.

# Building and Running the App:

    Clone the project from GitHub.
    Ensure you have Flutter and Dart installed (https://docs.flutter.dev/get-started/install).
    Run flutter pub get to install dependencies.
    Run flutter run to launch the application on a connected device or emulator.

# Additional Notes:

    This project serves as a foundation for a fully-fledged task management app.
    The code adheres to clean architecture principles, promoting separation of concerns and testability.
