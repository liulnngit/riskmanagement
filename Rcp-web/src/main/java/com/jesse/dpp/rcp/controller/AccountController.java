package com.jesse.dpp.rcp.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.jesse.dpp.rcp.constant.Constant;
import com.jesse.dpp.rcp.enums.ResponseStatus;
import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.ActiveAccount;
import com.jesse.dpp.rcp.po.Role;
import com.jesse.dpp.rcp.po.SystemType;
import com.jesse.dpp.rcp.service.IAccountService;
import com.jesse.dpp.rcp.service.IActiveAccountService;
import com.jesse.dpp.rcp.service.IRoleService;
import com.jesse.dpp.rcp.service.ISystemTypeService;
import com.jesse.dpp.rcp.session.SessionContext;
import com.jesse.dpp.rcp.shiro.IFilterChainDefinitonsService;
import com.jesse.dpp.rcp.utils.Utility;

import sun.misc.BASE64Decoder;

/**
 * 用户相关
 * 
 * @author dyq-t176
 *
 */
@Controller
public class AccountController {

    private static Log log = LogFactory.getLog(AccountController.class);

    @Autowired
    private IAccountService iAccountService;

   /* @Autowired
    private IActiveAccountService iActiveAccountService;*/

    @Autowired
    private IRoleService iRoleService;

    @Autowired
    private ISystemTypeService iSystemTypeService;

    @Autowired
    IFilterChainDefinitonsService IFilterChainDefinitonsService;

