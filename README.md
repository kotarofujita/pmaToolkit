# pmaToolkit

## Requirements
- iOS 8.0+
- Xcode 7.2+ - CocoaPods

## Before you start
The Philadelphia Museum of Art is committed to making its collection data available for public access. Whilst we have a web interface for searching the collection, we are now also making our dataset of works in the public domain available for free public download. 

#Usage guidelines
These usage guidelines are based on goodwill. They are not a legal contract but the Philadelphia Museum of Art requests that you follow these guidelines if you use Metadata from our Collection dataset.
##Give attribution to the Philadelphia Museum of Art
Make sure that others are aware of the rights status of the Philadelphia Museum of Art and are aware of these guidelines by keeping intact links.
If for technical or other reasons you cannot include all the links to all sources of the Metadata and rights information directly with the Metadata, you should consider including them separately, for example in a separate document that is distributed with the Metadata or dataset.
If for technical or other reasons you cannot include all the links to all sources of the Metadata and rights information, you may consider linking only to the Metadata source on the Philadelphia Museum of Art’s website, where all available sources and rights information can be found, including in machine readable formats.
##Metadata is dynamic
When working with Metadata obtained from the Philadelphia Museum of Art, please be aware that this Metadata is not static. It sometimes changes daily. The Philadelphia Museum of Art continuously updates its Metadata in order to correct mistakes and include new and additional information. Museum collections are under constant study and research, and new information is frequently added to objects in the collection.
##Pull requests
Because these datasets are generated from our internal database, we do not accept pull requests. If you have identified errors or have extra information to share, please email us at X and we will forward to the appropriate department for review.
##No endorsement
Use of this dataset does not grant or imply PMA’s  approval, commission, or support of your work. PMA retains the rights to all of its trademarks, and they are not part of the dataset.  Ensure that you do not use the Metadata in a way that suggests any official status or that the Philadelphia Museum of Art endorses you or your use of the Metadata, unless you have prior permission to do so. If you transform or modify to the dataset, you must clearly distinguish the resulting work as having been modified from the PMA dataset. If you create a derivative dataset from the PMA dataset, we ask that you consider releasing the derivative under a CC0 license, which mirrors the licensing of the PMA dataset.
##Ensure that you do not mislead others or misrepresent the Metadata or its sources
Ensure that your use of the Metadata does not breach any national legislation based thereon, notably concerning (but not limited to) data protection, defamation or copyright. Please note that you use the Metadata at your own risk. The Philadelphia Museum of Art offers the Metadata as-is and makes no representations or warranties of any kind concerning any Metadata published by the Philadelphia Museum of Art.
##The writers of these guidelines are deeply indebted to the Tate, MoMA, Smithsonian Cooper-Hewitt, National Design Museum; and Europeana.

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
