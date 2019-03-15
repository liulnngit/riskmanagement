package com.jesse.dpp.rcp.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jesse.dpp.rcp.constant.Constant;
import com.jesse.dpp.rcp.enums.ResponseStatus;
import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.ResetPassword;
import com.jesse.dpp.rcp.service.IAccountService;
import com.jesse.dpp.rcp.service.IResetPasswordService;
import com.jesse.dpp.rcp.session.SessionContext;
import com.jesse.dpp.rcp.utils.EncryptUtil;

/**
 * 登录功能
 * 
 * @author dyq-t176
 *
 */
@Controller
public class ResetPasswordController {

    private static Log log = LogFactory.getLog(ResetPasswordController.class);

    @Autowired
    private IResetPasswordService iResetPasswordService;

    @Autowired
    private IAccountService iAccountService;

    @RequestMapping(value = "forgetPassword", method = RequestMethod.GET)
    public @ResponseBody Map<String, Object> forgetPassword(HttpServletRequest request, Integer id) {
        log.info("forgetPassword...........");
        Map<String, Object> map = new HashMap<String, Object>();
        String status = ResponseStatus.RESPONSE_STATUS_FAIL.getStatus();
        String msg = "重置密码邮件发送失败！";
        try {
            Account account = iAccountService.selectByPrimaryKey(id);
            if(Constant.RECORD_INACTIVE.equals(account.getStatus())){
                status = ResponseStatus.RESPONSE_STATUS_FAIL.getStatus();
                msg = "未激活用户不允许重置密码";
                map.put("status", status);
                map.put("msg", msg);
                return map;
            }
            Account opAccount = SessionContext.getAccount();

            String path = request.getContextPath();
            String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;

            int count = iResetPasswordService.addResetPassword(account, opAccount.getId(), basePath);
            if (count == 1) {
                status = ResponseStatus.RESPONSE_STATUS_SUCCESS.getStatus();
                msg = "重置密码邮件已发送至该用户邮箱！";
            } else if (count == 0) {
                status = ResponseStatus.RESPONSE_STATUS_REPEAT.getStatus();
                msg = "30分钟内不可重复发送重置密码邮件！";
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        map.put("status", status);
        map.put("msg", msg);
        return map;
    }

    @RequestMapping(value = "toResetPage", method = RequestMethod.GET)
    public ModelAndView toResetPage(String sid, String id) {
        log.info("toResetPage...........");
        ModelAndView mv = new ModelAndView("resetPassword");
        try {
            String msg = "";
            
            //篡改重置URL,没有传入参数
            if(null == sid || "" == sid || null == id || "" == id){
                msg = "非法的URL请求!";
                mv.addObject("msg", msg);
                mv.addObject("status", "error");
                return mv;
            }
            
            //篡改重置URL,修改了请求参数SID
            ResetPassword resetPassword = iResetPasswordService.selectResetPasswordBySid(sid);
            if(null == resetPassword){
                msg = "非法的URL请求!";
                mv.addObject("msg", msg);
                mv.addObject("status", "error");
                return mv;
            }
            
            if(!Constant.RECORD_ACTIVE.equals(resetPassword.getStatus())){
                msg = "链接已失效!";
                mv.addObject("msg", msg);
                mv.addObject("status", "error");
                return mv;
            }
            
            Account account = iAccountService.selectByPrimaryKey(Integer.valueOf(id));
            if(null == account){
                msg = "非法的URL请求!";
                mv.addObject("msg", msg);
                mv.addObject("status", "error");
                return mv;
            }
            
            //篡改重置URL,修改了请求参数ID
            if(!resetPassword.getEmailAddress().equals(account.getEmailAddress())){
                msg = "非法的URL请求!";
                mv.addObject("msg", msg);
                mv.addObject("status", "error");
                return mv;
            }
            
            long expireTime = Long.valueOf(resetPassword.getExpireTime());
            if(expireTime <= System.currentTimeMillis()){
                resetPassword.setStatus(Constant.RECORD_INACTIVE);
                resetPassword.setUpdateDate(String.valueOf(System.currentTimeMillis()));
                iResetPasswordService.updateByPrimaryKeyWithBLOBs(resetPassword);
                
                msg = "链接已失效, 请重新申请找回密码!";
                mv.addObject("msg", msg);
                mv.addObject("status", "error");
                return mv;
            }
            
            mv.addObject("status", "success");
            mv.addObject("account", account);
            mv.addObject("sid", sid);
            return mv;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return mv;
    }
    
    @RequestMapping(value = "resetPassword", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> resetPassword(String id, String sid, String password, String rePassword) {
        log.info("resetPassword...........");
        Map<String, Object> obj = new HashMap<String, Object>();
        String status = ResponseStatus.RESPONSE_STATUS_FAIL.getStatus();
        try {
            String msg = "两次密码不一致";
            if(password.equals(rePassword)){
                Account account = iAccountService.selectByPrimaryKey(Integer.valueOf(id));
                String decryptPassword = DigestUtils.md5Hex(Constant.SALT + password);
                if(decryptPassword.equals(account.getLoginPwd())){
                    msg = "新密码不能与旧密码一样";
                    log.warn(msg);
                }
                account.setLoginPwd(decryptPassword);
                int count = iAccountService.updateByPrimaryKey(account);
                if (count == 1) {
                    status = ResponseStatus.RESPONSE_STATUS_SUCCESS.getStatus();
                }
                
                ResetPassword resetPassword = iResetPasswordService.selectResetPasswordBySid(sid);
                resetPassword.setStatus(Constant.RECORD_INACTIVE);
                resetPassword.setUpdaterId(account.getId());
                resetPassword.setUpdateDate(String.valueOf(System.currentTimeMillis()));
                iResetPasswordService.updateByPrimaryKeyWithBLOBs(resetPassword);
            }
            obj.put("status", status);
            return obj;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }
}
