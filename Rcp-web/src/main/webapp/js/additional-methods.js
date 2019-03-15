//两位小数校验   
$.validator.addMethod("validateNumber", function(value, element) {
	var tel = /^[0-9]+(.[0-9]{1,2})$/;
	return this.optional(element) || (tel.test(value));
}, "请输入合法的数字！");

//正数校验   
$.validator.addMethod("validatePositiveNum", function(value, element) {
	var rex = /^[1-9]\d*$/;
	return this.optional(element) || (rex.test(value));
}, "请输入正整数！");

//两位小数校验   
$.validator.addMethod("validateDecimals", function(value, element) {
	var tel = /^[0](.[0-9]{1,2})$/;
	return this.optional(element) || (tel.test(value));
}, "请输入合法的小数！");

//只能输入英文
$.validator.addMethod("codeEnglish", function(value, element) {
	var chrnum = /^([a-zA-Z]+)$/;
	return this.optional(element) || (chrnum.test(value));
}, "只能输入英文字母");

//只能输入英文、数字、或两者的组合
$.validator.addMethod("code", function(value, element) {
	var chrnum = /^[0-9a-zA-Z]*$/g;
	return this.optional(element) || (chrnum.test(value));
}, "请输入英文或数字！");

//联系电话(手机/电话皆可)验证
$.validator.addMethod("isPhone", function(value,element) {
var length = value.length;
var mobile = /^1[3|4|5|7|8][0-9]{9}$/;
var tel = /^d{3,4}-?d{7,9}$/;
return this.optional(element) || (tel.test(value) || mobile.test(value));
}, "请正确填写联系电话！");

//正数百分比校验   
$.validator.addMethod("validatePercent", function(value, element) {
	var tel = /^[0-9]+%$/;
	return this.optional(element) || (tel.test(value));
}, "请输入正整数百分比！");

//两位小数校验   
$.validator.addMethod("validateDecimals", function(value, element) {
	var decimals = /^0(\.\d{1,2})?$/;
	return this.optional(element) || (decimals.test(value));
}, "请输入最多两位小数（格式：0.12）！");

//身份证号码验证
$.validator.addMethod("isIdCardNo", function(value, element) {
return this.optional(element) || idCardNoUtil.checkIdCardNo(value);
}, "请正确输入您的身份证号码");

