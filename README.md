# open_as_default

A flutter plugin that allows opening a file to be opened with from the flutter app.

currently only works with android, soon support ios.

<img src="https://github.com/LuisDeLaValie/open_as_default/raw/master/demo_android.gif" alt="drawing" width="300"/>


# Usage

yaml file
```yaml
dependencies:
  flutter:
    sdk: flutter
  open_as_default: ^<Vertion> #add line
```
dart file
```dart
//import plugin
import 'package:open_as_default/open_as_default.dart';  

...

@override
  void initState() {
    super.initState();
    
    OpenAsDefault.getFileIntent.then((value) {
      print(value);
      // code 
    });
  }
```

#### Android

android/app/src/main/manifest.xml
```xml
<application
..
>
    <activity
    ...
    >           
        <!-- addd line -->
        <intent-filter>
            <action android:name="android.intent.action.VIEW" />
            <category android:name="android.intent.category.DEFAULT" />
            <category android:name="android.intent.category.BROWSABLE" />
            <category android:name="android.intent.category.APP_BROWSER" />

            <data
                android:mimeType="application/pdf" 
                android:scheme="content" />
        </intent-filter>

    </activity> 
</application>
```


