package com.jesse.dpp.rcp.utils.excel;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.util.CellRangeAddress;


import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author tsx-t171
 * @version 1.0.0
 * @date 2017/11/29 10:53
 * @description
 */
public class ExcelManager {

    private static Log log = LogFactory.getLog(ExcelManager.class);

    public static byte[] export(String title, List<Map<String, Object>> dataList, List<String> titleList, List<String> header) {
        OutputStream out = null;
        try {
            HSSFWorkbook workbook = new HSSFWorkbook();
            HSSFSheet sheet = workbook.createSheet();
            for (int i = 0; i < titleList.size(); i++) {
                sheet.setColumnWidth(i, String.valueOf(titleList.get(i)).getBytes().length * 2 * 256);
            }
            HSSFRow row;
            HSSFCellStyle style = workbook.createCellStyle();
            style.setAlignment(HorizontalAlignment.CENTER);
            row = sheet.createRow(0);
            CellRangeAddress region = new CellRangeAddress(0, 0, 0, (header.size() - 1));
            sheet.addMergedRegion(region);
            HSSFCell cell1 = row.createCell((short) 0);
            cell1.setCellStyle(style);
            cell1.setCellValue(title);
            row = sheet.createRow(1);
            createTitle(row, titleList);
            Map<String, Object> dMap;
            for (int i = 0; i < dataList.size(); i++) {
                dMap = dataList.get(i);
                row = sheet.createRow(i + 2);
                HSSFCell cell;
                int col = 0;
                for (int j = 0; j < header.size(); j++) {
                    cell = row.createCell(col++);
                    cell.setCellValue(dMap.get(header.get(j)) == null ? "--" : dMap.get(header.get(j)).toString());
                }
            }
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            workbook.write(baos);
            byte[] data = baos.toByteArray();
            return data;
        } catch (IOException e) {
            log.error(e.getMessage(), e);
            if (out != null)
                try {
                    out.close();
                } catch (IOException e2) {
                    log.error(e2.getMessage(), e2);
                }
        } finally {
            if (out != null)
                try {
                    out.close();
                } catch (IOException e) {
                }
        }
        return null;
    }

    public static void createTitle(HSSFRow row, List<String> pros) {
        HSSFCell cell;
        for (int i = 0; i < pros.size(); i++) {
            cell = row.createCell(i);
            cell.setCellType(CellType.STRING);
            cell.setCellValue(pros.get(i));
        }
    }

    public static void main(String[] args) {
        try {
            String title = "第一行大标题";
            List<Map<String, Object>> dataList = new ArrayList<>();
            Map<String, Object> dMap = new HashMap<>();
            dMap.put("一", "第一列第一行Value");
            dMap.put("二", "第二列第一行Value");
            dMap.put("三", "第三列第一行Value");
            dataList.add(dMap);

            Map<String, Object> dMap2 = new HashMap<>();
            dMap2.put("一", "第一列第二行Value");
            dMap2.put("二", "第二列第二行Value");
            dMap2.put("三", "第三列第二行Value");
            dataList.add(dMap2);

            List<String> titleList = new ArrayList<>();
            titleList.add("第一列名称");
            titleList.add("第二列名称");
            titleList.add("第三列名称");

            List<String> header = new ArrayList<>();
            header.add("一");
            header.add("二");
            header.add("三");

            final byte[] export = ExcelManager.export(title, dataList, titleList, header);
            File file = new File("D:\\usr\\excel.xls");
            if(!file.exists()) {
                file.createNewFile();
            }

            FileInputStream fis;
            FileOutputStream fos;

            fis = new FileInputStream(file);
            BufferedInputStream bis = new BufferedInputStream(fis);
            bis.read(export);
            fos = new FileOutputStream(file);
            fos.write(export);

            fis.close();
            fos.close();
        } catch (IOException e) {
            log.error(e.getMessage(), e);
        }
    }
}
