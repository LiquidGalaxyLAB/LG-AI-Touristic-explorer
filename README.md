
<p align="center">
  <img src="https://github.com/Manas-33/Manas-33/blob/76405e2ef1aa037800645ab026d41197c0ea5d7a/Big%20Logo.png" alt="Logo" height=350>
</p>

# LG AI Touristic Explorer



## Table of Contents

- [About](#about)
   - [Project Overview](#project-overview)
   - [Key Objectives](#key-objectives)

- [Features](#features)

- [Getting Started](#getting-started)
   - [Prerequisites](#prerequisites)
     
   - [Installation](#installation)

- [Screenshots](#screenshots)

- [Future Enhancements](#future-enhancements)

## About

### Project Overview
The **LG AI Touristic Explorer** is a Flutter application designed to offer an immersive exploration of cities. Its primary aim is to provide users with detailed insights into a city's historical, cultural, and geographical aspects, along with comprehensive information about various points of interest. The app can narrate stories about the city, enhancing the user experience with a deeper understanding of the location. It also features KML visualizations for select cities, multilingual support, and customizable color themes. The information is powered by Google's Gemini API, with narration handled by the Deepgram API.

### Key Objectives
- **City Exploration:** Allow users to explore cities with in-depth information about their history, culture, geography, and places of attraction.
- **Interactive Storytelling:** Generate and narrate city stories to offer users a unique experience.
- **Visualization:** Use KML data to visualize city layouts and historical maps.
- **Customization:** Provide multilingual support and customizable themes.

## Features

- **City Search 🔍:**
  Users can search for any city and receive comprehensive information about it.

- **AI-Powered City Information 🤖:**
  Integration with Google's Gemini API to generate detailed city information.

- **Storytelling with Gemini And Deepgram 📖:**
  Generate and narrate story regarding the given city.

- **Points of Interest (POI) Exploration 🏛️:**
  Users can explore various POIs within the city, each accompanied by detailed information using orbits.

- **KML Visualizations 🌍:**
  The app supports KML visualizations, allowing users to view city outlines, historical maps, and orbits.

- **Liquid Galaxy Rig Integration 🌐:**
  Users can connect to a Liquid Galaxy rig for a fully immersive experience, including a virtual tour of city POIs.

- **Flashcard Information Display 🃏:**
  During the virtual orbit, information about each POI is presented in a flashcard format, providing quick and engaging content.

- **In-App Demonstration 💻:**
  Users without a Liquid Galaxy rig can still explore cities and POIs within the app.

- **Orbits:** Offer orbit tours around different places of attraction in a given city.



## Getting Started

### Prerequisites
- **Flutter Development Environment:**
  Ensure Flutter is installed and set up. For installation, refer to the [Flutter official documentation](https://docs.flutter.dev/get-started/install).
  
- **Compatible Device:**
  A 10” tablet with Android 13 or API level 34 is recommended for optimal performance.

- **Liquid Galaxy Rig:**
  Set up a Liquid Galaxy rig for immersive city exploration.

- **API Keys:**
  Accounts for Gemini AI, Deepgram AI, and Google Maps SDK are required. Obtain and configure API keys within the project.

### Installation

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/LiquidGalaxyLAB/LG-AI-Touristic-explorer.git
   ```

2. **Install Flutter Dependencies:**
   ```bash
   flutter pub get
   ```

3. **Enter Google Maps API Key**
   Enter the Google Maps API key in the `android\app\src\main\AndroidManifest.xml` 
   ```
   <meta-data
    android:name="com.google.android.geo.API_KEY"
    android:value="YOUR_GOOGLE_MAPS_API_KEY"/>
   ```
   Replace the value of `YOUR_GOOGLE_MAPS_API_KEY` with your API Key.

4. **Run the App:**
   ```bash
   flutter run
   ```

<!-- 5. **Set Up Liquid Galaxy Rig:**
   Follow the provided guidelines to connect and configure your Liquid Galaxy rig. -->

## Screenshots
| **Homepage** | **City Information** |
|:--:|:--:|
| ![main](https://github.com/Manas-33/Manas-33/blob/9df809b67cf6e0d33a19ee042a4f7ed01b66d491/Screenshot_1724325514.png) | ![information](https://github.com/Manas-33/Manas-33/blob/9df809b67cf6e0d33a19ee042a4f7ed01b66d491/Screenshot_1724325536.png) |

| **LG Tasks** | **Connection Manager** |
|:--:|:--:|
| ![tasks](https://github.com/Manas-33/Manas-33/blob/9df809b67cf6e0d33a19ee042a4f7ed01b66d491/Screenshot_1724325562.png) | ![connection](https://github.com/Manas-33/Manas-33/blob/1e4dfca5043eaa4751c771b45cd6c91a86b0d650/Screenshot_1724324417.png) |

| **Drawer** | **Carousel Card** |
|:--:|:--:|
| ![drawer](https://github.com/Manas-33/Manas-33/blob/c6750348852d33e0c8dc3d67110a8d8d94a14998/Screenshot_1724323985.png) | ![card](https://github.com/Manas-33/Manas-33/blob/c6750348852d33e0c8dc3d67110a8d8d94a14998/Screenshot_1724323899.png) |




---

### Future Enhancements
- **Expanded Visualization Options:**
  Additional KML data and visualization options can be incorporated in future updates.
  
---
