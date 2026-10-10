# Uncle Grandpa

**Bored? Let's find something fun to do!**

A playful Flutter app that suggests random activities to make your day a little more interesting.

![Uncle Grandpa App Screenshot](docs/screenshots/home_screen.png)

## About the Project

Uncle Grandpa is a Flutter learning project I built to practice **HTTP requests, REST APIs, JSON handling, and Clean Architecture**.

I independently implemented the domain layer, data handling, API integration, business logic, and application state management to better understand how these concepts work together. I used AI assistance for UI design and implementation.

The app fetches random activities from a public API and displays them through a colorful, cartoon-inspired interface.

## Features

- 🎲 Discover random activities
- 🏷️ View activity categories and participant counts
- 🔗 Open related activity links when available
- ⏳ Handle loading and error states
- 🎨 Enjoy a playful UI with an expressive cartoon mascot

## Tech Stack

- **Flutter & Dart**
- **HTTP & REST API**
- **JSON Parsing**
- **Clean Architecture principles**
- **ChangeNotifier** for state management
- **url_launcher** for external links

## Architecture

The project follows a feature-first structure with three layers:

- **Domain:** Entities, repository contracts, and use cases
- **Data:** Models, remote data sources, and repository implementations
- **Presentation:** Controllers, pages, and reusable widgets

```text
UI → Controller → Use Case → Repository → Data Source → API
```

## Learning Notes 📚

I've also included reference notebooks covering concepts I've been studying throughout my Flutter learning journey.

- [HTTP, REST & JSON — Chapter 04](docs/notes/Flutter_Interview_Reference_Notebook_04_HTTP_REST_JSON.docx)
- [Git Mental Model & Team Workflow — Chapter 02](docs/notes/Flutter_Interview_Reference_Notebook_02_Git_Mental_Model_and_Team_Workflow.docx)

These notebooks include broader topics beyond those implemented in this app.

## Getting Started

Make sure Flutter is installed, then run:

```bash
flutter pub get
flutter run
```

## AI Assistance

I independently worked on the domain, data, API integration, and application logic as part of my learning process. AI assisted with UI/UX design, Flutter UI implementation, and visual refinements.

---

## Screenshot of the App
<img width="1122" height="1402" alt="image" src="https://github.com/user-attachments/assets/fddbd102-3e96-4a3d-9197-202b99fa4a0f" />


*Built to learn Flutter by doing.* 🚀

