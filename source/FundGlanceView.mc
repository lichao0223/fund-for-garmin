using Toybox.Graphics as G;
using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;

(:glance)
class FundGlanceView extends Ui.GlanceView {

	var GW;
	var GH;
	
	var tempCelsius = true;

	const DEGREE_SYMBOL = "\u00B0";
	
    function initialize() {
    	//p("GlanceView initialize");
        GlanceView.initialize();
		tempCelsius = !(Sys.getDeviceSettings().temperatureUnits == Sys.UNIT_STATUTE);
    }

    // Load your resources here
    function onLayout(dc as G.Dc) as Void {
    	//p("Glance onLayout");
    	GW = dc.getWidth();
    	GH = dc.getHeight();
    }

    function onShow() as Void {}

    // Update the view
    function onUpdate(dc as G.Dc) as Void {
        GlanceView.onUpdate(dc);
    	//p("Glance onUpdate");
    	dc.setColor(0, G.COLOR_BLACK);
        dc.clear();
        dc.setColor(G.COLOR_WHITE, -1);
        dc.setPenWidth(1);
        dc.drawLine(0, GH /2, GW, GH/2);
        dc.drawText(0, GH/4, G.FONT_SYSTEM_TINY, "我的基金", G.TEXT_JUSTIFY_LEFT | G.TEXT_JUSTIFY_VCENTER);
        
    }

    function onHide() as Void {}

	function celsius2fahrenheit(c) {return (c * 1.8) + 32;}

	function capitalize(s) {
		if (s == null || s.length() == 0) {return s;}
		return s.substring(0,1).toUpper() + (s.length() == 1 ? "" : s.substring(1, s.length()).toLower());
	}

	function p(s) {Sys.println(s);}
}