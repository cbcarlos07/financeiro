<%-- 
    Document   : mail
    Created on : 27/10/2016, 08:28:35
    Author     : carlos.brito
--%>

<%@page import="beans.Abertas"%>
<%@page import="controller.Abertas_Controller"%>
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

<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
        String result;
        DecimalFormat formato_decimal = new DecimalFormat("###,###,###,###,###");  
        String email = request.getParameter("email");
        
            {
            System.out.println("Preparando envio do e-mail");
            Properties props = new Properties();
            /** Parâmetros de conexão com servidor Gmail */
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.socketFactory.port", "465");
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.port", "465");
            
            Authenticator auth = new Autenticar("notificacoes@ham.org.br", "@dminti35");
            Session mailSession = Session.getDefaultInstance(props, auth);
           
            
            
            /** Ativa Debug para sessão */
           // session.setDebug(true);
            try {

                  Message message = new MimeMessage(mailSession);
                  
                  message.setFrom(new InternetAddress("notificacoes@ham.org.br","Hospital Adventista de Manaus")); //Remetente

                  Address[] toUser = InternetAddress //Destinatário(s)
                  .parse(email);  
                  Address[] cc = InternetAddress //Destinatário(s)
                  .parse(email);  
                  //message.addRecipients(Message.RecipientType.CC,  cc);// se quiser enviar uma mensagem com copia oculta
                  
                 //.parse("carlos.brito@ham.org.br");  
                  //"carlos.brito@ham.org.br, joanes.cardoso@ham.org.br, vicente.sarubbi@ham.org.br"
                  message.setRecipients(Message.RecipientType.TO, toUser);
                  SimpleDateFormat data_br = new SimpleDateFormat("dd/MM/yyyy");
                  SimpleDateFormat data_dia = new SimpleDateFormat("EEEEEE");
                  SimpleDateFormat hora_br = new SimpleDateFormat("HH");
                  Date dataAtual = new Date();
                  int hora = Integer.parseInt(hora_br.format(dataAtual));
                  String boasVindas;
                  if(hora> 0 && hora < 12){
                      boasVindas = "Bom dia!";
                  }else if(hora >= 12 && hora < 18){
                      boasVindas = "Boa tarde!";
                  }
                  else {
                      boasVindas = "Boa noite!";
                  }
                  message.setSubject("Contas Abertas: ["+data_dia.format(dataAtual)+"] - "+data_br.format(dataAtual));//Assunto

                  /**** BUSCANDO INFORMAÇÕES DO BANCO DE DADOS ***/
                  String corpoDaMensagem = "<html>"+
                                           "   <head>"+
                                           "      <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>"+
                                           "      <link href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css'  rel='stylesheet'>"+
                                           "  </head>"+
                                           "  <body>"+
                                           //"  "+boasVindas+
                                           "  <center><h1>Times de Contas - Contas Abertas</h1></center>"+
                                           "<font face='Arial' size='2.5'"+
                                           
                                          // "  <div style='display: inline;'>"+
                                           
                                           "  <div class='col-lg-6' style='float: left;'>"+
                                           "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='1'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='5' ><center>Contas Interna&ccedil;&atilde;o</center></th>"+
                                           "         </tr>   "+
                                           "         <tr bgcolor='#C0C0C0' > " +
                                           "            <th width='60' align='center'>M&ecirc;s</th> " +
                                           "            <th>Contas</th> " +
                                           "            <th>Abertas</th> " +
                                           "            <th>% Fechadas</th> " +                           
                                           "            <th>R$ Abertas</th> " +                           
                                           "        </tr> " +
                                           "    </thead>";
                  
                  Abertas_Controller ac = new Abertas_Controller();
                  Abertas aberta = new Abertas();
                  List lista = ac.getContasInternacao();
                  Iterator iterator = lista.iterator();
                  corpoDaMensagem += "<tbody>";


                  while(iterator.hasNext()){
                      aberta = (Abertas) iterator.next();                      
                      
                      
                   
                    
                    
                      corpoDaMensagem += "<tr>"+
                                         "  <td align='center'>"+aberta.getMes()+"</td>"+
                                         "  <td align='right'>"+aberta.getContas()+"</td>"+
                                         "  <td align='right' bgcolor='bdecca'>"+aberta.getAbertas()+"</td>"+
                                         "  <td align='right' bgcolor='bdecca'>"+aberta.getFechadas()+"</td>"+  
                                         "  <td align='right' bgcolor='bdecca'>"+aberta.getAbertas_rs()+"</td>";

                      corpoDaMensagem += "</tr>";
                  }
                  corpoDaMensagem += "</tbody>";
                  corpoDaMensagem += "</table>";
                  corpoDaMensagem += "&nbsp;&nbsp;&nbsp;&nbsp;";
                 // corpoDaMensagem += "</div>";   
                  
                  
                //  corpoDaMensagem += "  <div class='col-lg-6' style='float: right;'>";
                  corpoDaMensagem += "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='1'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='7' >Contas Pronto Atendimento</center></th>"+
                                           "         </tr>   "+
                                           "         <tr bgcolor='#C0C0C0' > " +
                                           "            <th width='60'>M&ecirc;s</th> " +
                                           "            <th>Contas</th> " +
                                           "            <th>N&atilde;o Protoc.</th> " +
                                           "            <th >% Protoc.</th> " +
                                           "            <th>Abertas</th> " +                           
                                           "            <th>% Fechadas</th> " +
                                           "            <th>R$ Abertas</th> " +
                                           "        </tr> " +
                                           "    </thead>";
                  
                  lista = ac.getProntoAtendimento();
                  iterator = lista.iterator();
                  corpoDaMensagem += "<tbody>";
                 
                  
                  while(iterator.hasNext()){
                    
                      aberta = (Abertas) iterator.next();
                      //ffcc99
                      corpoDaMensagem += "<tr>"+
                                         "  <td align='center'>"+aberta.getMes()+"</td>"+
                                         "  <td align='right'>"+aberta.getContas()+"</td>"+
                                         "  <td align='right' bgcolor='ffcc99'>"+aberta.getNao_protoc()+"</td>"+
                                         "  <td align='right' bgcolor='ffcc99'>"+aberta.getPorc_protoc()+"</td>"+
                                         "  <td align='right' bgcolor='bdecca'>"+aberta.getAbertas()+"</td>"+
                                         "  <td align='right' bgcolor='bdecca'>"+aberta.getFechadas()+"</td>"+
                                         "  <td align='right' bgcolor='bdecca'>"+aberta.getAbertas_rs()+"</td>";  

                      corpoDaMensagem += "</tr>";
                      
                     
                  }
                  
                  corpoDaMensagem += "</tbody>";
                  corpoDaMensagem += "</table>";
                  
                  //corpoDaMensagem += "</div>";
                  
                  corpoDaMensagem += "&nbsp;&nbsp;&nbsp;&nbsp;";
                  
                  //corpoDaMensagem += "<hr />"; //linha
                  
                //  corpoDaMensagem += "<div style='float: left;'>";
                 corpoDaMensagem += "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='1'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='7' >Contas Consult&oacute;rios</center></th>"+
                                           "         </tr>   "+
                                           "         <tr bgcolor='#C0C0C0' > " +
                                           "            <th width='60'>M&ecirc;s</th> " +
                                           "            <th>Contas</th> " +
                                           "            <th>N&atilde;o Protoc.</th> " +
                                           "            <th >% Protoc.</th> " +
                                           "            <th>Abertas</th> " +                           
                                           "            <th>% Fechadas</th> " +
                                           "            <th>R$ Abertas</th> " +
                                           "        </tr> " +
                                           "    </thead>";
                  
                  lista = ac.getConsultorio();
                  iterator = lista.iterator();
                  corpoDaMensagem += "<tbody>";
                 
                  while(iterator.hasNext()){
                      aberta = (Abertas) iterator.next();
                      //ffcc99
                      corpoDaMensagem += "<tr>"+
                                         "  <td align='center'>"+aberta.getMes()+"</td>"+
                                         "  <td align='right'>"+aberta.getContas()+"</td>"+
                                         "  <td align='right' bgcolor='ffcc99'>"+aberta.getNao_protoc()+"</td>"+
                                         "  <td align='right' bgcolor='ffcc99'>"+aberta.getPorc_protoc()+"</td>"+
                                         "  <td align='right' bgcolor='bdecca'>"+aberta.getAbertas()+"</td>"+
                                         "  <td align='right' bgcolor='bdecca'>"+aberta.getFechadas()+"</td>"+  
                                         "  <td align='right' bgcolor='bdecca'>"+aberta.getAbertas_rs()+"</td>";  

                      corpoDaMensagem += "</tr>";
                  }
                 
                  corpoDaMensagem += "</tbody>";
                  corpoDaMensagem += "</table>";
                  corpoDaMensagem += "&nbsp;&nbsp;&nbsp;&nbsp;";
                //  corpoDaMensagem += "</div>";
                  
                  
                  
               //   corpoDaMensagem += "<div style='float: right;'>";
                  corpoDaMensagem += "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='1'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='7' >Contas Laborat&oacute;rio</center></th>"+
                                           "         </tr>   "+
                                           "         <tr bgcolor='#C0C0C0' > " +
                                           "            <th width='60'>M&ecirc;s</th> " +
                                           "            <th>Contas</th> " +
                                           "            <th>N&atilde;o Protoc.</th> " +
                                           "            <th >% Protoc.</th> " +
                                           "            <th>Abertas</th> " +                           
                                           "            <th>% Fechadas</th> " +
                                           "            <th>R$ R$ Abertas</th> " +
                                           "        </tr> " +
                                           "    </thead>";
                  
                  lista = ac.getLaboratorio();
                  iterator = lista.iterator();
                  corpoDaMensagem += "<tbody>";
                  while(iterator.hasNext()){
                       aberta = (Abertas) iterator.next();
                      //ffcc99
                      corpoDaMensagem += "<tr>"+
                                         "  <td align='center'>"+aberta.getMes()+"</td>"+
                                         "  <td align='right'>"+aberta.getContas()+"</td>"+
                                         "  <td align='right' bgcolor='ffcc99'>"+aberta.getNao_protoc()+"</td>"+
                                         "  <td align='right' bgcolor='ffcc99'>"+aberta.getPorc_protoc()+"</td>"+
                                         "  <td align='right' bgcolor='bdecca'>"+aberta.getAbertas()+"</td>"+
                                         "  <td align='right' bgcolor='bdecca'>"+aberta.getFechadas()+"</td>"+
                                         "  <td align='right' bgcolor='bdecca'>"+aberta.getAbertas_rs()+"</td>";  

                      corpoDaMensagem += "</tr>";
                  }
                  corpoDaMensagem += "</tbody>";
                  corpoDaMensagem += "</table>";
               //   corpoDaMensagem += "</div>";
                  
                  corpoDaMensagem += "&nbsp;&nbsp;&nbsp;&nbsp;";
                 // corpoDaMensagem += "<hr />";
                  //corpoDaMensagem += "<br>";
                  //corpoDaMensagem += "<br>";
                 
                  
                  
               //   corpoDaMensagem += "<div style='float: left;'>";
                 corpoDaMensagem += "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='1'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='7' >Contas Diagn&oacute;tico</center></th>"+
                                           "         </tr>   "+
                                           "         <tr bgcolor='#C0C0C0' > " +
                                           "            <th width='60'>M&ecirc;s</th> " +
                                           "            <th>Contas</th> " +
                                           "            <th>N&atilde;o Protoc.</th> " +
                                           "            <th >% Protoc.</th> " +
                                           "            <th>Abertas</th> " +                           
                                           "            <th>% Fechadas</th> " +
                                           "            <th>R$ Abertas</th> " +
                                           "        </tr> " +
                                           "    </thead>";
                  
                  lista = ac.getDiagnostico();
                  iterator = lista.iterator();
                  corpoDaMensagem += "<tbody>";
                  
                  while(iterator.hasNext()){
                       aberta = (Abertas) iterator.next();
                      //ffcc99
                      corpoDaMensagem += "<tr>"+
                                         "  <td align='center'>"+aberta.getMes()+"</td>"+
                                         "  <td align='right'>"+aberta.getContas()+"</td>"+
                                         "  <td align='right' bgcolor='ffcc99'>"+aberta.getNao_protoc()+"</td>"+
                                         "  <td align='right' bgcolor='ffcc99'>"+aberta.getPorc_protoc()+"</td>"+
                                         "  <td align='right' bgcolor='bdecca'>"+aberta.getAbertas()+"</td>"+
                                         "  <td align='right' bgcolor='bdecca'>"+aberta.getFechadas()+"</td>"+
                                         "  <td align='right' bgcolor='bdecca'>"+aberta.getAbertas_rs()+"</td>";  

                      corpoDaMensagem += "</tr>";
                      
                  }
                 
                  corpoDaMensagem += "</tbody>";
                  corpoDaMensagem += "</table>";
                
              //    corpoDaMensagem += "</div>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  //corpoDaMensagem += "<hr />";
                  
                  
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  //corpoDaMensagem += "<p>Atenciosamente,</p>";
                  corpoDaMensagem += "<script src='https://code.jquery.com/jquery-2.2.4.min.js'></script>" +
                                     "<script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js'></script>";
                  corpoDaMensagem += "</font>";
                  corpoDaMensagem += "</body>";
                  corpoDaMensagem += "</html>";

                  //Criando a Multipart
                  Multipart multipart = new MimeMultipart();

                  //criando a primeira parte da mensagem
                  MimeBodyPart attachment0 = new MimeBodyPart();
                  //configurando o corpodamensagem com o mime type
                  attachment0.setContent(corpoDaMensagem, "text/html; charset=UTF-8");
                  
                  
                  
                  //adicionando na multipart
                  multipart.addBodyPart(attachment0);
                  



                  message.setContent(multipart);
                  //message.setText(corpoDaMensagem);

                  /**Método para enviar a mensagem criada*/
                  System.out.print("Tentando enviar e-mail... ");
                  Transport.send(message);
                  System.out.println("E-mail enviado com sucesso!");
                  result = "Email enviado com sucesso!";
                  out.println("1");
                 } catch (MessagingException e) {
                     e.printStackTrace();
                     result = "Problema ao enviar o email";
                     out.println("0");
                     
                  }
}
       
        %>

