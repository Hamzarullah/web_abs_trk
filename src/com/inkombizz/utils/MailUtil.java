//
//package com.inkombizz.utils;
//
//import com.inkombizz.action.BaseSession;
//import com.inkombizz.common.TransactionLogCommon;
//import com.inkombizz.common.enumeration.EnumTransactionAction;
//import com.inkombizz.dao.HBMSession;
//import com.inkombizz.sales.model.Email;
//import com.inkombizz.system.dao.TransactionLogDAO;
//import com.lowagie.text.Document;
//import com.lowagie.text.DocumentException;
//import com.lowagie.text.Paragraph;
//import com.lowagie.text.pdf.PdfWriter;
//import java.io.File;
//import java.io.FileNotFoundException;
//import java.io.FileOutputStream;
//import java.io.IOException;
//import java.util.List;
//import java.util.Properties;
//import javax.activation.DataHandler;
//import javax.activation.DataSource;
//import javax.activation.FileDataSource;
//import javax.mail.BodyPart;
//import javax.mail.Message;
//import javax.mail.MessagingException;
//import javax.mail.Session;
//import javax.mail.Transport;
//import javax.mail.internet.InternetAddress;
//import javax.mail.internet.MimeBodyPart;
//import javax.mail.internet.MimeMessage;
//import javax.mail.internet.MimeMultipart;
//import javax.servlet.http.HttpServletRequest;
//import net.sf.jasperreports.engine.JRException;
//import org.apache.struts2.ServletActionContext;
//
//
//
//
//public class MailUtil {
//    
//    private HBMSession hbmSession;
//    private CreatePDF createPDF;
//    
//    public MailUtil(HBMSession session) {
//        this.hbmSession = session;
//        createPDF = new CreatePDF(hbmSession);
//    }
//    
//    public void SendingEmail(Email emailModel,List<String> listEmail){
//        
//        try {
//
//            Properties properties=new Properties();
//
//            //inkombizz
////            properties.put("mail.smtp.host","mail.inkombizz.co.id");
////            properties.put("mail.smtp.auth","true");
//////          properties.put("mail.smtp.ssl.enable","false");
////            properties.put("mail.smtp.port", "587");//default port dari smptp
//            
//            properties.put("mail.smtp.host","smtp.gmail.com");
//            properties.put("mail.smtp.auth","true");
//            properties.put("mail.smtp.port", "465");//default port dari smptp
//            
//            Session session=Session.getInstance(properties);
//            session.setDebug(true);
//            
//            for(String email : listEmail){
//                MimeMessage pesan=new MimeMessage(session);
//                pesan.setFrom(new InternetAddress(emailModel.getUsername()));
//                pesan.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
//                pesan.setSubject(emailModel.getTitle());
////                pesan.setText("Email dikirim menggunakan Java Mail.");
//
//                MimeMultipart multipart = new MimeMultipart("related");
//
//
//                BodyPart messageBodyPart = new MimeBodyPart();
//                String htmlText = emailModel.getContent()+" "
//                        + "<img src=\"cid:image\">";
//                messageBodyPart.setContent(htmlText, "text/html");
//           
//                multipart.addBodyPart(messageBodyPart);
//
//            
//                messageBodyPart = new MimeBodyPart();
//                
//                HttpServletRequest request = ServletActionContext.getRequest();
//                String path = request.getRealPath(File.separator+"images"+File.separator+"logo_OCI.jpg");
//                
//                DataSource fds = new FileDataSource(path); 
//                
//                messageBodyPart.setDataHandler(new DataHandler(fds));
//                messageBodyPart.setHeader("Content-ID", "<image>");
//
//                // add image to the multipart
//                multipart.addBodyPart(messageBodyPart);
//
//                // Part three is attachment
//                messageBodyPart = new MimeBodyPart();
//                String filename = "user_login.pdf";
//                DataSource source = new FileDataSource("D:"+File.separator+"Temp"+File.separator+filename);
//                messageBodyPart.setDataHandler(new DataHandler(source));
//                messageBodyPart.setFileName(filename);
//                multipart.addBodyPart(messageBodyPart);
//                
//                // put everything together
//                pesan.setContent(multipart);
//                
//                Transport transport = session.getTransport("smtp");
//                transport.connect(emailModel.getUsername(), emailModel.getPassword());
//                transport.sendMessage(pesan, pesan.getAllRecipients());
//                transport.close();
//
//                System.out.println("Message Sent....");
//           }
//            
//        } catch (MessagingException ex) {
//            ex.printStackTrace();
//        }
//    }
//    
//    public void SendingEmail(Email email,String modulecode) throws FileNotFoundException, DocumentException, IOException, JRException{
//        
//        try {
//            
//            String filename = email.getCode().replace("/", "")+".pdf";
//            
//            createPDF.GeneratePDF(email, filename); 
//
//            Properties properties=new Properties();
//
//            //orion
////            properties.put("mail.smtp.host","smtp01.orion.net.id");
////            properties.put("mail.smtp.auth","true");
//            //properties.put("mail.smtp.ssl.enable","false");
////            properties.put("mail.smtp.port", "587");//default port dari smptp
//            
//            
//            //inkombizz
//            properties.put("mail.smtp.host","mail.inkombizz.co.id");
//            properties.put("mail.smtp.auth","true");
//            properties.put("mail.smtp.port", "587");//default port dari smptp
//
//            //properties.put("mail.smtp.host","smtp.gmail.com");
//            //properties.put("mail.smtp.auth","true");
//            //properties.put("mail.smtp.tls.enable","tru");
//            //properties.put("mail.smtp.starttls.enable","true");
//            //properties.put("mail.smtp.port", "587");//default port dari smptp
//            
//            Session session=Session.getInstance(properties);
//            session.setDebug(true);
//            
//            MimeMessage pesan=new MimeMessage(session);
////            pesan.setFrom(new InternetAddress(email.getUsername(), "finance@orion.net.id"));
//            pesan.setFrom(new InternetAddress(email.getUsername(), "wawan@inkombizz.co.id"));
//            pesan.setRecipient(Message.RecipientType.TO, new InternetAddress(email.getEmailDestination()));
//            pesan.setSubject(email.getTitle());
//
//            MimeMultipart multipart = new MimeMultipart("related");
//
//
//            BodyPart messageBodyPart = new MimeBodyPart();
//            String htmlText = email.getContent()+"<br/><img src=\"cid:image\">";
//            messageBodyPart.setContent(htmlText, "text/html");
//
//            multipart.addBodyPart(messageBodyPart);
//
//
//            messageBodyPart = new MimeBodyPart();
//
//            HttpServletRequest request = ServletActionContext.getRequest();
//            String path = request.getRealPath(File.separator+"images"+File.separator+"mms.jpg");
//
//            DataSource fds = new FileDataSource(path); 
//
//            messageBodyPart.setDataHandler(new DataHandler(fds));
//            messageBodyPart.setHeader("Content-ID", "<image>");
//
//            // add image to the multipart
//            multipart.addBodyPart(messageBodyPart);
//
//            // Part three is attachment
//            messageBodyPart = new MimeBodyPart();
//            
//            //String filename = "test.pdf";
//            DataSource source = new FileDataSource(BaseSession.loadProgramSession().getSetup().getPdfPath()+""+filename);
//            messageBodyPart.setDataHandler(new DataHandler(source));
//            messageBodyPart.setFileName(filename);
//            multipart.addBodyPart(messageBodyPart);
//
//            // put everything together
//            pesan.setContent(multipart);
//
//            Transport transport = session.getTransport("smtp");
//            transport.connect(email.getUsername(), email.getPassword());
//            transport.sendMessage(pesan, pesan.getAllRecipients());
//            transport.close();
//
//            System.out.println("Message Sent....");
//            
//            //add To Log And Update Invoice Send Email Count 
//            hbmSession.hSession.beginTransaction();
//            
//            hbmSession.hSession.createSQLQuery("UPDATE sal_invoice SET sendEmailCount = sendEmailCount + 1 "
//                    + "WHERE CODE = :prmCode")
//                    .setParameter("prmCode", email.getCode())
//                    .executeUpdate();
//            
//            TransactionLogDAO transactionLogDAO = new TransactionLogDAO(hbmSession);
//            transactionLogDAO.save(TransactionLogCommon.newInstance(modulecode, 
//                                                                    EnumTransactionAction.toString(EnumTransactionAction.ENUM_TransactionAction.INSERT), 
//                                                                    email.getTitle()+"-"+email.getEmailDestination(), ""));
//            
//            hbmSession.hTransaction.commit();
//            hbmSession.hSession.clear();
//            hbmSession.hSession.close();
//            
//        } catch (MessagingException ex) {
//            ex.printStackTrace();
//        }
//    }
//
//    public HBMSession getHbmSession() {
//        return hbmSession;
//    }
//
//    public void setHbmSession(HBMSession hbmSession) {
//        this.hbmSession = hbmSession;
//    }
//
//    public CreatePDF getCreatePDF() {
//        return createPDF;
//    }
//
//    public void setCreatePDF(CreatePDF createPDF) {
//        this.createPDF = createPDF;
//    }
//
//}
