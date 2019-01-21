package com.don.domain;

import java.util.Collection;
import java.util.List;

import javax.validation.constraints.Pattern;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class User implements UserDetails{
	@Pattern(regexp="[A-Za-z\\d]{6,15}",message="아이디는 6글자부터 15글자 사이입니다.")
	private String id;
	@Pattern(regexp="(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,15}"
					,message="비밀번호는 8글자부터 15글자 사이이며 특수문자(@$!%*?&)를 한개이상 입력해주세요.")
	private String password;
	private String CheckPassword;
	@Pattern(regexp=".*[가-힣]{2,5}",message="이름을 입력해주세요")
	private String name;
	@Pattern(regexp="\\d{11}",message="전화번호를 입력해주세요")
	private String phone;
	private List<Authority> authorities;
	
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
	public void setPassword(String password) {
		this.password = password;
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		
		return authorities;
	}
	@Override
	public String getPassword() {
		
		return password;
	}
	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return id;
	}
	@Override
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	@Override
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", password=" + password + ", name=" + name + ", phone=" + phone + ", authorities="
				+ authorities + "]";
	}
	public String getCheckPassword() {
		return CheckPassword;
	}
	public void setCheckPassword(String checkPassword) {
		CheckPassword = checkPassword;
	}
	
	
}
