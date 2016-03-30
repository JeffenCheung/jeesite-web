/*!
 * Copyright &copy; 2014-2016 <a href="https://pactera.com">Pactera</a> All rights reserved.
 * 
 * 日期时间处理方法
 * @author Jeffen
 * @version 2015-11-30
 */
 

// gang control the begin and end datepicker
function gangDateStart(endDateId, showClear, dateFormat){
	if($.isEmptyObject(showClear) && showClear){
		showClear = true;
	}
	if($.isEmptyObject(dateFormat)){
		dateFormat = 'yyyy-MM-dd HH:mm:ss';
	}
	var endDate=$dp.$(endDateId);
	WdatePicker({
		dateFmt: dateFormat
		, isShowClear: showClear
		, onpicked: function(){
			endDate.focus();
		}
		, maxDate: '#F{$dp.$D(\'' + endDateId + '\')}'});
}
function gangDateEnd(beginDateId, showClear, dateFormat){
	if($.isEmptyObject(showClear) && showClear){
		showClear = true;
	}
	if($.isEmptyObject(dateFormat)){
		dateFormat = 'yyyy-MM-dd HH:mm:ss';
	}
	WdatePicker({
		dateFmt: dateFormat
		, isShowClear: showClear
		, minDate: '#F{$dp.$D(\'' + beginDateId + '\')}'});
}

function str2date (str_datetime) {
    str_datetime = (str_datetime == null) ? "" : str_datetime;
    if(str_datetime.length == 0){
        return null;
    }
    var re_date = /^(\d+)\-(\d+)\-(\d+)$/;
    if (!re_date.exec(str_datetime)){
        //return alert("Invalid Datetime format: "+ str_datetime + "\r\n  yyyy-mm-dd");
			throw err;
		}

    return (new Date (RegExp.$1, RegExp.$2-1, RegExp.$3, 0, 0, 0));
}
function str2time (str_datetime) {
    str_datetime = (str_datetime == null) ? "" : str_datetime;
    if(str_datetime.length == 0){
        return null;
    }
    var re_date = /^(\d+)\:(\d+)\:(\d+)$/;
    if (!re_date.exec(str_datetime)){
        //return alert("Invalid Datetime format: "+ str_datetime + "\r\n  HH:MM:SS");
			throw err;
		}
    var d = new Date();
    return (new Date (d.getYear(), d.getMonth(), d.getDate(), RegExp.$1, RegExp.$2, RegExp.$3));
}
function str2datetime (str_datetime) {
    str_datetime = (str_datetime == null) ? "" : str_datetime;
    if(str_datetime.length == 0){
        return null;
    }
    var re_date = /^(\d+)\-(\d+)\-(\d+)\s+(\d+)\:(\d+)\:(\d+)$/;
    if (!re_date.exec(str_datetime)){
        //return alert("Invalid Datetime format: "+ str_datetime + "\r\n  yyyy-mm-dd HH:MM:SS");
			throw err;
		}
    return (new Date ( RegExp.$1, RegExp.$2-1, RegExp.$3, RegExp.$4, RegExp.$5, RegExp.$6));
}

function getNewDate(d)
{
    if(d != null && typeof(d) == 'object')
    {
        if(d.getTime != null){
            return new Date(d.getTime());
        }
    }
    var nd = parseFloat(d);
    if(isNaN(nd))
    {
        return null;
    }
    else
    {
        return new Date(nd);
    }
}

function formatDate(arg)
{
    var d = getNewDate(arg);
    if(d == null) return "";

    var ds = getDateYear(d) + '-';
    ds += getDateMonth(d) + '-';
    ds += getDay(d);

    return ds;
}

function getDateYear(d)
{
    return "" + d.getFullYear();
}
function getDateMonth(d)
{
    var m = d.getMonth() + 1;
    if(m < 10) m = "0" + m;
    return "" + m;
}
function getDay(d)
{
    var day = d.getDate();
    if(day < 10) day = "0" + day;
    return "" + day;
}
function getHour(d)
{
    var h = d.getHours();
    if(h < 10) h = "0" + h;
    return "" + h;
}
function getMinute(d)
{
    var m = d.getMinutes();
    if(m < 10) m = "0" + m;
    return "" + m;
}
function getSecond(d)
{
    var s = d.getSeconds();
    if(s < 10) s = "0" + s;
    return "" + s;
}
function getMillisecond(d)
{
    var s = d.getMilliseconds();
    if(s < 10) s = "0000" + s;
    return "" + s;
}

function formatTime(arg)
{
    var d = getNewDate(arg);
    if(d == null) return "";

    var ds = getHour(d) + ':';
    ds += getMinute(d) + ':';
    ds += getSecond(d);

    return ds;
}

