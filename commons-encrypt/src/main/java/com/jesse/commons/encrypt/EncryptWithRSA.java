package com.jesse.commons.encrypt;

import java.io.ByteArrayOutputStream;
import java.io.Closeable;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.SecureRandom;
import java.security.cert.Certificate;
import java.security.cert.CertificateFactory;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;

import javax.crypto.Cipher;

public class EncryptWithRSA implements IEncrypt {
	
	private final static String  DEFAULT_PRIVATE_KEY_STRING = "MIIBnAIBADANBgkqhkiG9w0BAQEFAASCAYYwggGCAgEAAlEAkNUUZvtJt6ru5KWMW27DT1ejnBt8R0sRIGyJ8eTUlrA/xbQI+ASyuwtp/JGicxKs/JMkYIWPgM5W+JQISKh6TY3tX/t33iE8tUQoBxn4EkkCAwEAAQJQXTA9CGX3cK4TOBsszEfgc1S4eOFWfajXRD2SJIpQHwUYg2TrwGmFdcxC8PU4u8Ju9HDldTYaP2I6pjaWuNOXG1fZvR7a2PvSyOXDj527+4ECKQDJLED6o9B8nbERG7D0ow/bTxb4spVzpNlA3AbJ+SRyReXnD2wvjQvtAikAuE34o2rvWjU7rQE3xtZC1NuiK4CKTGO3Iu3ESAfVLkkafpSprCHsTQIpAMgJgCd6YuK3Lw2y+leYGTlawJ3VfjS68+jBoOKPIcWbaYtD07DI0NUCKAhKWZjgQowIQPrzRxMGqFLy3kSer5noEmDb2Sx0Tb6bQznWbht0GzECKBGGPyaJZmlCZmGTwAsBy77rOzKzbKv+I59SlQuHRDT1Gog3cRWAAWs=";
    private final static String  DEFAULT_PUBLIC_KEY_STRING  = "MGwwDQYJKoZIhvcNAQEBBQADWwAwWAJRAJDVFGb7Sbeq7uSljFtuw09Xo5wbfEdLESBsifHk1JawP8W0CPgEsrsLafyRonMSrPyTJGCFj4DOVviUCEioek2N7V/7d94hPLVEKAcZ+BJJAgMBAAE=";
 
    
    public String decrypt(String cipherText) throws Exception {
        return decrypt((String) null, cipherText);
    }

    public String decrypt(String publicKeyText, String cipherText) throws Exception {
        PublicKey publicKey = getPublicKey(publicKeyText);

        return decrypt(publicKey, cipherText);
    }

    public PublicKey getPublicKeyByX509(String x509File) {
        if (x509File == null || x509File.length() == 0) {
            return getPublicKey(null);
        }

        FileInputStream in = null;
        try {
            in = new FileInputStream(x509File);

            CertificateFactory factory = CertificateFactory.getInstance("X.509");
            Certificate cer = factory.generateCertificate(in);
            return cer.getPublicKey();
        } catch (Exception e) {
            throw new IllegalArgumentException("Failed to get public key", e);
        } finally {
            closeQuietly(in);
        }
    }

    public PublicKey getPublicKey(String publicKeyText) {
        if (publicKeyText == null || publicKeyText.length() == 0) {
            publicKeyText = DEFAULT_PUBLIC_KEY_STRING;
        }

        try {
            byte[] publicKeyBytes = Base64.base64ToByteArray(publicKeyText);
            X509EncodedKeySpec x509KeySpec = new X509EncodedKeySpec(publicKeyBytes);

            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            return keyFactory.generatePublic(x509KeySpec);
        } catch (Exception e) {
            throw new IllegalArgumentException("Failed to get public key", e);
        }
    }

