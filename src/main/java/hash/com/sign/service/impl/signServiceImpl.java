package hash.com.sign.service.impl;

import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.stereotype.Service;

import hash.com.sign.service.signService;

@Service("signService")
public class signServiceImpl implements signService{
	
	@Resource(name="signMapperDao")
	private signMapperDao signMapperDao;

	@Override
	public List<Map<String, Object>> loginCheck(Map<String, Object> map) throws Exception{
		return signMapperDao.loginCheck(map);
	}

	@Override
	public int signUpIdChk(Map<String, Object> map) throws Exception {
		return signMapperDao.signUpIdChk(map);
	}

	@Override
	public void signUpProcess(Map<String, Object> map) throws Exception {
		
		int signUpIdChkRst = signMapperDao.signUpIdChk(map);
		if(signUpIdChkRst == 0) {
			// transaction check success
			signMapperDao.signUpProcess(map);
		}
	}

	@Override
	public void updatePasswordAndSendMail(String inputUserEmail) throws Exception {
		
		String newPassword = getRandomPassword(8);
		sendMail(inputUserEmail, newPassword);
	}
	
	
	/**
	 * 메일 전송
	 * @param inputUserEmail
	 * @param newPassword
	 * @throws Exception
	 */
	public void sendMail(String inputUserEmail, String newPassword) throws Exception {
		
		// 메일 host, port 설정정보
		String smtpHost = "smtp.gmail.com";
		String smtpPort = "465";

		// 전송자 계정
		String sendUserMailId = "shinhash123@gmail.com";
		String sendUserMailPw = "ktum mcwe cook cfca";
		
		// 수신자 계정
		String reciveUserMail = "tlsgktmd123@gmail.com";
		
		// smtp 설정
		Properties props = System.getProperties();
		props.put("mail.transport.protocol", "smtp"); 
		props.put("mail.smtp.host", smtpHost); 
		props.put("mail.smtp.port", smtpPort); 
		props.put("mail.smtp.auth", true);
		props.put("mail.smtp.ssl.enable", true);
        props.put("mail.smtp.ssl.trust", smtpHost);
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        
        // mail session 설정
        Session mailSession = Session.getInstance(props, 
        		new javax.mail.Authenticator() {
        			protected PasswordAuthentication getPasswordAuthentication() {
        				return new PasswordAuthentication(sendUserMailId, sendUserMailPw);
        			}
        });
        
        try {
        	// message 설정
        	Message message = new MimeMessage(mailSession);
        	message.setFrom(new InternetAddress(sendUserMailId));
        	message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(reciveUserMail));
        	
        	// 제목
        	message.setSubject("테스트 메일 제목");
        	// 내용
        	message.setText("테스트 메일 내용입니다. \n 새로운 비밀번호 입니다." + "\n " + newPassword);
        	// mail 전송
        	Transport.send(message);
        	
        }catch(MessagingException e) {
        	e.printStackTrace();
        }
	}
	
	
	/**
	 * 비밀번호 랜덤생성
	 * @param size
	 * @return
	 */
	public String getRandomPassword(int size) {
		String randomPassword = RandomStringUtils.randomAlphanumeric(size);
		return randomPassword;
	}

}
