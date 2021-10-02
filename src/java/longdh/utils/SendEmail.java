/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package longdh.utils;

import static java.rmi.server.LogStream.log;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Dong Long
 */
public class SendEmail {

    String userEmail;
    String hash;

    public SendEmail(String userEmail, String hash) {
        super();
        this.userEmail = userEmail;
        this.hash = hash;
    }

    public void sendMail() {
        final String email = "donglong453@gmail.com";
        final String password = "long0147852369";

        Properties properties = new Properties();

        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        Session session = Session.getDefaultInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(email, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(email));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(userEmail));
            message.setSubject("Activation Your Account For Simple Blog");
            message.setText("Congratulations on applying for Simple Blog \nCode to active your account: " + hash);
            Transport.send(message);
        } catch (Exception e) {
            log("SendEmail File Error" + e);
        }
    }
}
