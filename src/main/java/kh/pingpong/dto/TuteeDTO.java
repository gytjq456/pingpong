package kh.pingpong.dto;

import org.springframework.web.multipart.MultipartFile;

public class TuteeDTO {

   private int seq;
   private String id;
   private String name;
   private String email;
   private String phone_country;
   private String phone;
   private String bank_name;
   private int price;
   private String account;
   private MultipartFile profile;
   private String title;
   private String address;
   private String cancle;
   private int refundPrice;
   private int parent_seq;
   private String sysname;
   
   public TuteeDTO() {
      super();
      // TODO Auto-generated constructor stub
   }

public TuteeDTO(int seq, String id, String name, String email, String phone_country, String phone, String bank_name,
		int price, String account, MultipartFile profile, String title, String address, String cancle, int refundPrice,
		int parent_seq, String sysname) {
	super();
	this.seq = seq;
	this.id = id;
	this.name = name;
	this.email = email;
	this.phone_country = phone_country;
	this.phone = phone;
	this.bank_name = bank_name;
	this.price = price;
	this.account = account;
	this.profile = profile;
	this.title = title;
	this.address = address;
	this.cancle = cancle;
	this.refundPrice = refundPrice;
	this.parent_seq = parent_seq;
	this.sysname = sysname;
}

public int getSeq() {
	return seq;
}

public void setSeq(int seq) {
	this.seq = seq;
}

public String getId() {
	return id;
}

public void setId(String id) {
	this.id = id;
}

public String getName() {
	return name;
}

public void setName(String name) {
	this.name = name;
}

public String getEmail() {
	return email;
}

public void setEmail(String email) {
	this.email = email;
}

public String getPhone_country() {
	return phone_country;
}

public void setPhone_country(String phone_country) {
	this.phone_country = phone_country;
}

public String getPhone() {
	return phone;
}

public void setPhone(String phone) {
	this.phone = phone;
}

public String getBank_name() {
	return bank_name;
}

public void setBank_name(String bank_name) {
	this.bank_name = bank_name;
}

public int getPrice() {
	return price;
}

public void setPrice(int price) {
	this.price = price;
}

public String getAccount() {
	return account;
}

public void setAccount(String account) {
	this.account = account;
}

public MultipartFile getProfile() {
	return profile;
}

public void setProfile(MultipartFile profile) {
	this.profile = profile;
}

public String getTitle() {
	return title;
}

public void setTitle(String title) {
	this.title = title;
}

public String getAddress() {
	return address;
}

public void setAddress(String address) {
	this.address = address;
}

public String getCancle() {
	return cancle;
}

public void setCancle(String cancle) {
	this.cancle = cancle;
}

public int getRefundPrice() {
	return refundPrice;
}

public void setRefundPrice(int refundPrice) {
	this.refundPrice = refundPrice;
}

public int getParent_seq() {
	return parent_seq;
}

public void setParent_seq(int parent_seq) {
	this.parent_seq = parent_seq;
}

public String getSysname() {
	return sysname;
}

public void setSysname(String sysname) {
	this.sysname = sysname;
}
   
   

}