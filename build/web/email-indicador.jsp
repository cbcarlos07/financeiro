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
<%@page import="controller.Indicador_Controller"%>
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
                  message.setSubject("Indicador Financeiro: ["+data_dia.format(dataAtual)+"] - "+data_br.format(dataAtual));//Assunto

                  /**** BUSCANDO INFORMAÇÕES DO BANCO DE DADOS ***/
                  String corpoDaMensagem = "<html>"+
                                           "   <head>"+
                                           "      <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>"+
                                           "      <link href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css'  rel='stylesheet'>"+
                                           "  </head>"+
                                           "  <body>"+
                                           //"  "+boasVindas+
                                           "  <center><h1>Indicadores Estrat&eacute;gicos</h1></center>"+
                                           "<font face='Arial' size='2.5'"+
                                           
                                          // "  <div style='display: inline;'>"+
                                           
                                           "  <div class='col-lg-6' style='float: left;'>"+
                                           "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='1'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='4' bgcolor='bdecca'><center>Leitos</center></th>"+
                                           "         </tr>   "+
                                           "         <tr bgcolor='#C0C0C0' > " +
                                           "            <th width='300'>Indicadores</th> " +
                                           "            <th>Ontem</th> " +
                                           "            <th >M&eacute;dia</th> " +
                                           "            <th >Acumulado</th> " +                           
                                           "        </tr> " +
                                           "    </thead>";
                  
                  Indicador_Controller fc = new Indicador_Controller();
                  Financeiro financeiro = new Financeiro();
                  List lista = fc.getLeitos();
                  Iterator iterator = lista.iterator();
                  corpoDaMensagem += "<tbody>";


                  while(iterator.hasNext()){
                      financeiro = (Financeiro) iterator.next();
                      String str_acum =  "";
                      String str_media = "";
                      String media_cor = "bgcolor='#DDDDDD'";
                      String branco = "bgcolor='#DDDDDD' ";
                    if(financeiro.getAcumulado() != null){
                       str_acum = financeiro.getAcumulado();
                       branco = "";
                    } 
                    if(financeiro.getMedia() != null)
                    {
                        str_media = financeiro.getMedia();
                        media_cor = "bgcolor='bdecca'";
                     
                    }
                    
                    
                      corpoDaMensagem += "<tr>"+
                                         "  <td>"+financeiro.getInd_Unid()+"</td>"+
                                         "  <td align='right'>"+financeiro.getOntem()+"</td>"+
                                         "  <td align='right' "+media_cor+">"+str_media+"</td>"+
                                         "  <td align='right' "+branco+">"+str_acum+"</td>";  

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
                                           "               <th colspan='5' bgcolor='bdecca'><center>Pacientes Dia (Meia Noite)</center></th>"+
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
                      String str_media =  "";
                      String branco_total = "bgcolor='DDDDDD' ";
                      String branco_media = "bgcolor='DDDDDD' ";
                      if(financeiro.getMedia() != null){
                          str_media = financeiro.getMedia();
                          branco_media = "bgcolor='bdecca'";
                      }
                       
                    if(financeiro.getAcumulado() != null){
                       str_acum = financeiro.getAcumulado();
                       branco_total = "";
                    }
                      //System.out.println("Media pacientes: "+financeiro.getMedia());
                      corpoDaMensagem += "<tr>"+
                                         "  <td>"+financeiro.getInd_Unid()+"</td>"+
                                         "  <td align='right'>"+financeiro.getLeito()+"</td>"+
                                         "  <td align='right'>"+financeiro.getOntem()+"</td>"+
                                         "  <td align='right' "+branco_media+">"+str_media+"</td>"+
                                         "  <td align='right'"+branco_total+">"+str_acum+"</td>";  

                      corpoDaMensagem += "</tr>";
                      
                      leitos += Integer.parseInt(financeiro.getLeito());
                      ontem  += Integer.parseInt(financeiro.getOntem());
                      try{//caso os numeros vieram vazios
                      media  += Double.parseDouble(str_media.replace(",",".")) ;
                      }catch(Exception e){
                      media += 0;
                      }
                      try{ //caso os numeros vieram vazios
                      acumulado  += Integer.parseInt(str_acum) ;
                      }catch(Exception e){}
                  }
                  corpoDaMensagem += "<tr style='font-size: 15; font-weight: bold;'>"+
                                         "  <th align='left'> TOTAL </th>"+
                                         "  <th align='right'>"+leitos+"</th>"+
                                         "  <th align='right'>"+ontem+"</th>"+
                                         "  <th align='right' bgcolor='#bdecca'>"+String.format("%.2f", media / total)+"</th>"+
                                         "  <th align='right'>"+acumulado+"</th>";  
                  corpoDaMensagem += "</tbody>";
                  corpoDaMensagem += "</table>";
                  
                  //corpoDaMensagem += "</div>";
                  
                  corpoDaMensagem += "&nbsp;&nbsp;&nbsp;&nbsp;";
                  corpoDaMensagem += "<hr />"; //linha
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  
                  
                  
                  
                  
                   
                //  corpoDaMensagem += "<div style='float: left;'>";
                  corpoDaMensagem += "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='1'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='4' bgcolor='#ffe389'><center>Centro Cir&uacute;rgico</center></th>"+
                                           "         </tr>   "+
                                           "         <tr bgcolor='#C0C0C0' > " +
                                           "            <th width='300' >Indicador</th> " +
                                           "            <th>Ontem</th> " +
                                           "            <th >M&eacute;dia</th> " +
                                           "            <th width='70'>Acumulado</th> " +                           
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
                      String branco_total = "bgcolor='DDDDDD' ";
                      String branco_media = "bgcolor='DDDDDD' ";
                      
                    if(financeiro.getOntem() != null)
                          str_ontem = financeiro.getOntem();
                    
                    if(financeiro.getMedia() != null){
                           str_media = financeiro.getMedia();
                           branco_media = "bgcolor='ffe389'";
                    }    
                    
                    if(financeiro.getAcumulado() != null){
                        str_acum = financeiro.getAcumulado();
                        branco_total = "";
                    }  
                    
                      if(financeiro.getInd_Unid().equals("Top 5")){ //CASO O TEXTO SEJA IGUAL A TOP 5 -- ESSE CAMPO PODERIA TER SIDO SEPARADO NO BANCO MAS...
                            corpoDaMensagem += "<tr>"+
                                               "  <td colspan='4' bgcolor='#C0C0C0'><center>"+financeiro.getInd_Unid()+"</center></td>";
                            corpoDaMensagem += "</tr>";    
                      }else{
                        corpoDaMensagem += "<tr>"+
                                           "  <td>"+financeiro.getInd_Unid()+"</td>"+
                                           "  <td align='right'>"+str_ontem+"</td>"+
                                           "  <td align='right' "+branco_media+">"+str_media+"</td>"+
                                           "  <td align='right' "+branco_total+">"+str_acum+"</td>";  
                        corpoDaMensagem += "</tr>";
                     }
                  }
                 
                  corpoDaMensagem += "</tbody>";
                  corpoDaMensagem += "</table>";
                  corpoDaMensagem += "&nbsp;&nbsp;&nbsp;&nbsp;";
                //  corpoDaMensagem += "</div>";
                  
                  
                  
               //   corpoDaMensagem += "<div style='float: right;'>";
                  corpoDaMensagem += "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='1'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='4' bgcolor='#ffe389'><center>Hemodin&acirc;mica</center></th>"+
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
                           str_media = financeiro.getMedia();
                    
                    if(financeiro.getAcumulado() != null)
                       str_acum = financeiro.getAcumulado();
                    
                      if(financeiro.getInd_Unid().equals("Top 5")){ //CASO O TEXTO SEJA IGUAL A TOP 5 -- ESSE CAMPO PODERIA TER SIDO SEPARADO NO BANCO MAS...
                            corpoDaMensagem += "<tr>"+
                                               "  <td colspan='4' bgcolor='#C0C0C0'><center>"+financeiro.getInd_Unid()+"</center></td>";
                            corpoDaMensagem += "</tr>";    
                      }else{
                    
                                corpoDaMensagem += "<tr>"+
                                                   "  <td>"+financeiro.getInd_Unid()+"</td>"+
                                                   "  <td align='right'>"+str_ontem+"</td>"+
                                                   "  <td align='right' bgcolor='#ffe389'>"+str_media+"</td>"+
                                                   "  <td align='right'>"+str_acum+"</td>";  
                                corpoDaMensagem += "</tr>";
                      }
                  }    
                  corpoDaMensagem += "</tbody>";
                  corpoDaMensagem += "</table>";
               //   corpoDaMensagem += "</div>";
                  
                  corpoDaMensagem += "&nbsp;&nbsp;&nbsp;&nbsp;";
                  corpoDaMensagem += "<hr />";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                 
                  
                  
               //   corpoDaMensagem += "<div style='float: left;'>";
                  corpoDaMensagem += "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='1'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='4' bgcolor='#8fbae4'><center>Diagn&oacute;stico por Imagem</center></th>"+
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
                           str_media = financeiro.getMedia();
                    
                    if(financeiro.getAcumulado() != null)
                       str_acum = financeiro.getAcumulado();
                      corpoDaMensagem += "<tr>"+
                                         "  <td>"+financeiro.getInd_Unid()+"</td>"+
                                         "  <td align='right'>"+str_ontem+"</td>"+
                                         "  <td align='right' bgcolor='#8fbae4'>"+str_media+"</td>"+
                                         "  <td align='right'>"+formato_decimal.format(Integer.parseInt(str_acum))+"</td>";  
                      corpoDaMensagem += "</tr>";
                      
                      ontem  += Integer.parseInt(str_ontem);
                      media  += Double.parseDouble(str_media.replace(",",".")) ;
                      acumulado  += Integer.parseInt(str_acum) ;
                      
                  }
                  corpoDaMensagem += "<tr>"+
                                         "  <th align='left'> TOTAL </th>"+
                                         "  <th align='right'>"+ontem+"</th>"+
                                         "  <th align='right' bgcolor='#8fbae4'>"+String.format("%.2f", media / total) +"</th>"+
                                         "  <th align='right'>"+formato_decimal.format(acumulado)+"</th>";  
                  corpoDaMensagem += "</tbody>";
                  corpoDaMensagem += "</table>";
                //  corpoDaMensagem += "</div>";
                  corpoDaMensagem += "&nbsp;&nbsp;&nbsp;&nbsp;";
               //  corpoDaMensagem += "<div style='float: right;'>";
                  corpoDaMensagem += "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='1'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='4' bgcolor='#8fbae4'><center>Laborat&oacute;rio</center></th>"+
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
                           str_media = financeiro.getMedia();
                    
                    if(financeiro.getAcumulado() != null)
                       str_acum = financeiro.getAcumulado();
                      corpoDaMensagem += "<tr>"+
                                         "  <td>"+financeiro.getInd_Unid()+"</td>"+
                                         "  <td align='right'>"+str_ontem+"</td>"+
                                         "  <td align='right' bgcolor='#8fbae4'>"+str_media+"</td>"+
                                         "  <td align='right'>"+formato_decimal.format(Integer.parseInt(str_acum))+"</td>";  
                      corpoDaMensagem += "</tr>";
                      ontem  += Integer.parseInt(str_ontem);
                      media  += Double.parseDouble(str_media.replace(".","").replace(",",".")) ;                      
                      acumulado  += Integer.parseInt(str_acum) ;
                      
                  }
                  corpoDaMensagem += "<tr>"+
                                         "  <th align='left'> TOTAL </th>"+
                                         "  <th align='right'>"+formato_decimal.format(ontem)+"</th>"+
                                         "  <th align='right' bgcolor='#8fbae4'>"+String.format("%.2f", media / total)+"</th>"+
                                         "  <th align='right'>"+formato_decimal.format(acumulado)+"</th>";  
                  corpoDaMensagem += "</tbody>";
                  corpoDaMensagem += "</table>";
                 // corpoDaMensagem += "</div>";
                 corpoDaMensagem += "&nbsp;&nbsp;&nbsp;&nbsp;";
                  corpoDaMensagem += "<hr />";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  
                  
                  
                //  corpoDaMensagem += "<div style='float: left;'>";
                  corpoDaMensagem += "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='1'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='4' bgcolor='#FA7F7F' ><center>Consult&oacute;rio</center></th>"+
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
                           str_media = financeiro.getMedia();
                    
                    if(financeiro.getAcumulado() != null)
                       str_acum = financeiro.getAcumulado();
                      corpoDaMensagem += "<tr>"+
                                         "  <td>"+financeiro.getInd_Unid()+"</td>"+
                                         "  <td align='right'>"+str_ontem+"</td>"+
                                         "  <td align='right' bgcolor='#FA7F7F'>"+str_media+"</td>"+
                                         "  <td align='right'>"+formato_decimal.format(Integer.parseInt(str_acum))+"</td>";  
                      corpoDaMensagem += "</tr>";
                  }
                  corpoDaMensagem += "</tbody>";
                  corpoDaMensagem += "</table>";
                //  corpoDaMensagem += "</div>";
                  
                   corpoDaMensagem += "&nbsp;&nbsp;&nbsp;&nbsp;";
                 // corpoDaMensagem += "<div style='float: right;'>";
                  corpoDaMensagem += "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='1'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='4' bgcolor='#FA7F7F'><center>Ambulat&oacute;rio Cardiologia</center></th>"+
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
                           str_media = financeiro.getMedia();
                    
                    if(financeiro.getAcumulado() != null)
                       str_acum = financeiro.getAcumulado();
                      corpoDaMensagem += "<tr>"+
                                         "  <td>"+financeiro.getInd_Unid()+"</td>"+
                                         "  <td align='right'>"+str_ontem+"</td>"+
                                         "  <td align='right' bgcolor='#FA7F7F'>"+str_media+"</td>"+
                                         "  <td align='right'>"+formato_decimal.format(Integer.parseInt(str_acum))+"</td>";  
                      corpoDaMensagem += "</tr>";
                      ontem  += Integer.parseInt(str_ontem);
                      try{
                      media  += Double.parseDouble(str_media.replace(",",".")) ;
                      }catch(Exception e){}
                      acumulado  += Integer.parseInt(str_acum) ;
                      
                  }
                  String med_total = "0";
                  if(media > 0){
                      
                      med_total = String.format("%.2f", media / total );
                  }
                  corpoDaMensagem += "<tr>"+
                                         "  <th align='left'> TOTAL </th>"+
                                         "  <th align='right'>"+ontem+"</th>"+
                                         "  <th align='right' bgcolor='#FA7F7F'>"+med_total+"</th>"+
                                         "  <th align='right'>"+formato_decimal.format(acumulado)+"</th>";  
                  corpoDaMensagem += "</tbody>";
                  corpoDaMensagem += "</table>";
                 // corpoDaMensagem += "</div>";
                  corpoDaMensagem += "&nbsp;&nbsp;&nbsp;&nbsp;";
                  corpoDaMensagem += "<hr />";
                  corpoDaMensagem += "<br>";
                  corpoDaMensagem += "<br>";
                  
                  
                  
                  
                  
                   corpoDaMensagem += "    <table class='table table-striped table-hover' cellspacing='0' cellpadding='0' border='1'>  " +
                                           "      <thead> " +
                                           "         <tr >   "+
                                           "               <th colspan='4' bgcolor='#f8c4a1'><center>Pronto Atendimento</center></th>"+
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
                  acumulado = 0;
                  media = 0;
                  ontem = 0;
                  total = 0;
                  while(iterator.hasNext()){
                      total++;
                      financeiro = (Financeiro) iterator.next();
                      String str_acum =  "";
                      String str_ontem = "";;
                      String str_media = "";;
                      
                    if(financeiro.getOntem() != null)
                          str_ontem = financeiro.getOntem();
                    
                    if(financeiro.getMedia() != null)
                           str_media = financeiro.getMedia();
                    
                    if(financeiro.getAcumulado() != null)
                       str_acum = financeiro.getAcumulado();
                      corpoDaMensagem += "<tr>"+
                                         "  <td>"+financeiro.getInd_Unid()+"</td>"+
                                         "  <td align='right'>"+str_ontem+"</td>"+
                                         "  <td align='right' bgcolor='#f8c4a1'>"+str_media+"</td>"+
                                         "  <td align='right'>"+formato_decimal.format(Integer.parseInt(str_acum))+"</td>";  
                      corpoDaMensagem += "</tr>";
                      ontem  += Integer.parseInt(str_ontem);
                      try{
                      media  += Double.parseDouble(str_media.replace(",",".")) ;
                      }catch(Exception e){}
                      acumulado  += Integer.parseInt(str_acum) ;
                      System.out.println("Acumulado: "+formato_decimal.format(acumulado));
                      
                  }
                  med_total = "0";
                  if(media > 0){
                      
                      med_total = String.format("%.2f", media / total );
                  }
                  corpoDaMensagem += "<tr>"+
                                         "  <th align='left'> TOTAL </th>"+
                                         "  <th align='right'>"+ontem+"</th>"+
                                         "  <th align='right' bgcolor='#f8c4a1'>"+med_total+"</th>"+
                                         "  <th align='right'>"+formato_decimal.format(acumulado)+"</th>";  
                  
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

