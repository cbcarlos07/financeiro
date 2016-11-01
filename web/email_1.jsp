<%-- 
    Document   : mail
    Created on : 27/10/2016, 08:28:35
    Author     : carlos.brito
--%>

<%@page import="org.apache.commons.mail.SimpleEmail"%>
<%@page import="com.sun.xml.internal.ws.api.message.saaj.SAAJFactory"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.sun.xml.internal.ws.util.StringUtils"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="auth.Autenticar"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.internet.MimeBodyPart"%>
<%@page import="javax.mail.internet.MimeMultipart"%>
<%@page import="javax.mail.Multipart"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="beans.Financeiro"%>
<%@page import="controller.Financeiro_Controller"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
       
    
   SimpleEmail email = new SimpleEmail();
   //Utilize o hostname do seu provedor de email
   System.out.println("alterando hostname...");
   email.setHostName("smtp.gmail.com");
   //Quando a porta utilizada não é a padrão (gmail = 465)
   email.setSmtpPort(465);
   //Adicione os destinatários
   email.addTo("carlos.brito@ham.org.br", "Carlos Bruno");
   //Configure o seu email do qual enviará
   email.setFrom("cbcarlos07@gmail.com", "Carlos");
   //Adicione um assunto
   email.setSubject("Test message");
   //Adicione a mensagem do email
   email.setMsg("This is a simple test of commons-email");
   //Para autenticar no servidor é necessário chamar os dois métodos abaixo
   System.out.println("autenticando...");
   email.setSSL(false);
   email.setAuthentication("cbcarlos07@gmail.com", "brito1985.");
   System.out.println("enviando...");
   email.send();
   System.out.println("Email enviado!");

       
%>

