import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class FundApp extends Application.AppBase {
    var view = null;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        System.println("exit");
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        view = new FundView();
        return [ view, new FundDelegate() ] as Array<Views or InputDelegates>;
    }

    function getGlanceView() {
        return [new FundGlanceView()];
    }

    function onSettingsChanged() as Void {
        System.println("setting changed");
        view.page = 0;
        view.updateData();
        view.createTimer();
    }

}

function getApp() as FundApp {
    return Application.getApp() as FundApp;
}