package com.jesse.dpp.rcp.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.jesse.dpp.rcp.constant.Constant;
import com.jesse.dpp.rcp.dao.AccountDao;
import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.AccountRole;
import com.jesse.dpp.rcp.po.ActiveAccount;
import com.jesse.dpp.rcp.po.Role;
import com.jesse.dpp.rcp.po.SystemType;
import com.jesse.dpp.rcp.service.IAccountRoleService;
import com.jesse.dpp.rcp.service.IAccountService;
import com.jesse.dpp.rcp.service.IActiveAccountService;
import com.jesse.dpp.rcp.service.IRoleService;
import com.jesse.dpp.rcp.service.ISystemTypeService;
import com.jesse.dpp.rcp.utils.EncryptUtil;
import com.jesse.dpp.rcp.utils.exception.BaseRuntimeException;
import com.jesse.dpp.rcp.vo.AccountVo;

public class AccountServiceImpl implements IAccountService {

    private static Log log = LogFactory.getLog(AccountServiceImpl.class);

    @Autowired
    private AccountDao accountDao;

    @Autowired
    private IAccountRoleService iAccountRoleService;


    @Autowired
    private IRoleService iRoleService;

    @Autowired
    private ISystemTypeService iSystemTypeService;

    @Autowired
    private IActiveAccountService iActiveAccountService;

