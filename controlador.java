package Control;

import java.io.*;
import javax.crypto.*;
import java.security.*;
import java.security.cert.CertificateException;
import java.util.Base64;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;

public class controlador {
    
  public controlador(){}
  
  private static String  keyStoreFile = "./codiceinsicuro.keystore";

  public static String encrypt_Password(String id, String value)throws NoSuchAlgorithmException, NoSuchPaddingException,BadPaddingException, InvalidKeyException, IllegalBlockSizeException, Exception {
    String plainText = value;
    String algorithm = "AES";
    Cipher cipher = Cipher.getInstance(algorithm);
    KeyGenerator keygen = KeyGenerator.getInstance(algorithm);
    keygen.init(256);
    SecretKey secretKey = keygen.generateKey();
    cipher.init(Cipher.ENCRYPT_MODE, secretKey);
    byte[] encrypText = cipher.doFinal(plainText.getBytes());    
    String encodedEncText = Base64.getEncoder().encodeToString(encrypText);       
    String encodedKey = Base64.getEncoder().encodeToString(secretKey.getEncoded());
    setKey(id, encodedKey , "SebasTebiSiles");        
    return encodedEncText;
 } 
  public static String decrypt_Password(String id, String encrypText) throws NoSuchAlgorithmException, NoSuchPaddingException, Exception{
      String algorithm = "AES";
      Cipher cipher = Cipher.getInstance(algorithm);
      byte[] secretKey = Base64.getDecoder().decode(getKey(id,"SebasTebiSiles"));
      SecretKey originalKey = new SecretKeySpec(secretKey, 0, secretKey.length, "AES");
      
      cipher.init(Cipher.DECRYPT_MODE, originalKey);
      byte[] encryptedChar = Base64.getDecoder().decode(encrypText);      
      byte[] decrypText = cipher.doFinal(encryptedChar);
      return new String(decrypText);
  }

  public static String change_Encrypt_Password(String id, String value) throws Exception{
    byte[] secretKey = Base64.getDecoder().decode(getKey(id,"SebasTebiSiles"));
    SecretKey originalKey = new SecretKeySpec(secretKey, 0, secretKey.length, "AES");
    String algorithm = "AES";
    Cipher cipher = Cipher.getInstance(algorithm);
    cipher.init(Cipher.ENCRYPT_MODE, originalKey);
    byte[] encrypText = cipher.doFinal(value.getBytes());    
    String encodedEncText = Base64.getEncoder().encodeToString(encrypText);
    return encodedEncText;
  }
  
  public static KeyStore createKeyStore() throws NoSuchAlgorithmException, CertificateException, IOException, KeyStoreException {
    File file = new File(keyStoreFile);   
    String pw = "SebasTebiSiles";
    final KeyStore keyStore = KeyStore.getInstance("JCEKS");
    if (file.exists()) {
      keyStore.load(new FileInputStream(file), pw.toCharArray());
    } else {
      keyStore.load(null, null);
      keyStore.store(new FileOutputStream(keyStoreFile), pw.toCharArray());
    }
    return keyStore;
  }

  private static String getKey(String key, String keyStorePassword) throws Exception{
    KeyStore ks = KeyStore.getInstance("JCEKS");
    ks.load(null, keyStorePassword.toCharArray());
    KeyStore.PasswordProtection keyStorePP = new KeyStore.PasswordProtection(keyStorePassword.toCharArray());
    FileInputStream fIn = new FileInputStream(keyStoreFile);
    ks.load(fIn, keyStorePassword.toCharArray());
    SecretKeyFactory factory = SecretKeyFactory.getInstance("PBE");
    KeyStore.SecretKeyEntry ske = (KeyStore.SecretKeyEntry)ks.getEntry(key, keyStorePP);
    PBEKeySpec keySpec = (PBEKeySpec)factory.getKeySpec(
    ske.getSecretKey(),
    PBEKeySpec.class);
    char[] password = keySpec.getPassword();
    return new String(password);
  }

  private static void setKey(String key, String value, String keyStorePassword) throws Exception {
    SecretKeyFactory factory = SecretKeyFactory.getInstance("PBE");
    SecretKey generatedSecret = factory.generateSecret(new PBEKeySpec(value.toCharArray()));
    KeyStore ks = KeyStore.getInstance("JCEKS");
    ks.load(null, keyStorePassword.toCharArray());
    KeyStore.PasswordProtection keyStorePP = new KeyStore.PasswordProtection(keyStorePassword.toCharArray());
    ks.setEntry(key, new KeyStore.SecretKeyEntry( generatedSecret), keyStorePP);
    FileOutputStream fos = new java.io.FileOutputStream(keyStoreFile);
    ks.store(fos, keyStorePassword.toCharArray());
  }                                                       
}

