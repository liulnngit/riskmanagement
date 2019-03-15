package com.jesse.dpp.rcp.utils;

import java.util.Arrays;
import java.util.Random;
import java.util.UUID;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.jesse.dpp.rcp.utils.encrypt.EncryptWithAES;
import com.jesse.dpp.rcp.utils.encrypt.EncryptWithRSA;

public class EncryptUtil {
    private static Log log = LogFactory.getLog(EncryptUtil.class);

    public static String encrypt(String plainText) throws Exception {
        return EncryptWithRSA.getInstance().encrypt(plainText);
    }

    public static String decrypt(String cipherText) throws Exception {
        return EncryptWithRSA.getInstance().decrypt(cipherText);
    }

    public static String generateToken() throws Exception {
        try {
            String uuid = UUID.randomUUID().toString().replace("-", "");
            String timestamp = String.valueOf(System.currentTimeMillis());
            String random = String.valueOf(new Random().nextInt(999999999));

            String[] strArr = { uuid, timestamp, random };
            Arrays.sort(strArr);
            String str = strArr[0] + strArr[1] + strArr[2];

            return encrypt(str);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    public static String encryptAES(String plainText, String encryptKey) throws Exception {
        return EncryptWithAES.getInstance().aesEncrypt(plainText, encryptKey);
    }

    public static String decryptAES(String cipherText, String decryptKey) throws Exception {
        return EncryptWithAES.getInstance().aesDecrypt(cipherText, decryptKey);
    }
}
