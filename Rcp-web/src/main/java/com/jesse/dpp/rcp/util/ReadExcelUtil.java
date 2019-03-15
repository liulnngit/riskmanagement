/*package com.jesse.dpp.rcp.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.CellType;

import com.jesse.dpp.rcp.utils.ConstantUtils;
import com.jesse.dpp.rcp.utils.exception.BaseRuntimeException;
import com.jesse.dpp.rcp.vo.AttentionLibVO;

public class ReadExcelUtil {
	
   private static Log log = LogFactory.getLog(ReadExcelUtil.class);
   
   private static void getExcelFile(File excel) {
		// TODO Auto-generated method stub
		String fileName = excel.getName();
        int iIndex = fileName.lastIndexOf(".");
        String ext = (iIndex < 0) ? "" : fileName.substring(iIndex + 1).toLowerCase();
        if (!"xls,xlsx".contains(ext) || "".contains(ext)) {
            log.error("文件类型不是EXCEL！");
        }
	}
	
	public static  List<AttentionLibVO> readExcelToObject(File file) {
		
		 log.info("readExcelToObject invoke......");
		// TODO Auto-generated method stub
		 List<AttentionLibVO> attentionLibraries = new ArrayList<AttentionLibVO>();
	//	 getExcelFile(file);
		 
		 log.info("path is " + file.getPath());
		 
	     try {
	            POIFSFileSystem poifsFileSystem = new POIFSFileSystem(new FileInputStream(file));
	            HSSFWorkbook workbook = new HSSFWorkbook(poifsFileSystem);
	            
	            // 循环工作表Sheet    
	            for(int numSheet = 0; numSheet < workbook.getNumberOfSheets(); numSheet++){    
	              HSSFSheet hssfSheet = workbook.getSheetAt( numSheet);    
	              AttentionLibVO attentionLibrary = new AttentionLibVO();
		          Field[] declaredField = attentionLibrary.getClass().getDeclaredFields();
		     
	              if(hssfSheet == null){    
	            	  continue;    
	              }    
	              // 循环行Row rowNum = 1 从第二行开始读取，第一行是描述性字段      
	              for(int rowNum = 1; rowNum <= hssfSheet.getLastRowNum(); rowNum++){    
	                HSSFRow hssfRow = hssfSheet.getRow( rowNum);   
	                attentionLibrary = new AttentionLibVO();
	                LinkedList<Object> linkedList = new LinkedList<Object>();
	                int index = 0;
	                if(hssfRow == null){    
	                  continue;    
	                }    
	                
	                // 循环列Cell     
	                for(int cellNum = 0; cellNum <= hssfRow.getLastCellNum(); cellNum++){    
		                  
                	  Object object = null;
	                  int plus = cellNum - index; 
	                  HSSFCell hssfCell = hssfRow.getCell(plus); 
	                      
	                  if(hssfCell == null){    
		                    continue;    
		              }  
	                  
	                  if (plus == 6 || plus == 7) {
	                      object = ConstantUtils.SDF_YYYYMMDDHHMMSS.format(hssfCell.getDateCellValue()); 
	                  }else {
		                  //处理函数单元格问题，先将单元格内容转为String  
		                  if(hssfRow.getCell(cellNum)!=null){
		                      hssfRow.getCell(cellNum).setCellType(CellType.STRING);
		                  } 
	                	  object = hssfCell.getStringCellValue();
	                  }
	                  
	                  linkedList.add(object);
	                }  
	                log.info("linkedList size is " + linkedList.size());
	                invokeSet(attentionLibrary, linkedList, declaredField);
	                attentionLibraries.add(attentionLibrary);
	              }    
	              
	            }
	        } catch (Exception e) {
	            e.printStackTrace(); 
	            log.error(e.getMessage(), e);
	            throw new BaseRuntimeException(e.getMessage(), e);
	        }finally {
				log.error(attentionLibraries);
			}
	        
	       log.info("attentionLibraries : " + attentionLibraries);
	       return attentionLibraries;
	}
	
	*//**
	 * 反射相关
	 * @param o
	 * @param fieldName
	 * @param value
	 *//*
	 public static void invokeSet(Object o, LinkedList<Object> linkedList, Field[] declaredField) {
		 
		 if (null != linkedList && linkedList.size() > 0) {
			 int index = 0;
			 for (int i = 0; i <= linkedList.size(); i++) {
				//获取字段名
		        String field = declaredField[i].getName();
		        if( Modifier.isStatic(declaredField[i].getModifiers())) {  //静态 field 不处理 
		        	index++;
		            continue;
		        }
		        
		        Method method = getSetMethod(o.getClass(), field);
		        try {
		            method.invoke(o, new Object[]{linkedList.get(i-index)});
		        } catch (Exception e) {
		            e.printStackTrace();
		            log.error(e.getMessage(), e);
		            throw new BaseRuntimeException(e.getMessage(), e);
		        }
			 }
		 }	  
	    }

     public static Method getSetMethod(Class objectClass, String fieldName) {
	        try {
	            Class[] parameterTypes = new Class[1];
	            Field field = objectClass.getDeclaredField(fieldName);
	            
	            parameterTypes[0] = field.getType();
	            StringBuffer sb = new StringBuffer();
	            sb.append("set");
	            sb.append(fieldName.substring(0, 1).toUpperCase());
	            sb.append(fieldName.substring(1));
	            Method method = objectClass.getMethod(sb.toString(), parameterTypes);
	            return method;
	        } catch (Exception e) {
	            e.printStackTrace();
	            log.error(e.getMessage(), e);
	        }
	        return null;
     }
     
     public static void main(String[] args) throws FileNotFoundException {
    	 ReadExcelUtil readExcelUtil = new ReadExcelUtil();
		 File file = new File("C:/Users/ljw-t256/Desktop/test.xls");
		 System.out.println(file.getAbsolutePath());
		 readExcelUtil.readExcelToObject(file);
	 }
}
*/