    @Override
    public int deleteByPrimaryKey(Integer id, String systemId) {
        try {
        	Map<String, Object> params = new HashMap<String, Object>();
        	params.put("id", id);
        	params.put("systemId", systemId);
            return accountDao.deleteByPrimaryKey(params);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int insert(Account account) {
        try {
            return accountDao.insert(account);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int insertSelective(Account account) {
        try {
            return accountDao.insertSelective(account);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public Account selectByPrimaryKey(Integer id) {
        try {
            return accountDao.selectByPrimaryKey(id);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(Account account) {
        try {
            return accountDao.updateByPrimaryKeySelective(account);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateByPrimaryKey(Account account) {
        try {
            return accountDao.updateByPrimaryKey(account);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public Account selectAccountByLoginName(String loginName) {
        try {
            return accountDao.selectAccountByLoginName(loginName);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int addAccount(Account account, String roleIds, Integer creatorId, String basePath,
            String ipAddress) {
        try {
            boolean isSystemAdmin = false;
            if(Constant.RECORD_SYSTEM.equals(account.getStatus())){
                isSystemAdmin = true;
            }
            account.setRoleId(roleIds);
            account.setCreatorId(creatorId);
            account.setCreateDate(String.valueOf(System.currentTimeMillis()));
            account.setUpdateDate(account.getCreateDate());
            account.setUpdaterId(account.getCreatorId());
            int count = this.accountDao.insertSelective(account);
            String[] roleIdArrs = null;
            if (StringUtils.isNotBlank(roleIds)) {
                roleIdArrs = roleIds.split(",");
            }
            AccountRole ar = null;
            if (count > 0) {
                if(isSystemAdmin){
                    this.sendAccessNotifyEmail(account, basePath);
                } else {
                    this.generateActivateEmail(account, creatorId, basePath);
                }

                List<String> roleNames = new ArrayList<String>();

                for (String roleId : roleIdArrs) {
                    ar = new AccountRole();
                    ar.setAccountId(account.getId());
                    ar.setCreateDate(String.valueOf(System.currentTimeMillis()));
                    ar.setStatus(Constant.RECORD_ACTIVE);
                    ar.setCreatorId(creatorId);
                    ar.setUpdateDate(ar.getCreateDate());
                    ar.setUpdaterId(ar.getCreatorId());
                    ar.setRoleId(new Integer(roleId));
                    iAccountRoleService.insertSelective(ar);

                    // 把用户与角色关联到activiti数据库中
                    Role role = iRoleService.selectByPrimaryKey(Integer.valueOf(roleId));
                    roleNames.add(role.getRoleName());
                }
            }
            return count;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int deleteAccount(Integer id, Account account, String ipAddress) {
        try {

            iAccountRoleService.deleteBatchByAccountId(id);

            Account tmpAccount = this.selectByPrimaryKey(id);
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("id", id);
            params.put("systemId", account.getSystemId());
            int count = accountDao.deleteByPrimaryKey(params);

            return count;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateAccount(Account account, String roleIds, Integer updaterId, String ipAddress) {
        try {
            int count = 0;
            boolean isUpdate = false;
            StringBuffer oldSbuffer = new StringBuffer();
            StringBuffer newSbuffer = new StringBuffer();

            Account originalAccount = accountDao.selectByPrimaryKey(account.getId());
            if (null != originalAccount) {
                if (Constant.RECORD_INACTIVE.equals(originalAccount.getStatus())) {
                    log.error("未激活用户不允许修改");
                    return count;
                }
                if (!originalAccount.getLoginPwd().equals(account.getLoginPwd())) {
                    oldSbuffer.append("修改密码：[] ");
                    newSbuffer.append("修改密码：[] ");
                    isUpdate = true;
                }
                if (!originalAccount.getEmailAddress().equals(account.getEmailAddress())) {
                    oldSbuffer.append("电子邮箱：[").append(originalAccount.getEmailAddress()).append("] ");
                    newSbuffer.append("电子邮箱：[").append(account.getEmailAddress()).append("] ");
                    isUpdate = true;
                }
                if (!originalAccount.getRoleId().equals(roleIds)) {
                    oldSbuffer.append("所属角色：[").append(this.getRoleNames(originalAccount.getRoleId()))
                            .append("] ");
                    newSbuffer.append("所属角色：[").append(this.getRoleNames(roleIds)).append("] ");
                    isUpdate = true;
                }

                account.setRoleId(roleIds);
                account.setStatus(originalAccount.getStatus());
                account.setUpdaterId(updaterId);
                account.setUpdateDate(String.valueOf(System.currentTimeMillis()));
                if (StringUtils.isBlank(account.getLoginPwd())) {
                    account.setLoginPwd(originalAccount.getLoginPwd());
                }
                count = accountDao.updateByPrimaryKeySelective(account);

                String[] roleIdArrs = null;
                if (StringUtils.isNotBlank(roleIds)) {
                    roleIdArrs = roleIds.split(",");
                }
                iAccountRoleService.deleteBatchByAccountId(account.getId());

                List<String> roleNames = new ArrayList<String>();

                if (null != roleIdArrs && roleIdArrs.length > 0) {
                    for (String roleId : roleIdArrs) {
                        AccountRole mar = new AccountRole();
                        mar.setAccountId(account.getId());
                        mar.setRoleId(Integer.valueOf(roleId));
                        mar.setStatus(Constant.RECORD_ACTIVE);
                        mar.setCreatorId(updaterId);
                        mar.setCreateDate(String.valueOf(System.currentTimeMillis()));
                        mar.setUpdaterId(updaterId);
                        mar.setUpdateDate(String.valueOf(System.currentTimeMillis()));
                        iAccountRoleService.insert(mar);

                        Role role = iRoleService.selectByPrimaryKey(Integer.valueOf(roleId));
                        roleNames.add(role.getRoleName());
                    }
                }

                return count;
            } else {
                String errorMsg = "can not found the account by accountId : " + account.getId();
                log.error(errorMsg);
                throw new BaseRuntimeException(errorMsg);
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public Map<String, Object> selectAccountListByPagination(int currentPage, Integer limit, String systemId,
            String jsonParam) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("systemId", systemId);

            Account searchAccount = new Account();
            if (StringUtils.isNotBlank(jsonParam)) {
                searchAccount = JSON.parseObject(jsonParam, Account.class);
            }
            searchAccount.setSystemId(systemId);
            PageHelper.startPage(currentPage, limit);
            List<AccountVo> accountList = accountDao.selectAccountListByPagination(searchAccount);
            PageInfo<AccountVo> info = new PageInfo<AccountVo>(accountList);
            List<AccountVo> accountVoList = new ArrayList<AccountVo>();
            for (AccountVo account : accountList) {
                if (null != account.getRoleId()) {
                    List<Role> roleList = iRoleService.selectRoleListByIds(account.getRoleId());
                    AccountVo accountVo = new AccountVo();
                    accountVo.setId(account.getId());
                    accountVo.setLoginName(account.getLoginName());
                    accountVo.setLoginPwd(account.getLoginName());
                    accountVo.setEmailAddress(account.getEmailAddress());
                    accountVo.setLastLogin(account.getLastLogin());
                    accountVo.setRoleId(account.getRoleId());
                    accountVo.setStatus(account.getStatus());
                    accountVo.setCreatorId(account.getCreatorId());
                    accountVo.setCreateDate(account.getCreateDate());
                    accountVo.setUpdaterId(account.getUpdaterId());
                    accountVo.setUpdateDate(account.getUpdateDate());
                    accountVo.setRoleList(roleList);
                    accountVo.setSystemType(account.getSystemType());
                    accountVo.setAccount(account.getAccount());
                    accountVoList.add(accountVo);
                }
            }
            Map<String, Object> resultMap = new HashMap<String, Object>();
            if (null != info) {
                resultMap.put("total", info.getTotal());
                resultMap.put("rows", accountVoList);
            }
            return resultMap;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public AccountVo selectAccountVoByLoginName(String loginName) {
        try {
            return accountDao.selectAccountVoByLoginName(loginName);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public Account selectAccountByEmail(String email) {
        try {
            return accountDao.selectAccountByEmail(email);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    public void generateActivateEmail(Account account, Integer creatorId, String basePath) {
        try {
            String email = account.getEmailAddress();
            String secretKey = UUID.randomUUID().toString().replace("-", ""); // 随机密钥
            long expireTime = System.currentTimeMillis() + 30 * 60 * 1000;// 30分钟后过期
            String randomStr = email + "$" + secretKey;
            String sid = EncryptUtil.encrypt(randomStr).replace("+", "");

            ActiveAccount activeAccount = new ActiveAccount();
            activeAccount.setAccountId(account.getId());
            activeAccount.setEmailAddress(email);
            activeAccount.setSid(sid);
            activeAccount.setExpireTime(String.valueOf(expireTime));
            activeAccount.setStatus(Constant.RECORD_ACTIVE);
            activeAccount.setCreatorId(creatorId);
            activeAccount.setCreateDate(String.valueOf(System.currentTimeMillis()));
            activeAccount.setUpdaterId(creatorId);
            activeAccount.setUpdateDate(String.valueOf(System.currentTimeMillis()));

            iActiveAccountService.insert(activeAccount);
            
            String url = basePath + "/activateAccount?sid=" + sid + "&id=" + account.getId();
            this.sendEmail(email, url, account);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    private void sendEmail(String email, String url, Account account) throws Exception {
        try {
            String subject = "激活账户";
            StringBuffer content = new StringBuffer();
            content.append(
                    "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">")
                    .append("<html>").append("<head>")
                    .append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">")
                    .append("<title>").append(subject).append("</title><style type=\"text/css\">")
                    .append("</style>").append("</head>").append("<body>").append("<br>")
                    .append("<span class=\"\">请勿回复本邮件, 点击下面的链接激活账户, 本邮件超过30分钟, 链接将会失效, 请联系管理员.</span>")
                    .append("<span class=\"test\">").append("<a href=\"").append(url).append("\">")
                    .append(url).append("</a>").append("</span></br></br>");
                    /*.append("<span>用户名：").append(account.getLoginName()).append("</span></br>")
                    .append("<span>密&nbsp;&nbsp;&nbsp;&nbsp;码：").append(account.getLoginPwd()).append("</span></br>");*/
            
            if(Constant.RECORD_SYSTEM.equals(account.getStatus())){
                log.info("initial Admin account, systemId : " + account.getSystemId());
                SystemType systemType = iSystemTypeService.selectByPrimaryKey(account.getSystemId());
                if(null != systemType){
                    content.append("<span>系统ID：").append(systemType.getId()).append("</span></br>")
                    .append("<span>系统token：").append(systemType.getToken()).append("</span></br>");
                }
            }
            content.append("</body>").append("</html>");

            //iEmailService.sendHtmlEmail(subject, content.toString(), email);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }
    
    private void sendAccessNotifyEmail(Account account, String basePath) throws Exception {
        try {
            log.info("initial Admin account, systemId : " + account.getSystemId());
            SystemType systemType = iSystemTypeService.selectByPrimaryKey(account.getSystemId());
            String subject = "接入信息";
            StringBuffer content = new StringBuffer();
            content.append(
                    "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">")
                    .append("<html>").append("<head>")
                    .append("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">")
                    .append("<title>").append(subject).append("</title><style type=\"text/css\">")
                    .append("</style>").append("</head>").append("<body>").append("<br>")
                    .append("<span>尊敬的用户：").append("</span></br></br>")
                    .append("<span>&nbsp;&nbsp;非常感谢您对智盾大数据风控系统的支持，贵平台接入帐号已经开通，账户信息如下：").append("</span></br></br>")
                    
                    .append("<span>&nbsp;&nbsp;账号名称：").append(account.getLoginName()).append("</span></br>")
                    .append("<span>&nbsp;&nbsp;账号密码：").append(account.getLoginName()).append("</span></br>")
                    .append("<span>&nbsp;&nbsp;系统ID：").append(systemType.getId()).append("</span></br>")
                    .append("<span>&nbsp;&nbsp;系统token：").append(systemType.getToken()).append("</span></br>")
                    .append("<span>&nbsp;&nbsp;后台地址：").append("<a href=\"").append(basePath).append("\">").append(basePath).append("</a></span></br></br>")
                    .append("<span>&nbsp;&nbsp;请妥善保管好以上信息,以免信息泄露而导致安全问题").append("</span></br></br>")
                    .append("</body>").append("</html>");
            
            //iEmailService.sendHtmlEmail(subject, content.toString(), account.getEmailAddress());
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public boolean checkLoginNameAndEmail(Account account, String systemId) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("id", account.getId());
            map.put("loginName", account.getLoginName());
            map.put("emailAddress", account.getEmailAddress());
            map.put("systemId", systemId);
            List<Account> list = accountDao.checkLoginNameAndEmail(map);
            if (null != list && list.size() > 0) {
                return false;
            }
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public boolean checkEmailAddress(String emailAddress, String id) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("id", id);
            map.put("emailAddress", emailAddress);
            List<Account> accounts = accountDao.checkEmailAddress(map);
            if (null != accounts && accounts.size() > 0) {
                return false;
            }
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    @Override
    public boolean checkLoginName(String loginName, String id) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("id", id);
            map.put("loginName", loginName);
            List<Account> accounts = accountDao.checkLoginName(map);
            if (null != accounts && accounts.size() > 0) {
                return false;
            }
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

    private String getRoleNames(String roleIds) {
        try {
            StringBuffer sbuffer = new StringBuffer();
            String[] roleIdArr = roleIds.split(",");
            if (roleIdArr.length > 0) {
                for (String roleId : roleIdArr) {
                    Role role = iRoleService.selectByPrimaryKey(Integer.valueOf(roleId));
                    if (null != role) {
                        sbuffer.append(role.getRoleName()).append(", ");
                    }
                }
                String roleNames = sbuffer.toString();
                if (roleNames.length() > 2) {
                    roleNames = roleNames.substring(0, roleNames.length() - 2);
                }
                return roleNames;
            }
        } catch (NumberFormatException e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    @Override
    public int sendActiviEmail(Integer accountId, Integer updaterId, String basePath) {
        try {
            Account account = this.selectByPrimaryKey(accountId);
            if (Constant.RECORD_INACTIVE.equals(account.getStatus())) {
                ActiveAccount activeAccount = iActiveAccountService
                        .selectActiveAccountByAccountId(accountId);
                if (null != activeAccount) {
                    long expireTime = Long.valueOf(activeAccount.getExpireTime());

                    if (expireTime <= System.currentTimeMillis()) {
                        activeAccount.setStatus(Constant.RECORD_INACTIVE);
                        activeAccount.setUpdaterId(updaterId);
                        activeAccount.setUpdateDate(String.valueOf(System.currentTimeMillis()));
                        iActiveAccountService.updateByPrimaryKeyWithBLOBs(activeAccount);
                    } else {
                        log.warn("there is activi email send before, it is still not expire......");
                        return 0;
                    }
                }
                this.generateActivateEmail(account, updaterId, basePath);
                return 1;
            }
            return 0;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public Account selectSysAdmin(String systemId) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("systemId", systemId);

            return accountDao.selectSysAdmin(map);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }
}
