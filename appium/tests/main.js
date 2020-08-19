const wdio = require(""webdriverio"");

// javascript
const opts = {
  path: '/wd/hub',
  port: 4723,
  capabilities: {
    platformName: ""Android"",
    platformVersion: ""10"",
    deviceName: ""Pixel XL API 30"",   //check this out on Android-studio
    app: ""/Users/Stefan/Documents/Projects/supernode-app/build/app/outputs/apk/app.apk"", //apk location
    appPackage: ""com.mxc.smartcity"",  // AndroidManifest.xml
    appActivity: "".MainActivity"",  // AndroidManifest.xml
    automationName: ""UiAutomator2""
  }
};

async function main () {
  const browser =  await wdio.remote(opts);
  const btnCreateAccount = 'new UISelector().text(""Create Account"")';
  const btn = await browser.$('android=new UiSelector().text(""Create Account"")');
  await btn.waitForExist({timeout: 5000});
  await btn.waitForDisplayed({timeout: 5000});

  await btn.click();

  const txtName = await browser.$('android=new UiSelector().text(""Name"")');
  await txtName.waitForExist({timeout: 5000});
  await txtName.setValue('test');



  await browser.deleteSession();
}

main()