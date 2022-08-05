import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Timer;
using Toybox.Application as App;

class FundView extends WatchUi.View {
    var api;
    var fundData = null;
    var page = 0;
    var myTimer = null;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
        fundData = App.Storage.getValue("fund");
        api = new FundAPI();
        updateData();
        createTimer();
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        dc.clear();
        fundData = App.Storage.getValue("fund");
        var appIcon = WatchUi.loadResource($.Rez.Drawables.Logo) as BitmapResource;

        var shortName;
        var shortName2;
        var width = dc.getWidth();
        var height = dc.getHeight();
        if(fundData != null){
            var name = fundData[page]["SHORTNAME"];
            var time = fundData[page]["GZTIME"];
            time = time.substring(5,time.length());
            if(name.length() > 5){
                System.println("name too long");
                shortName = name.substring(0, 5);
                shortName2 = name.substring(5, name.length());
                dc.drawText(5, height / 2 - 50, Graphics.FONT_SYSTEM_XTINY, shortName, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
                dc.drawText(5, height / 2 - 25, Graphics.FONT_SYSTEM_XTINY, shortName2, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
            }else{
                shortName = name;
                dc.drawText(5, height / 2 - 50, Graphics.FONT_SYSTEM_XTINY, shortName, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
            }

            var box = WatchUi.getSubscreen();
            dc.drawBitmap(120, 8, appIcon);

            dc.drawLine(0, height / 2 - 10,  dc.getWidth(), height / 2 - 10);
            dc.drawText(5, height / 2 , Graphics.FONT_SYSTEM_XTINY, "涨跌幅：", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
            dc.drawText(75, height / 2 , Graphics.FONT_SYSTEM_XTINY, fundData[page]["GSZZL"]+"%", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
            dc.drawText(5, height / 2 + 25 , Graphics.FONT_SYSTEM_XTINY, "净值：", Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
            dc.drawText(55, height / 2 + 25 , Graphics.FONT_SYSTEM_XTINY, fundData[page]["GSZ"], Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);

            dc.drawText(42, height -10 , Graphics.FONT_SYSTEM_XTINY, time, Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER);
        }
        
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
        System.println("exit");
    }

    function onReceiveData(responseCode, data) {
        if (responseCode == 200) {
            var fundData = data.get("Datas");
            App.Storage.setValue("fund", fundData);
            System.println(fundData);
            WatchUi.requestUpdate();
        } else {
            System.println(responseCode);
            System.println("request failed");
        }
    }

    function setNextPage() {
        System.println("setNextPage");
        if(page < fundData.size()-1){
            page = page + 1;
        }
        else{
            page = 0;
        }
        
    }

    function setPreviousPage() {
        System.println("setPreviousPage");
        if(page == 0){
            page = fundData.size()-1;
        }
        else{
            page = page - 1;
        }
        
    }

    function updateData() as Void {
        api.getFundData(method(:onReceiveData));
    }

    function createTimer() {
        if(myTimer != null){
            myTimer.stop();
        }
        if(FundPrefs.isAutoRefresh()){
            myTimer = new Timer.Timer();
            var interval = FundPrefs.getNumber("refreshInterval", 300000, 0, 200000000);
            myTimer.start(method(:updateData), interval, true);
            System.println("create Timer,interval:"+interval);
        }
    }

}
