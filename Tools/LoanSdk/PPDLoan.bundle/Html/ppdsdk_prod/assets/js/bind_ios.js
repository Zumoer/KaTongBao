
Step_next('title');


  var loadStart = function(){
      var $load = $('.loading');
      $load.show();
    }

  var  loadStop =function(){
      var $load = $('.loading');
      $load.hide();
    } 


 var bindCardsInitAndroid = function(){
    
    uNameInit();
    bankInit();

 }


 
//userName API _用户名

 var uNameInit = function(){
    
      Http_post("/PPDMobileBorrow/UserService/GetUserDetailByUserId", "{}", "httpUnameCallback");
 }
 var httpUnameCallback = function(params){
     loadStop();
     var resultCode = params.ResultCode,
         resultMsg  = params.ResultMessage,
         resultName = params.Content.realname,
         $uName     = $('#uName');
     if(resultCode == 0){
        //name初始化加载成功
        $uName.text(resultName)
     }else{
        //name初始化加载失败

        PPD_SDK.reminderMsg(resultMsg)
     }
 }


//银行数据加载

var bankInit = function(){
 
    var _url = "/PPDMobileBorrow/UserBankService/GetBankList";
    Http_post(_url, "{}", "bankInitCallback");
    loadStart();
}

var bankInitCallback = function(params){
    loadStop();
     var resultCode = params.ResultCode,
         resultMsg  = params.ResultMessage,
         resultCont = params.Content;
     if(resultCode == 0){
        //成功
        if(resultCont){
            var opts = '';
            for(var i=0;i<resultCont.length;i++){
                opts += '<option data-id="'+ resultCont[i].Id +'">'+ resultCont[i].BankName +'</option>';
            }
            $(opts).appendTo($('#selectBank'));
        }
     }else{
        //name初始化加载失败
        PPD_SDK.reminderMsg(resultMsg)

     }
}



 //发送手机验证码

 var sendBindCardsCode = function(){
      var mobile = $("#phone").val(),
          bankNum = $('#bankCardsNum').val(),
          bankId = $('#selectBank').attr('data-id'),
          _url  ="/PPDMobileBorrow/UserBankService/SendBindBankCardValidateCode";

      //校验银行卡
      if(!bankId){
        PPD_SDK.reminderMsg("请选择银行");
        return;
      }

      if(!bankNum.length){
        PPD_SDK.reminderMsg("银行卡号不能为空");
        return;
      }

      if(!mobile.length){
        PPD_SDK.reminderMsg("请输入正确的手机号");
        return;
      }
      

      Http_post(_url, "{\"MobilePhone\":\"" + mobile + "\",\"BankCardNum\":\""+ bankNum + "\",\"BankId\":\""+ bankId + "\",\"Requestor\":\"04\"}", 
               "httpBindCardsCallback")
      loadStart();
 }

 var httpBindCardsCallback = function(params){
     loadStop();
     var resultCode = params.ResultCode,
         resultMsg  = params.ResultMessage,
         resultNum = params.Content;


     if(resultCode == 0){
        //name初始化加载成功
        time();
        resultNum=resultNum?resultNum:'-1';
        //console.log("input的内容"+resultNum)
        $('#withholdBillNo').val(resultNum);
     }else{
        //name初始化加载失败
        PPD_SDK.reminderMsg(resultMsg)
     }
 }


 //绑定提交接口

 var bindSumitData = function(){
      var mobile = $("#phone").val(),
          bankNum = $('#bankCardsNum').val(),
          bankName = $('.select-t').text(),
          bankId = $('#selectBank').attr('data-id'),
          validateCode = $('#dxCode').val(),
          withholdBillNo = $('#withholdBillNo').val(),
          _url  ="/PPDMobileBorrow/UserBankService/BindUserBankCard",
          reg    = /^1[3|4|5|7|8]\d{9}$/;

      if(!bankId){
        PPD_SDK.reminderMsg("请选择银行");
        return;
      }

      if(!bankNum.length){
        PPD_SDK.reminderMsg("银行卡号不能为空");
        return;
      }

      if(!mobile.length||mobile.length<11||!reg.test(mobile)){
        PPD_SDK.reminderMsg("请输入正确的手机号");
        return;
      }

      if(!validateCode.length){
        PPD_SDK.reminderMsg("请输入短信验证码");
        return;
      }

      if(withholdBillNo == ''){
        PPD_SDK.reminderMsg("请发送短信验证码");
        return;
      }

      Http_post(_url, "{\"BankCardNum\":\"" + bankNum + "\",\"BankId\":\""+ bankId + "\",\"BankBranchId\":\"0\",\"MobilePhone\":\""+ mobile + "\",\"ValidateCode\": \"" + validateCode + "\",\"WithholdBillNo\": \"" + withholdBillNo + "\",\"Requestor\": \"03\"}",
               "httpBindSumitDataCallback");
      loadStart();
      
 }


 var httpBindSumitDataCallback = function(params){
     loadStop();
     var resultCode = params.ResultCode,
         resultMsg  = params.ResultMessage;
     if(resultCode == 0){
        //成功
        Step_next("bindCard:success");
     }else{
        //失败
        PPD_SDK.reminderMsg(resultMsg)
     }

 }


bindCardsInitAndroid();