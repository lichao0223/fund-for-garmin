import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.Application as App;

class FundMenuDelegate extends WatchUi.Menu2InputDelegate {
    var api;

    function initialize() {
        Menu2InputDelegate.initialize();
        api = new FundAPI();
    }

    function onSelect(item as MenuItem) {
        System.println("selected");
        var id = item.getId() as String;
        System.println(id);
        if (id.equals("refreshInterval")) {
            System.println("refreshInterval");
            WatchUi.pushView(new Rez.Menus.RefreshIntervalMenu(), new FundSubMenuDelegate(), WatchUi.SLIDE_UP);
        }
    }
}