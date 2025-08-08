# 📝 Task Manager App

A simple **offline** task management application built with **Flutter** as part of a technical interview assessment.
The app helps users create, view, edit, and delete tasks — with persistent storage and a responsive light/dark theme.

## 🚀 Features

- **Offline Support** – Tasks are stored locally using SharedPreferences.
- **Task CRUD** – Create, Read, Update, and Delete tasks.
- **Toggle Completion** – Quickly mark tasks as complete or incomplete from the home screen.
- **Three-Screen Flow**:

  1. **Home Screen** – List of all tasks with completion toggle.
  2. **View Screen** – Detailed view of a single task.
  3. **Edit Screen** – Modify task details.

- **Automatic Theme Switching** – Light/Dark mode based on device settings.
- **Smooth State Management** – Powered by [Riverpod](https://riverpod.dev/).

## 🛠️ Tech Stack

- **Flutter** – Cross-platform UI framework.
- **Dart** – Programming language.
- **[Riverpod](https://riverpod.dev/)** – State management.
- **SharedPreferences** – Local data persistence.

## 📸 Screens

- **Home Screen** – View all tasks and toggle completion.
- **View Screen** – See full task details.
- **Edit Screen** – Modify and save task details.

## ⚙️ Installation & Running

1. **Clone the repository**

   ```bash
   git clone https://github.com/JER3MIAH/task_manager
   cd task_manager
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   ```bash
   flutter run
   ```

## 📌 Notes

- The app works completely offline.
- Tasks persist between sessions using SharedPreferences.
- Theme automatically adapts to system preference.
