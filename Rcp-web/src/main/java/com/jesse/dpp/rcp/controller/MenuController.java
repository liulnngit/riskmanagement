package com.jesse.dpp.rcp.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.Menu;
import com.jesse.dpp.rcp.po.RoleMenu;
import com.jesse.dpp.rcp.service.IMenuService;
import com.jesse.dpp.rcp.service.IRoleMenuService;
import com.jesse.dpp.rcp.session.SessionContext;

@Controller
public class MenuController {

    private static Log log = LogFactory.getLog(MenuController.class);

    @Autowired
    private IMenuService iMenuService;

    @Autowired
    private IRoleMenuService iMtmRoleMenuService;

    @ResponseBody
    @RequestMapping(value = "queryMenuList", method = RequestMethod.POST)
    public List<Map<String, Object>> queryMenuList() {
        log.info("querMenuList start......");
        Account opAccount = SessionContext.getAccount();
        List<Menu> menuList = iMenuService.selectMenuListByType(opAccount.getAccountType());
        List<Map<String, Object>> menus = new ArrayList<Map<String, Object>>();;
        for (Menu menu : menuList) {
        	Map<String, Object> map = new HashMap<String, Object>();
            if (0 == menu.getParentId()) {
            	map.put("id", menu.getId());
            	map.put("pId", 0);
            	map.put("name", menu.getMenuName());
            } else {
            	map.put("id", menu.getId());
            	map.put("pId", menu.getParentId());
            	map.put("name", menu.getMenuName());
            }
            menus.add(map);
        }
        
        return menus;
    }

    @ResponseBody
    @RequestMapping(value = "checkedMenuList", method = RequestMethod.POST)
    public List<Map<String, Object>> checkedMenuList(String roleId) {
        log.info("checkedMenuList start......");
        List<Map<String, Object>> checkMenuList = new ArrayList<Map<String, Object>>();
        if (null != roleId && "" != roleId) {
            List<RoleMenu> roleMenuList = iMtmRoleMenuService.selectRoleMenuListByRoleId(new Integer(roleId));
            for (RoleMenu mtmRoleMenu : roleMenuList) {
            	Map<String, Object> map = new HashMap<String, Object>();
            	map.put("id", mtmRoleMenu.getMenuId());
                checkMenuList.add(map);
            }
            return checkMenuList;
        }
        return null;
    }
}
