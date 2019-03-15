package com.jesse.dpp.rcp.utils.encrypt;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class EncryptWithAES {

    public static final String VIPARA = "SHpyQm14MFNadkJ0";
    private static final String AES = "AES";
    private static final String MD5 = "MD5";

    /** 编码格式；默认null为GBK */
    public static String charset = "utf-8";
    /** AES */
    public int keysizeAES = 128;

    public static EncryptWithAES me;

    private EncryptWithAES() {
        // 单例
    }

    public static EncryptWithAES getInstance() {
        if (me == null) {
            me = new EncryptWithAES();
        }
        return me;
    }

    public String aesEncrypt(String content, String encryptKey) throws Exception {
        return keyGeneratorAES(content, encryptKey, AES, true);
    }

    public String aesDecrypt(String content, String decryptKey) throws Exception {
        return keyGeneratorAES(content, decryptKey, AES, false);
    }

    public String keyGeneratorAES(String content, String key, String algorithm, boolean isEncode) throws Exception {
        try {
            key = md5Hex(key, false);
            String iv = md5Hex(key, false);
            IvParameterSpec zeroIv = new IvParameterSpec(iv.getBytes(charset));
            KeyGenerator kgen = KeyGenerator.getInstance(algorithm);
            SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG");
            secureRandom.setSeed(key.getBytes(charset));
            kgen.init(keysizeAES, secureRandom);
            SecretKeySpec secretKey = new SecretKeySpec(key.getBytes(charset), algorithm);
            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");

            if (isEncode) {
                cipher.init(Cipher.ENCRYPT_MODE, secretKey, zeroIv);
                byte[] doFinal = cipher.doFinal(content.getBytes(charset));
                return Base64.byteArrayToBase64(doFinal);
            } else {
                cipher.init(Cipher.DECRYPT_MODE, secretKey, zeroIv);
                byte[] decryptBytes = cipher.doFinal(Base64.base64ToByteArray(content));
                return new String(decryptBytes);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private static String md5Hex(String plainText, boolean char32) throws Exception {
        try {
            MessageDigest md = MessageDigest.getInstance(MD5);
            md.update(plainText.getBytes(charset));
            byte b[] = md.digest();
            int i;
            StringBuffer buf = new StringBuffer("");
            for (int j = 0; j < b.length; j++) {
                i = b[j];
                if (i < 0)
                    i += 256;
                if (i < 16)
                    buf.append("0");
                buf.append(Integer.toHexString(i));
            }
            String result = buf.toString();
            if (char32) {
                return result;
            }
            return result.substring(8, 24);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }

    }
}