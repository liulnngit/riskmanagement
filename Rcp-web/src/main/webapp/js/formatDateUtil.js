// 对Date的扩展，将 Date 转化为指定格式的String
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
// 例子： 
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
//日期格式化
Date.prototype.format = function(format) {
	var o = {
		"M+": this.getMonth() + 1, // month
		"d+": this.getDate(), // day
		"h+": this.getHours(), // hour
		"m+": this.getMinutes(), // minute
		"s+": this.getSeconds(), // second
		"q+": Math.floor((this.getMonth() + 3) / 3), // quarter
		"S": this.getMilliseconds()
		// millisecond
	}

	if(/(y+)/.test(format))
		format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	for(var k in o)
		if(new RegExp("(" + k + ")").test(format))
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
	return format;
}
/** 
 *转换日期对象为日期字符串 
 * @param date 日期对象 
 * @param isFull 是否为完整的日期数据, 
 * 为true时, 格式如"2000-03-05 01:05:04" 
 * 为false时, 格式如 "2000-03-05" 
 * @return 符合要求的日期字符串 
 */  
function getSmpFormatDate(date, isFull) {  
    var pattern = "";  
    if (isFull == true || isFull == undefined) {  
        pattern = "yyyy-MM-dd hh:mm:ss";  
    } else {  
        pattern = "yyyy-MM-dd";  
    }  
    return getFormatDate(date, pattern);  
}  
/** 
 *转换当前日期对象为日期字符串 
 * @param date 日期对象 
 * @param isFull 是否为完整的日期数据, 
 * 为true时, 格式如"2000-03-05 01:05:04" 
 * 为false时, 格式如 "2000-03-05" 
 * @return 符合要求的日期字符串 
 */  
function getSmpFormatNowDate(isFull) {  
    return getSmpFormatDate(new Date(), isFull);  
}  
/** 
 *转换long值为日期字符串 
 * @param l long值 
 * @param isFull 是否为完整的日期数据, 
 * 为true时, 格式如"2000-03-05 01:05:04" 
 * 为false时, 格式如 "2000-03-05" 
 * @return 符合要求的日期字符串 
 */  
function getSmpFormatDateByLong(l, isFull) {  
    return getSmpFormatDate(new Date(l), isFull);  
}  
/** 
 *转换long值为日期字符串 
 * @param l long值 
 * @param pattern 格式字符串,例如：yyyy-MM-dd hh:mm:ss 
 * @return 符合要求的日期字符串 
 */  
function getFormatDateByLong(l, pattern) {  
    return getFormatDate(new Date(l), pattern);  
}  
/** 
 *转换日期对象为日期字符串 
 * @param l long值 
 * @param pattern 格式字符串,例如：yyyy-MM-dd hh:mm:ss 
 * @return 符合要求的日期字符串 
 */  
function getFormatDate(date, pattern) {  
    if (date == undefined) {  
        date = new Date();  
    }  
    if (pattern == undefined) {  
        pattern = "yyyy-MM-dd hh:mm:ss";  
    }  
    return date.format(pattern);  
}  

/**
 * 将数值四舍五入(保留2位小数)后格式化成金额形式
 *
 * @param num 数值(Number或者String)
 * @return 金额格式的字符串,如'1,234,567.45'
 * @type String
 */
function formatCurrency(num) {
    num = num.toString().replace(/\$|\,/g,'');
    if(isNaN(num))
    num = "0";
    sign = (num == (num = Math.abs(num)));
    num = Math.floor(num*100+0.50000000001);
    cents = num%100;
    num = Math.floor(num/100).toString();
    if(cents<10)
    cents = "0" + cents;
    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
    num = num.substring(0,num.length-(4*i+3))+','+
    num.substring(num.length-(4*i+3));
    return (((sign)?'':'-') + num + '.' + cents);
}

/**
 * 格式化数字
 * @param num
 * @returns {string}
 */
function formatNumber(num) {
    if (num != '') {
        num = num.toString().replace(/\$|\,/g,'');
        if(isNaN(num))
            num = "0";
        sign = (num == (num = Math.abs(num)));
        num = Math.floor(num*100+0.50000000001);
        cents = num%100;
        num = Math.floor(num/100).toString();
        if(cents<10)
            cents = "0" + cents;
        for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
            num = num.substring(0,num.length-(4*i+3))+','+
                num.substring(num.length-(4*i+3));
        return (((sign)?'':'-') + num);
    } else {
        return '';
    }

}