var idCardNoUtil = {
		  
		provinceAndCitys: {11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江",
		31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北",43:"湖南",44:"广东",
		45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",
		65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外"},
		powers: ["7","9","10","5","8","4","2","1","6","3","7","9","10","5","8","4","2"],
		parityBit: ["1","0","X","9","8","7","6","5","4","3","2"],
		genders: {male:"男",female:"女"},
		checkAddressCode: function(addressCode){
		var check = /^[1-9]\d{5}$/.test(addressCode);
		if(!check) return false;
		if(idCardNoUtil.provinceAndCitys[parseInt(addressCode.substring(0,2))]){
		return true;
		}else{
		return false;
		}
		},
		checkBirthDayCode: function(birDayCode){
		var check = /^[1-9]\d{3}((0[1-9])|(1[0-2]))((0[1-9])|([1-2][0-9])|(3[0-1]))$/.test(birDayCode);
		if(!check) return false;
		var yyyy = parseInt(birDayCode.substring(0,4),10);
		var mm = parseInt(birDayCode.substring(4,6),10);
		var dd = parseInt(birDayCode.substring(6),10);
		var xdata = new Date(yyyy,mm-1,dd);
		if(xdata > new Date()){
		return false;//生日不能大于当前日期
		}else if ( ( xdata.getFullYear() == yyyy ) && ( xdata.getMonth () == mm - 1 ) && ( xdata.getDate() == dd ) ){
		return true;
		}else{
		return false;
		}
		},
		getParityBit: function(idCardNo){
		var id17 = idCardNo.substring(0,17);
		  
		var power = 0;
		for(var i=0;i<17;i++){
		power += parseInt(id17.charAt(i),10) * parseInt(idCardNoUtil.powers[i]);
		}
		  
		var mod = power % 11;
		return idCardNoUtil.parityBit[mod];
		},
		checkParityBit: function(idCardNo){
		var parityBit = idCardNo.charAt(17).toUpperCase();
		if(idCardNoUtil.getParityBit(idCardNo) == parityBit){
		return true;
		}else{
		return false;
		}
		},
		checkIdCardNo: function(idCardNo){
		//15位和18位身份证号码的基本校验
		var check = /^\d{15}|(\d{17}(\d|x|X))$/.test(idCardNo);
		if(!check) return false;
		//判断长度为15位或18位
		if(idCardNo.length==15){
		return idCardNoUtil.check15IdCardNo(idCardNo);
		}else if(idCardNo.length==18){
		return idCardNoUtil.check18IdCardNo(idCardNo);
		}else{
		return false;
		}
		},
		  
		//校验15位的身份证号码
		check15IdCardNo: function(idCardNo){
		//15位身份证号码的基本校验
		var check = /^[1-9]\d{7}((0[1-9])|(1[0-2]))((0[1-9])|([1-2][0-9])|(3[0-1]))\d{3}$/.test(idCardNo);
		if(!check) return false;
		//校验地址码
		var addressCode = idCardNo.substring(0,6);
		check = idCardNoUtil.checkAddressCode(addressCode);
		if(!check) return false;
		var birDayCode = '19' + idCardNo.substring(6,12);
		//校验日期码
		return idCardNoUtil.checkBirthDayCode(birDayCode);
		},
		  
		//校验18位的身份证号码
		check18IdCardNo: function(idCardNo){
		//18位身份证号码的基本格式校验
		var check = /^[1-9]\d{5}[1-9]\d{3}((0[1-9])|(1[0-2]))((0[1-9])|([1-2][0-9])|(3[0-1]))\d{3}(\d|x|X)$/.test(idCardNo);
		if(!check) return false;
		//校验地址码
		var addressCode = idCardNo.substring(0,6);
		check = idCardNoUtil.checkAddressCode(addressCode);
		if(!check) return false;
		//校验日期码
		var birDayCode = idCardNo.substring(6,14);
		check = idCardNoUtil.checkBirthDayCode(birDayCode);
		if(!check) return false;
		//验证校检码
		return idCardNoUtil.checkParityBit(idCardNo);
		},
		  
		formateDateCN: function(day){
		var yyyy =day.substring(0,4);
		var mm = day.substring(4,6);
		var dd = day.substring(6);
		return yyyy + '-' + mm +'-' + dd;
		},
		  
		//获取信息
		getIdCardInfo: function(idCardNo){
		var idCardInfo = {
		gender:"", //性别
		birthday:"" // 出生日期(yyyy-mm-dd)
		};
		if(idCardNo.length==15){
		var aday = '19' + idCardNo.substring(6,12);
		idCardInfo.birthday=idCardNoUtil.formateDateCN(aday);
		if(parseInt(idCardNo.charAt(14))%2==0){
		idCardInfo.gender=idCardNoUtil.genders.female;
		}else{
		idCardInfo.gender=idCardNoUtil.genders.male;
		}
		}else if(idCardNo.length==18){
		var aday = idCardNo.substring(6,14);
		idCardInfo.birthday=idCardNoUtil.formateDateCN(aday);
		if(parseInt(idCardNo.charAt(16))%2==0){
		idCardInfo.gender=idCardNoUtil.genders.female;
		}else{
		idCardInfo.gender=idCardNoUtil.genders.male;
		}
		  
		}
		return idCardInfo;
		},
		getId15:function(idCardNo){
		if(idCardNo.length==15){
		return idCardNo;
		}else if(idCardNo.length==18){
		return idCardNo.substring(0,6) + idCardNo.substring(8,17);
		}else{
		return null;
		}
		},
		getId18: function(idCardNo){
		if(idCardNo.length==15){
		var id17 = idCardNo.substring(0,6) + '19' + idCardNo.substring(6);
		var parityBit = idCardNoUtil.getParityBit(id17);
		return id17 + parityBit;
		}else if(idCardNo.length==18){
		return idCardNo;
		}else{
		return null;
		}
		}
		};

function isDate8(sDate) {
    if(!/^[0-9]{8}$/.test(sDate)) {
       return false;
    }
    var year,month, day;
    year =sDate.substring(0, 4);
    month =sDate.substring(4, 6);
    day =sDate.substring(6, 8);
    variaMonthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30,31]
    if (year< 1700 || year > 2500) returnfalse
    if (((year %4 == 0) && (year % 100 != 0)) ||(year % 400 == 0)) iaMonthDays[1] = 29;
    if (month< 1 || month > 12) return false
    if (day< 1 || day > iaMonthDays[month - 1]){
    	return false
    }
    return true;
}