    public PublicKey getPublicKeyByPublicKeyFile(String publicKeyFile) {
        if (publicKeyFile == null || publicKeyFile.length() == 0) {
            return getPublicKey(null);
        }

        FileInputStream in = null;
        try {
            in = new FileInputStream(publicKeyFile);
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            int len = 0;
            byte[] b = new byte[512 / 8];
            while ((len = in.read(b)) != -1) {
                out.write(b, 0, len);
            }

            byte[] publicKeyBytes = out.toByteArray();
            X509EncodedKeySpec spec = new X509EncodedKeySpec(publicKeyBytes);
            KeyFactory factory = KeyFactory.getInstance("RSA");
            return factory.generatePublic(spec);
        } catch (Exception e) {
            throw new IllegalArgumentException("Failed to get public key", e);
        } finally {
            closeQuietly(in);
        }
    }

    public String decrypt(PublicKey publicKey, String cipherText) throws Exception {
        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.DECRYPT_MODE, publicKey);

        if (cipherText == null || cipherText.length() == 0) {
            return cipherText;
        }

        byte[] cipherBytes = Base64.base64ToByteArray(cipherText);
        byte[] plainBytes = cipher.doFinal(cipherBytes);

        return new String(plainBytes);
    }

    public String encrypt(String plainText) throws Exception {
        return encrypt((String) null, plainText);
    }

    public String encrypt(String key, String plainText) throws Exception {
        if (key == null) {
            key = DEFAULT_PRIVATE_KEY_STRING;
        }

        byte[] keyBytes = Base64.base64ToByteArray(key);
        return encrypt(keyBytes, plainText);
    }

    public String encrypt(byte[] keyBytes, String plainText) throws Exception {
        PKCS8EncodedKeySpec spec = new PKCS8EncodedKeySpec(keyBytes);
        KeyFactory factory = KeyFactory.getInstance("RSA");
        PrivateKey privateKey = factory.generatePrivate(spec);
        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.ENCRYPT_MODE, privateKey);

        byte[] encryptedBytes = cipher.doFinal(plainText.getBytes("UTF-8"));
        String encryptedString = Base64.byteArrayToBase64(encryptedBytes);

        return encryptedString;
    }

    public static byte[][] genKeyPairBytes(int keySize) throws NoSuchAlgorithmException {
        byte[][] keyPairBytes = new byte[2][];

        KeyPairGenerator gen = KeyPairGenerator.getInstance("RSA");
        gen.initialize(keySize, new SecureRandom());
        KeyPair pair = gen.generateKeyPair();

        keyPairBytes[0] = pair.getPrivate().getEncoded();
        keyPairBytes[1] = pair.getPublic().getEncoded();

        return keyPairBytes;
    }

    public static String[] genKeyPair(int keySize) throws NoSuchAlgorithmException {
        byte[][] keyPairBytes = genKeyPairBytes(keySize);
        String[] keyPairs = new String[2];

        keyPairs[0] = Base64.byteArrayToBase64(keyPairBytes[0]);
        keyPairs[1] = Base64.byteArrayToBase64(keyPairBytes[1]);

        return keyPairs;
    }
    
    private static void closeQuietly(Closeable closeable) {
    	try {
            if (closeable != null) {
                closeable.close();
            }
        } catch (IOException ioe) {
            // ignore
        }
    }
    
    public static void main(String[] args) throws Exception {
//    	String[] keyPair = genKeyPair(640);
//    	System.out.println(keyPair[0].length()+" "+keyPair[0]);
//    	System.out.println(keyPair[1].length()+" "+keyPair[1]);
    	
    	EncryptWithRSA encrypt = new EncryptWithRSA();    	
        String password = args[0];        
        String strEncry = encrypt.encrypt(password);
        //System.out.println(System.currentTimeMillis()-beginTime);
        System.out.println("密文："+strEncry);
//        beginTime = System.currentTimeMillis();
//        String decode = decrypt(strEncry);
//        System.out.println(System.currentTimeMillis()-beginTime);
//        System.out.println(decode);
        
    }

}