function formatDateTime(arg)
{
    var d = getNewDate(arg);
    if(d == null) return "";

    var ds = formatDate(arg) + " " + formatTime(arg);
    return ds;
}

// YYYY-MM-DD hh:mm:ss
function formatDateTimeA()
{
    var d = new Date();
    return formatDateTime(d.getTime());
}

// YYYY-MM-DD hh:mm:ss mis
function formatDateTimeB()
{
    var d = new Date();
    return formatDateTime(d.getTime()) + getMillisecond(d);
}

// 时间方法
function getTime() {
	var now= new Date(),
	h=now.getHours(),
	m=now.getMinutes(),
	s=now.getSeconds(),
	ms=now.getMilliseconds();
	return (h+":"+m+":"+s+ " " +ms);
}

// 平台日志输出
// via. http://getfirebug.com/wiki/index.php/Console_API
// 平台日志输出[LOG]
function cLog(fn, content){
	window.console&&console.log("LOG-[" + formatDateTimeB() + " " + fn + "]" + content);
}
// 平台日志输出[DEBUG]
function cDebug(fn, content){
	window.console&&console.debug("DEBUG-[" + formatDateTimeB() + " " + fn + "]" + content);
}
// 平台日志输出[INFO]
function cInfo(fn, content){
	window.console&&console.info("INFO-[" + formatDateTimeB() + " " + fn + "]" + content);
}
// 平台日志输出[WARN]
function cWarn(fn, content){
	window.console&&console.warn("WARN-[" + formatDateTimeB() + " " + fn + "]" + content);
}
// 平台日志输出[ERROR]
function cError(fn, content){
	window.console&&console.error("ERROR-[" + formatDateTimeB() + " " + fn + "]" + content);
}

/* 得到日期年月日等加数字后的日期 */ 
Date.prototype.dateAdd = function(interval,number) 
{ 
    var d = this; 
    var k={'y':'FullYear', 'q':'Month', 'm':'Month', 'w':'Date', 'd':'Date', 'h':'Hours', 'n':'Minutes', 's':'Seconds', 'ms':'MilliSeconds'}; 
    var n={'q':3, 'w':7}; 
    eval('d.set'+k[interval]+'(d.get'+k[interval]+'()+'+((n[interval]||1)*number)+')'); 
    return d; 
} 
/* 计算两日期相差的日期年月日等
		返回两个日期对象之间的时间间隔。
		dateObj.dateDiff(interval, dateObj2)

		参数
		interval
		    必选项。字符串表达式，表示用于计算 date1 和 date2 之间的时间间隔。有关数值，请参阅“设置”部分。
		dateObj, dateObj2
		    必选项。日期对象。用于计算的两个日期对象。

		设置
		interval 参数可以有以下值：
		设置	描述
			y	年
			q	季度
			m	月
			d	日
			w	周
			h	小时
			n	分钟
			s	秒
			ms	毫秒
	
	 */ 
Date.prototype.dateDiff = function(interval,objDate2) 
{ 
    var d=this, i={}, t=d.getTime(), t2=objDate2.getTime(); 
    i['y']=objDate2.getFullYear()-d.getFullYear(); 
    i['q']=i['y']*4+Math.floor(objDate2.getMonth()/4)-Math.floor(d.getMonth()/4); 
    i['m']=i['y']*12+objDate2.getMonth()-d.getMonth(); 
    i['ms']=objDate2.getTime()-d.getTime(); 
    i['w']=Math.floor((t2+345600000)/(604800000))-Math.floor((t+345600000)/(604800000)); 
    i['d']=Math.floor(t2/86400000)-Math.floor(t/86400000); 
    i['h']=Math.floor(t2/3600000)-Math.floor(t/3600000); 
    i['n']=Math.floor(t2/60000)-Math.floor(t/60000); 
    i['s']=Math.floor(t2/1000)-Math.floor(t/1000); 
    return i[interval]; 
}

/* 
	date diff test:
			// definition start date.
			var start = new Date();
			////////your process code here.////////
			// call date diff by sample function.
			cDebug("test", start.dateDiffNowLimitedSecond());
			// format date diff log here: 
			// DEBUG-[2016-01-07 19:01:06536 test]276 millisecond (about 1 second)
	*/
Date.prototype.dateDiffNowLimitedSecond = function()
{ 
    return this.dateDiffNowMs(new Date())+' (about '+this.dateDiffNowS(new Date())+')';
}
Date.prototype.dateDiffNowMs = function()
{ 
    return this.dateDiff('ms', new Date())+' millisecond';
}
Date.prototype.dateDiffNowS = function()
{ 
    return this.dateDiff('s', new Date())+' second';
}