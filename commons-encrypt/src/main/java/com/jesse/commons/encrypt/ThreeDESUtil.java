package com.jesse.commons.encrypt;

import java.security.InvalidKeyException;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESedeKeySpec;

/**
 * 3DES + base64 加解密工具类
 * 
 * @ClassName: ThreeDESUtil
 * @author ChaoLiangHua
 * @date 2016-3-17 下午07:48:21
 */

public class ThreeDESUtil {

    /**
     * DES加密
     * 
     * @param encryptString
     * @return
     */
    public static String encryptThreeDESECB(String key, String encryptString) {
        String encryptDES = "";
        try {
            DESedeKeySpec dks = new DESedeKeySpec(key.getBytes("UTF-8"));
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DESede");
            SecretKey securekey = keyFactory.generateSecret(dks);

            Cipher cipher = Cipher.getInstance("DESede/ECB/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, securekey);
            byte[] b = cipher.doFinal(encryptString.getBytes());

            encryptDES = Base64.byteArrayToBase64(b);
        } catch (Exception e) {

        }
        return encryptDES;
    }

    /**
     * 3DESECB 解密,key 必须是长度大于等于 3*8 = 24 位
     * 
     * @param decryptString
     * @return
     * @throws InvalidKeyException
     * @throws Exception
     */
    public static String decryptThreeDESECB(String key, String decryptString) throws Exception {
        // --通过base64,将字符串转成byte 数组
        byte[] bytesrc = Base64.base64ToByteArray(decryptString);
        // --解密的key
        DESedeKeySpec dks = new DESedeKeySpec(key.getBytes("UTF-8"));
        SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DESede");
        SecretKey securekey = keyFactory.generateSecret(dks);
        // --Chipher 对象解密
        Cipher cipher = Cipher.getInstance("DESede/ECB/PKCS5Padding");
        cipher.init(Cipher.DECRYPT_MODE, securekey);
        byte[] retByte = cipher.doFinal(bytesrc);

        return new String(retByte);
    }

}
