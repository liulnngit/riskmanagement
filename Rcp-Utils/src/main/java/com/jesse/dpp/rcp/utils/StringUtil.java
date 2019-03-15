package com.jesse.dpp.rcp.utils;

import org.apache.commons.lang.StringUtils;

import java.util.StringTokenizer;


public class StringUtil {
    /**
     * replace s1 with s2 in source String
     * @param source in which to find s1
     * @param s1 the String to be replaced
     * @param s2 the String used to replace
     * @return the replaced String
     */
    public static String replace(String source, String s1, String s2){
        //return source.replace(s1, s2 == null?"":s2);
        StringBuffer buf = new StringBuffer(source.length() * 2);
        int a = 0, b = source.indexOf(s1);
        char[] chars = source.toCharArray();
        while(b >= 0){
            buf.append(chars, a, b - a).append(s2);
            a = b + s1.length();
            b = source.indexOf(s1, a);
        }
        if (a < source.length()){
            buf.append(chars, a, source.length() - a);
        }

        return buf.toString();
    }

    /**
     * replace each item in s1 with the item in s2 whose index is the same
     * @param source the source String to operate
     * @param s1 an array holds all the String to be replaced
     * @param s2 an array holds all the String used to replace
     * @return the replaced String
     */
    public static String replace(String source, String[] s1, String[] s2){
        for(int i = 0;i < s1.length;i++){
            source = StringUtil.replace(source, s1[i], s2[i]);
        }

        return source;
    }


    /**
     * @param source
     * @param s1
     * @param ss
     * @return
     */
    public static String replace(String source, String s1, String[] ss){
        String[] ss1 = StringUtil.split(",", s1);
        return replace(source, ss1, ss);
    }


    /**
     * @param format
     * @param s1
     * @return
     */
    public static String format(String format, Object s1){
        return replace(format, "{0}", s1 == null?"":s1.toString());
    }
    public static String format(String format, Object s1, Object s2){
        return replace(format, new String[]{"{0}", "{1}"}, new String[]{
            s1 == null?"":s1.toString(),
            s2 == null?"":s2.toString()
        });
    }
    public static String format(String format, Object s1, Object s2, Object s3){
        return replace(format, new String[]{"{0}", "{1}", "{2}"}, new String[]{
            s1 == null?"":s1.toString(),
            s2 == null?"":s2.toString(),
            s3 == null?"":s3.toString()
        });
    }
    public static String format(String format, Object s1, Object s2, Object s3, Object s4){
        return replace(format, new String[]{"{0}", "{1}", "{2}", "{3}"}, new String[]{
            s1 == null?"":s1.toString(),
            s2 == null?"":s2.toString(),
            s3 == null?"":s3.toString(),
            s4 == null?"":s4.toString()
        });
    }
    public static String format(String format, Object s1, Object s2, Object s3, Object s4,Object s5){
        return replace(format, new String[]{"{0}", "{1}", "{2}", "{3}","{4}"}, new String[]{
            s1 == null?"":s1.toString(),
            s2 == null?"":s2.toString(),
            s3 == null?"":s3.toString(),
            s4 == null?"":s4.toString(),
            s5 == null?"":s5.toString()
        });
    }
    public static String format(String format, Object s1, Object s2, Object s3, Object s4,Object s5, Object s6){
        return replace(format, new String[]{"{0}", "{1}", "{2}", "{3}","{4}","{5}"}, new String[]{
            s1 == null?"":s1.toString(),
            s2 == null?"":s2.toString(),
            s3 == null?"":s3.toString(),
            s4 == null?"":s4.toString(),
            s5 == null?"":s5.toString(),
            s6 == null?"":s6.toString()
        });
    }
    
    public static String format(String format, Object s1, Object s2, Object s3, Object s4,Object s5, Object s6, Object s7){
        return replace(format, new String[]{"{0}", "{1}", "{2}", "{3}","{4}","{5}","{6}"}, new String[]{
            s1 == null?"":s1.toString(),
            s2 == null?"":s2.toString(),
            s3 == null?"":s3.toString(),
            s4 == null?"":s4.toString(),
            s5 == null?"":s5.toString(),
            s6 == null?"":s6.toString(),
            s7 == null?"":s7.toString()
        });
    }
    
    public static String format(String format, Object s1, Object s2, Object s3, Object s4,Object s5, Object s6, Object s7,Object s8){
      return replace(format, new String[]{"{0}", "{1}", "{2}", "{3}","{4}","{5}","{6}","{7}"}, new String[]{
          s1 == null?"":s1.toString(),
          s2 == null?"":s2.toString(),
          s3 == null?"":s3.toString(),
          s4 == null?"":s4.toString(),
          s5 == null?"":s5.toString(),
          s6 == null?"":s6.toString(),
          s7 == null?"":s7.toString(),
          s8 == null?"":s8.toString()
      });
  }
    
    public static String format(String format, Object s1, Object s2, Object s3, Object s4,Object s5, Object s6, Object s7,Object s8,Object s9){
      return replace(format, new String[]{"{0}", "{1}", "{2}", "{3}","{4}","{5}","{6}","{7}","{8}"}, new String[]{
          s1 == null?"":s1.toString(),
          s2 == null?"":s2.toString(),
          s3 == null?"":s3.toString(),
          s4 == null?"":s4.toString(),
          s5 == null?"":s5.toString(),
          s6 == null?"":s6.toString(),
          s7 == null?"":s7.toString(),
          s8 == null?"":s8.toString(),
          s9 == null?"":s9.toString()              
      });
  }
    
    
    public static String format(String format, Object s1, Object s2, Object s3, Object s4,Object s5, Object s6, Object s7,Object s8,Object s9,Object s10){
      return replace(format, new String[]{"{0}", "{1}", "{2}", "{3}","{4}","{5}","{6}","{7}","{8}","{9}"}, new String[]{
          s1 == null?"":s1.toString(),
          s2 == null?"":s2.toString(),
          s3 == null?"":s3.toString(),
          s4 == null?"":s4.toString(),
          s5 == null?"":s5.toString(),
          s6 == null?"":s6.toString(),
          s7 == null?"":s7.toString(),
          s8 == null?"":s8.toString(),
          s9 == null?"":s9.toString(),
          s10 == null?"":s10.toString()
      });
  }
    
