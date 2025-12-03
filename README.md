# ReinMKG - Remake InfoBMKG

**ReinMKG** is a comprehensive weather and earthquake monitoring application designed to provide up-to-date and accurate information. Inspired by InfoBMKG, this app offers a simple and intuitive interface, allowing users to easily check weather forecasts, temperature, humidity, and wind speed, while also keeping track of the latest earthquake activity and other meteorological conditions.

## Key Features

- **Real-Time Weather Forecast**: Get live weather updates based on your current location or specific cities in Indonesia.
- **Daily and Weekly Forecast**: View detailed weather predictions for the days ahead.
- **Interactive Earthquake Map**: Explore recent earthquake data with a detailed, interactive map view.
- **Multi-Language Support**: Access the app in multiple languages, including English and Indonesian.

## Screenshots

Here are some screenshots of **ReinMKG** in action:

<div align="center">
  <img src="readme/screenshoots/Home_screen_1.png?raw=true" width="30%">
  <img src="readme/screenshoots/Weather_1.png?raw=true" width="30%">
  <img src="readme/screenshoots/Weather_2.png?raw=true" width="30%">
</div>
<div align="center">
  <img src="readme/screenshoots/Earthquake_1.png?raw=true" width="30%">
  <img src="readme/screenshoots/Radar_1.png?raw=true" width="30%">
  <img src="readme/screenshoots/Earthquake_2.png?raw=true" width="30%">
</div>

## Prerequisites

Before you begin, ensure you have the following:

- **Android Device**: Recommended to run on Android 10 or newer.
- **Flutter SDK**: Ensure the Flutter SDK and necessary development tools are installed on your machine.

## Running the App Locally

Follow these steps to build yourself:

### 1. Clone the Repository
```bash
git clone https://github.com/StarSkyGeminid/reinmkg.git
cd reinmkg
```

#### 2. Install Dependencies
Install all necessary packages by running:

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

## TODO
- Add glossary

## Limitations
While ReinMKG strives to offer the best weather-related services, there are some limitations to the app:

 - No Earthquake Notifications: The app does not currently provide notifications for earthquakes, which are offered by specific apps like InfoBMKG.
- No Early Weather Warning Alerts: The app does not include early warning notifications for weather phenomena such as storms, floods, or tsunamis. These are typically provided by official government services such as BMKG.

We are continually working to improve the app, and future updates may address some of these limitations but we don't promise that there will be such a feature because we don't have access to their Firebase Cloud Messaging (FCM).

## Disclaimer
```
ReinMKG is an independent project and is not affiliated with, endorsed by, or officially connected to BMKG (Badan Meteorologi, Klimatologi, dan Geofisika).

This application utilizes data provided by the BMKG API for weather and earthquake information. Map data is attributed to: Esri, HERE, Garmin, (c) OpenStreetMap contributors, and the GIS user community.

By using this app, you agree that the developers claim no ownership over the data provided by these services. This app is intended for personal, non-commercial use only.
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
