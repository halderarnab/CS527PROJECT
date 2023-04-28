package com.cs527.pkg;

import java.sql.Date;

public class UserDataNOTUSED {
	
	private String password;
	private int userId;
	private String phoneNo;
	private String address;
	private String cardNo;
	private Date cardExpiry;
	private String cvv;
	private String name;
	private String bankAccountNo;

	    // Default constructor
	public UserDataNOTUSED() {
	}

	    // Parameterized constructor
	public UserDataNOTUSED(String password, int userId, String phoneNo, String address, String cardNo, Date cardExpiry, 
			String cvv, String name, String bankAccountNo) {
		
		this.password = password;
		this.userId = userId;
		this.phoneNo = phoneNo;
		this.address = address;
		this.cardNo = cardNo;
		this.cardExpiry = cardExpiry;
		this.cvv = cvv;
		this.name = name;
		this.bankAccountNo = bankAccountNo;
	}

	// Getter and Setter methods for the member variables
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	//////////
	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	public String getCardNo() {
		return cardNo;
	}

	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public Date getCardExpiry() {
		return cardExpiry;
	}

	public void setCardExpiry(Date cardExpiry) {
		this.cardExpiry = cardExpiry;
	}
	public String getCvv() {
		return cvv;
	}

	public void setCvv(String cvv) {
		this.cvv= cvv;
	}
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	public String getBankAccountNo() {
		return bankAccountNo;
	}

	public void setBankAccountNo(String bankAccountNo) {
		this.bankAccountNo = bankAccountNo;
	}
}

