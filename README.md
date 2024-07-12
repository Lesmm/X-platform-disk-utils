# X-platform-disk-utils

## Android

### publish to jitpack.io

1. It will automatically finding the android library and go into the `disk_utils_android/`
2. The `gradle/`(which contains `gradle-wrapper.properties`) directory is needed, otherwise it will use it's default gradle version
3. The Android Gradle Plugin is needed:
```
    buildscript {
        ...
        repositories {
            ...
        }
        dependencies {
            classpath 'com.android.tools.build:gradle:7.2.0'
            ...
        }
    }
```
4. The allprojects's repositories is needed, for finding the `kotlin-gradle-plugin` plugin:
```
allprojects {
    repositories {
        ...
    }
}
```
5. jitpack.io do not use the following configurations (groupId & artifactId & version), it just need github user domain & git repository name & git tag information

### jitpack.io build.log example:

```
Build starting...
...
Going into directory: ./disk_utils_android
Gradle build script
Generating Gradle wrapper v 7.5
...
> Task :assembleRelease
> Task :assemble
> Task :generateMetadataFileForDisk_utils_androidPublication
> Task :publishDisk_utils_androidPublicationToMavenLocal
> Task :publishToMavenLocal
...
BUILD SUCCESSFUL in 49s
...
Exit code: 0

✅ Build artifacts:
com.github.[githug_user_name]:X-platform-disk-utils:0.0.2.alpha

Files:
com/github/[githug_user_name]/X-platform-disk-utils/0.0.2.alpha
com/github/[githug_user_name]/X-platform-disk-utils/0.0.2.alpha/X-platform-disk-utils-0.0.2.alpha.aar
com/github/[githug_user_name]/X-platform-disk-utils/0.0.2.alpha/X-platform-disk-utils-0.0.2.alpha.module
com/github/[githug_user_name]/X-platform-disk-utils/0.0.2.alpha/X-platform-disk-utils-0.0.2.alpha.pom
com/github/[githug_user_name]/X-platform-disk-utils/0.0.2.alpha/X-platform-disk-utils-0.0.2.alpha.pom.md5
com/github/[githug_user_name]/X-platform-disk-utils/0.0.2.alpha/X-platform-disk-utils-0.0.2.alpha.pom.sha1
com/github/[githug_user_name]/X-platform-disk-utils/0.0.2.alpha/build.log
com/github/[githug_user_name]/X-platform-disk-utils/0.0.2.alpha/maven-metadata-local.xml
```

Check it out:
https://jitpack.io/com/github/[githug_user_name]/X-platform-disk-utils/0.0.2.alpha/X-platform-disk-utils-0.0.2.alpha.aar
