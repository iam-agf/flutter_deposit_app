# dev_deposit_app

## Preset 

To add web3auth, first [follow the process explained here](https://docs.web3auth.io/api-reference/android/setting-up) about how to set up your Flutter app with web3auth.

Don't forget to add a torus wallet for your project to make it work.

After this add the 

```xml
<intent-filter android:label="flutter_web_auth">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE"/>
    <data android:scheme="com.example.swifty_companion" />
</intent-filter>
```