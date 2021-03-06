# 1.1.8

* Fixed error handling for iOS

## 1.1.7

* Fixed a crash on iOS due to Swift SDK update

## 1.1.6

* Added `excludeProperties`.
Usage:
```dart
dataQueryBuilder.excludeProperties = ['excluded-property-1', 'exclude-property-2'];
```
* Fixed `EmailBodyParts` naming

## 1.1.5

* Updated relations method signatures. Now you can just use parent and child object IDs instead of the object itself.
* Fixed crash during `Backendless.data.describe()` call
* Implemented method `removeHeader` that accepts `String` key
* Implemented custom class approach for the `BackendlessUser` class. Call `Backendless.data.withClass<BackendlessUser>()` to start working with `Users` table.

## 1.1.4

* Fixed DateTime deserialization

## 1.1.3

* Fixed iOS methods not returning the result

## 1.1.2

* Fixed inner sdk classes deserialization

## 1.1.1

* Guest login with social account

## 1.1.0

* Support for geometry data types
* Custom classes caching

## 1.0.1

* Fixed crash during `publish()` call

## 1.0.0

* Bump to released version
* Added integration tests
* Fixes and optimizations

## 0.4.1

* Added `relationsPageSize` parameter to `DataQueryBuilder`
* Fixed deserialization of `List<CustomClass>` properties in `ClassDrivenDataStore`
* Fixed `DateTime` deserialization in `ClassDrivenDataStore`
* Fixed encoding/decoding of class `BackendlessGeoQuery`

## 0.4.0

* Fixed method `setRelation` to correctly work with `Map children`
* Fixed deserialization of `DateTime` for `ClassDrivenDataStore` on iOS
* Added AndroidX support in Android example
* Fixed decoding of `EmailEnvelope`
* A lot of fixes and improvements.

## 0.3.1

* Fixed `HeadersEnum` rawValues in iOS.
* Fixed problem with sending BackendlessUser from Flutter to native SDK.

## 0.3.0

* Added `Class to Table Mapping` and `Column Name Mapping`.
* Added `FlutterBackendlessFCMService`. Now you can handle notifications from Flutter.
* Added the ability to publish and subscribe to custom classes.
* A lot of fixes and improvements.

## 0.2.0

* Add support for custom classes. To start working with custom classes, use the following method: `Backendless.data.withClass<TestTable>()`.
* Add methods `Backendless.getHeaders`, `Backendless.setHeader`, `Backendless.removeHeader`, and also `Backendless.userService.getUserToken`, `Backendless.UserService.setUserToken`.
* Fixes and optimizations.

## 0.1.1

* Remove redundant methods.
* Fix encoding issues.

## 0.1.0

* Add support for iOS.

## 0.0.4

* Fixes and improvements.

## 0.0.3

* Restructure the plugin.

## 0.0.2

* Fix all analyzer hints.

## 0.0.1

* Initial version for Android.