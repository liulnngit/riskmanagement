package com.jesse.dpp.rcp.filter;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.filter.OncePerRequestFilter;

public class ParameterFilter extends OncePerRequestFilter {

    private static final String regEx_script = "<script[^>]*?>[\\s\\S]*?<\\/script>"; // 定义script的正则表达式
    private static final String regEx_style = "<style[^>]*?>[\\s\\S]*?<\\/style>"; // 定义style的正则表达式
    private static final String regEx_html = "<[^>]+>"; // 定义HTML标签的正则表达式
    private static final String regEx_ent = "\t|\r|\n";// 定义回车换行符
    private static final String regEx_L_brackets = "\\<";// 定义左尖括号
    private static final String regEx_R_brackets = "\\>";// 定义右尖括号
    private static final String regEx_space = "(^\\s*)|(\\s*$)";

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws ServletException, IOException {

        request = new Request((HttpServletRequest) request);

        response.setHeader("Set-Cookie", "name=value; HttpOnly");

        HttpServletResponse servletResponse = (HttpServletResponse) response;
        HttpServletRequest servletRequest = (HttpServletRequest) request;
        chain.doFilter(servletRequest, servletResponse);

    }

    public String filterDangerString(String value) {
        if (value == null) {
            return null;
        }
        Pattern p_script = Pattern.compile(regEx_script, Pattern.CASE_INSENSITIVE);
        Matcher m_script = p_script.matcher(value);
        value = m_script.replaceAll(""); // 过滤script标签

        Pattern p_style = Pattern.compile(regEx_style, Pattern.CASE_INSENSITIVE);
        Matcher m_style = p_style.matcher(value);
        value = m_style.replaceAll(""); // 过滤style标签

        Pattern p_html = Pattern.compile(regEx_html, Pattern.CASE_INSENSITIVE);
        Matcher m_html = p_html.matcher(value);
        value = m_html.replaceAll(""); // 过滤html标签

        Pattern p_space = Pattern.compile(regEx_ent, Pattern.CASE_INSENSITIVE);
        Matcher m_space = p_space.matcher(value);
        value = m_space.replaceAll(""); // 过滤空格回车标签

        Pattern p_l_brackets = Pattern.compile(regEx_L_brackets, Pattern.CASE_INSENSITIVE);
        Matcher m_l_brackets = p_l_brackets.matcher(value);
        value = m_l_brackets.replaceAll("");// 过滤左尖括号

        Pattern p_r_brackets = Pattern.compile(regEx_R_brackets, Pattern.CASE_INSENSITIVE);
        Matcher m_r_brackets = p_r_brackets.matcher(value);
        value = m_r_brackets.replaceAll("");// 过滤右尖括号
        
        //value = value.trim();

        return value; // 返回文本字符串
    }

    class Request extends HttpServletRequestWrapper {
        HttpServletRequest req = null;

        public Request(HttpServletRequest request) {
            super(request);
            this.req = request;
        }

        @Override
        public String getParameter(String name) {
            // 返回值之前 先进行过滤
            return filterDangerString(super.getParameter(name));
        }

        @Override
        public String[] getParameterValues(String name) {
            // 返回值之前 先进行过滤
            String url = req.getRequestURL().toString();
            String[] values = super.getParameterValues(name);
            boolean isFilter = true;
            if (url.endsWith("editRiskCase") || url.endsWith("addRiskCase")) {
                isFilter = false;
                if ("title".equals(name)) {
                    isFilter = true;
                }
            }
            if (!isFilter) {
                return values;
            }
            if (null != values && values.length > 0) {
                for (int i = 0; i < values.length; i++) {
                    values[i] = filterDangerString(values[i]);
                }
            }
            return values;
        }
    }
}