    @RequestMapping(value = "addAccount", method = RequestMethod.POST)
    @ResponseBody
    private Map<String, Object> addAccount(Account account, String roleIds, HttpServletRequest request) {
        Map<String, Object> obj = new HashMap<String, Object>();
        String status = ResponseStatus.RESPONSE_STATUS_FAIL.getStatus();
        boolean isFilter = false;
        try {
            Account opAccount = SessionContext.getAccount();
            if (null != opAccount){
                String loginName = account.getLoginName().trim();
                account.setLoginName(loginName);
                byte[] decodeBuffer = new BASE64Decoder().decodeBuffer(account.getLoginPwd());
                String password = new String(decodeBuffer, "utf-8");
                account.setLoginPwd(DigestUtils.md5Hex(Constant.SALT + password));
                String systemId = opAccount.getSystemId();
                boolean isValid = iAccountService.checkLoginNameAndEmail(account, systemId);
                if (isValid) {
                    Integer creatorId = 0;
                    if (null != opAccount) {
                        creatorId = opAccount.getId();
                    }
                    account.setAccountType(opAccount.getAccountType());
                    account.setSystemId(opAccount.getSystemId());
                    String path = request.getContextPath();
                    String basePath = request.getScheme() + "://" + request.getServerName() + ":"
                            + request.getServerPort() + path;
                    
                    String ipAddress = Utility.getIpAddr(request);
                    account.setStatus(Constant.RECORD_INACTIVE);
                    int count = iAccountService.addAccount(account, roleIds, creatorId, basePath, ipAddress);
                    if (count == 1) {
                        isFilter = true;
                        status = ResponseStatus.RESPONSE_STATUS_SUCCESS.getStatus();
                    }
                }
                obj.put("status", status);
                return obj;
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        } finally {
            if (isFilter) {
                new Thread(new Runnable() {
                    public void run() {
                       IFilterChainDefinitonsService.reloadFilterChain();
                    }
	            }).start();
                
            }
        }

        return null;
    }

    /**
     * 分页列表展示
     * 
     * @param offset
     * @param limit
     * @return
     */
    @RequestMapping(value = "getListAccount", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getListAccount(
            @RequestParam(value = "offset", defaultValue = "0") Integer offset,
            @RequestParam(value = "limit", defaultValue = "10") Integer limit,
            @RequestParam(value = "jsonParam", defaultValue = "") String jsonParam) {
        try {
            log.info("getListAccount start......");
            int currentPage = offset / limit;
            currentPage += 1;
            Account account = SessionContext.getAccount();
            if (null != account) {
                Map<String, Object> map = iAccountService.selectAccountListByPagination(currentPage, limit,
                        account.getSystemId(), jsonParam);
                if (null != map && map.size() > 0) {
                    return map;
                }
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    @RequestMapping(value = "deleteAccount", method = RequestMethod.POST)
    private @ResponseBody Map<String, Object> deleteAccount(Integer id, HttpServletRequest request) {
        try {
            Map<String, Object> obj = new HashMap<String, Object>();
            String status = ResponseStatus.RESPONSE_STATUS_FAIL.getStatus();

            Account account = SessionContext.getAccount();
            Account selectAccount = iAccountService.selectByPrimaryKey(id);
            if (Constant.RECORD_SYSTEM.equals(selectAccount.getStatus())) {
                obj.put("isSystemAccount", "isSystemAccount");
                return obj;
            }
            if (null != account && id == account.getId()) {
                obj.put("isCurrentAccount", "isCurrentAccount");
                return obj;
            }
            String ipAddress = Utility.getIpAddr(request);
            int count = iAccountService.deleteAccount(id, account, ipAddress);
            if (count == 1) {
                status = ResponseStatus.RESPONSE_STATUS_SUCCESS.getStatus();
            }
            obj.put("status", status);
            return obj;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    @RequestMapping(value = "toEditAccountPage", method = RequestMethod.GET)
    private ModelAndView toEditPage(String selectAccountId) {
        try {
            Account sessionAccount = SessionContext.getAccount();
            ModelAndView mv = new ModelAndView("editAccount");
            Account account = iAccountService.selectByPrimaryKey(Integer.valueOf(selectAccountId));
            List<Role> selectedRoleList = iRoleService.selectRoleListByIds(account.getRoleId());
            List<Role> roleList = iRoleService.selectRoleListBySystemId(sessionAccount.getSystemId());
            mv.addObject("user", account);
            mv.addObject("roleList", roleList);
            mv.addObject("selectedRoleList", selectedRoleList);
            return mv;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    @RequestMapping(value = "editAccount", method = RequestMethod.POST)
    @ResponseBody
    private Map<String, Object> editAccount(Account account, String roleIds, HttpServletRequest request) {
        Map<String, Object> obj = new HashMap<String, Object>();
        String status = ResponseStatus.RESPONSE_STATUS_FAIL.getStatus();
        boolean isFilter = false;
        try {
            Account sessionAccount = SessionContext.getAccount();
            if (null != sessionAccount) {
                boolean isValid = iAccountService.checkLoginNameAndEmail(account, sessionAccount.getSystemId());
                if (isValid) {
                    if (StringUtils.isNotBlank(account.getLoginPwd())) {
                        byte[] decodeBuffer = new BASE64Decoder().decodeBuffer(account.getLoginPwd());
                        String password = new String(decodeBuffer, "utf-8");
                        account.setLoginPwd(DigestUtils.md5Hex(Constant.SALT + password));
                    }
                    account.setSystemId(sessionAccount.getSystemId());
                    String ipAddress = Utility.getIpAddr(request);
                    int count = iAccountService.updateAccount(account, roleIds, sessionAccount.getId(),
                            ipAddress);
                    if (count == 1) {
                    	isFilter = true;
                        status = ResponseStatus.RESPONSE_STATUS_SUCCESS.getStatus();
                    }
                }
                obj.put("status", status);
                return obj;
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }finally {
            if (isFilter) {
            	new Thread(new Runnable() {
                    public void run() {
                       IFilterChainDefinitonsService.reloadFilterChain();
                    }
	            }).start();
            }
		}
        return null;
    }

    @RequestMapping(value = "toAddAccountPage", method = RequestMethod.GET)
    private ModelAndView toAddPage() {
        try {
            ModelAndView mv = new ModelAndView("addAccount");
            Account sessionAccount = SessionContext.getAccount();
            List<Role> roleList = iRoleService.selectRoleListBySystemId(sessionAccount.getSystemId());
            SystemType systemType = iSystemTypeService.selectByPrimaryKey(sessionAccount.getSystemId());
            if (null != systemType) {
                mv.addObject("sysCode", systemType.getSystemCode());
            }
            mv.addObject("roleList", roleList);
            return mv;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    @RequestMapping(value = "activateAccount", method = RequestMethod.GET)
    public ModelAndView activateAccount(String sid, String id) {
        log.info("activateAccount...........");
        ModelAndView mv = new ModelAndView("activateAccount");

        try {
            String msg = "";
            // 篡改重置URL,没有传入参数
            if (null == sid || "" == sid || null == id || "" == id) {
                msg = "非法的URL请求!";
                mv.addObject("msg", msg);
                mv.addObject("status", "error");
                return mv;
            }

            /*// 篡改重置URL,修改了请求参数SID
            ActiveAccount activeAccount = iActiveAccountService.selectActiveAccountBySid(sid);
            if (null == activeAccount) {
                msg = "非法的URL请求!";
                mv.addObject("msg", msg);
                mv.addObject("status", "error");
                return mv;
            }*/

          /*  if (!Constant.RECORD_ACTIVE.equals(activeAccount.getStatus())) {
                msg = "链接已失效!";
                mv.addObject("msg", msg);
                mv.addObject("status", "error");
                return mv;
            }*/

            Account account = iAccountService.selectByPrimaryKey(Integer.valueOf(id));
            if (null == account) {
                msg = "非法的URL请求!";
                mv.addObject("msg", msg);
                mv.addObject("status", "error");
                return mv;
            }

           /* // 篡改重置URL,修改了请求参数ID
            if (!activeAccount.getEmailAddress().equals(account.getEmailAddress())) {
                msg = "非法的URL请求!";
                mv.addObject("msg", msg);
                mv.addObject("status", "error");
                return mv;
            }*/

         /*   long expireTime = Long.valueOf(activeAccount.getExpireTime());
            if (expireTime <= System.currentTimeMillis()) {
                activeAccount.setStatus(Constant.RECORD_INACTIVE);
                activeAccount.setUpdateDate(String.valueOf(System.currentTimeMillis()));
                iActiveAccountService.updateByPrimaryKeySelective(activeAccount);

                msg = "链接已失效, 请重新申请激活!";
                mv.addObject("msg", msg);
                mv.addObject("status", "error");
                return mv;
            }*/
            mv.addObject("status", "success");
            account.setStatus(Constant.RECORD_ACTIVE);
            iAccountService.updateByPrimaryKey(account);
          /*  activeAccount.setStatus(Constant.RECORD_INACTIVE);
            iActiveAccountService.updateByPrimaryKeySelective(activeAccount);*/
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }

        return mv;
    }

    /**
     * 用户名校验
     * 
     * @param loginName
     * @param id
     * @param request
     * @param response
     */
    @RequestMapping(value = "account/checkLoginNameValid", method = RequestMethod.POST)
    public void checkLoginName(String loginName, String id, HttpServletRequest request,
            HttpServletResponse response) {
        try {
            log.info("account/checkLoginNameValid start......");
            response.setContentType("text/html;charset=UTF-8");
            loginName = loginName.trim();
            boolean result = false;
            if (StringUtils.isNotBlank(loginName)) {
                result = iAccountService.checkLoginName(loginName, id);
            }
            response.getWriter().print(result);
        } catch (IOException e) {
            log.error(e.getMessage(), e);
        }
    }

    /**
     * 邮箱校验
     * 
     * @param emailAddress
     * @param id
     * @param request
     * @param response
     */
    @RequestMapping(value = "account/checkEmailAddressValid", method = RequestMethod.POST)
    public void checkEmailAddress(String emailAddress, String id, HttpServletRequest request,
            HttpServletResponse response) {
        try {
            log.info("account/checkLoginNameValid start......");
            response.setContentType("text/html;charset=UTF-8");
            emailAddress = emailAddress.trim();
            boolean result = false;
            if (StringUtils.isNotBlank(emailAddress)) {
                result = iAccountService.checkEmailAddress(emailAddress, id);
            }
            response.getWriter().print(result);
        } catch (IOException e) {
            log.error(e.getMessage(), e);
        }
    }

    /**
     * 发送激活账户邮件
     * 
     * @param request
     * @param id
     * @return
     */
    @RequestMapping(value = "sendActiviEmail", method = RequestMethod.GET)
    public @ResponseBody Map<String, Object> sendActiviEmail(HttpServletRequest request, Integer id) {
        log.info("sendActiviEmail...........");
        Map<String, Object> map = new HashMap<String, Object>();
        String status = ResponseStatus.RESPONSE_STATUS_FAIL.getStatus();
        String msg = "";
        try {
            Account opAccount = SessionContext.getAccount();

            String path = request.getContextPath();
            String basePath = request.getScheme() + "://" + request.getServerName() + ":"
                    + request.getServerPort() + path;
            int count = iAccountService.sendActiviEmail(id, opAccount.getId(), basePath);
            if (count == 1) {
                status = ResponseStatus.RESPONSE_STATUS_SUCCESS.getStatus();
                msg = "激活账户链接已发送！";
            } else {
                msg = "30分钟内不可重复激活！";
            }
            map.put("status", status);
            map.put("msg", msg);
            return map;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }
    
    /**
     * 校验原始密码
     * @param originalPwd
     * @param id
     * @param response
     */
    @RequestMapping(value = "account/checkOriginalPwd", method = RequestMethod.POST)
    public void checkOriginalPwd(String originalPwd, Integer id, HttpServletResponse response) {
        try {
            log.info("checkOriginalPwd start......");
            response.setContentType("text/html;charset=UTF-8");
            boolean result = false;
            Account account = iAccountService.selectByPrimaryKey(id);
            if (null != account) {
                log.info(account.getLoginPwd().equals(DigestUtils.md5Hex(Constant.SALT + originalPwd)));
                byte[] decodeBuffer = new BASE64Decoder().decodeBuffer(originalPwd);
                String password = new String(decodeBuffer, "utf-8");
                if (account.getLoginPwd().equals(DigestUtils.md5Hex(Constant.SALT + password))) {
                    result = true;
                }
            }
            response.getWriter().print(result);
        } catch (IOException e) {
            log.error(e.getMessage(), e);
        }
    }
    
    /**
     * 校验新密码是否与原始密码相同
     * @param originalPwd
     * @param id
     * @param response
     */
    @RequestMapping(value = "account/checkOldPwd", method = RequestMethod.POST)
    public void checkOldPwd(String loginPwd, Integer id, HttpServletResponse response) {
        try {
            log.info("checkOriginalPwd start......");
            response.setContentType("text/html;charset=UTF-8");
            boolean result = false;
            Account account = iAccountService.selectByPrimaryKey(id);
            if (null != account) {
                log.info(account.getLoginPwd().equals(DigestUtils.md5Hex(Constant.SALT + loginPwd)));
                byte[] decodeBuffer = new BASE64Decoder().decodeBuffer(loginPwd);
                String password = new String(decodeBuffer, "utf-8");
                if (!account.getLoginPwd().equals(DigestUtils.md5Hex(Constant.SALT + password))) {
                    result = true;
                }
            }
            response.getWriter().print(result);
        } catch (IOException e) {
            log.error(e.getMessage(), e);
        }
    }
    
    /**
     * 跳转到用户中心页面
     * @param id
     * @return
     */
    @RequestMapping(value = "toAccountCenterPage", method = RequestMethod.GET)
    public ModelAndView toAccountCenterPage(Integer id) {
        log.info("toAccountCenterPage start......");
        ModelAndView mv = new ModelAndView("accountCenter");
        try {
            Account account = iAccountService.selectByPrimaryKey(id);
            if (null != account) {
                account.setLoginPwd("");
                mv.addObject("user", account);
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return mv;
    }
    
    /**
     * 从用户中心修改
     * @param account
     * @return
     */
    @RequestMapping(value = "editAccountCenter", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> editAccountCenter(Account account) {
        log.info("editAccountCenter start......");
        Map<String, Object> obj = new HashMap<String, Object>();
        String status = ResponseStatus.RESPONSE_STATUS_FAIL.getStatus();
        try {
            Account sessionAccount = SessionContext.getAccount();
            //修改密码的操作
            if (null != sessionAccount) {
                if (StringUtils.isNotBlank(account.getLoginPwd())) {
                    byte[] decodeBuffer = new BASE64Decoder().decodeBuffer(account.getLoginPwd());
                    String password = new String(decodeBuffer, "utf-8");
                    account.setLoginPwd(DigestUtils.md5Hex(Constant.SALT + password));
                }
                account.setSystemId(sessionAccount.getSystemId());
                int rows = iAccountService.updateByPrimaryKeySelective(account);
                if (rows > 0) {
                    status = ResponseStatus.RESPONSE_STATUS_SUCCESS.getStatus();
                }
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        obj.put("status", status);
        return obj;
    }
}
