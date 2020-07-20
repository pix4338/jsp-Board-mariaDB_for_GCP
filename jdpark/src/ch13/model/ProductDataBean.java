package ch13.model;
/*NO       NOT NULL NUMBER(38)    
NAME     NOT NULL VARCHAR2(30)  
DIVISION NOT NULL VARCHAR2(20)  
PRICE    NOT NULL NUMBER(38)    
COUNT             NUMBER(38)    
IMG               VARCHAR2(30)  
INFO     NOT NULL VARCHAR2(500) */
public class ProductDataBean {

	int no;//상품 number
	String name;//상품 이름
	int division;//상품 분류
	int price;//상품 가격
	int count;//상품 재고
	String img;//상품 이미지
	String info;//상품 설명
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getDivision() {
		return division;
	}
	public void setDivision(int division) {
		this.division = division;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
}
