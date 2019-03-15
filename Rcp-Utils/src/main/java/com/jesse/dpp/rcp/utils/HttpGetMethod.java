package com.jesse.dpp.rcp.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.zip.GZIPInputStream;

import org.apache.commons.httpclient.methods.GetMethod;

/**
 * 
 * created by ll-t150 on 2016-12-29
 *
 */

public class HttpGetMethod extends GetMethod {

    public HttpGetMethod(String uri) {
        super(uri);
    }

    /**
     * Get response as string whether response is GZipped or not
     * 
     * @return
     * @throws IOException
     */
    @Override
    public String getResponseBodyAsString() throws IOException {
        GZIPInputStream gzin;
        if (getResponseBody() != null || getResponseStream() != null) {
            if (getResponseHeader("Content-Encoding") != null && getResponseHeader("Content-Encoding").getValue().toLowerCase().indexOf("gzip") > -1) {
                // For GZip response
                InputStream is = getResponseBodyAsStream();
                gzin = new GZIPInputStream(is);
                InputStreamReader isr = new InputStreamReader(gzin, getResponseCharSet());
                BufferedReader br = new BufferedReader(isr);
                StringBuffer sb = new StringBuffer();
                String tempbf;
                while ((tempbf = br.readLine()) != null) {
                    sb.append(tempbf);
                    sb.append("\r\n");
                }
                isr.close();
                gzin.close();
                return sb.toString();
            } else {
                // For deflate response
                return super.getResponseBodyAsString();
            }
        } else {
            return null;
        }
    }

}