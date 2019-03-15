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

public class RSAEncrypt implements IEncrypt {
	
	private final static String  DEFAULT_PRIVATE_KEY_STRING = "MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBALOqg6ok5vcTGY0nQuYNHD5DWbGeQoKBYtFRUeeK4vfcWuNVMIHtGVyQcChrRwlHWBio7IQgFJpCn6QVcBfdtEOPgIkc7OiLDebS3VOI0r4yxXOztZn00NvrE0m3EjM65ju8XU6zKO6FXbgsJpTEXtBrWlp2L3oj+J4HrsSoz62jAgMBAAECgYBK9koZI2x6ii2PB2KSOcYe9FroEPAPI4znaNaTlQ89+2Kwl0q16wc558nkE16AMJRBNbn5Jqlx83pIK+mpC4e6M/wGn7lmztuM+FV6Dm72ZBhC8XdXs7qIEk9lwZqxveYt4hLE5kAYlJe7FuDIok4AhYMepVN8lFoN0g4BQH2pgQJBAPV9jx3+tiWRL/kd1f/ixgKbi+CKQfx4rIErxtQkLVc3UDnt/orv9tYamqLNPDkzem2hrlRnCEbVF4xXyI7psjUCQQC7W45VNlZFG/xRtgfouMy4CmH3eSa7zmm2reoWAXcN2fNfE7kUQMSPgK8mhdbxHiChkDBScktxX7j/zD5TIVt3AkEAiyhXnmsqmXUJuq9dBaZpFEVULz5wVUuajcZg+RRg11W1loEAj4WjaI7AJZUtlEdIGSlThui42l4k8Rs5xzlWGQJAMbwTI3GiIwRTzYkJvnBX/77Z1Ky3aIFZtKGkEyVeajHiFeoRZlvvEbzyQcKjlSwPM3QoL6qhdj4XyOd53+1p7wJAGd6FXH2CHXl00mwJY97Tg+Y1zDlpXoBwGDF3DlUhCzzYgueq4iGJw5J72LDaV5QBAGn5OxafbcxEirL8ZIFdvg==";
    private final static String  DEFAULT_PUBLIC_KEY_STRING  = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCzqoOqJOb3ExmNJ0LmDRw+Q1mxnkKCgWLRUVHniuL33FrjVTCB7RlckHAoa0cJR1gYqOyEIBSaQp+kFXAX3bRDj4CJHOzoiw3m0t1TiNK+MsVzs7WZ9NDb6xNJtxIzOuY7vF1OsyjuhV24LCaUxF7Qa1padi96I/ieB67EqM+towIDAQAB";
 
    
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
        Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
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
        Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
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
//    	String[] keyPair = genKeyPair(1024);
//    	System.out.println(keyPair[0].length()+" "+keyPair[0]);
//    	System.out.println(keyPair[1].length()+" "+keyPair[1]);
    	
//    	EncryptWithRSA encrypt = new EncryptWithRSA();    	
//        String password = args[0];        
//        String strEncry = encrypt.encrypt(password);
        //System.out.println(System.currentTimeMillis()-beginTime);
//        System.out.println("密文："+strEncry);
//        beginTime = System.currentTimeMillis();
//        String decode = decrypt(strEncry);
//        System.out.println(System.currentTimeMillis()-beginTime);
//        System.out.println(decode);
    	
    	
//    	System.out.println("-------------");
    	EncryptWithRSA encrypt = new EncryptWithRSA();    
    	String password ="123456789";    
    	String strEncry = encrypt.encrypt(password);
    	System.out.println("密文"+strEncry);
//    	System.out.println("-------------");
    	
    	
    	String decode = encrypt.decrypt(strEncry);
    	System.out.println("明文"+decode);
    	
    	
    	
    }

}