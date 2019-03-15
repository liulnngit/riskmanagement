package com.jesse.dpp.rcp.shiro.factory;

/**
 * @author wzs-t178
 * 
 * 获取所有角色-菜单关系
 */
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map.Entry;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.AccountRole;
import com.jesse.dpp.rcp.po.Menu;
import com.jesse.dpp.rcp.po.Role;
import com.jesse.dpp.rcp.po.RoleMenu;
import com.jesse.dpp.rcp.service.IAccountRoleService;
import com.jesse.dpp.rcp.service.IAccountService;
import com.jesse.dpp.rcp.service.IMenuService;
import com.jesse.dpp.rcp.service.IRoleMenuService;
import com.jesse.dpp.rcp.service.IRoleService;
import com.jesse.dpp.rcp.shiro.IFilterChainDefinitionMapService;

public class FilterChainDefinitionMap implements IFilterChainDefinitionMapService{

    private static Log log = LogFactory.getLog(FilterChainDefinitionMap.class);

    @Autowired
    private IRoleMenuService iRoleMenuService;

    @Autowired
    private IMenuService iMenuService;

    @Autowired
    private IRoleService iRoleService;
    
    @Autowired
    private IAccountRoleService iAccountRoleService;

    @Override
    public LinkedHashMap<String, String> buildFilterChainDefinitionMap() {
        LinkedHashMap<String, String> map = new LinkedHashMap<String, String>();

        log.info("buildFilterChainDefinitionMap start.............." + iAccountRoleService + "--" + iRoleMenuService);
        
        map.put("/css/**", "anon");
        map.put("/fonts/**", "anon");
        map.put("/images/**", "anon");
        map.put("/js/**", "anon");
        map.put("/code", "anon");
        map.put("/login", "anon");
        map.put("/403.jsp", "anon");
        map.put("/sign", "anon");
  //      map.put("/success", "anon");
  //      map.put("/index", "anon");
  //      map.put("/addAttention", "anon");
        map.put("/riskAnalyze", "anon");
  //      map.put("/paySuccess", "anon");
        map.put("/websocket", "anon");
        map.put("/activateAccount", "anon");
        map.put("/toResetPage", "anon");
        map.put("/resetPassword", "anon");
        
        List<RoleMenu> roleMenuDaos = iRoleMenuService.selectRoleMenuList();
        List<AccountRole> ars = iAccountRoleService.selectAccountList(); 
        
    //    log.info("==============" + ars);
        
        for (RoleMenu roleMenu : roleMenuDaos) {
            Menu menu = iMenuService.selectByPrimaryKey(roleMenu.getMenuId());
            if (null != menu && menu.getParentId() != 0) {
                Role role = iRoleService.selectByPrimaryKey(roleMenu.getRoleId());
                if(null != role && null != ars){
                	for (AccountRole accountRole : ars) {
						if (accountRole.getRoleId().equals(roleMenu.getRoleId())) {
							String roleQ = accountRole.getAccountId() + "_" + roleMenu.getRoleId() + "_" + role.getRoleName();
				               //     log.info(menu.getLinkUrl() + " : " + getRolesName(role.getRoleName()));
							if (role.getRoleName().equals("Administrator") || role.getRoleName().equals("Admin")) {
								roleQ = role.getRoleName();
							}
		                    if (map.containsKey(menu.getLinkUrl())) {
		                        map.put(menu.getLinkUrl(), getRolesNames(map.get(menu.getLinkUrl()), roleQ));
		                    } else {
		                        map.put(menu.getLinkUrl(), getRolesName(roleQ));
		                    }
						}
					}
                	
                }
            }
        }
        map.put("/**", "authc");

        for (Entry<String, String> entry : map.entrySet()) {
            System.err.println("Key = " + entry.getKey() + ", Value = " + entry.getValue());
        }
        return map;
    }

    public String getRolesName(String roleString) {

        String string = "authc,roleOrFilter[" + roleString + "]";
        return string;
    }

    public static String getRolesNames(String oldRole, String newRole) {
        String string1 = oldRole.substring(oldRole.indexOf("[") + 1, oldRole.indexOf("]"));
        String string = "authc,roleOrFilter[" + string1 + "," + newRole + "]";
        return string;
    }

    public static void main(String[] args) {
      //   System.out.println(getRolesNames("authc,roles[\"admin\"]", "user"));
    }
}
