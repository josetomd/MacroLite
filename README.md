# 🍽️ MacroLite

**MacroLite** is a macro-tracking application built with **SwiftUI**.
Designed for users who prioritize **speed**, **simplicity**, and **data integrity**, it delivers a low-friction experience for logging daily nutrition and tracking fitness progress.

---

## 🎥 App Demo

<table>
<tr>
<td align="center">
<a href="https://github.com/user-attachments/assets/e4f25f4a-509c-4cd7-88af-41029e6b1f27">
<img width="260" alt="onboarding-portrait" src="https://github.com/user-attachments/assets/5d9ec91b-b853-424c-83bd-8b0474247b19" />
</a>
</td>

<td align="center">
<a href="https://github.com/user-attachments/assets/501398af-7db5-4edd-82f2-42f21ace459e">
<img width="260" alt="scroll-thumbnail-portrait" src="https://github.com/user-attachments/assets/a7a9f66b-64a3-4ed8-ad3b-ceb5d4c84876"/>
</a>
</td>

<td align="center">
<a href="https://github.com/user-attachments/assets/cdb891fe-a7ab-401b-846e-e170159d2952">
<img width="260" alt="macro-breakdown-portrait" src="https://github.com/user-attachments/assets/5c938cb8-390b-40a2-bf79-a274874fb1e0" />
</a>
</td>
</tr>
</table>

---

## 📸 Screenshots

<p align="center">
  <img width="200" alt="home" src="https://github.com/user-attachments/assets/43e8d2d6-5f68-450f-997b-78be5331849a" />
  <img width="200" alt="home-dark" src="https://github.com/user-attachments/assets/2f442dfc-5e52-4ed0-9ebf-f4894a1d21bf" />
  <img width="200" alt="welcome" src="https://github.com/user-attachments/assets/38b38ac7-5f65-4433-8ede-bdf995090cfc" />
  <img width="200" alt="details" src="https://github.com/user-attachments/assets/9a681c29-bf09-40fc-b993-170751e698da" />
</p>

---

## 📱 Features

* ⚡ **Real-time Nutrition Tracking**
  Instantly updates calories and macronutrients (**Protein**, **Carbs**, **Fats**) as you log entries.

* 💾 **Persistent Data Store**
  Reliable local storage using **SwiftData**, ensuring full offline access.

* 📊 **Progress Visualization**
  Clean, intuitive UI to compare daily goals vs. actual intake.

* 🎯 **Minimalist UI/UX**
  Built following **Apple’s Human Interface Guidelines (HIG)** for a smooth native experience.

* 🔊 **Feedback Systems: Sounds & Haptics**
  To enhance the user experience and provide clear state confirmation, this project implements a multi-sensory feedback system:

  * **Acoustic Feedback** (UI sounds)
  * **Haptic Feedback** (tactile vibrations)

* 🌍 **Internationalization (i18n)**
  MacroLite leverages Apple’s localization system to provide a seamless multilingual experience based on the user’s device settings.
  Currently available in:

  * 🇺🇸 English
  * 🇪🇸 Spanish

---

## 🏗 Architecture

MacroLite follows the **MVVM (Model-View-ViewModel)** pattern to ensure scalability, testability, and maintainability.

### 🔹 View

* Built with **SwiftUI**
* Declarative and state-driven
* Keeps logic minimal ("dumb" views)

### 🔹 ViewModel

* Handles **business logic** and **data transformation**
* Uses the **Observation** framework for reactive updates
* Acts as the bridge between UI and data

### 🔹 Model

Defines core data structures:

* Nutritional entries
* Differentiates between **Food used as entries** and **Food stored in the catalog**
* User profiles

### 🔹 Data Layer

* Encapsulates persistence logic
* Keeps storage implementation abstracted from the app

---

## 🛠 Tech Stack

| Category     | Technology |
| ------------ | ---------- |
| Language     | Swift 5.10 |
| Framework    | SwiftUI    |
| Persistence  | SwiftData  |
| Architecture | MVVM       |
| Tools        | Xcode 16+  |

---

## 🧪 Testing

A dedicated test suite ensures reliability, especially in the presentation layer.

* ✅ **Unit Tests**

  * Validate ViewModel logic
  * Macro calculations
  * Data validation rules

* 🧩 **Mocking**

  * Protocol-Oriented Programming
  * Isolated and deterministic tests

---

## 🚀 Getting Started

### 1. Clone the repository

Clone the project from GitHub and navigate into the project folder.

```bash
git clone https://github.com/josetomd/MacroLite.git
cd MacroLite
```

### 2. Open the project in Xcode

Open the project using Xcode.

```bash
open MacroLite.xcodeproj
```

Alternatively, open it manually from **Xcode**.

### 3. Select a simulator

In Xcode, choose an iPhone simulator such as:

- iPhone 15 Pro  
- iPhone 16
### 4. Run the app

Build and run the project.

```bash
⌘ + R
```

The app will compile and launch in the iOS Simulator.
