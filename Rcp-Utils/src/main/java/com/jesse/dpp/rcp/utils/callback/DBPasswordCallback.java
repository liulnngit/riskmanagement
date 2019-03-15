package com.jesse.dpp.rcp.utils.callback;

import java.util.Properties;

import com.jesse.dpp.rcp.utils.encrypt.IEncrypt;

public class DBPasswordCallback extends DruidPasswordCallback {	
	private static final long serialVersionUID = 4545626446301312119L;
	
	private IEncrypt encrypt;
	
	public void setProperties(Properties properties) {
		if(getPassword()==null) {
			String password = (String)properties.get("password");
			if(password != null) {
				String decrypt = null;
				try {
					decrypt = encrypt.decrypt(password);
				} catch (Exception e) {					
				}
				if(decrypt != null) {
					setPassword(decrypt.toCharArray());
				}	
			}
		}
	}

	public void setEncrypt(IEncrypt encrypt) {
		this.encrypt = encrypt;
	}

}
