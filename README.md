# pmaToolkit

## Requirements
- iOS 8.0+
- Xcode 7.2+ - CocoaPods

## Getting started

### Install CocoaPods (if not already installed) 
```$ gem install cocoapods```

### Add to your Podfile:
```ruby
  platform :ios, '8.0'
  use_frameworks!

  pod 'SwiftyJSON', :git => ‘https://github.com/SwiftyJSON/SwiftyJSON.git'
  pod 'pmaToolkit', :git => ‘https://github.com/philamuseum/pmaToolkit.git '
```

Then run pod install

```$ pod install```

## Configuration

In order for the framework to work, the following information has to be supplied:

- iBeacon UUID
```swift
pmaToolkit.settings.iBeaconUUID = “{Your UUID}”
```

- Remote Location & iBeacon definitions 
```swift
pmaToolkit.settings.cacheSettings.hostProtocol = “https” 
hostname = “yourhost.com” 
urlBeacons = “/path/to/beacons.json” 
urlLocations = “/path/to/locations.json”
```
## Features

### Heading

The framework outputs the current heading in 10 degree steps as a ```NSNotification``` (**didUpdateHeading**). There are two values that come along with the notification for an updated heading: **actualHeadingDegrees** and **calculatedHeadingRadians**, with the latter already converted for the actual orientation of the building.

### Ranging beacons
The following NSNotification-based notifications are being sent:
- **locationChanged** with ```currentLocation as pmaLocation```
This event will only be sent in case a location change happened, in other words, it will not fire while a user stays in the same space in a gallery (except if that location happens to be at the intersection of two galleries, so the signal could bounce)
- **locationUnknown** with ```lastKnownLocation as? pmaLocation``` (optional, can be nil) This notification is only sent every 30s in case no location can be determined. Since we placed our beacons at the entrance ways of a gallery, it can certainly happen that the device looses its signal.
This event should be treated with care for this reason.

### Logging
The framework has four log levels with 4 being the most verbose. By default, it is set to 3. If you want to make changes, use ```pmaToolkit.settings.logLevel = X```.
To use the supplied logger, simply call

```swift
pmaToolkit.logDebug("") 
pmaToolkit.logInfo("") 
pmaToolkit.logError("")
```
