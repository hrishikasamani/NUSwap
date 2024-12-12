# NUSwap

**NUSwap** is a student-only marketplace app built using Swift for iOS. Designed exclusively for Northeastern University students, the app provides a secure platform to buy and sell second-hand items within the campus community, leveraging verified `northeastern.edu` email authentication. The app simplifies transactions during move-ins and move-outs, ensuring a seamless and trustworthy experience.

## Table of Contents
- [Features](#features)
- [MainScreens](#mainscreens)
- [Requirements](#requirements)
- [Installation](#installation)
- [Setup](#setup)
- [Usage](#usage)
- [Contact](#contact)

## Features
- **Secure Authentication**: Users can sign up and log in using verified `northeastern.edu` email addresses.
- **Listings & Bids**: Add, view, and manage listings; place bids or purchase items immediately using the "Seal the Deal" feature.
- **Profile Management**: View personal details, transaction history, and manage active bids and listings.
- **Responsive UI**: Built programmatically with UIKit and Auto Layout, supporting both dark and light modes.
- **Real-Time Updates**: Firebase Firestore ensures real-time listing and bidding updates.
- **Comprehensive Validation**: Edge cases handled for empty fields, character limits, and pricing rules.

## MainScreens
1. **Home Screen**: Displays all active listings on the application.
2. **Item Details Screen**: Shows item details with options to place bids or purchase directly skiping through the auction process.
3. **Profile Screen**: Displays user details and transaction history. Allows toggling the application to a Dark Mode.
4. **Listings Screen**: Lists items posted by the user with options to delete, or sell to highest bidder.
5. **Biddings Screen**: Displays items the user has placed bids on.

## Requirements
- macOS with **Xcode 14.0** or later
- iOS **15.0** or later
- Swift **5.0** or later
- **Git** (for version control)
- **Firebase** (for authentication and Firestore integration)

## Installation
To set up this project on your local machine, follow these steps:

### 1. Clone the Repository
First, clone the repository using the terminal:
```bash
git clone https://github.com/hrishikasamani/NUSwap
cd NUSwap
```

### 2. Open the Project in Xcode
Open Xcode.
Click on File > Open.
Navigate to the cloned repository folder and select the .xcodeproj file:
```bash
open NUSwap.xcodeproj
```

### 3. Install Dependencies (if using Cocoapods)
If your project uses Cocoapods for dependency management:
```bash
# Install pods
pod install
```
Then, open the .xcworkspace file instead of .xcodeproj:
```bash
open NUSwap.xcworkspace
```

### 4. Configure Signing & Capabilities
Open the project in Xcode.
Go to the Signing & Capabilities tab.
Select your development team and ensure the bundle identifier is unique.

### 5. Build & Run the Project
Select the target device or simulator (e.g., iPhone 15 Pro).
Press `Cmd + R` or click the Run button to build and run the app.

## Setup

### Step-by-Step Setup Guide

1. **Download Xcode:**
   
   - Ensure you have the latest version of Xcode installed from the Mac App Store.
   
2. **Clone the Repository:**
   
   ```bash
    git clone https://github.com/hrishikasamani/NUSwap
    cd NUSwap
   ```
   
3. **Open the Project**

4. **Install Dependencies (If Applicable):**

   - If you're using Cocoapods, run:
     ```bash
     pod install
     ```
     
   - If you're using Swift Package Manager, open the project in Xcode, go to *File > Add Packages* to resolve any dependencies.

5. **Configure Firebase:**

   - Download your `GoogleService-Info.plist` file from Firebase Console.
   - Add it to the project root in Xcode.
 
6. **Running the App:**
   
   - In Xcode, select a target simulator (e.g., iPhone 16 Pro).
   - Press Cmd + R to build and run the project.

## Usage

- *Sign Up*: Register with your northeastern.edu email address and personal details.
- *Add a Listing*: Tap "+" on the Home or Listings screen, fill in item details, and tap "List Your Item".
- *Place a Bid*: Enter a bid amount and tap "Place a New Bid" on the item details screen.
- *Seal the Deal*: Purchase an item immediately at its listed price.
- *Manage Listings*: Edit, delete, or mark your listings as sold.
- *View Transactions*: Access your transaction history and contact buyers/sellers through the Profile screen.
- *Dark/Light Mode*: Toggle between modes for a customized experience.

## Contact

If you have any questions, feel free to reach out to our team:

- **Hrishika Samani**
  [LinkedIn](https://www.linkedin.com/in/hrishika-samani)
  [Email](mailto:samani.hr@northeastern.edu)
- **Dhruv Doshi**
  [LinkedIn](https://www.linkedin.com/in/d-doshi/)
  [Email](mailto:doshi.dhru@northeastern.edu)
- **Preksha Patil**
  [LinkedIn](https://www.linkedin.com/in/prekshaspatil/)
  [Email](mailto:patil.pre@northeastern.edu)
- **Feng Hua Tan (Karyn)**
  [LinkedIn](https://www.linkedin.com/in/karynfengtan/)
  [Email](mailto:tan.fe@northeastern.edu)
  
