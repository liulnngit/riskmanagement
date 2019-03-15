package com.jesse.dpp.rcp.shiro.realm;

import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.AccountRole;
import com.jesse.dpp.rcp.po.Role;
import com.jesse.dpp.rcp.service.IAccountRoleService;
import com.jesse.dpp.rcp.service.IAccountService;
import com.jesse.dpp.rcp.service.IRoleService;

public class RiskRealm extends AuthorizingRealm {

    private static Log log = LogFactory.getLog(RiskRealm.class);

    @Autowired
    private IAccountService iAccountService;

    @Autowired
    private IRoleService iRoleService;

    @Autowired
    private IAccountRoleService iMtmAccountRoleService;

    /**
     * 权限验证
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();


        try {
            String userName = (String) principals.getPrimaryPrincipal();

            Account account = iAccountService.selectAccountByLoginName(userName);
            List<AccountRole>  accountRoleList = iMtmAccountRoleService.selectByPrimaryAccountID(account.getId());
            Set<String> roles = new LinkedHashSet<String>(); // 用户角色
            for(AccountRole accountRole:accountRoleList){
                //Set<String> perms = new LinkedHashSet<String>(); // 用户权限

                Role role = iRoleService.selectByPrimaryKey(accountRole.getRoleId());
                String perm = account.getId() + "_" + accountRole.getRoleId() + "_" + role.getRoleName();
                if (role.getRoleName().equals("Administrator") || role.getRoleName().equals("Admin")) {
                    perm = role.getRoleName();
                }
                roles.add(perm);

                log.info("权限 ： " + perm);
            }

            // List<Menu> menus = menuDao.selectMenuList(account.getStatus());
            //
            // for (Menu menu : menus) {
            // perms.add(menu.getLinkUrl());
            // }
            //

            authorizationInfo.setRoles(roles);
            // authorizationInfo.setStringPermissions(perms);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }

        return authorizationInfo;
    }

    /**
     * 登入验证
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {

        // 获取网页端传过来的userName
        String userName = (String) token.getPrincipal();

        Account account = iAccountService.selectAccountByLoginName(userName);

        log.info("doGetAuthenticationInfo : " + account);

        if (account == null) {
            throw new UnknownAccountException();// 用户名密码不正确
        }

//        if ("I".equals(account.getStatus())) {
//            throw new LockedAccountException(); // 用户被锁定
//        }

        // 交给AuthenticatingRealm使用CredentialsMatcher进行密码匹配
        SimpleAuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(userName, account.getLoginPwd(), getName());
        return authenticationInfo;
    }

    @Override
    public void clearCachedAuthorizationInfo(PrincipalCollection principals) {
        super.clearCachedAuthorizationInfo(principals);
    }

    @Override
    public void clearCachedAuthenticationInfo(PrincipalCollection principals) {
        super.clearCachedAuthenticationInfo(principals);
    }

    @Override
    public void clearCache(PrincipalCollection principals) {
        super.clearCache(principals);
    }

    public void clearAllCachedAuthorizationInfo() {
        getAuthorizationCache().clear();
    }

    public void clearAllCachedAuthenticationInfo() {
        getAuthenticationCache().clear();
    }

    public void clearAllCache() {
        clearAllCachedAuthenticationInfo();
        clearAllCachedAuthorizationInfo();
    }

}
