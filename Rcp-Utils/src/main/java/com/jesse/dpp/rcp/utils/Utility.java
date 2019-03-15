package com.jesse.dpp.rcp.utils;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class Utility {

    private static final Log log = LogFactory.getLog(Utility.class);

    /**
     * isEmpty
     *
     * Test to see whether input string is empty.
     *
     * @param str
     *            A String
     * @return True if it is empty; false if it is not.
     */
    public static boolean isEmpty(String str) {
        return (str == null || str.length() == 0 || str.trim().equals(""));
    }

    /**
     * isEmpty
     *
     * Test to see whether input string buffer is empty.
     *
     * @param str
     *            A StringBuffer
     * @return True if it is empty; false if it is not.
     */
    public static boolean isEmpty(StringBuffer stringBuffer) {
        return (stringBuffer == null || stringBuffer.length() == 0 || stringBuffer.toString().trim().equals(""));
    }

    /**
     * isEmpty
     *
     * Test to see whether input string is empty.
     *
     * @param str
     *            A String
     * @return True if it is empty; false if it is not.
     */
    public static boolean isEmpty(Object[] array) {
        return (array == null || array.length == 0);
    }

    /**
     * isEmpty
     *
     * Test to see whether input is empty.
     *
     * @param StringArray
     *            A array
     * @return True if it is empty; false if it is not.
     */
    public static boolean isEmpty(String[] array) {
        return (array == null || array.length == 0);
    }

    /**
     * isEmpty
     *
     * Test to see whether input is representing a NULL value.
     *
     * @param val
     *            An Object
     * @return True if it represents NULL; false if it is not.
     */
    public static boolean isEmpty(Object val) {
        return (val == null);
    }

    /**
     * isEmpty
     *
     * Test to see whether input is empty.
     *
     * @param list
     *            A List
     * @return True if it is empty; false if it is not.
     */
    public static boolean isEmpty(List<Object> list) {
        return (list == null || list.size() == 0);
    }

    public static boolean isEmpty(Vector<Object> vector) {
        return (vector == null || vector.size() == 0);
    }

    public static boolean isHtmlNull(String str) {
        if (isEmpty(str) || "null".equals(str.toLowerCase().trim())) {
            return true;
        }
        return false;
    }

    /**
     * Convert an Object Array into String Array by calling obj.toString()
     *
     * @param obj
     *            The object array.
     * @return The String Array representing that object array
     */
    public static String[] getStringArray(Object[] obj) {
        if (obj == null) {
            return null;
        }

        String[] strArray = new String[obj.length];
        for (int i = 0; i < obj.length; i++) {
            strArray[i] = obj[i].toString();
        }
        return strArray;
    }

    /**
     *
     * @param String
     *            : Query
     * @return String[]: Array of logical param
     */
    public static String[] getLogicalString(String query) {
        String andString[] = query.toUpperCase().split("\\s(AND|\\+)\\s");
        String orString[] = query.toUpperCase().split("\\sOR\\s");
        String notString[] = query.toUpperCase().split("\\s(\\-|NOT)\\s");
        String resultString[] = null;
        if (andString.length > 1) {
            for (int i = 0; i < andString.length; i++) {
                andString[i] = "AND";
            }
            resultString = andString;
        } else if (orString.length > 1) {
            for (int i = 0; i < orString.length; i++) {
                orString[i] = "OR";
            }
            resultString = orString;
        } else if (notString.length > 1) {
            for (int i = 0; i < notString.length; i++) {
                notString[i] = "NOT";
            }
            resultString = notString;
        }

        return resultString;
    }

    /**
     * splitLogicalString
     *
     * @param query
     *            Query
     * @return String[] result splited array
     */
    public static String[] splitLogicalString(String query) {
        String andString[] = query.toUpperCase().split("\\s(AND|\\+)\\s");
        String orString[] = query.toUpperCase().split("\\sOR\\s");
        String notString[] = query.toUpperCase().split("\\s(\\-|NOT)\\s");
        String resultString[] = null;
        if (andString.length > 1) {
            resultString = andString;
        } else if (orString.length > 1) {
            resultString = orString;
        } else if (notString.length > 1) {
            resultString = notString;
        } else {
            resultString = new String[1];
            resultString[0] = query;
        }
        return resultString;
    }

    /**
     * getList
     *
     * @param ary
     *            The object array.
     * @return The list contains all the object array elements.
     */
    public static List<Object> getList(Object[] ary) {
        if (ary == null) {
            return (null);
        }
        List<Object> result = new ArrayList<Object>();
        for (int i = 0; i < ary.length; i++) {
            result.add(ary[i]);
        }
        return (result);
    }

    /**
     * getStringArray
     *
     * @param ary
     *            The object array.
     * @return The list contains all the object array elements.
     */
    public static String[] getStringArray(List<String> list) {
        if (list == null) {
            return null;
        }
        String[] result = new String[list.size()];
        for (String str : list) {
            String.valueOf(str);
        }
        return (result);
    }

    /**
     * Returns Calendar converted from Timestamp.
     *
     * @param inTime
     *            Source timestamp which to be converted.
     * @return Calendar object which converted from input.
     */
    public static java.util.Calendar timestampToCalendar(java.sql.Timestamp inTime) {
        if (inTime == null) {
            return (null);
        }
        java.util.Calendar cal = java.util.Calendar.getInstance();
        cal.setTime(inTime);
        return (cal);
    }

    /**
     * Returns Timestamp converted from Calendar.
     *
     * @param inCal
     *            Source calendar which to be converted.
     * @return Timestamp object which converted from input.
     */
    public static java.sql.Timestamp calendarToTimestamp(java.util.Calendar inCal) {
        if (inCal == null) {
            return (null);
        }
        java.sql.Timestamp time = new java.sql.Timestamp(inCal.getTime().getTime());
        return (time);
    }

    /**
     * addYear - Returns the timestamp after adding certain amount of Year.
     *
     * @param src
     *            Source timestamp.
     * @param val
     *            Number of years going to add, can be negative number.
     * @return Timestamp after adding certain amount of years.
     */
    public static java.sql.Timestamp addYear(java.sql.Timestamp src, int val) {
        java.util.Calendar tmpCal = timestampToCalendar(src);
        if (tmpCal == null) {
            return (null);
        }
        tmpCal.add(java.util.Calendar.YEAR, val);
        return (calendarToTimestamp(tmpCal));
    }

    /**
     * addMonth - Returns the timestamp after adding certain amount of Month.
     *
     * @param src
     *            Source timestamp.
     * @param val
     *            Number of months going to add, can be negative number.
     * @return Timestamp after adding certain amount of months.
     */
    public static java.sql.Timestamp addMonth(java.sql.Timestamp src, int val) {
        java.util.Calendar tmpCal = timestampToCalendar(src);
        if (tmpCal == null) {
            return (null);
        }
        tmpCal.add(java.util.Calendar.MONTH, val);
        return (calendarToTimestamp(tmpCal));
    }

    /**
     * addDay - Returns the timestamp after adding certain amount of day.
     *
     * @param src
     *            Source timestamp.
     * @param val
     *            Number of days going to add, can be negative number.
     * @return Timestamp after adding certain amount of days.
     */
    public static java.sql.Timestamp addDay(java.sql.Timestamp src, int val) {
        java.util.Calendar tmpCal = timestampToCalendar(src);
        if (tmpCal == null) {
            return (null);
        }
        tmpCal.add(java.util.Calendar.DAY_OF_MONTH, val);
        return (calendarToTimestamp(tmpCal));
    }

    /**
     * addHour - Returns the timestamp after adding certain amount of hours.
     *
     * @param src
     *            Source timestamp.
     * @param val
     *            Number of hours going to add, can be negative number.
     * @return Timestamp after adding certain amount of hours.
     */
    public static java.sql.Timestamp addHour(java.sql.Timestamp src, int val) {
        java.util.Calendar tmpCal = timestampToCalendar(src);
        if (tmpCal == null) {
            return (null);
        }
        tmpCal.add(java.util.Calendar.HOUR, val);
        return (calendarToTimestamp(tmpCal));
    }

    /**
     * addMinute - Returns the timestamp after adding certain amount of minutes.
     *
     * @param src
     *            Source timestamp.
     * @param val
     *            Number of minutes going to add, can be negative number.
     * @return Timestamp after adding certain amount of minutes.
     */
    public static java.sql.Timestamp addMinute(java.sql.Timestamp src, int val) {
        java.util.Calendar tmpCal = timestampToCalendar(src);
        if (tmpCal == null) {
            return (null);
        }
        tmpCal.add(java.util.Calendar.MINUTE, val);
        return (calendarToTimestamp(tmpCal));
    }

    /**
     * addSecond - Returns the timestamp after adding certain amount of seconds.
     *
     * @param src
     *            Source timestamp.
     * @param val
     *            Number of seconds going to add, can be negative number.
     * @return Timestamp after adding certain amount of seconds.
     */
    public static java.sql.Timestamp addSecond(java.sql.Timestamp src, int val) {
        java.util.Calendar tmpCal = timestampToCalendar(src);
        if (tmpCal == null) {
            return (null);
        }
        tmpCal.add(java.util.Calendar.SECOND, val);
        return (calendarToTimestamp(tmpCal));
    }

    /**
     * Call this function to set the time section of a calendar
     *
     * @param inCalendar
     * @param hr
     * @param min
     * @param sec
     * @param milliSec
     */
    public static void setCalendarTime(Calendar inCalendar, int hr, int min, int sec, int milliSec) {
        if (inCalendar != null) {
            if (hr != -1) {
                inCalendar.set(Calendar.HOUR_OF_DAY, hr);
            }
            if (min != -1) {
                inCalendar.set(Calendar.MINUTE, min);
            }
            if (sec != -1) {
                inCalendar.set(Calendar.SECOND, sec);
            }
            if (milliSec != -1) {
                inCalendar.set(Calendar.MILLISECOND, milliSec);
            }
        }
    }

    /**
     * 1 day = 1*24*60*60*1000 millisecond.
     * 
     * @param dayValue
     * @return
     */
    public static int dayValue2Millisecond(int dayValue) {
        return (dayValue * 24 * 60 * 60 * 1000);
    }

    /**
     * Call this function to round off the second and millisecond of time.
     *
     * @param timestamp
     *            The timestamp value to be strip to minutes
     * @return
     */

    public static java.sql.Timestamp stripToMinutes(java.sql.Timestamp timestamp) {
        Calendar cal = Calendar.getInstance();
        cal.setTimeInMillis(timestamp.getTime());
        int day = cal.get(Calendar.DATE);
        int month = cal.get(Calendar.MONTH);
        int year = cal.get(Calendar.YEAR);
        int hour = cal.get(Calendar.HOUR_OF_DAY);
        int time = cal.get(Calendar.MINUTE);

        cal.clear();
        cal.set(year, month, day, hour, time);
        timestamp = new java.sql.Timestamp(cal.getTimeInMillis());
        return timestamp;
    }

    /**
     * Function to convert a resource bundle into java.util.Map
     *
     * @param bundleName
     *            The bundle name to parse
     * @return the key / value pair in java.util.Map format
     */
    public static Map<String, String> parseResourceBundle(String bundleName) {
        Map<String, String> paraMap = new HashMap<String, String>();
        ResourceBundle resourceBundle = null;
        try {
            resourceBundle = ResourceBundle.getBundle(bundleName);
            Enumeration<String> resKeys = resourceBundle.getKeys();
            while (resKeys.hasMoreElements()) {
                String key = (String) resKeys.nextElement();
                String value = resourceBundle.getString(key);
                if (value == null) {
                    value = "";
                }
                paraMap.put(key, value);
            }
        } catch (java.util.MissingResourceException e) {
            log.error(e.getMessage(), e);
        }
        return paraMap;
    }

    /**
     *
     * @param stringArray
     *            A String Array
     * @param logic
     *            The value is "AND" or "OR"
     * @return the String /
     */
    public static String genericLogicSql(String[] stringArray, String logic) {
        String returnTo = null;
        if (!Utility.isEmpty(stringArray)) {
            int count = 0;
            for (int i = 0; i < stringArray.length; i++) {
                if (count == 0) {
                    returnTo = stringArray[i];
                } else {
                    returnTo = returnTo + " " + logic + " " + stringArray[i];
                }
                count = 1;
            }
        }
        return returnTo;

    }

    /**
     * delete this repeat character
     * 
     * @param repeatStr
     *            The String contain the repeat character
     * @param separator
     *            The list separator
     * @return noRepeatStr The String has not contain the repeat character
     */
    public static String deleteRepeatStr(String repeatStr, String separator) {
        if (repeatStr == null) {
            return null;
        }
        StringBuffer noRepeatStr = new StringBuffer();
        String[] strElement = repeatStr.split(separator);
        List<String> strlist = new ArrayList<String>();
        for (int i = 0; i < strElement.length; i++) {
            if (!strlist.contains(strElement[i])) {
                strlist.add(strElement[i]);
            }
        }
        for (int i = 0; i < strlist.size(); i++) {
            noRepeatStr.append(strlist.get(i));
            if (i != strlist.size() - 1) {
                noRepeatStr.append(separator);
            }
        }
        return noRepeatStr.toString();
    }

    /**
     * remove the repeat element in the list
     * 
     * @param list
     * @return newList
     */
    public static List<String> removeDuplicate(List<String> list) {
        if (Utility.isEmpty(list)) {
            return null;
        }
        HashSet<String> h = new HashSet<String>(list);
        List<String> newList = new ArrayList<String>();
        newList.addAll(h);
        return newList;
    }

    public static String inputStream2String(InputStream is) throws IOException {
        if (null == is) {
            return "";
        }
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        int i = -1;
        while ((i = is.read()) != -1) {
            baos.write(i);
        }
        return baos.toString();
    }

    public static String inputStream2String(InputStream is, String type) throws IOException {
        if (null == is) {
            return "";
        }
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        int i = -1;
        while ((i = is.read()) != -1) {
            baos.write(i);
        }
        return baos.toString(type);
    }

    public static String formatTimestampToIndex(java.sql.Timestamp timestamp) {
        if (timestamp == null) {
            return "";
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", java.util.Locale.US);
        String dateStr = sdf.format(timestamp);
        return dateStr;
    }

    public static String sicenToString(double value) {
        if (isEmpty(value)) {
            return null;
        }
        String retValue = null;
        DecimalFormat df = new DecimalFormat("0");
        retValue = df.format(value);

        System.out.println(retValue);
        retValue = retValue.replaceAll(",", "");
        return retValue.toString();

    }

    public static double parseStoreSize(String value) {
        double size = 0;
        value = value.toUpperCase();
        if (value.endsWith("KB") || value.endsWith("K")) {
            String temp = value.substring(0, value.lastIndexOf("K"));
            size = Long.parseLong(temp) * Math.pow(2, 10);
        } else if (value.endsWith("MB") || value.endsWith("M")) {
            String temp = value.substring(0, value.lastIndexOf("M"));
            size = Long.parseLong(temp) * Math.pow(2, 20);
        } else if (value.endsWith("GB") || value.endsWith("G")) {
            String temp = value.substring(0, value.lastIndexOf("G"));
            size = Long.parseLong(temp) * Math.pow(2, 30);
        } else if (value.endsWith("TB") || value.endsWith("T")) {
            String temp = value.substring(0, value.lastIndexOf("T"));
            size = Long.parseLong(temp) * Math.pow(2, 40);
        } else if (value.endsWith("PB") || value.endsWith("P")) {
            String temp = value.substring(0, value.lastIndexOf("P"));
            size = Long.parseLong(temp) * Math.pow(2, 50);
        } else if (value.endsWith("B")) {
            String temp = value.substring(0, value.lastIndexOf("B"));
            size = Long.parseLong(temp);
        } else {
            size = Long.parseLong(value) * Math.pow(2, 20);
            ;
        }
        return size;
    }

    public static String parseListToString(List<Object> list, String div) {
        String result = "";
        if (isEmpty(list)) {
            return result;
        }
        int i = 0;
        for (Object object : list) {
            if (i == 0) {
                result += object;
            } else {
                result += div + object;
            }
            i++;
        }
        return result;
    }
    
    public static String getIpAddr(HttpServletRequest request) {
        log.info("get IP Address...........");
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        if (!isEmpty(ip) && !"unknown".equalsIgnoreCase(ip)) {
            if (ip.indexOf(",") > 0) {
                ip = ip.substring(0, ip.indexOf(","));
            }
        }
        return ip;
    }
    
    public static boolean validateMoney(String opMoney) {
        if(opMoney.contains(".")){
            DecimalFormat df = new DecimalFormat("#0.00");
            try {
                opMoney = df.format(new BigDecimal(opMoney));
            } catch (Exception e) {
                log.info("DecimalFormat error, opMoney : " + opMoney);
                return false;
            }
        }
        
        String regex = "^\\d{1,13}(\\.\\d{2})?$";
        Pattern p = Pattern.compile(regex);
        Matcher m = p.matcher(String.valueOf(opMoney));
        boolean flag = m.matches();
        return flag;
    }
    
    public static boolean isValidDate(String str) {
        boolean convertSuccess = true;
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            format.setLenient(false);
            format.parse(str);
        } catch (ParseException e) {
            convertSuccess = false;
        }
        return convertSuccess;
    }
}