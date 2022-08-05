import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;

class FundDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        var menu = new WatchUi.Menu2({:title=>new $.DrawableMenuTitle()});

        // Add menu items for demonstrating toggles, checkbox and icon menu items
        menu.addItem(new WatchUi.MenuItem("Toggles", "sublabel", "toggle", { "alignment" => WatchUi.MenuItem.MENU_ITEM_LABEL_ALIGN_LEFT }));
        menu.addItem(new WatchUi.MenuItem("Checkboxes", null, "check", null));
        menu.addItem(new WatchUi.MenuItem("Icons", null, "icon", null));
        menu.addItem(new WatchUi.MenuItem("Custom", null, "custom", null));
        WatchUi.pushView(menu, new $.FundMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    //!
    function onKey(key) {
        System.println("press button");
        // Enter key toggles start/stop
        if (key.getKey() == WatchUi.KEY_ENTER) {
            //mController.confirmStart();
            WatchUi.pushView(new Rez.Menus.RightMenu(), new FundSubMenuDelegate(), WatchUi.SLIDE_RIGHT);
        }

        // All other buttons toggle backlight
        if (key.getKey() == WatchUi.KEY_LIGHT || key.getKey() == WatchUi.KEY_UP || key.getKey() == WatchUi.KEY_DOWN) {
            System.println("press button");
            //mController.turnOnBacklight();
        }
        return true;
    }

    function onBack() {
        //Exit the app
        System.exit();
    }

    function onNextPage() {
      if (!System.getDeviceSettings().isTouchScreen) {
        var view = Application.getApp().view;
        view.setNextPage();
        WatchUi.requestUpdate();
      }
      return true;
    }

    function onPreviousPage() {
      if (!System.getDeviceSettings().isTouchScreen) {
        var view = Application.getApp().view;
        view.setPreviousPage();
        WatchUi.requestUpdate();
      }
      return true;
    }

}

class DrawableMenuTitle extends WatchUi.Drawable {

    //! Constructor
    public function initialize() {
        Drawable.initialize({});
    }

    //! Draw the application icon and main menu title
    //! @param dc Device Context
    public function draw(dc as Dc) as Void {
        var spacing = 2;
        var appIcon = WatchUi.loadResource($.Rez.Drawables.Setting) as BitmapResource;
        var bitmapWidth = appIcon.getWidth();
        var labelWidth = dc.getTextWidthInPixels("设置", Graphics.FONT_MEDIUM);

        var bitmapX = labelWidth + 80;
        var bitmapY = (dc.getHeight() - appIcon.getHeight()) / 2;
        var labelX = 30;
        var labelY = dc.getHeight() / 2;

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        dc.drawBitmap(bitmapX, bitmapY, appIcon);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(labelX, labelY, Graphics.FONT_MEDIUM, "设置", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    }
}
