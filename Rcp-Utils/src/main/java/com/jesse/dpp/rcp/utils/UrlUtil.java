package com.jesse.dpp.rcp.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class UrlUtil {

    public static String getHostName(String url) {
        Pattern p = Pattern.compile("(((\\w+-+)+)|(\\w+)\\.)+(\\w+)(?=/|$|\\?|:)");
        Matcher matcher = p.matcher(url);
        if (matcher.find()) {
            return matcher.group(0);// 匹配的整个字符串
        }
        return null;
    }

}
