package ch13.model;

import java.sql.Timestamp;

/*
 이름        널?       유형             
--------- -------- -------------- 
NUM       NOT NULL NUMBER(20)     
WRITER             VARCHAR2(15)   
EMAIL              VARCHAR2(30)   
SUBJECT            VARCHAR2(75)   
PASSWD    NOT NULL VARCHAR2(12)   
REG_DATE  NOT NULL TIMESTAMP(6)   
READCOUNT          NUMBER         
REF       NOT NULL NUMBER(20)     
RE_STEP   NOT NULL NUMBER(10)     
RE_LEVEL  NOT NULL NUMBER(10)     
CONTENT   NOT NULL VARCHAR2(3000) 
IP        NOT NULL VARCHAR2(20)   */


public class BoardDataBean {
	private int num;
	private String writer;
	private String subject;
	private String email;
	private String content;
	private String passwd;
	private Timestamp reg_date;
	private int readcount;
	private String ip;
	private int ref;
	private int re_step;
	private int re_level;
	private String fileName;
	

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public Timestamp getReg_date() {
		return reg_date;
	}

	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}

	public int getReadcount() {
		return readcount;
	}

	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getRe_step() {
		return re_step;
	}

	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}

	public int getRe_level() {
		return re_level;
	}

	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

}
