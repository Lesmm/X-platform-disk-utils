# react-native-disk-utils

## Getting started

`$ npm install react-native-disk-utils --save`

### Mostly automatic installation

`$ react-native link react-native-disk-utils`

## Usage
```javascript
import DiskUtils from 'react-native-disk-utils';

// TODO: What to do with the module?
DiskUtils;
```



# Creation

# https://reactnative.dev/docs/native-modules-setup
# https://www.npmjs.com/package/create-react-native-library
# https://www.npmjs.com/package/create-react-native-module


`$ npx create-react-native-module --generate-example DiskUtils`


# Version Control
`$ git config --local user.name "June"  && git config --local user.email "June@Tesla.com"`


# Common known build/compile issue



## Android

### Error 1. Plugin with id 'maven' not found
// https://stackoverflow.com/a/74118097
```javascript
change
    apply plugin: 'maven'
to 
    apply plugin: 'maven-publish'
```

## Error 2. Configuration with name 'compile' not found:
```javascript
node_modules/react-native-disk-utils/android/build.gradle' line: 112

A problem occurred configuring project ':react-native-disk-utils'.
> Configuration with name 'compile' not found.
```
# Just comment the gradle script `afterEvaluate` block:
```javascript
    afterEvaluate { project ->
        ...
        task androidJavadoc(type: Javadoc) {
            ...
        }
        ...
    }
```

### Error 3. Unable to resolve module missing-asset-registry-path
```javascript
error: Error: Unable to resolve module missing-asset-registry-path from example/node_modules/react-native/Libraries/LogBox/UI/LogBoxImages/chevron-left.png: missing-asset-registry-path could not be found within the project or in these directories:
  node_modules/react-native/node_modules
  node_modules
  example/node_modules/missing-asset-registry-path
> 1 | �PNG
```
# Change the `example/metro.config.js` conent in https://github.com/facebook/react-native/issues/38282
```javascript

// ************ the workaround finally worked ************
// https://github.com/facebook/react-native/issues/38282
const { getDefaultConfig, mergeConfig } = require('@react-native/metro-config')
const path = require('path')
const escape = require('escape-string-regexp')
const exclusionList = require('metro-config/src/defaults/exclusionList')
const pak = require('../package.json')

const root = path.resolve(__dirname, '..')
const modules = Object.keys({ ...pak.peerDependencies })

/**
 * Metro configuration
 * https://facebook.github.io/metro/docs/configuration
 *
 * @type {import('metro-config').MetroConfig}
 */
const config = {
  watchFolders: [root],

  // We need to make sure that only one version is loaded for peerDependencies
  // So we block them at the root, and alias them to the versions in example's node_modules
  resolver: {
    blacklistRE: exclusionList(
      modules.map(
        (m) =>
          new RegExp(`^${escape(path.join(root, 'node_modules', m))}\\/.*$`)
      )
    ),

    extraNodeModules: modules.reduce((acc, name) => {
      acc[name] = path.join(__dirname, 'node_modules', name)
      return acc
    }, {}),
  },

  transformer: {
    getTransformOptions: async () => ({
      transform: {
        experimentalImportSupport: false,
        inlineRequires: true,
      },
    }),
  },
}

module.exports = mergeConfig(getDefaultConfig(__dirname), config)


```


### Error 4. Inconsistent JVM-target compatibility detected for tasks 'compileDebugJavaWithJavac' (17) and 'compileDebugKotlin' (1.8).
// https://stackoverflow.com/a/76060790
// Add gradle 8.x version check in script `gradle.gradleVersion.matches("8.+")`
```javascript
    compileOptions {
        sourceCompatibility gradle.gradleVersion.matches("8.+") ? JavaVersion.VERSION_17 : JavaVersion.VERSION_1_8
        targetCompatibility gradle.gradleVersion.matches("8.+") ? JavaVersion.VERSION_17 : JavaVersion.VERSION_1_8
    }
    kotlinOptions {
        jvmTarget = gradle.gradleVersion.matches("8.+") ? '17' : '1.8'
    }
```


## Error 5. Plugin with id 'com.facebook.react.rootproject' not found.
How to fix? In Root build.gradle, specify the $kotlinVersion:
classpath("org.jetbrains.kotlin:kotlin-gradle-plugin") -> classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlinVersion")



## Error 6. Plugin with id 'com.facebook.react.rootproject' not found.
Happened when change 'distributionUrl=https\://xxx/gradle-8.6-all.zip' to 'distributionUrl=https\://xxx/gradle-7.5-all.zip' in gradle-wrapper.properties
How to fix? In Root build.gradle, change as followeding:
apply plugin: "com.facebook.react.rootproject" -> apply plugin: "com.facebook.react"



## Error 7. Calling `[node, /../node_modules/@react-native-community/cli/build/bin.js, config]` finished with an exception. Error message: groovy.json.JsonException: Unable to determine the current character, it is not a string, number, array, or object ... Config Validation Error: "project.ios.automaticPodsInstallation" is not allowed 

In example/react-native.config.js, just comment the `project ... ios ... ` block as followed:

    ```
    module.exports = {
      // project: {
      //   ios: {
      //     automaticPodsInstallation: true,
      //   },
      // },
      dependencies: {
        [pkg.name]: {
          root: path.join(__dirname, '..'),
        },
      },
    };
    ```



## Error 8. MainApplication.kt, Unresolved reference: ReactHost & override val reactHost: ReactHost error
Cause download react-native version in package.json, so you should:
1. delete method `override val reactHost: ReactHost`
2. method `override val reactNativeHost: ReactNativeHost = `  change to `override fun getReactNativeHost(): ReactNativeHost { \n return object ...`



## iOS

### Error 1. disk_utils_ios-Swift.h file not found
```Objective-C
#if __has_include(<disk_utils_ios/disk_utils_ios-Swift.h>)
#import <disk_utils_ios/disk_utils_ios-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "disk_utils_ios-Swift.h"
#endif
....

```
// In Podfile add `use_frameworks!` in first line
```javascript
    use_frameworks!
    ...
```