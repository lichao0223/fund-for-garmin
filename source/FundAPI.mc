import Toybox.Communications;
using Toybox.Application as App;

class FundAPI {

    function genericGet(url, notify) {
        Communications.makeWebRequest(
            url, null,
            {
                :method => Communications.HTTP_REQUEST_METHOD_GET,
                :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
            },
            notify
        );
    }

    (:background)
    hidden function genericPost(url, notify) {
        Communications.makeWebRequest(
            url,
            { "dummy" => "dummy" },
            {
                :method => Communications.HTTP_REQUEST_METHOD_POST,
                :headers => {
                    "Content-Type" => Communications.REQUEST_CONTENT_TYPE_JSON
                },
                :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
            },
            notify
        );
    }

    (:background)
    function getFundData(notify) {
        System.println("fundCode：" + App.getApp().getProperty("fundCodes"));
        var url = "https://fundmobapi.eastmoney.com/FundMNewApi/FundMNFInfo?pageIndex=1&pageSize=200&plat=Android&appType=ttjj&product=EFund&Version=1&deviceid=fb52c556-3b7c-4864-8799-48053b8bd31c&Fcodes=" + App.getApp().getProperty("fundCodes");
        genericGet(url, notify);
    }

    (:background)
    function getVehicle(vehicle, notify) {
        var url = "http://www.baidu.com" + vehicle.toString();
        genericGet(url, notify);
    }
}