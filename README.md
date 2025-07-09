# 🎬 Movies App

A beautifully designed Flutter application for browsing and exploring the **latest and most popular movies**, built with **Clean Architecture**, **MVVM pattern**, and **BLoC** for state management.

---

## 🌟 Features

- 🔐 **Authentication**
  - Full auth flow: Sign Up, Login, Forgot Password
  - Profile photo selection during registration
  - Reset password and delete account

- 🏠 **Home Tab**
  - Displays **Most Popular Movies**
  - Horizontal carousels for each genre

- 📽️ **Movie Details Screen**
  - View movie info, screenshots, cast, and suggestions
  - Download or open the movie’s external site

- 🔍 **Browse Tab**
  - Powerful **search** functionality for movies

- 🧭 **Explore Tab**
  - Genre-based grid with **infinite scroll (pagination)**

- 👤 **Profile Tab**
  - View personal info, favorites, and watch history
  - Profile update (image, name, email, password)

---

## 🧠 Architecture

- ✅ **Clean Architecture**
- ✅ **MVVM Design Pattern**
- ✅ **Feature-based Modular Structure**
- ✅ **Hydrated Bloc & Offline Support**
- ✅ **Dependency Injection** with `get_it` and `injectable`

---

## 📱 UI Previews

### 🖼️ Authentication
![movies mookup1](https://github.com/khalidabdelrazk/photos/blob/main/movies%20mookup1.png?raw=true)

### 🖼️ Root
![movies mookup2](https://github.com/khalidabdelrazk/photos/blob/main/movies%20mookup2.png?raw=true)

### 🖼️ Profile
![movies mookup3](https://github.com/khalidabdelrazk/photos/blob/main/movies%20mookup3.png?raw=true)

### 🖼️ Movie Details
![movies mookup4](https://github.com/khalidabdelrazk/photos/blob/main/movies%20mookup4.png?raw=true)

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (latest stable)
- Android Studio / VSCode / Xcode
- A connected device or emulator

---

## 💡 Contribution

Feel free to **fork** the project and **submit a pull request**.  
For major changes, please **open an issue first** to discuss what you would like to change.


### Installation

1.  **Clone the repository**:

    ```bash
    git clone https://github.com/khalidabdelrazk/movies_app.git
    ```

2.  **Navigate to the project directory**:

    ```bash
    cd movies_app
    ```

3.  **Get Flutter dependencies**:

    ```bash
    flutter pub get
    ```

4.  **Run the application**:

    ```bash
    flutter run
    ```

---

## 🧩 Packages Used

The following key packages were utilized in the development of this application:

```yaml
dependencies:
  cupertino_icons: ^1.0.8
  flutter_native_splash:
  cached_network_image: ^3.4.1
  carousel_slider: ^5.0.0
  flutter_screenutil: ^5.9.3
  icons_plus: ^5.0.0
  flutter_svg: ^2.1.0
  google_fonts: ^6.2.1
  animated_toggle_switch: ^0.8.5
  bloc: ^9.0.0
  fluttertoast: ^8.2.12
  flutter_bloc: ^9.1.1
  either_dart: ^1.0.0
  connectivity_plus: ^6.1.4
  dio: ^5.8.0+1
  get_it: ^8.0.3
  injectable: ^2.5.0
  shared_preferences:
  http: ^1.3.0
  easy_localization: ^3.0.7+1
  provider: ^6.1.5
  introduction_screen: ^3.1.17
  hydrated_bloc: ^10.0.0
  path_provider: ^2.1.5
  photo_view: ^0.14.0
  url_launcher: ^6.2.6