//IP地址验证   
$.validator.addMethod("ip", function(value, element) { 
	var ipAddr = /^(([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))\.)(([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))\.){2}([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))$/;
    return this.optional(element) || ipAddr.test(value);    
}, "请正确输入IP地址！");

$.validator.addMethod("bankCardNum", function(bankno, element) {       
    var lastNum=bankno.substr(bankno.length-1,1);//取出最后一位（与luhm进行比较）
     
    var first15Num=bankno.substr(0,bankno.length-1);//前15或18位
    var newArr=new Array();
    for(var i=first15Num.length-1;i>-1;i--){    //前15或18位倒序存进数组
        newArr.push(first15Num.substr(i,1));
    }
    var arrJiShu=new Array();  //奇数位*2的积 <9
    var arrJiShu2=new Array(); //奇数位*2的积 >9
     
    var arrOuShu=new Array();  //偶数位数组
    for(var j=0;j<newArr.length;j++){
        if((j+1)%2==1){//奇数位
            if(parseInt(newArr[j])*2<9)
            arrJiShu.push(parseInt(newArr[j])*2);
            else
            arrJiShu2.push(parseInt(newArr[j])*2);
        }
        else //偶数位
        arrOuShu.push(newArr[j]);
    }
     
    var jishu_child1=new Array();//奇数位*2 >9 的分割之后的数组个位数
    var jishu_child2=new Array();//奇数位*2 >9 的分割之后的数组十位数
    for(var h=0;h<arrJiShu2.length;h++){
        jishu_child1.push(parseInt(arrJiShu2[h])%10);
        jishu_child2.push(parseInt(arrJiShu2[h])/10);
    }       
     
    var sumJiShu=0; //奇数位*2 < 9 的数组之和
    var sumOuShu=0; //偶数位数组之和
    var sumJiShuChild1=0; //奇数位*2 >9 的分割之后的数组个位数之和
    var sumJiShuChild2=0; //奇数位*2 >9 的分割之后的数组十位数之和
    var sumTotal=0;
    for(var m=0;m<arrJiShu.length;m++){
        sumJiShu=sumJiShu+parseInt(arrJiShu[m]);
    }
     
    for(var n=0;n<arrOuShu.length;n++){
        sumOuShu=sumOuShu+parseInt(arrOuShu[n]);
    }
     
    for(var p=0;p<jishu_child1.length;p++){
        sumJiShuChild1=sumJiShuChild1+parseInt(jishu_child1[p]);
        sumJiShuChild2=sumJiShuChild2+parseInt(jishu_child2[p]);
    }     
    //计算总和
    sumTotal=parseInt(sumJiShu)+parseInt(sumOuShu)+parseInt(sumJiShuChild1)+parseInt(sumJiShuChild2);
     
    //计算Luhm值
    var k= parseInt(sumTotal)%10==0?10:parseInt(sumTotal)%10;       
    var luhm= 10-k;
     
    if(lastNum==luhm){
        return true;
    }
    else{
        return false;
    }       
}, "请正确填写您的银行卡号"); 