package com.jesse.dpp.rcp.controller;

import com.jesse.dpp.rcp.constant.Constant;
import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.AccountRole;
import com.jesse.dpp.rcp.po.Menu;
import com.jesse.dpp.rcp.po.RoleMenu;
import com.jesse.dpp.rcp.service.*;
import com.jesse.dpp.rcp.session.SessionContext;
import com.jesse.dpp.rcp.utils.EncryptUtil;
import com.jesse.dpp.rcp.vo.AccountVo;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import sun.misc.BASE64Decoder;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * 登录功能
 * 
 * @author dyq-t176
 *
 */
@Controller
public class LoginController {

    private static Log log = LogFactory.getLog(LoginController.class);

    @Autowired
    private IMenuService iMenuService;

    @Autowired
    private IAccountService iAccountService;

    @Autowired
    private IAccountRoleService iAccountRoleService;

    @Autowired
    private IRoleMenuService iRoleMenuService;
    
    @Autowired
    private ISystemTypeService iSystemTypeService;
    
    @Value("#{configProperties['locking_time']}")
    private String lockingTime;
    
    @Value("#{configProperties['try_count']}")
    private String tryCount;

    @Value("#{configProperties['inner_system_id']}")
    private String inner_system_id;

    @RequestMapping(value = "login", method = RequestMethod.POST)
    public String toIndex(String username, String password, String code, HttpSession session, Model model) {
        log.info("toIndex...........");
        String message = "";
        Integer codisValue = 0;
        Integer time = StringUtils.isNotBlank(lockingTime) ? Integer.valueOf(lockingTime) : 600;
        Integer count = StringUtils.isNotBlank(tryCount) ? Integer.valueOf(tryCount) : 5;
        try {
            // 获取session中的验证码
            String validation_code = null;
            if (null != session && null != session.getAttribute("code")) {
                validation_code = session.getAttribute("code").toString();
            }
            // 判断session中的验证码不为空，并且与前端页面传进入的验证码相同
            if (StringUtils.isNotBlank(validation_code) && validation_code.equalsIgnoreCase(code)) {
                // password进行MD5不可逆加密
                String password1 = EncryptUtil.encrypt(password);
                password = DigestUtils.md5Hex(Constant.SALT + password);
                System.err.println(password1+"  "+password);
                // 验证用户名密码 shiro 自带
                UsernamePasswordToken token = new UsernamePasswordToken(username, password1);
                Subject subject = SecurityUtils.getSubject();
                // 执行该方法会跳转到自定义的realm
                subject.login(token);
                if (subject.isAuthenticated()) { // 是否已经身份验证过
                    AccountVo account = iAccountService.selectAccountVoByLoginName(username);
                    //iCodisService.setCodisData(username, 1, "");

                   /* boolean checkSystemStatus = iSystemTypeService.checkStatusActiveById(account.getSystemId());
                    if(!checkSystemStatus){
                        message = "账户被锁定";
                        log.error(message);
                        model.addAttribute("rUserName", username);
                        model.addAttribute("message", message);
                        return "login";
                    }*/
                    String loginName = null;
                    if (null != account) {
						loginName = account.getLoginName();
					}
                    
                    Account sessionAccount = SessionContext.getAccount();
                    if (null != sessionAccount && !loginName.equals(sessionAccount.getLoginName())) {
                        message = "同一个浏览器只能一个用户在线！";
                        log.error(message);
                        model.addAttribute("message", message);
                        return "login";
                    }
                    
                    Session shiroSession = subject.getSession();
                    shiroSession.setTimeout(1800000);
                    shiroSession.setAttribute("userName", username);
                    session.setAttribute("userId", account.getId());
                    
                    List<AccountRole> accountRoleList = iAccountRoleService.selectRoleListByAccountId(account.getId());
                    if (null != accountRoleList) {
                        List<Menu> menuList = filterMenuByRole(accountRoleList);
                        shiroSession.setAttribute("menuList", menuList);
                    }
                    account.setLoginPwd("");
                    shiroSession.setAttribute("account", account);
                    session.setAttribute("account", account);
                    if(StringUtils.isNotBlank(inner_system_id) && inner_system_id.equals(account.getSystemId())){
                        session.setAttribute("systemAccount", "1");
                        session.setAttribute("adminAccount", "1");
                    } else {
                        Account adminAccount = iAccountService.selectSysAdmin(account.getSystemId());
                        if(null != adminAccount && account.getLoginName().equals(adminAccount.getLoginName())) {
                            session.setAttribute("adminAccount", "1");
                        }
                    }

                    return "redirect:index";
                }
            } else {
                message = "验证码错误";
                model.addAttribute("rUserName", username);
                model.addAttribute("rPassword", password);
                log.error(message);
            }
        } catch (ExcessiveAttemptsException e) {
            message = "该账号被锁定！" + (time / 60) + "分钟后解锁！";
            log.error(message);
            log.error(e.getMessage(), e);
            model.addAttribute("rUserName", username);
        } catch (AuthenticationException e) {
            codisValue += 1;
            //iCodisService.setCodisData(username, time, String.valueOf(codisValue));
            message = "用户名或密码错误！还有" + (count - codisValue) + "次机会！";
            if (count == codisValue) {
                message = "该账户已被锁定！" + (time / 60) + "分钟后解锁！";
            }
            model.addAttribute("rUserName", username);
            log.error(message);
            log.error(e.getMessage(), e);
        } catch (Exception e) {
            message = "未知错误";
            log.error(message);
            log.error(e.getMessage(), e);
            model.addAttribute("rUserName", username);
            model.addAttribute("message", message);
        }

        model.addAttribute("message", message);
        
        return "login";
    }

    private List<Menu> filterMenuByRole(List<AccountRole> accountRoleList) {
        List<Integer> menuIds = new ArrayList<Integer>();
        for (AccountRole accountRole : accountRoleList) {
            List<RoleMenu> roleMenuList = iRoleMenuService.selectRoleMenuListByRoleId(accountRole.getRoleId());
            if (null != roleMenuList) {
                for (RoleMenu roleMenu : roleMenuList) {
                    if (999 != roleMenu.getMenuId() && !menuIds.contains(roleMenu.getMenuId())) {
                        menuIds.add(roleMenu.getMenuId());
                    }
                }
            }
        }
        log.info("menuIds : " + menuIds);
        if (null != menuIds && menuIds.size() > 0) {
            return iMenuService.selectMenuListByIds(menuIds);
        }
        return null;
    }

    /**
     * 退出登录
     * 
     * @return
     */
    @RequestMapping(value = "logout", method = RequestMethod.GET)
    public String logout() {
        try {
            log.info("logout...........");
            Subject subject = SecurityUtils.getSubject();
            subject.logout();
            return "redirect:login";
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }
}
