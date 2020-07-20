package ch13.model;
/*----------- -------- ------------ 
ID          NOT NULL VARCHAR2(15) 
PWD         NOT NULL VARCHAR2(12) 
DATE_NUMBER          VARCHAR2(15) 
EMAIL                VARCHAR2(30) 
ADDRESS              VARCHAR2(25) 
TEL                  VARCHAR2(13) 
NAME        NOT NULL VARCHAR2(15) 
REG_DATE    NOT NULL TIMESTAMP(6) */
public class LoginDataBean {
	private String id;
	private String pwd;
	private String date_number;
	private String email;
	private String address;
	private String tel;
	private String nickname;
	private String reg_date;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getDate_number() {
		return date_number;
	}
	public void setDate_number(String date_number) {
		this.date_number = date_number;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
}
