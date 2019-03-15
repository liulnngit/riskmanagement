package com.jesse.dpp.rcp.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;  

/**  
 * 读取excel通用工具类
 * @version 1.0.0
 * @author dyq-t176  
 * @date 创建时间：2017年11月15日  下午12:11:30
 * @description
 *
*/
public class ReadExcelUtils {

    private static final Log logger = LogFactory.getLog(ReadExcelUtils.class);  
    private static Workbook wb;  
    private static Sheet sheet;  
    private static Row row;  
  
    /** 
     * 读取Excel表格表头的内容 
     *  
     * @param InputStream 
     * @return String 表头内容的数组 
     * @author zengwendong 
     */  
    public String[] readExcelTitle() throws Exception{  
        if(wb==null){  
            throw new Exception("Workbook对象为空！");  
        }  
        sheet = wb.getSheetAt(0);  
        row = sheet.getRow(0);  
        // 标题总列数  
        int colNum = row.getPhysicalNumberOfCells();  
        System.out.println("colNum:" + colNum);  
        String[] title = new String[colNum];  
        for (int i = 0; i < colNum; i++) {  
            // title[i] = getStringCellValue(row.getCell((short) i));  
            title[i] = row.getCell(i).getCellFormula();  
        }  
        return title;  
    }  
  
    /** 
     * 读取Excel数据内容 
     *  
     * @param InputStream 
     * @return Map 包含单元格数据内容的Map对象 
     * @author zengwendong 
     */  
    public static Map<Integer, Map<Integer,Object>> readExcelContent(String filePath) throws Exception{  
        Map<Integer, Map<Integer,Object>> content = new HashMap<Integer, Map<Integer,Object>>();  
        try {  
            if (StringUtils.isNotBlank(filePath)) {
                String ext = filePath.substring(filePath.lastIndexOf("."));  
                    InputStream is = new FileInputStream(filePath);  
                    if(".xls".equals(ext)){  
                        wb = new HSSFWorkbook(is); 
                        
                        sheet = wb.getSheetAt(0);  
                        // 得到总行数  
                        int rowNum = sheet.getLastRowNum();  
                        row = sheet.getRow(0);  
                        int colNum = row.getPhysicalNumberOfCells();  
                        // 正文内容应该从第二行开始,第一行为表头的标题  
                        for (int i = 1; i <= rowNum; i++) {  
                            row = sheet.getRow(i);  
                            int j = 0;  
                            Map<Integer,Object> cellValue = new HashMap<Integer, Object>();  
                            while (j < colNum) {  
                                Object obj = getCellFormatValue(row.getCell(j));  
                                cellValue.put(j, obj);  
                                j++;  
                            }  
                            content.put(i, cellValue);  
                        }  
                    } 
                }
        } catch (FileNotFoundException e) {  
            logger.error("FileNotFoundException", e);  
        } catch (IOException e) {  
            logger.error("IOException", e);  
        } 
        return content;  
    }  
  
    /** 
     *  
     * 根据Cell类型设置数据 
     *  
     * @param cell 
     * @return 
     * @author zengwendong 
     */  
    private static Object getCellFormatValue(Cell cell) {  
        DecimalFormat df = new DecimalFormat("0");
        Object cellvalue = "";  
        if (cell != null) {  
            // 判断当前Cell的Type  
            switch (cell.getCellType()) {  
            case Cell.CELL_TYPE_NUMERIC:// 如果当前Cell的Type为NUMERIC  
            case Cell.CELL_TYPE_FORMULA: {  
                // 判断当前的cell是否为Date  
                if (DateUtil.isCellDateFormatted(cell)) {  
                    // 如果是Date类型则，转化为Data格式  
                    // data格式是带时分秒的：2013-7-10 0:00:00  
                    // cellvalue = cell.getDateCellValue().toLocaleString();  
                    // data格式是不带带时分秒的：2013-7-10  
                    Date date = cell.getDateCellValue();  
                    cellvalue = date.getTime();  
                } else {// 如果是纯数字  
  
                    // 取得当前Cell的数值  
                    cellvalue = String.valueOf(df.format(cell.getNumericCellValue()));  
                }  
                break;  
            }  
            case Cell.CELL_TYPE_STRING:// 如果当前Cell的Type为STRING  
                // 取得当前的Cell字符串  
                cellvalue = cell.getRichStringCellValue().getString();  
                break;  
            default:// 默认的Cell值  
                cellvalue = "";  
            }  
        } else {  
            cellvalue = "";  
        }  
        return cellvalue;  
    }  
  
    public static void main(String[] args) {  
        try {  
            String filepath = "D://complaint_file.xls";  
            //ReadExcelUtils excelReader = new ReadExcelUtils(filepath);  
            // 对读取Excel表格标题测试  
//          String[] title = excelReader.readExcelTitle();  
//          System.out.println("获得Excel表格的标题:");  
//          for (String s : title) {  
//              System.out.print(s + " ");  
//          }  
              
            // 对读取Excel表格内容测试  
            Map<Integer, Map<Integer,Object>> map = readExcelContent(filepath);  
            System.out.println("获得Excel表格的内容:");  
            for (int i = 1; i <= map.size(); i++) {  
                System.out.println(map.get(i));  
                Map<Integer, Object> m = map.get(i);
                for (Map.Entry<Integer, Object> entry : m.entrySet()) {
                    if (entry.getKey() == 0) {
                        System.out.println("投诉人：" + entry.getValue());
                    } else if (entry.getKey() == 1) {
                        System.out.println("投诉电话：" + entry.getValue());
                    } else if (entry.getKey() == 2) {
                        System.out.println("投诉邮箱：" + entry.getValue());
                    } else if (entry.getKey() == 3) {
                        System.out.println("投诉订单号：" + entry.getValue());
                    } else if (entry.getKey() == 4) {
                        System.out.println("投诉商家号：" + entry.getValue());
                    } else if (entry.getKey() == 5) {
                        System.out.println("交易金额：" + entry.getValue());
                    } else if (entry.getKey() == 6) {
                        System.out.println("投诉时间：" + entry.getValue());
                    } else if (entry.getKey() == 7) {
                        System.out.println("投诉原因：" + entry.getValue());
                    }
                }
            }  
        } catch (FileNotFoundException e) {  
            logger.error("未找到指定路径的文件!");  
            e.printStackTrace();  
        }catch (Exception e) {  
            e.printStackTrace();  
        }  
    }  
}
