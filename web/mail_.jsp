<%-- 
    Document   : mail
    Created on : 27/10/2016, 08:28:35
    Author     : carlos.brito
--%>

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
        String result;
        DecimalFormat formato_decimal = new DecimalFormat("#.##");  
        String email = request.getParameter("email");
        
            {
            Properties props = new Properties();
            /** Parâmetros de conexão com servidor Gmail */
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.socketFactory.port", "465");
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.port", "465");
            
            Authenticator auth = new Autenticar("cbcarlos07@gmail.com", "brito1985.");
            Session mailSession = Session.getDefaultInstance(props, auth);
           
            
            
            /** Ativa Debug para sessão */
           // session.setDebug(true);
            try {

                  Message message = new MimeMessage(mailSession);
                  message.setFrom(new InternetAddress("carlos.brito@ham.org.br")); //Remetente

                  Address[] toUser = InternetAddress //Destinatário(s)
                 .parse("carlos.brito@ham.org.br");  
                  //"carlos.brito@ham.org.br, joanes.cardoso@ham.org.br, vicente.sarubbi@ham.org.br"
                  message.setRecipients(Message.RecipientType.TO, toUser);
                  SimpleDateFormat data_br = new SimpleDateFormat("dd/MM/yyyy");
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
                  message.setSubject("Indicador Financeiro: "+data_br.format(dataAtual));//Assunto

                  /**** BUSCANDO INFORMAÇÕES DO BANCO DE DADOS ***/
                  String corpoDaMensagem = "<html>"+
                                           "   <head>"+
                                           "      <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>"+
                                           "      <link href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css'  rel='stylesheet'>"+
                                           "  </head>"+
                                           "  <body>"+
                                           "  "+boasVindas+
                                           "  <center><h1>Indicadores Estrat&eacute;gicos</h1></center>"+
                                           "<font face='Arial' size='2.5'"+
                                           
                                           "  <div style='display: inline;'>"+
                                           
                                           "  <div class='col-lg-6' style='float: left;'>"+
                                           "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='2'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='4' ><center>Leitos</center></th>"+
                                           "         </tr>   "+
                                           "         <tr bgcolor='#C0C0C0' > " +
                                           "            <th width='300'>Indicadores</th> " +
                                           "            <th>Ontem</th> " +
                                           "            <th >M&eacute;dia</th> " +
                                           "            <th >Acumulado</th> " +                           
                                           "        </tr> " +
                                           "    </thead>";

                  Financeiro_Controller fc = new Financeiro_Controller();
                  Financeiro financeiro = new Financeiro();
                  List lista = fc.getLeitos();
                  Iterator iterator = lista.iterator();
                  corpoDaMensagem += "<tbody>";


                  while(iterator.hasNext()){
                      financeiro = (Financeiro) iterator.next();
                      String str_acum =  "";
                    if(financeiro.getAcumulado() != null)
                       str_acum = financeiro.getAcumulado();
                      corpoDaMensagem += "<tr>"+
                                         "  <td>"+financeiro.getInd_Unid()+"</td>"+
                                         "  <td align='center'>"+financeiro.getOntem()+"</td>"+
                                         "  <td align='center' bgcolor='#8ed07e'>"+financeiro.getMedia().replace(",",".")+"</td>"+
                                         "  <td align='center'>"+str_acum+"</td>";  

                      corpoDaMensagem += "</tr>";
                  }
                  corpoDaMensagem += "</tbody>";
                  corpoDaMensagem += "</table>";
                  corpoDaMensagem += "&nbsp;&nbsp;&nbsp;&nbsp;";
                  corpoDaMensagem += "</div>";   
                  
                  
                  corpoDaMensagem += "  <div class='col-lg-6' style='float: right;'>";
                  corpoDaMensagem += "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='2'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='5' ><center>Pacientes Dia (Meia Noite)</center></th>"+
                                           "         </tr>   "+
                                           "         <tr bgcolor='#C0C0C0' > " +
                                           "            <th width='300'>Unidade</th> " +
                                           "            <th>Leitos</th> " +
                                           "            <th>Ontem</th> " +
                                           "            <th >M&eacute;dia</th> " +
                                           "            <th>Acumulado</th> " +                           
                                           "        </tr> " +
                                           "    </thead>";

                  lista = fc.getPacienteInternado();
                  iterator = lista.iterator();
                  corpoDaMensagem += "<tbody>";
                  int leitos = 0;
                  int ontem = 0;
                  double media = 0;
                  int acumulado = 0;
                  int total = 0;
                  
                  while(iterator.hasNext()){
                      total++;
                      financeiro = (Financeiro) iterator.next();
                      String str_acum =  "";
                    if(financeiro.getAcumulado() != null)
                       str_acum = financeiro.getAcumulado();
                      corpoDaMensagem += "<tr>"+
                                         "  <td>"+financeiro.getInd_Unid()+"</td>"+
                                         "  <td align='center'>"+financeiro.getLeito()+"</td>"+
                                         "  <td align='center'>"+financeiro.getOntem()+"</td>"+
                                         "  <td align='center' bgcolor='#8ed07e'>"+financeiro.getMedia().replace(",",".")+"</td>"+
                                         "  <td align='center'>"+str_acum+"</td>";  

                      corpoDaMensagem += "</tr>";
                      leitos += Integer.parseInt(financeiro.getLeito());
                      ontem  += Integer.parseInt(financeiro.getOntem());
                      media  += Double.parseDouble(financeiro.getMedia().replace(",",".")) ;
                      
                      acumulado  += Integer.parseInt(str_acum) ;
                      
                  }
                  corpoDaMensagem += "<tr>"+
                                         "  <td> TOTAL </td>"+
                                         "  <td align='center'>"+leitos+"</td>"+
                                         "  <td align='center'>"+ontem+"</td>"+
                                         "  <td align='center' bgcolor='#8ed07e'>"+String.format("%.2f", media / total)+"</td>"+
                                         "  <td align='center'>"+acumulado+"</td>";  
                  corpoDaMensagem += "</tbody>";
                  corpoDaMensagem += "</table>";
                  
                  corpoDaMensagem += "</div>";
                  
                  corpoDaMensagem += "<br >";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br >";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br >";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br >";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  
                  corpoDaMensagem += "<hr />";
                  
                   
                  corpoDaMensagem += "<div style='float: left;'>";
                  corpoDaMensagem += "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='2'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='4'><center>Centro Cir&uacute;rgico</center></th>"+
                                           "         </tr>   "+
                                           "         <tr bgcolor='#C0C0C0' > " +
                                           "            <th width='300'>Indicador</th> " +
                                           "            <th>Ontem</th> " +
                                           "            <th >M&eacute;dia</th> " +
                                           "            <th width='70'>Total</th> " +                           
                                           "        </tr> " +
                                           "    </thead>";

                  lista = fc.getCentroCirurgico();
                  iterator = lista.iterator();
                  corpoDaMensagem += "<tbody>";
                 
                  while(iterator.hasNext()){
                      financeiro = (Financeiro) iterator.next();
                      String str_acum = "";
                      String str_ontem = "";
                      String str_media = "";
                 
                      
                    if(financeiro.getOntem() != null)
                          str_ontem = financeiro.getOntem();
                    
                    if(financeiro.getMedia() != null)
                           str_media = financeiro.getMedia().replace(",",".");
                    
                    if(financeiro.getAcumulado() != null)
                        str_acum = financeiro.getAcumulado();
                      corpoDaMensagem += "<tr>"+
                                         "  <td>"+financeiro.getInd_Unid()+"</td>"+
                                         "  <td align='center'>"+str_ontem+"</td>"+
                                         "  <td align='center' bgcolor='#8ed07e'>"+str_media+"</td>"+
                                         "  <td align='center'>"+str_acum+"</td>";  
                      corpoDaMensagem += "</tr>";
                
                  }
                 
                  corpoDaMensagem += "</tbody>";
                  corpoDaMensagem += "</table>";

                  corpoDaMensagem += "</div>";
                  
                  
                  
                  corpoDaMensagem += "<div style='float: right;'>";
                  corpoDaMensagem += "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='2'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='4'><center>Hemodin&acirc;mica</center></th>"+
                                           "         </tr>   "+
                                           "         <tr bgcolor='#C0C0C0' > " +
                                           "            <th width='300'>Indicador</th> " +
                                           "            <th>Ontem</th> " +
                                           "            <th >M&eacute;dia</th> " +
                                           "            <th>Acumulado</th> " +                           
                                           "        </tr> " +
                                           "    </thead>";

                  lista = fc.getHemodinamica();
                  iterator = lista.iterator();
                  corpoDaMensagem += "<tbody>";
                  while(iterator.hasNext()){
                      financeiro = (Financeiro) iterator.next();
                      String str_acum =  "";
                      String str_ontem = "";;
                      String str_media = "";;
                      
                    if(financeiro.getOntem() != null)
                          str_ontem = financeiro.getOntem();
                    
                    if(financeiro.getMedia() != null)
                           str_media = financeiro.getMedia().replace(",",".");
                    
                    if(financeiro.getAcumulado() != null)
                       str_acum = financeiro.getAcumulado();
                      corpoDaMensagem += "<tr>"+
                                         "  <td>"+financeiro.getInd_Unid()+"</td>"+
                                         "  <td align='center'>"+str_ontem+"</td>"+
                                         "  <td align='center' bgcolor='#8ed07e'>"+str_media+"</td>"+
                                         "  <td align='center'>"+str_acum+"</td>";  
                      corpoDaMensagem += "</tr>";
                  }
                  corpoDaMensagem += "</tbody>";
                  corpoDaMensagem += "</table>";
                  corpoDaMensagem += "</div>";
                  
                  corpoDaMensagem += "<br >";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br >";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br >";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br >";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  
                  corpoDaMensagem += "<hr />";
                  corpoDaMensagem += "<div style='float: left;'>";
                  corpoDaMensagem += "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='2'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='4'><center>Diagn&oacute;tico Por Imagem</center></th>"+
                                           "         </tr>   "+
                                           "         <tr bgcolor='#C0C0C0' > " +
                                           "            <th width='300'>Indicador</th> " +
                                           "            <th>Ontem</th> " +
                                           "            <th >M&eacute;dia</th> " +
                                           "            <th>Acumulado</th> " +                           
                                           "        </tr> " +
                                           "    </thead>";

                  lista = fc.getDiagnoticoImagem();
                  iterator = lista.iterator();
                  corpoDaMensagem += "<tbody>";
                  total = 0;
                  ontem = 0;
                  acumulado = 0;
                  media = 0;
                  while(iterator.hasNext()){
                      financeiro = (Financeiro) iterator.next();
                      String str_acum =  "";
                      String str_ontem = "";;
                      String str_media = "";;
                      total++;
                    if(financeiro.getOntem() != null)
                          str_ontem = financeiro.getOntem();
                    
                    if(financeiro.getMedia() != null)
                           str_media = financeiro.getMedia().replace(",",".");
                    
                    if(financeiro.getAcumulado() != null)
                       str_acum = financeiro.getAcumulado();
                      corpoDaMensagem += "<tr>"+
                                         "  <td>"+financeiro.getInd_Unid()+"</td>"+
                                         "  <td align='center'>"+str_ontem+"</td>"+
                                         "  <td align='center' bgcolor='#8ed07e'>"+str_media+"</td>"+
                                         "  <td align='center'>"+str_acum+"</td>";  
                      corpoDaMensagem += "</tr>";
                      
                      ontem  += Integer.parseInt(str_ontem);
                      media  += Double.parseDouble(str_media) ;
                      acumulado  += Integer.parseInt(str_acum) ;
                      
                  }
                  corpoDaMensagem += "<tr>"+
                                         "  <td> TOTAL </td>"+
                                         "  <td align='center'>"+ontem+"</td>"+
                                         "  <td align='center' bgcolor='#8ed07e'>"+String.format("%.2f", media / total) +"</td>"+
                                         "  <td align='center'>"+acumulado+"</td>";  
                  corpoDaMensagem += "</tbody>";
                  corpoDaMensagem += "</table>";
                  corpoDaMensagem += "</div>";
                  
                  corpoDaMensagem += "<div style='float: right;'>";
                  corpoDaMensagem += "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='2'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='4'><center>Laborat&oacute;rio</center></th>"+
                                           "         </tr>   "+
                                           "         <tr bgcolor='#C0C0C0' > " +
                                           "            <th width='300'>Tipo</th> " +
                                           "            <th>Ontem</th> " +
                                           "            <th >M&eacute;dia</th> " +
                                           "            <th>Acumulado</th> " +                           
                                           "        </tr> " +
                                           "    </thead>";

                  lista = fc.getLaboratorio();
                  iterator = lista.iterator();
                  corpoDaMensagem += "<tbody>";
                  total = 0;
                  ontem = 0;
                  media = 0;
                  acumulado = 0;
                  while(iterator.hasNext()){
                      financeiro = (Financeiro) iterator.next();
                      String str_acum =  "";
                      String str_ontem = "";;
                      String str_media = "";;
                      total++;
                    if(financeiro.getOntem() != null)
                          str_ontem = financeiro.getOntem();
                    
                    if(financeiro.getMedia() != null)
                           str_media = financeiro.getMedia().replace(",",".");
                    
                    if(financeiro.getAcumulado() != null)
                       str_acum = financeiro.getAcumulado();
                      corpoDaMensagem += "<tr>"+
                                         "  <td>"+financeiro.getInd_Unid()+"</td>"+
                                         "  <td align='center'>"+str_ontem+"</td>"+
                                         "  <td align='center' bgcolor='#8ed07e'>"+str_media+"</td>"+
                                         "  <td align='center'>"+str_acum+"</td>";  
                      corpoDaMensagem += "</tr>";
                      ontem  += Integer.parseInt(str_ontem);
                      media  += Double.parseDouble(str_media) ;                      
                      acumulado  += Integer.parseInt(str_acum) ;
                      
                  }
                  corpoDaMensagem += "<tr>"+
                                         "  <td> TOTAL </td>"+
                                         "  <td align='center'>"+ontem+"</td>"+
                                         "  <td align='center' bgcolor='#8ed07e'>"+String.format("%.2f", media / total)+"</td>"+
                                         "  <td align='center'>"+acumulado+"</td>";  
                  corpoDaMensagem += "</tbody>";
                  corpoDaMensagem += "</table>";
                  corpoDaMensagem += "</div>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br >";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br >";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br >";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  
                  corpoDaMensagem += "<hr />";
                  corpoDaMensagem += "<div style='float: left;'>";
                  corpoDaMensagem += "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='2'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='4'><center>Consult&oacute;rio</center></th>"+
                                           "         </tr>   "+
                                           "         <tr bgcolor='#C0C0C0' > " +
                                           "            <th width='300'>Tipo</th> " +
                                           "            <th>Ontem</th> " +
                                           "            <th >M&eacute;dia</th> " +
                                           "            <th>Acumulado</th> " +                           
                                           "        </tr> " +
                                           "    </thead>";

                  lista = fc.getConsultorio();
                  iterator = lista.iterator();
                  corpoDaMensagem += "<tbody>";
                  while(iterator.hasNext()){
                      financeiro = (Financeiro) iterator.next();
                      String str_acum =  "";
                      String str_ontem = "";;
                      String str_media = "";;
                      
                    if(financeiro.getOntem() != null)
                          str_ontem = financeiro.getOntem();
                    
                    if(financeiro.getMedia() != null)
                           str_media = financeiro.getMedia().replace(",",".");
                    
                    if(financeiro.getAcumulado() != null)
                       str_acum = financeiro.getAcumulado();
                      corpoDaMensagem += "<tr>"+
                                         "  <td>"+financeiro.getInd_Unid()+"</td>"+
                                         "  <td align='center'>"+str_ontem+"</td>"+
                                         "  <td align='center' bgcolor='#8ed07e'>"+str_media+"</td>"+
                                         "  <td align='center'>"+str_acum+"</td>";  
                      corpoDaMensagem += "</tr>";
                  }
                  corpoDaMensagem += "</tbody>";
                  corpoDaMensagem += "</table>";
                  corpoDaMensagem += "</div>";
                  
                  
                  corpoDaMensagem += "<div style='float: right;'>";
                  corpoDaMensagem += "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='2'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='4'><center>Ambulat&oacute;rio Cardiologia</center></th>"+
                                           "         </tr>   "+
                                           "         <tr bgcolor='#C0C0C0' > " +
                                           "            <th width='300'>Exame</th> " +
                                           "            <th>Ontem</th> " +
                                           "            <th >M&eacute;dia</th> " +
                                           "            <th>Acumulado</th> " +                           
                                           "        </tr> " +
                                           "    </thead>";

                  lista = fc.getAmbulatorioCardiologia();
                  iterator = lista.iterator();
                  corpoDaMensagem += "<tbody>";
                  total = 0;
                  media = 0;
                  ontem = 0;
                  acumulado = 0;
                  while(iterator.hasNext()){
                      financeiro = (Financeiro) iterator.next();
                      String str_acum =  "";
                      String str_ontem = "";;
                      String str_media = "";;
                      total++;
                    if(financeiro.getOntem() != null)
                          str_ontem = financeiro.getOntem();
                    
                    if(financeiro.getMedia() != null)
                           str_media = financeiro.getMedia().replace(",",".");
                    
                    if(financeiro.getAcumulado() != null)
                       str_acum = financeiro.getAcumulado();
                      corpoDaMensagem += "<tr>"+
                                         "  <td>"+financeiro.getInd_Unid()+"</td>"+
                                         "  <td align='center'>"+str_ontem+"</td>"+
                                         "  <td align='center' bgcolor='#8ed07e'>"+str_media+"</td>"+
                                         "  <td align='center'>"+str_acum+"</td>";  
                      corpoDaMensagem += "</tr>";
                      ontem  += Integer.parseInt(str_ontem);
                      media  += Double.parseDouble(str_media) ;
                      acumulado  += Integer.parseInt(str_acum) ;
                      
                  }
                  corpoDaMensagem += "<tr>"+
                                         "  <td> TOTAL </td>"+
                                         "  <td align='center'>"+ontem+"</td>"+
                                         "  <td align='center' bgcolor='#8ed07e'>"+String.format("%.2f", media / total )+"</td>"+
                                         "  <td align='center'>"+acumulado+"</td>";  
                  corpoDaMensagem += "</tbody>";
                  corpoDaMensagem += "</table>";
                  corpoDaMensagem += "</div>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br >";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br >";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br >";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<hr />";
                  
                  
                  
                   corpoDaMensagem += "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='2'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='4'><center>Pronto Atendimento</center></th>"+
                                           "         </tr>   "+
                                           "         <tr bgcolor='#C0C0C0' > " +
                                           "            <th width='300'>Tipo</th> " +
                                           "            <th>Ontem</th> " +
                                           "            <th >M&eacute;dia</th> " +
                                           "            <th>Acumulado</th> " +                           
                                           "        </tr> " +
                                           "    </thead>";

                  lista = fc.getProntoAtendimento();
                  iterator = lista.iterator();
                  corpoDaMensagem += "<tbody>";
                  while(iterator.hasNext()){
                      financeiro = (Financeiro) iterator.next();
                      String str_acum =  "";
                      String str_ontem = "";;
                      String str_media = "";;
                      
                    if(financeiro.getOntem() != null)
                          str_ontem = financeiro.getOntem();
                    
                    if(financeiro.getMedia() != null)
                           str_media = financeiro.getMedia().replace(",",".");
                    
                    if(financeiro.getAcumulado() != null)
                       str_acum = financeiro.getAcumulado();
                      corpoDaMensagem += "<tr>"+
                                         "  <td>"+StringUtils.capitalize(financeiro.getInd_Unid())+"</td>"+
                                         "  <td align='center'>"+str_ontem+"</td>"+
                                         "  <td align='center' bgcolor='#8ed07e'>"+str_media+"</td>"+
                                         "  <td align='center'>"+str_acum+"</td>";  
                      corpoDaMensagem += "</tr>";
                  }
                  corpoDaMensagem += "</tbody>";
                  corpoDaMensagem += "</table>";
                  corpoDaMensagem += "</div>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<hr />";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<p>Atenciosamente,</p>";
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
                  Transport.send(message);
                  System.out.println("E-mail enviado com sucesso!");
                  result = "Email enviado com sucesso!";
                 } catch (MessagingException e) {
                     e.printStackTrace();
                     result = "Problema ao enviar o email";
                     
                  }
}
       
        %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Indicadores</title>
        
        <link href="css/bootstrap.min.css"  rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link rel="shortcut icon" href="img/ham.png">
    </head>
    <body>
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <!--<span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        -->
                    </button>
                    <a class="navbar-brand" href=".">Indicadores</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">                       
                        
                    </ul>
                </div>
            </div>
        </nav>
        <div id="main" class="container">
                    <br>
                    <br>
                    <br>
                    <br>
                 <center>
                     <h1>Informa&ccedil;&atilde;o de envio de e-mail</h1>
                 </center>
                <p align="center">
                <% 
                   out.println(result + "\n");
                %>
                </p>
        </div>  
    </body>
</html>
