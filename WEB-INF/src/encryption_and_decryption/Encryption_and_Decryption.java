package encryption_and_decryption;

import java.io.Serializable;
import java.security.MessageDigest;
import java.util.Arrays;
import java.util.Base64;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

@SuppressWarnings("serial")
public class Encryption_and_Decryption implements Serializable {
	private final String passwd = "8wUc_zo@HAFl5ew*!HI+1";	//暗号復号キー
	private String messeage = "";	//暗号化したいデータ
	private String cryptText = "";	//復号化したいデータ
	private String encrypt_str = "";	//暗号化したデータ
	private String decrypt_str = "";	//復号化したデータ
	
	public Encryption_and_Decryption() {
		super();
	}
	
	public void setMesseage(String messeage_text) {
		this.messeage = "";
		this.messeage = messeage_text;
	}
	
	public void setCryptText(String cryptText_text) {
		this.cryptText = "";
		this.cryptText = cryptText_text;
	}
	
	//暗号化
	public void encrypt() {
		try {
			byte[] key = passwd.getBytes();
			MessageDigest sha = MessageDigest.getInstance("SHA-256");
			key = sha.digest(key);
			key = Arrays.copyOf(key, 32);
			
			SecretKeySpec keyObj = new SecretKeySpec(key, "AES");
			IvParameterSpec ivObj = new IvParameterSpec(Arrays.copyOf(key, 16));
			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
			cipher.init(Cipher.ENCRYPT_MODE, keyObj, ivObj);
			byte[] byteCipherText = cipher.doFinal(this.messeage.getBytes());
			this.encrypt_str = Base64.getEncoder().encodeToString(byteCipherText);
		} catch(Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	//復号
	public void decrypt() {
		try {
			byte[] key = passwd.getBytes();
			MessageDigest sha = MessageDigest.getInstance("SHA-256");
			key = sha.digest(key);
			key = Arrays.copyOf(key, 32);
			SecretKeySpec keyObj = new SecretKeySpec(key, "AES");
			IvParameterSpec ivObj = new IvParameterSpec(Arrays.copyOf(key, 16));
			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
			cipher.init(Cipher.DECRYPT_MODE, keyObj, ivObj);
			byte[] cipherBytes = Base64.getDecoder().decode(this.cryptText);
			byte[] bytedecryptedText = cipher.doFinal(cipherBytes);
			
			this.decrypt_str = new String(bytedecryptedText);
		} catch(Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	public String getEncrypt_str() {
		return this.encrypt_str;
	}
	public String getDecrypt_str() {
		return this.decrypt_str;
	}
}
