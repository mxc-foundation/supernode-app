import com.microsoft.appcenter.appium.Factory;
import com.microsoft.appcenter.appium.EnhancedAndroidDriver;
import org.junit.rules.TestWatcher;
import org.junit.Rule;
import io.github.cdimascio.dotenv.Dotenv;

import io.appium.java_client.MobileElement;
import org.junit.*;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.remote.DesiredCapabilities;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.TimeUnit;



public class TestAndroid {

    private static EnhancedAndroidDriver<MobileElement> driver;
    private Actions actions;
    Dotenv dotenv = Dotenv.load();

    @Rule
    public TestWatcher watcher = Factory.createWatcher();

    @Before
    public void initializeDriver() throws MalformedURLException {
        DesiredCapabilities dc = new DesiredCapabilities();
        dc.setCapability("automationName", "UiAutomator2");
        dc.setCapability("platformName", "Android");
        dc.setCapability("appPackage", "com.mxc.smartcity");
        dc.setCapability("appActivity", "com.mxc.smartcity.MainActivity");
        dc.setCapability("deviceName", "Pixel XL API 30");
        //dc.setCapability("app", "/Users/Stefan/Documents/Projects/supernode-app/build/app/outputs/apk/app.apk");

        driver = Factory.createAndroidDriver(new URL("http://0.0.0.0:4723/wd/hub"), dc);
        driver.manage().timeouts().implicitlyWait(15, TimeUnit.SECONDS);
        actions = new Actions(driver);
    }

    @Test
    public void errorForInconsistentPassword() throws InterruptedException {

    }

    @Test
    public void login() throws InterruptedException {
        //logs test user into testserver
        for(int i = 0;i < 7;i++){
            //click on logo 7 times to unlock test server.
            click(By.id("home_logo"));
        }
        click(By.id("home_supernode_menu"));
        click(By.id("home_test_server"));
        enterText(By.id("home_email"), dotenv.get("TESTSERVER_EMAIL"));
        enterText(By.id("home_password"), dotenv.get("TESTSERVER_PASS"));
        click(By.id("home_login_button"));
        Assert.assertTrue(isDisplayed(By.id("fp_deposit")));
        Assert.assertTrue(isDisplayed(By.id("fp_withdraw")));
        Assert.assertTrue(isDisplayed(By.id("fp_stake")));
    }

    @Test
    public void stake() throws InterruptedException {
        click(By.id("fp_stake"));
        enterText(By.id("stake_amount"), "200");
        click(By.id("stake_confirm"));
        Assert.assertTrue(isDisplayed(By.xpath("//android.view.View[@text='Stake successful.']")));
        click(By.id("stake_done"));
        click(By.id("stake_x"));
        Assert.assertEquals(By.id("fp_stake_amount").toString(), "200");
    }

    public String getActivity() {
        return driver.currentActivity();
    }

    public boolean isDisplayed(By by) {
        return driver.findElement(by).isDisplayed();
    }

    public void enterText(By by, String text) throws InterruptedException {
        WebElement edit = driver.findElement(by);
        edit.click();
        Thread.sleep(200);
        actions.sendKeys(edit, text).perform();
    }

    public void click(By by) {
        driver.findElement(by).click();
    }

    @After
    public void teardown() {
        driver.quit();
    }
}