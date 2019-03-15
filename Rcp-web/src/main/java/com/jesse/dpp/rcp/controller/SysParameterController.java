/*package com.jesse.dpp.rcp.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jesse.dpp.rcp.enums.ResponseStatus;
import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.SysParameter;
import com.jesse.dpp.rcp.service.ISysParameterService;
import com.jesse.dpp.rcp.session.SessionContext;
import com.jesse.dpp.rcp.utils.Utility;
import com.jesse.dpp.rcp.vo.SysParameterVo;
import com.github.pagehelper.PageInfo;

@Controller
public class SysParameterController {

    private static final Log log = LogFactory.getLog(SysParameterController.class);

    @Autowired
    private ISysParameterService iSysParameterService;

    *//**
     * 查询
     * 
     * @param attentionLibrary
     * @return
     *//*
    @RequestMapping(value = "getListSysParameter", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> listSysParameter(@RequestParam(value = "limit", defaultValue = "10") Integer limit, @RequestParam(value = "offset", defaultValue = "0") Integer offset) {
        try {
            log.info("listSysParameter start......");
            Account opAccount = SessionContext.getAccount();
            int currentPage = offset / limit;
            currentPage += 1;
            PageInfo<SysParameterVo> sysParameters = iSysParameterService.selectSysParameterListByPagination(currentPage, limit, opAccount.getSystemId());
            Map<String, Object> obj = new HashMap<String, Object>();
            obj.put("total", sysParameters.getTotal());
            obj.put("rows", sysParameters.getList());
            return obj;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    @RequestMapping(value = "toEditSysParameterPage", method = RequestMethod.GET)
    public ModelAndView toEditSysParameterPage(Integer id) {
        try {
            ModelAndView mv = new ModelAndView("editSysParameter");
            SysParameter sysParameter = iSysParameterService.selectByPrimaryKey(id);
            mv.addObject("sysParameter", sysParameter);
            return mv;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    @RequestMapping(value = "editSysParameter", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> editSysParameter(SysParameter sysParameter, HttpServletRequest request) {
        Map<String, Object> obj = new HashMap<String, Object>();
        String result = ResponseStatus.RESPONSE_STATUS_FAIL.getStatus();
        try {
            Account account = SessionContext.getAccount();
            String ipAddress = Utility.getIpAddr(request);
            
            if (null != account) {
            	sysParameter.setSystemId(account.getSystemId());
			}
            
            int count = iSysParameterService.updateSysParameter(sysParameter, account.getId(), ipAddress);
            if (count == 1) {
                result = ResponseStatus.RESPONSE_STATUS_SUCCESS.getStatus();
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        obj.put("status", result);
        return obj;
    }
}
*/