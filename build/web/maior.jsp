<%-- 
    Document   : jeum
    Created on : 18/08/2016, 09:07:43
    Author     : CARLOS
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contas Maior que 50 mill</title>
        
        <link href="css/bootstrap.min.css"  rel="stylesheet">
        <link href="css/jquery.waiting.css"  rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link rel="shortcut icon" href="img/ham.png">
        
        <script src="js/jquery.min.js"></script>
   <!--     
        <link href='css/nprogress.css' rel='stylesheet' />
        <script src='js/jquery-1.11.2.min.js'></script>
        <script src='js/nprogress.js'></script>
       --> 
        
        
        <script src="js/jquery.min.js"></script>
        <script src="js/jquery.waiting.js"></script>
        <script >
               $(document).ready(function(){
			$(".jquery-waiting-base-container").waiting({modo:"slow"});
                 });
        </script>
        <link href="css/pace.css" rel="stylesheet" />
       <script>
            paceOptions = {
              elements: true
            };
          </script>
         <script src="js/pace.min.js"></script>
       
       
    </head>
    <body >
       <div  class="jquery-waiting-base-container">
            <p>Carregando p&aacute;gina.</p>
            <img src="img/loader.gif" width="120" height="120">
        </div>
            
        <c:import url="menu.jsp" /> 
        
        <hr />
        
 

        <jsp:useBean id="cc" class="controller.Maior_Controller" />
        
        <div id="main" class="container ">
            <div id="list" class="row col-lg-12 " >
                <center><h2>Pacientes internados com conta maior que R$ 50.000</h2></center>
                <div class="table-responsive col-md-12">
                    
                    <table class="table table-striped table-hover" cellspacing="0" cellpadding="0" >
                        <thead>
                            <tr>
                                <th colspan="7"><center>Contas Abertas</center></th>
                            </tr>
                            <tr>    
                                <th>Data de Atendimento</th>
                                <th>Atendimento</th>
                                <th>Paciente</th>
                                <th>Idade</th>
                                <th>Conv&ecirc;nio</th>
                                <th>Setor</th>
                                <th>Perman&ecirc;cia</th>
                                <th>Valor Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="conta" items="${cc.maior}" >
                                <tr>
                                     <c:if test="${empty conta.data}">
                                         <td colspan="7">${conta.permanencia}</td>
                                         <td>${conta.valor}</td>   
                                     </c:if>
                                    <c:if test="${not empty conta.data}">
                                        <td><fmt:formatDate value="${conta.data}" pattern="dd/MM/yyyy" /></td>
                                        <td>${conta.atendimento}</td>
                                        <td>${conta.paciente}</td>                                        
                                        <td>${conta.idade}</td>
                                        <td>${conta.convenio}</td>
                                        <td>${conta.setor}</td>
                                        <td>${conta.permanencia}</td>
                                        <td>${conta.valor}</td>   
                                     </c:if>                               
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <hr />
                
                
                
                
                <div >
                    <%
                      SimpleDateFormat format = new SimpleDateFormat("EEEE, dd 'de' MMMM 'de' yyyy");
                      String dataAtual = format.format(new Date());
                      String msg = "Manaus, "+dataAtual+". Obs: A atualiza&ccedil;&atilde;o est&aacute; sendo a cada 2 minutos, para atualizar antes pressione a tecla F5";
                      out.println(msg);
                      
                    %>
                    
                </div>
            </div>
            
        </div>   
       <!-- 
        <script>
         NProgress.start();   
         NProgress.done();
        // setTimeout(function() { NProgress.done(); $('.fade').toggleClass('change_me in'); }, 1000);
           $('.fade').toggleClass('change_me in');
        </script>
        -->
        <script src="js/bootstrap.min.js"></script>
        <script src="js/email.js"></script>
        <script>
                $('.email').on('click', function(){
                var nome = $(this).data('nome'); // vamos buscar o valor do atributo data-name que temos no botão que foi clicado 
                var email = $(this).data('email');
                $('#alvo').val(nome);
                console.log("Arquivo para envio: "+nome);
                document.querySelector("[name='email']").value = email;
                
                $('#myModal').modal('show'); // modal aparece
          });
        </script> 
        
    </body>
</html>
