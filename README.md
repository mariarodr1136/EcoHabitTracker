# EcoHabit Tracker ♻️🦸‍♀️

EcoHabit Tracker is an engaging iOS app designed to inspire and empower kids to adopt sustainable habits in a fun, interactive, and educational way. By leveraging gamification, engaging challenges, and bite-sized educational tips, this app teaches kids the importance of making eco-friendly choices in their daily lives.

Through completing exciting sustainability challenges, tracking their progress, and earning rewards, kids learn how their small actions—such as reducing plastic use, conserving water, and adopting energy-saving habits—can collectively make a big difference for the environment.

The app also features an AI-powered assistant, offering personalized guidance, answering environmental questions, and motivating kids with encouraging messages. This combination of education, technology, and gamification helps foster a generation of eco-heroes who feel equipped and motivated to lead a greener future while having fun along the way.

![Swift](https://img.shields.io/badge/Language-Swift-orange) ![SwiftUI](https://img.shields.io/badge/Framework-SwiftUI-blue) ![Xcode](https://img.shields.io/badge/IDE-Xcode-lightblue) ![Hugging Face](https://img.shields.io/badge/Library-Hugging_Face-purple)

## Table of Contents
- [Purpose](#purpose)
- [Features](#features)
- [Code Structure](#code-structure)
- [Installation](#installation)
- [Requirements](#requirements)
- [Contributing](#contributing)
- [Contact](#contact-)

## Purpose:

EcoHabit Tracker aims to make sustainable living exciting for kids by motivating them to adopt eco-friendly habits such as reducing plastic use, saving water, and eating plant-based meals. By completing challenges, earning points, and learning fun facts, kids can see the impact of their actions and inspire others to do the same.

## Features:

- **Gamification**: Earn points for completing challenges and building eco-friendly habits.
- **Challenges**: Take on sustainability challenges that promote eco-friendly behaviors.
- **Impact Tracker**: Track your progress and see the environmental impact of your actions.
- **Rewards**: Unlock medals (Bronze, Silver, Gold, and Platinum) based on earned points.
- **Educational Tips**: Receive daily tips and fun facts about sustainability.
- **AI Assistant**: Integrated a conversational AI assistant powered by the Hugging Face API to provide personalized guidance, answer queries related to environmental impact, and motivate users with inspiring messages.

---

![EcoHabits Tracker](https://github.com/user-attachments/assets/156bd8db-4d8c-4fa1-a1ae-4312ea9cec6e)

---

## Code Structure:

The app is built using Swift and SwiftUI. It consists of several key components:

- **HomeView**: The main interface where users can view challenges, receive tips, and track progress.
- **ChallengesView**: Allows users to browse, filter, and start eco-friendly challenges, tracking their progress along the way.
- **RewardsView**: Displays the rewards system where users can see the medals they’ve earned and how many points they need for the next level.
- **AI Integration**: Leverages the Hugging Face API to integrate a conversational assistant that enhances user interaction.

---

<div align="center">
   <h3>AI Assistant Update</h3>
  <img src="https://github.com/user-attachments/assets/e7fa97c0-39f2-4fd7-b3cd-205287a242e6" alt="EcoHabit Tracker" width="300">
</div>

---


## Installation:

1. Clone the repository:
   ```bash
   git clone https://github.com/mariarodr1136/EcoHabitTracker.git
2. Open the project in Xcode.
3. **Important Step**: Obtain an API key from Hugging Face to ensure the app works as expected. Follow these steps to get your token:

- Visit [Hugging Face](https://huggingface.co) and sign up for a free account if you don’t already have one.
- Log in, and go to Settings by clicking your profile picture in the top-right corner.
- Select Access Tokens and click New Token.
- Name your token (e.g., “EcoHabitTracker”) and click Generate Token.
- Copy the generated token.

- Open the ChatMessage class file and navigate to line 23. Update the following line by pasting your token:

   ```bash
   private let apiToken = "your_generated_token_here"

4. Run the app on the simulator or on a physical iOS device.

## Requirements

- macOS Sonoma or later
- Xcode 12.0 or later
- iOS 14.0 or later
- Swift 5.3 or later


## Contributing:

Feel free to submit issues or pull requests for improvements or bug fixes. All contributions are welcome to enhance the app’s features or functionality!

To contribute, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix:
   ```bash
   git checkout -b feat/your-feature-name
- Alternatively, for bug fixes:
   ```bash
   git checkout -b fix/your-bug-fix-name
3. Make your changes and run all tests before committing the changes and make sure all tests are passed.
4. After all tests are passed, commit your changes with descriptive messages:
   ```bash
   git commit -m 'add your commit message'
5. Push your changes to your forked repository:
   ```bash
   git push origin feat/your-feature-name.
6. Submit a pull request to the main repository, explaining your changes and providing any necessary details.

## Contact 🌐

If you have any questions or feedback, feel free to reach out at [mrodr.contact@gmail.com](mailto:mrodr.contact@gmail.com).

