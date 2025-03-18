# ReinMKG - Remake InfoBMKG

**ReinMKG** is a weather app that provides up-to-date and accurate weather information for various locations. With a simple and intuitive interface, ReinMKG allows users to easily check weather forecasts, temperature, humidity, wind speed, and other weather conditions.

## Key Features

- **Real-Time Weather Forecast**: Get live weather information based on your location or any city worldwide.
- **Daily and Weekly Forecast**: View weather forecasts for the next several days.
- **Interactive Earthquake Map**: Explore earthquake with an interactive map for a more detailed view.
- **Multi-Language Support**: Access weather information in various languages, including English and Indonesian.

## Screenshots

Here are some screenshots of the **ReinMKG** app in action:

<img src="./readme/screenshoots/Home_screen_1.png?raw=true" width="32%"> <img src="readme/screenshoots/Weather_1.png?raw=true" width="32%">  <img src="readme/screenshoots/Weather_2.png?raw=true" width="32%"> <img src="readme/screenshoots/Earthquake_1.png?raw=true" width="32%"> <img src="./readme/screenshoots/Radar_1.png?raw=true" width="32%"> <img src="./readme/screenshoots/Earthquake_2.png?raw=true" width="32%"> 


## Prerequisites

Before you begin, make sure you have the following:

- **Android**: Android 10.0 or newer
- **Flutter**: Make sure you have Flutter SDK and necessary development tools installed.

## Running the App Locally

Follow the steps below to run this app locally on your device:

#### 1. Clone the Repository

```bash
git clone https://github.com/username/weather-now.git
cd weather-now
```

#### 2. Install Dependencies
To install all the necessary dependencies, run the following command:

```bash 
flutter pub get
```

#### 3. Run the App
To run the app on an emulator or physical device:

```bash
flutter run
```

## Contributing
We welcome contributions from everyone! If you'd like to contribute to this project, please follow these steps:

- Fork the repository.
- Create a new branch (```git checkout -b new-feature```).
- Make your changes and commit them (```git commit -am 'Add new feature'```).
- Push to your branch (```git push origin new-feature```).
- Submit a pull request.

## Limitations
While ReinMKG strives to offer the best weather-related services, there are some limitations to the app:

 - No Earthquake Notifications: The app does not currently provide notifications for earthquakes, which are offered by specific apps like InfoBMKG.
- No Early Weather Warning Alerts: The app does not include early warning notifications for weather phenomena such as storms, floods, or tsunamis. These are typically provided by official government services such as BMKG.

We are continually working to improve the app, and future updates may address some of these limitations but we don't promise that there will be such a feature because we don't have access to their Firebase Cloud Messaging (FCM).

## Disclaimer
```
ReinMKG does not own or officially use the BMKG (Indonesian Meteorology, Climatology, and Geophysics Agency) API. The application utilizes public weather data from BMKG and OpenStreemMap API to provide map information.  By using the app, you agree that we do not claim any ownership or rights over the data provided by these services and other content only for personal, non-commercial purposes and in compliance with all applicable laws and regulations.
```

## Credits
ReinMKG wouldn't be possible without the inspiration from the following teams, tools, and software:

- InfoBMKG App Team
- SiDarMa App Team
- Rorojonggrang Team / Simap
- BLEKOK Team / inatews
- and all the people/teams that I cannot mention one by one


## License
```
MIT License

Copyright (c) 2025 StarSkyGeminid

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
