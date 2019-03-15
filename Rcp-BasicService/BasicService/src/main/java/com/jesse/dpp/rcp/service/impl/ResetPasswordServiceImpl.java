package com.jesse.dpp.rcp.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.jesse.dpp.rcp.constant.Constant;
import com.jesse.dpp.rcp.dao.ResetPasswordDao;
import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.ResetPassword;
import com.jesse.dpp.rcp.service.IResetPasswordService;
import com.jesse.dpp.rcp.utils.EncryptUtil;
import com.jesse.dpp.rcp.utils.exception.BaseRuntimeException;

public class ResetPasswordServiceImpl implements IResetPasswordService {

    private static Log log = LogFactory.getLog(AccountRoleServiceImpl.class);

    @Autowired
    private ResetPasswordDao resetPasswordDao;
    
/*    @Autowired
    private IEmailService iEmailService;
*/
    @Override
    public int deleteByPrimaryKey(Integer id) {
        try {
            return resetPasswordDao.deleteByPrimaryKey(id);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int insert(ResetPassword resetPassword) {
        try {
            return resetPasswordDao.insert(resetPassword);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int insertSelective(ResetPassword resetPassword) {
        try {
            return resetPasswordDao.insertSelective(resetPassword);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public ResetPassword selectByPrimaryKey(Integer id) {
        try {
            return resetPasswordDao.selectByPrimaryKey(id);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateByPrimaryKeySelective(ResetPassword resetPassword) {
        try {
            return resetPasswordDao.updateByPrimaryKeySelective(resetPassword);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateByPrimaryKeyWithBLOBs(ResetPassword resetPassword) {
        try {
            return resetPasswordDao.updateByPrimaryKeyWithBLOBs(resetPassword);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateByPrimaryKey(ResetPassword resetPassword) {
        try {
            return resetPasswordDao.updateByPrimaryKey(resetPassword);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int addResetPassword(Account account, Integer creatorId, String basePath) {
        try {
            String email = account.getEmailAddress();
            String secretKey = UUID.randomUUID().toString().replace("-", ""); // 随机密钥
            long expireTime = System.currentTimeMillis() + 30 * 60 * 1000;// 30分钟后过期
            String randomStr = email + "$" + secretKey;
            
            String sid = EncryptUtil.encrypt(randomStr).replace("+", "");
            
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("accountId", account.getId());
            //查询需要重置密码的信息
            List<ResetPassword> rp = resetPasswordDao.selectResetPasswordByAccountId(map);
            
            ResetPassword resetPassword = new ResetPassword();
            resetPassword.setEmailAddress(email);
            resetPassword.setSid(sid);
            resetPassword.setExpireTime(String.valueOf(expireTime));
            resetPassword.setStatus(Constant.RECORD_ACTIVE);
            resetPassword.setCreatorId(creatorId);
            resetPassword.setCreateDate(String.valueOf(System.currentTimeMillis()));
            resetPassword.setUpdaterId(creatorId);
            resetPassword.setUpdateDate(String.valueOf(System.currentTimeMillis()));
            resetPassword.setAccountId(account.getId());
            
            if (null != rp && rp.size() > 0) {
                if (Long.parseLong(rp.get(0).getExpireTime()) <= System.currentTimeMillis()) {
                    this.insert(resetPassword);
                    String url = basePath + "/toResetPage?sid="+ sid +"&id="+account.getId();
                    this.sendEmail(email, url);
                    return 1;
                } else {
                    if (Constant.RECORD_INACTIVE.equals(rp.get(0).getStatus())) {
                        this.insert(resetPassword);
                        String url = basePath + "/toResetPage?sid="+ sid +"&id="+account.getId();
                        this.sendEmail(email, url);
                        return 1;
                    } else {
                        log.warn("there is resetPassword email send before, it is still not expire......");
                        return 0;
                    }
                }
            } else {
                this.insert(resetPassword);
                String url = basePath + "/toResetPage?sid="+ sid +"&id="+account.getId();
                this.sendEmail(email, url);
                return 1;
            }
            
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }
    
    private void sendEmail(String email, String url) throws Exception{
        try {
            log.info("getEmailContent.............");
            
            String subject = "重置密码";
            StringBuffer content = new StringBuffer();  
            content.append("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">")  
            .append("<html>")  
            .append("<head>")  
            .append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">")  
            .append("<title>").append(subject).append("</title>")
            .append("<style type=\"text/css\">")  
            .append("</style>")
            .append("</head>")
            .append("<body>")
            .append("<br>")
            .append("<span class=\"\">请勿回复本邮件, 点击下面的链接重置密码, 本邮件超过30分钟, 链接将会失效, 需要重新申请找回密码.</span>")
            .append("<span class=\"test\">")
            .append("<a href=\"").append(url).append("\">").append(url).append("</a>")
            .append("</span>")
            .append("</body>")  
            .append("</html>");  
            
            //iEmailService.sendHtmlEmail(subject, content.toString(), email);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
    }

    @Override
    public ResetPassword selectResetPasswordBySid(String sid) {
        try {
            return resetPasswordDao.selectResetPasswordBySid(sid);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public List<ResetPassword> selectResetPasswordByAccountId(Integer accountId) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("accountId", accountId);
            return resetPasswordDao.selectResetPasswordByAccountId(map);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }
}
