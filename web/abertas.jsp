<%-- 
    Document   : jeum
    Created on : 18/08/2016, 09:07:43
    Author     : CARLOS
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Indicadores -  Contas Abertas</title>
        
        <link href="css/bootstrap.min.css"  rel="stylesheet">
        <link href="css/jquery.waiting.css"  rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link rel="shortcut icon" href="img/ham.png">
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
    <body>
        
        <div  class="jquery-waiting-base-container">
            <p>Carregando p&aacute;gina.</p>
            <img src="img/loader.gif" width="120" height="120">
        </div>
            
        <c:import url="menu.jsp" /> 
        <hr />
        
           <!-- Modal -->
<div class="modal fade" id="send-modal" tabindex="-1" role="dialog" aria-labelledby="modalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
             <form action="#" method="post" id="form-mail">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="modalLabel">E-mail ser&atilde;o enviados para o(s) seguinte(s) endere&ccedil;os:</h4>
                    </div>
                    <div class="modal-body">
                               <input type="hidden" name="alvo" id="alvo"> 
                               <div class="form-group">
                               <input type="text" name="email" id="email" value="osmir.alves@ham.org.br,ciro.filho@ham.org.br,ronaldo.quintana@ham.org.br,andreia.barbosa@ham.org.br" class="form-control"/>
                               <!-- ,joanes.cardoso@ham.org.br-->
                               </div>

                        </div>
                    <div class="modal-footer">
                        <button type="submit"  class="btn btn-success" onclick="enviar()">Confirma</button>
                        <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                    </div>
             </form>   
        </div>
    </div>
