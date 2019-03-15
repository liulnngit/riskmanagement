package com.jesse.dpp.rcp.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 日期工具类
 * 
 * @author dyq-t176
 *
 */
public class RCPDateUtils {

    /**
     * 获取上一个月的第一天
     * 
     * @return
     */
    public static Date getPreMouthOne() {
        Calendar ca = Calendar.getInstance();// 获取当前日期
        ca.add(Calendar.MONTH, -1);
        ca.set(Calendar.DAY_OF_MONTH, 1);// 设置为1号,当前日期既为本月第一天
        return ca.getTime();
    }

    /**
     * 获取上一个月的最后一天
     * 
     * @return
     */
    public static Date getPreMouthLast() {
        Calendar ca = Calendar.getInstance();
        ca.set(Calendar.DAY_OF_MONTH, 0);// 设置为1号,当前日期既为本月第一天
        return ca.getTime();
    }

    /**
     * 获取本月第一天
     * 
     * @return
     */
    public static Date getMouthOne() {
        Calendar ca = Calendar.getInstance();// 获取当前日期
        ca.add(Calendar.MONTH, 0);
        ca.set(Calendar.DAY_OF_MONTH, 1);// 设置为1号,当前日期既为本月第一天
        return ca.getTime();
    }

    /**
     * 获取本月最后一天
     * 
     * @return
     */
    public static Date getMouthLast() {
        Calendar ca = Calendar.getInstance();
        ca.set(Calendar.DAY_OF_MONTH, ca.getActualMaximum(Calendar.DAY_OF_MONTH));
        return ca.getTime();
    }

    /**
     * 获取最近七天
     * 
     * @return
     */
    public static Date get7day() {
        Calendar ca = Calendar.getInstance();
        ca.setTime(new Date());
        ca.add(Calendar.DAY_OF_WEEK, -6);
        ca.set(Calendar.HOUR_OF_DAY, 00);
        ca.set(Calendar.MINUTE, 00);
        ca.set(Calendar.SECOND, 00);
        return ca.getTime();
    }
    
    /**
     * 获取明天的日期
     * @return
     */
    public static Date getDay() {
        Calendar ca = Calendar.getInstance(); 
        ca.setTime(new Date());
        ca.add(Calendar.DAY_OF_WEEK, 1);
        return  ca.getTime();
    }
    
    /**
     * 获取最近30天的日期
     * @return
     */
    public static Date get30Day(){
	    Calendar ca = Calendar.getInstance(); 
        ca.setTime(new Date());
        ca.add(ca.DATE, -30);  
        return ca.getTime();
    }
    
    /** 
     * 取得季度第一天 
     *  
     * @param date 
     * @return 
     */  
    public static Date getFirstDateOfSeason() {
        Date date = new Date();
        Date seasonDate = getSeasonDate(date)[0];
        Calendar c = Calendar.getInstance();  
        c.setTime(seasonDate);  
        c.set(Calendar.DAY_OF_MONTH, c.getActualMinimum(Calendar.DAY_OF_MONTH));  
        return c.getTime();   
    }  
    
    /** 
     * 取得季度最后一天 
     *  
     * @param date 
     * @return 
     */  
    public static Date getLastDateOfSeason() {  
        Date date = new Date();
        Date seasonDate = getSeasonDate(date)[2];
        Calendar c = Calendar.getInstance();  
        c.setTime(seasonDate);  
        c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));  
        return c.getTime();   
    } 
    
    /** 
     * 取得季度月 
     *  
     * @param date 
     * @return 
     */  
    public static Date[] getSeasonDate(Date date) {  
        Date[] season = new Date[3];  
  
        Calendar c = Calendar.getInstance();  
        c.setTime(date);  
  
        int nSeason = getSeason(date);  
        if (nSeason == 1) {// 第一季度  
            c.set(Calendar.MONTH, Calendar.JANUARY);  
            season[0] = c.getTime();  
            c.set(Calendar.MONTH, Calendar.FEBRUARY);  
            season[1] = c.getTime();  
            c.set(Calendar.MONTH, Calendar.MARCH);  
            season[2] = c.getTime();  
        } else if (nSeason == 2) {// 第二季度  
            c.set(Calendar.MONTH, Calendar.APRIL);  
            season[0] = c.getTime();  
            c.set(Calendar.MONTH, Calendar.MAY);  
            season[1] = c.getTime();  
            c.set(Calendar.MONTH, Calendar.JUNE);  
            season[2] = c.getTime();  
        } else if (nSeason == 3) {// 第三季度  
            c.set(Calendar.MONTH, Calendar.JULY);  
            season[0] = c.getTime();  
            c.set(Calendar.MONTH, Calendar.AUGUST);  
            season[1] = c.getTime();  
            c.set(Calendar.MONTH, Calendar.SEPTEMBER);  
            season[2] = c.getTime();  
        } else if (nSeason == 4) {// 第四季度  
            c.set(Calendar.MONTH, Calendar.OCTOBER);  
            season[0] = c.getTime();  
            c.set(Calendar.MONTH, Calendar.NOVEMBER);  
            season[1] = c.getTime();  
            c.set(Calendar.MONTH, Calendar.DECEMBER);  
            season[2] = c.getTime();  
        }  
        return season;  
    }
    
    /** 
     *  
     * 1 第一季度 2 第二季度 3 第三季度 4 第四季度 
     *  
     * @param date 
     * @return 
     */  
    public static int getSeason(Date date) {  
  
        int season = 0;  
  
        Calendar c = Calendar.getInstance();  
        c.setTime(date);  
        int month = c.get(Calendar.MONTH);  
        switch (month) {  
        case Calendar.JANUARY:  
        case Calendar.FEBRUARY:  
        case Calendar.MARCH:  
            season = 1;  
            break;  
        case Calendar.APRIL:  
        case Calendar.MAY:  
        case Calendar.JUNE:  
            season = 2;  
            break;  
        case Calendar.JULY:  
        case Calendar.AUGUST:  
        case Calendar.SEPTEMBER:  
            season = 3;  
            break;  
        case Calendar.OCTOBER:  
        case Calendar.NOVEMBER:  
        case Calendar.DECEMBER:  
            season = 4;  
            break;  
        default:  
            break;  
        }  
        return season;  
    }  
    
    /**
     * 获取当前年中的第一个月
     * @return
     */
    public static String getFirstYearMonth() {
        Calendar c = Calendar.getInstance();
        c.setTime(new Date());
        int year = c.get(Calendar.YEAR);
        return year + "-01";
    }
    
    public static void main(String[] args) {
        System.out.println("当前季度第一天：" + (new SimpleDateFormat("yyyy-MM-dd").format(getDay())));
    }
    
    /**
     * 获取当前日期的月份
     * @return
     * @throws ParseException
     */
    public static String  getLastYearMonth() {
        Calendar c = Calendar.getInstance();
        c.setTime(new Date());
        c.add(Calendar.MONTH, +1);
        String year = String.valueOf(c.get(Calendar.YEAR));
        String month = String.valueOf(c.get(Calendar.MONTH)+1).length()==2?String.valueOf(c.get(Calendar.MONTH)+1):"0"+String.valueOf(c.get(Calendar.MONTH)+1); 
        return year + "-" + month;
    }
}