    public static String format(String format, String[] ss){
        for(int i = 0;ss != null && i < ss.length;i++){
            format = replace(format, '{' + String.valueOf(i) + '}', ss[i]);
        }
        return format;
    }


    /**
     * when given String is blank or blank after trim(), return null
     * @param s
     * @return
     */
    public static String noblank(String s){
        if (s != null && "".equals(s.trim())){
            return null;
        }

        return s;
    }


    /**
     */
    public static String fill(String s, int n){
        if (s == null || s.length() == 0)
        {
            return s;
        }

        StringBuffer buf = new StringBuffer(s.length() * n);

        for(int i = 0;i < n;i++){
            buf.append(s);
        }

        return buf.toString();
    }

    /**
     */
    public static String fill(char c, int n){
        StringBuffer buf = new StringBuffer(n);

        for(int i = 0;i < n;i++){
            buf.append(c);
        }

        return buf.toString();
    }


    /**
     * @param seperators
     * @param list
     * @return
     */
    public static String[] split(String seperators, String list) {
		return split(seperators, list, false);
	}

    /**
     * @param seperators
     * @param list
     * @param include
     * @return
     */
	public static String[] split(String seperators, String list, boolean include) {
		StringTokenizer tokens = new StringTokenizer(list, seperators, include);
		String[] result = new String[ tokens.countTokens() ];
		int i = 0;
		while ( tokens.hasMoreTokens() ) {
			result[i++] = tokens.nextToken();
		}
		return result;
	}


    /**
     * @param strArray
     * @param separator
     * @return
     */
    public static String join(String[] strArray, char[] separator){
        if (separator == null) {
          separator = new char[0];
        }
        StringBuffer buf = new StringBuffer();
        for(int i = 0;i < strArray.length;i++){
            if (i > 0){
                buf.append(separator);
            }
            buf.append(strArray[i]);
        }
        return buf.toString();
    }

    /**
     * @param strArray
     * @param separator
     * @return
     */
    public static String join(String[] strArray, String separator){
        return join(strArray, separator == null?null:separator.toCharArray());
    }

    /**
     * @param strArray
     * @param separator
     * @return
     */
    public static String join(String[] strArray, char separator){
        return join(strArray, new char[]{separator});
    }





    /**
     * @param s
     * @return
     */
    public static boolean isNullOrEmpty(String s)
    {
        if (s == null)
        {
            return true;
        }

        s = s.trim();
        if (s.length() == 0)
        {
            return true;
        }

        return false;
    }

    /**
     * @param s
     * @return
     */
    public static boolean isDigit(String s)
    {
        if (isNullOrEmpty(s))
        {
            return false;
        }

        for(int i = s.length() - 1;i >= 0;i--)
        {
            if (!Character.isDigit(s.charAt(i))) {
              return false;
            }
        }

        return true;
    }


    /**
     * @param text
     * @param encodeCharset
     * @return
     */
    public static String charset(String text, String encodeCharset)
    {
        return charset(text, null, encodeCharset);
    }

    /**
     * @param text
     * @param decodeCharset
     * @param encodeCharset
     * @return
     */
    public static String charset(String text, String decodeCharset, String encodeCharset)
    {
        try
        {
            text = new String(
                    decodeCharset == null?text.getBytes():text.getBytes(decodeCharset),
                    encodeCharset);
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }

        return text;
    }

    /**
     * @param s
     * @return
     */
    public static String lowerField(String s){
        if (s.length() == 1){
            return s.toLowerCase();
        }else{
            return s.substring(0,1).toLowerCase() + s.substring(1);
        }
    }

    /**
     * @param s
     * @return
     */
    public static String upperField(String s){
        if (s.length() == 1){
            return s.toUpperCase();
        }else{
            return s.substring(0,1).toUpperCase() + s.substring(1);
        }
    }


    public static String prefix(Object source, int len, char prefix){
        if (len <= 0){
            return "";
        }

        String s;
        if (source instanceof String){
            s = (String)source;
        }else{
            s = source.toString();
        }

        StringBuffer buf = new StringBuffer();
        for(int i = 0;i < len - s.length();i++){
            buf.append(prefix);
        }
        buf.append(s);
        return buf.toString();
    }

    public static String suffix(Object source, int len, char suffix){
        if (len <= 0){
            return "";
        }

        String s;
        if (source instanceof String){
            s = (String)source;
        }else{
            s = source.toString();
        }

        StringBuffer buf = new StringBuffer();
        buf.append(s);
        for(int i = 0;i < len - s.length();i++){
            buf.append(suffix);
        }
        return buf.toString();
    }

    public static String getSystemId(String systemId, String accountSystemId, String innerSystemId) {
        if(StringUtils.isBlank(systemId)) {
            if (!innerSystemId.equals(accountSystemId)) {
                systemId = accountSystemId;
            }
        } else {
            if (innerSystemId.equals(systemId)) {
                systemId = null;
            }
        }
        return systemId;
    }
}