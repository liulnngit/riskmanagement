package com.jesse.dpp.rcp.shiro.filter;

/**
 * 
 * @author wzs-t178
 * 
 * 重写 RolesAuthorizationFilter isAccessAllowed
 * 用于多角色 or 关系，原来 and 关系
 * 例如：role[admin,user] 满足一种角色就可以
 */
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authz.RolesAuthorizationFilter;

import java.io.IOException;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class AnyOfRolesAuthorizationFilter extends RolesAuthorizationFilter {

    @Override
    public boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws IOException {

        final Subject subject = getSubject(request, response);
        final String[] rolesArray = (String[]) mappedValue;

        if (rolesArray == null || rolesArray.length == 0) {
            return true;
        }

        for (String roleName : rolesArray) {
            if (subject.hasRole(roleName)) {
                return true;
            }
        }

        return false;
    }
}
