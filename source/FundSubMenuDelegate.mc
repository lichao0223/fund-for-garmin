import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.Application as App;

class FundSubMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item as Symbol) as Void {
        if (item == :refreshInterval) {
            System.println("refreshInterval");
            WatchUi.pushView(new Rez.Menus.RefreshIntervalMenu(), new FundMenuDelegate(), WatchUi.SLIDE_UP);
        } else if (item == :refresh) {
            System.println("refresh Data");
            var view = Application.getApp().view;
            view.updateData();
        } else if (item == :item_3) {
            System.println("item 3");
        }
    }
}