</div>


        <jsp:useBean id="ac" class="controller.Abertas_Controller" />
        
        <div id="main" class="container">
            <div id="list" class="row col-lg-12" >
                <center><h1>Time de Contas -  Contas Abertas</h1></center>
                <div class="table-responsive col-md-12">                    
                    <table class="table table-striped table-hover" cellspacing="0" cellpadding="0" >
                        <thead>
                            <tr>
                                <th colspan="5"><center>Contas Interna&ccedil;&atilde;o</center></th>
                            </tr>
                            <tr>   
                                <th>M&ecirc;s</th>
                                <th>Contas</th>
                                <th>Abertas</th>
                                <th>% Fechadas</th>
                                <th>R$ Abertas</th>                                
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="valor" value="" />
                            <c:forEach var="internacao" items="${ac.contasInternacao}" >                                
                                <tr>
                                    <td>${internacao.mes}</td>
                                    <td>${internacao.contas}</td>
                                    <td>${internacao.abertas}</td>
                                    <td>${internacao.fechadas}</td>
                                    <td>${internacao.abertas_rs}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <hr />
                <div class="table-responsive col-md-12">                    
                       <table class="table table-striped table-hover" cellspacing="0" cellpadding="0" >
                           <thead>
                               <tr>
                                   <th colspan="7"><center>Contas Pronto Atendimento</center></th>
                               </tr>
                               <tr>   
                                   <th>M&ecirc;s</th>
                                   <th>Contas</th>
                                   <th>N&atilde;o Protoc</th>
                                   <th>% Protoc</th>
                                   <th>Abertas</th>
                                   <th>% Fechadas</th>
                                   <th>R$ Abertas</th>

                               </tr>
                           </thead>
                           <tbody>

                               <c:forEach var="pa" items="${ac.prontoAtendimento}" >                                
                                   <tr>
                                       <td>${pa.mes}</td>
                                       <td>${pa.contas}</td>
                                       <td>${pa.nao_protoc}</td>
                                       <td>${pa.porc_protoc}</td>
                                       <td>${pa.abertas}</td>
                                       <td>${pa.fechadas}</td>
                                       <td>${pa.abertas_rs}</td>

                                   </tr>
                               </c:forEach>
                           </tbody>
                       </table>
                   </div>
                   <hr />
                   <div class="table-responsive col-md-12">                    
                       <table class="table table-striped table-hover" cellspacing="0" cellpadding="0" >
                           <thead>
                               <tr>
                                   <th colspan="7"><center>Contas Consult&oacute;rios</center></th>
                               </tr>
                               <tr>   
                                   <th>M&ecirc;s</th>
                                   <th>Contas</th>
                                   <th>N&atilde;o Protoc</th>
                                   <th>% Protoc</th>
                                   <th>Abertas</th>
                                   <th>% Fechadas</th>
                                   <th>R$ Abertas</th>

                               </tr>
                           </thead>
                           <tbody>

                               <c:forEach var="cons" items="${ac.consultorio}" >                                
                                   <tr>
                                       <td>${cons.mes}</td>
                                       <td>${cons.contas}</td>
                                       <td>${cons.nao_protoc}</td>
                                       <td>${cons.porc_protoc}</td>
                                       <td>${cons.abertas}</td>
                                       <td>${cons.fechadas}</td>
                                       <td>${cons.abertas_rs}</td>

                                   </tr>
                               </c:forEach>
                           </tbody>
                       </table>
                   </div>
                   
                   <hr />
                   <div class="table-responsive col-md-12">                    
                       <table class="table table-striped table-hover" cellspacing="0" cellpadding="0" >
                           <thead>
                               <tr>
                                   <th colspan="7"><center>Contas Laborat&oacute;rio</center></th>
                               </tr>
                               <tr>   
                                   <th>M&ecirc;s</th>
                                   <th>Contas</th>
                                   <th>N&atilde;o Protoc</th>
                                   <th>% Protoc</th>
                                   <th>Abertas</th>
                                   <th>% Fechadas</th>
                                   <th>R$ Abertas</th>

                               </tr>
                           </thead>
                           <tbody>

                               <c:forEach var="lab" items="${ac.laboratorio}" >                                
                                   <tr>
                                       <td>${lab.mes}</td>
                                       <td>${lab.contas}</td>
                                       <td>${lab.nao_protoc}</td>
                                       <td>${lab.porc_protoc}</td>
                                       <td>${lab.abertas}</td>
                                       <td>${lab.fechadas}</td>
                                       <td>${lab.abertas_rs}</td>

                                   </tr>
                               </c:forEach>
                           </tbody>
                       </table>
                   </div>
                   <div class="table-responsive col-md-12">                    
                       <table class="table table-striped table-hover" cellspacing="0" cellpadding="0" >
                           <thead>
                               <tr>
                                   <th colspan="7"><center>Contas Diagn&oacute;stico</center></th>
                               </tr>
                               <tr>   
                                   <th>M&ecirc;s</th>
                                   <th>Contas</th>
                                   <th>N&atilde;o Protoc</th>
                                   <th>% Protoc</th>
                                   <th>Abertas</th>
                                   <th>% Fechadas</th>
                                   <th>R$ Abertas</th>

                               </tr>
                           </thead>
                           <tbody>

                               <c:forEach var="diag" items="${ac.diagnostico}" >                                
                                   <tr>
                                       <td>${diag.mes}</td>
                                       <td>${diag.contas}</td>
                                       <td>${diag.nao_protoc}</td>
                                       <td>${diag.porc_protoc}</td>
                                       <td>${diag.abertas}</td>
                                       <td>${diag.fechadas}</td>
                                       <td>${diag.abertas_rs}</td>

                                   </tr>
                               </c:forEach>
                           </tbody>
                       </table>
                   </div>
                   
                
                
              
            </div>
            
        </div>   
        
        
        
        <script src="js/bootstrap.min.js"></script>
        <script src="js/email.js"></script>
        <script>
                $('.email').on('click', function(){
                var nome = $(this).data('nome'); // vamos buscar o valor do atributo data-name que temos no botão que foi clicado             
                $('#alvo').val(nome);
                console.log("Arquivo para envio: "+nome)
                
                $('#myModal').modal('show'); // modal aparece
          });
        </script> 
    </body>
</html>
