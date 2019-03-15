package com.nbtv.commons.context;

import org.apache.commons.lang.StringUtils;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class AppContext {
	
    private volatile static AbstractApplicationContext appContext;
    private final static String XML_EXPRESSION = "classpath*:applicationContext*.xml";
    
    public synchronized static void initConfig(String regularExpression) {
    	if(appContext == null) {
    		if(StringUtils.isEmpty(regularExpression)) {
        		appContext = new ClassPathXmlApplicationContext(XML_EXPRESSION);
        	} else {
        		appContext = new ClassPathXmlApplicationContext(regularExpression.split("[,\\s]+"));
        	}  
    	}    	  	
    }    
    
    public  static void setAppContext(final ApplicationContext applicationContext) {
    	appContext = (AbstractApplicationContext) applicationContext;
	}
    
    public static AbstractApplicationContext getAppContext() {
    	if(appContext == null) {
    		initConfig(null);
    	}
        return appContext;
    }

    public static Object getBean(String name) {
    	if(appContext == null) {
    		initConfig(null);
    	}
    	
        return appContext.getBean(name);
    }
    
    public static void start() {
    	if(appContext == null) {
    		initConfig(null);
    	}
    	
    	appContext.start();
    }
    
    public synchronized static void stop() {
    	if (appContext != null) {
        	appContext.stop();
        	appContext.close();
        	appContext = null;
        }        
    }
       
   
}
