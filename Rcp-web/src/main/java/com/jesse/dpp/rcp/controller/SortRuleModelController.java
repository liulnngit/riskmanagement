package com.jesse.dpp.rcp.controller;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SortRuleModelController {
	private static Log log = LogFactory.getLog(SortRuleModelController.class);
	
	 /**
     * 分页列表展示
     * @param offset
     * @param limit
     * @return
     */
    @RequestMapping(value = "sortRuleModel", method = RequestMethod.GET)
    public ModelAndView getSortRuleModel() {
    	try {
    		ModelAndView mv = new ModelAndView("sortRuleModel");
			//to do something...
			return mv;
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
    	return null;
    }
}