package com.jesse.dpp.rcp.utils.formatdate;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 格式化时间工具类
 * @author dyq-t176
 *
 */
public class FormatDateUtil {
    
    private static Log log = LogFactory.getLog(FormatDateUtil.class);

	private static final String DATEFORMAT_HHMMSS = "yyyy-MM-dd HH:mm:ss";
	
	private static DateFormat startDf = new SimpleDateFormat("yyyy-MM-dd 00:00:00");

    private static DateFormat endDf = new SimpleDateFormat("yyyy-MM-dd 23:59:59");
	
	public static String formatDate(String time) {
		if (StringUtils.isNotBlank(time)) {
			SimpleDateFormat format = new SimpleDateFormat(DATEFORMAT_HHMMSS);
			return format.format(Long.parseLong(time));
		}else {
			return "";
		}
	}
	
	public static String formatDateToString(Date date, String format){
	    DateFormat df = new SimpleDateFormat(format);
	    String dateStr = df.format(date);
	    return dateStr;
	}
	
	public static Date formatStringToDate(String str) throws Exception{
	    DateFormat df = new SimpleDateFormat(DATEFORMAT_HHMMSS);
	    Date date = df.parse(str);
	    return date;
	}
	
	public static String formatCuurentTime(){
	    DateFormat df = new SimpleDateFormat(DATEFORMAT_HHMMSS);
        String dateStr = df.format(new Date());
        return dateStr;
	}
	
	/**
     * 
     * @param dateType
     *            (0、七天; 1、上月; 2、本月; 3、上季度; 4、本季度)
     * @param type
     *            (0、startDate, 1、endDate)
     * @return
     */
    public static String getBetweenDate(String dateType, String type) {
        Calendar cal = Calendar.getInstance();
        if ("0".equals(dateType)) {
            // 获取七天数据
            if ("0".equals(type)) {
                cal.setTime(new Date());
                cal.set(Calendar.DAY_OF_MONTH, cal.get(Calendar.DAY_OF_MONTH) - 7);
                String startDate = startDf.format(cal.getTime());
                log.info("startDate : " + startDate);
                return startDate;
            } else if ("1".equals(type)) {
                String endDate = endDf.format(cal.getTime());
                log.info("endDate : " + endDate);
                return endDate;
            }
        } else if ("1".equals(dateType)) {
            // 获取上月数据
            if ("0".equals(type)) {
                cal.add(Calendar.MONTH, -1);
                cal.set(Calendar.DAY_OF_MONTH, 1);
                String startDate = startDf.format(cal.getTime());
                log.info("startDate : " + startDate);
                return startDate;
            } else if ("1".equals(type)) {
                cal.set(Calendar.DAY_OF_MONTH, 0);
                String endDate = endDf.format(cal.getTime());
                log.info("endDate : " + endDate);
                return endDate;
            }
        } else if ("2".equals(dateType)) {
            // 获取本月数据
            if ("0".equals(type)) {
                cal.add(Calendar.MONTH, 0);
                cal.set(Calendar.DAY_OF_MONTH, 1);
                String startDate = startDf.format(cal.getTime());
                log.info("startDate : " + startDate);
                return startDate;
            } else if ("1".equals(type)) {
                cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH));
                String endDate = endDf.format(cal.getTime());
                log.info("endDate : " + endDate);
                return endDate;
            }
        } else if ("3".equals(dateType)) {
            // 获取上季度数据
            if ("0".equals(type)) {
                int currentMonth = cal.get(Calendar.MONTH) + 1;
                if (currentMonth >= 1 && currentMonth <= 3) {
                    cal.set(Calendar.YEAR, -1);
                    cal.set(Calendar.MONTH, 9);
                } else if (currentMonth >= 4 && currentMonth <= 6) {
                    cal.set(Calendar.MONTH, 0);
                } else if (currentMonth >= 7 && currentMonth <= 9) {
                    cal.set(Calendar.MONTH, 3);
                } else if (currentMonth >= 10 && currentMonth <= 12) {
                    cal.set(Calendar.MONTH, 6);
                }
                cal.set(Calendar.DATE, 1);
                String startDate = startDf.format(cal.getTime());
                log.info("startDate : " + startDate);
                return startDate;
            } else if ("1".equals(type)) {
                int currentMonth = cal.get(Calendar.MONTH) + 1;
                if (currentMonth >= 1 && currentMonth <= 3) {
                    cal.set(Calendar.YEAR, -1);
                    cal.set(Calendar.MONTH, 11);
                    cal.set(Calendar.DATE, 31);
                } else if (currentMonth >= 4 && currentMonth <= 6) {
                    cal.set(Calendar.MONTH, 2);
                    cal.set(Calendar.DATE, 31);
                } else if (currentMonth >= 7 && currentMonth <= 9) {
                    cal.set(Calendar.MONTH, 5);
                    cal.set(Calendar.DATE, 30);
                } else if (currentMonth >= 10 && currentMonth <= 12) {
                    cal.set(Calendar.MONTH, 8);
                    cal.set(Calendar.DATE, 30);
                }
                String endDate = endDf.format(cal.getTime());
                log.info("endDate : " + endDate);
                return endDate;
            }
        } else if ("4".equals(dateType)) {
            // 获取本季度数据
            if ("0".equals(type)) {
                int currentMonth = cal.get(Calendar.MONTH) + 1;
                if (currentMonth >= 1 && currentMonth <= 3) {
                    cal.set(Calendar.MONTH, 0);
                } else if (currentMonth >= 4 && currentMonth <= 6) {
                    cal.set(Calendar.MONTH, 3);
                } else if (currentMonth >= 7 && currentMonth <= 9) {
                    cal.set(Calendar.MONTH, 6);
                } else if (currentMonth >= 10 && currentMonth <= 12) {
                    cal.set(Calendar.MONTH, 9);
                }
                cal.set(Calendar.DATE, 1);
                String startDate = startDf.format(cal.getTime());
                log.info("startDate : " + startDate);
                return startDate;
            } else if ("1".equals(type)) {
                int currentMonth = cal.get(Calendar.MONTH) + 1;
                if (currentMonth >= 1 && currentMonth <= 3) {
                    cal.set(Calendar.MONTH, 2);
                    cal.set(Calendar.DATE, 31);
                } else if (currentMonth >= 4 && currentMonth <= 6) {
                    cal.set(Calendar.MONTH, 5);
                    cal.set(Calendar.DATE, 30);
                } else if (currentMonth >= 7 && currentMonth <= 9) {
                    cal.set(Calendar.MONTH, 8);
                    cal.set(Calendar.DATE, 30);
                } else if (currentMonth >= 10 && currentMonth <= 12) {
                    cal.set(Calendar.MONTH, 11);
                    cal.set(Calendar.DATE, 31);
                }
                String endDate = endDf.format(cal.getTime());
                log.info("endDate : " + endDate);
                return endDate;
            }
        }
        return null;
    }
    
    /**
     * 
     * @param type(0:开始时间, 1:结束时间)
     * @return
     * @throws Exception 
     */
    public static Date todayDate(String type) throws Exception{
        Date today = new Date();
        if("0".equals(type)){
            String startDate = startDf.format(today);
            today = formatStringToDate(startDate);
        } else if("1".equals(type)){
            String endDate = endDf.format(today);
            today = formatStringToDate(endDate);
        }
        return today;
    }
}