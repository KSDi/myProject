package com.don.service;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.don.dao.UserDao;
import com.don.domain.User;

@Service
public class UserService implements UserDetailsService{
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private JavaMailSender javaMailSender;


	@Override
	public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
		User user = userDao.selectOne(id);
		if(user == null) {
			throw new UsernameNotFoundException("아이디 또는 비밀번호가 올바르지 않습니다");
		}
		return user;
	}
	
	public void insertUser(User user){
		userDao.insertUser(user);
		
	}

	public void setAuthority(String id) {
		userDao.setAuthority(id);
	}

	public User selectOneById(String id) {
		return userDao.selectOne(id);
	}
	
	public String sendCertifyEmail(String email) throws Exception {
		String from = "rlatkdehs9@google.com";
		String subject = "[D SHOP] 인증메일";
		String emailCode = getRandomCode();
		String content = 
				"[D SHOP] 인증코드는 ["+emailCode+"]입니다. "+
				"인증코드를 입력하여 이메일 인증을 완료해 주세요";
		
		
		MimeMessage msg = javaMailSender.createMimeMessage();
		MimeMessageHelper helper =
				new MimeMessageHelper(msg, true, "UTF-8");
		helper.setFrom(from);
		helper.setTo(email);
		helper.setSubject(subject);
		helper.setText(content);
		javaMailSender.send(msg);
		
		return emailCode;
	}
	
	// ex)"1572" "9710"
	private String getRandomCode() {
		String randomCode = "";
		for(int i = 0; i < 4; i++) {
			randomCode += (int)(Math.random()*9);
		}
		return randomCode;
	}

	public boolean checkValidEmail(String email) {
		String regex = "^[\\w!#$%&'*+/=?`{|}~^-]+(?:\\.[\\w!#$%&'*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,6}$";
		 
		Pattern pattern = Pattern.compile(regex);
		 
		Matcher matcher = pattern.matcher(email);
		
		return matcher.matches();
	}

	public boolean dupCheckEmail(String email) {
		User user = userDao.selectOneByEmail(email);
		if(user != null) {
			return true;
		}
		return false;
	}

	public void updateEmail(User user) {
		userDao.updateEmail(user);
	}

	public void updatePassword(User modUser) {
		userDao.updatePassword(modUser);
		
	}

	public int selectNewUser() {
		return userDao.selectNewUser();
	}
	
	
}
