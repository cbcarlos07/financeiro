<%-- 
    Document   : jeum
    Created on : 18/08/2016, 09:07:43
    Author     : CARLOS
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Indicadores</title>
        
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
    </head>
    <body>
        
        <div  class="jquery-waiting-base-container">
            <p>Carregando p&aacute;gina.</p>
            <img src="img/loader.gif" width="120" height="120">
        </div>
            
        
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
                       
                        <li><a href="#" data-toggle="modal" data-target="#send-modal">E-mail</a></li>
                    </ul>
                </div>
            </div>
        </nav>
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

                               <div class="form-group">
                               <input type="text" name="email" id="email" value="carlos.brito@ham.org.br" class="form-control"/>
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
        
        
        <jsp:useBean id="fc" class="controller.Financeiro_Controller" />
        <div id="main" class="container">
            <div id="list" class="row">
                <div class="table-responsive col-md-12">
                    
                    <table class="table table-striped table-hover" cellspacing="0" cellpadding="0" >
                        <thead>
                            <tr>
                                <th colspan="4"><center>Leitos</center></th>
                            </tr>
                            <tr>    
                                <th>Indicadores</th>
                                <th>Ontem</th>
                                <th>M&eacute;dia</th>
                                <th>Acumulado</th>                                
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="leito" items="${fc.getLeitos()}" >
                                <tr>
                                    <td>${leito.ind_Unid}</td>
                                    <td>${leito.ontem}</td>
                                    <td>${leito.media}</td>
                                    <td>${leito.acumulado}</td>                                   
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
                                <th colspan="5"><center>Paciente Dia (Meia Noite)</center></th>
                            </tr>
                            <tr>    
                                <th>Unidade</th>
                                <th>Leitos</th>
                                <th>Ontem</th>
                                <th>M&eacute;dia</th>                                
                                <th>Acumulado</th>
                            </tr>
                        </thead>
                        <tbody>
                                <c:set var="total" value="" />
                                <c:set var="leitos" value="" />
                                <c:set var="ontem" value="" />
                                <c:set var="media" value="" />
                                <c:set var="acumulado" value="" />
                            <c:forEach var="paciente" items="${fc.pacienteInternado}" varStatus="status">
                                <c:set var="total" value="${status.count}"/>
                                <c:set var="leitos" value="${leitos + paciente.leito}"/>
                                <c:set var="ontem" value="${ontem + paciente.ontem}" />                                
                                <c:set var="media" value="${media + fn:replace(paciente.media,',','.')}" />
                                <c:set var="acumulado" value="${acumulado + paciente.acumulado}" />
                                <tr>
                                    <td>${paciente.ind_Unid}</td>
                                    <td>${paciente.leito}</td>
                                    <td>${paciente.ontem}</td>
                                    <td>${paciente.media}</td>                                   
                                    <td>${paciente.acumulado}</td>
                                </tr>                                    
                            </c:forEach>
                        </tbody>
                        <tfoot>
                                <tr class="footer-table">
                                    <td>TOTAL</td>
                                    <td>${leitos}</td>
                                    <td>${ontem}</td>
                                    <td><fmt:formatNumber minFractionDigits="2" maxFractionDigits="2" value="${media / total}"/></td>
                                    <td>${acumulado}</td>
                                </tr>
                        </tfoot>
                    </table>
                </div>
                <br>
                <hr />
                <div class="table-responsive col-md-12">                    
                    <table class="table table-striped table-hover" cellspacing="0" cellpadding="0" >
                        <thead>
                            <tr>
                                <th colspan="4"><center>Centro Cir&uacute;rgico</center></th>
                            </tr>
                            <tr>    
                                <th>Indicador</th>
                                <th>Ontem</th>
                                <th>M&eacute;dia</th>                                
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="centro" items="${fc.centroCirurgico}" >
                                <tr>
                                    <td>${centro.ind_Unid}</td>
                                    <td>${centro.ontem}</td>
                                    <td>${centro.media}</td>                                   
                                    <td>${centro.acumulado}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <br>
                <hr />
                <div class="table-responsive col-md-12">                    
                    <table class="table table-striped table-hover" cellspacing="0" cellpadding="0" >
                        <thead>
                            <tr>
                                <th colspan="4"><center>Hemodin&acirc;mica</center></th>
                            </tr>
                            <tr>    
                                <th>Indicador</th>
                                <th>Ontem</th>
                                <th>M&eacute;dia</th>                                
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="hemodinamica" items="${fc.hemodinamica}" >
                                <tr>
                                    <td>${hemodinamica.ind_Unid}</td>
                                    <td>${hemodinamica.ontem}</td>
                                    <td>${hemodinamica.media}</td>                                   
                                    <td>${hemodinamica.acumulado}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <br>
                <hr />
                <div class="table-responsive col-md-12">                    
                    <table class="table table-striped table-hover" cellspacing="0" cellpadding="0" >
                        <thead>
                            <tr>
                                <th colspan="4"><center>Diagn&oacute;stico por Imagem</center></th>
                            </tr>
                            <tr>    
                                <th>Indicador</th>
                                <th>Ontem</th>
                                <th>M&eacute;dia</th>                                
                                <th>Total</th>
                            </tr>
                        </thead>
                                <c:set var="total" value="" />
                                <c:set var="ontem" value="" />
                                <c:set var="media" value="" />
                                <c:set var="acumulado" value="" />
                        <tbody>
                            <c:forEach var="diagnostico" items="${fc.diagnoticoImagem}" varStatus="status">
                                <c:set var="total" value="${status.count}" />
                                <c:set var="ontem" value="${ontem + diagnostico.ontem}" />
                                <c:set var="media" value="${media + fn:replace(diagnostico.media,',','.')}" />
                                <c:set var="acumulado" value="${acumulado + diagnostico.acumulado}" />                                
                                <tr>
                                    <td>${diagnostico.ind_Unid}</td>
                                    <td>${diagnostico.ontem}</td>
                                    <td>${diagnostico.media}</td>                                   
                                    <td>${diagnostico.acumulado}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                                <tr class="footer-table">
                                    <td>TOTAL</td>
                                    <td>${ontem}</td>
                                    <td><fmt:formatNumber minFractionDigits="2" maxFractionDigits="2" value="${media / total}"/></td>
                                    <td>${acumulado}</td>
                                </tr>
                        </tfoot>
                    </table>
                </div>
                
                <br>
                <hr />
                <div class="table-responsive col-md-12">                    
                    <table class="table table-striped table-hover" cellspacing="0" cellpadding="0" >
                        <thead>
                            <tr>
                                <th colspan="4"><center>Laborat&oacute;rio</center></th>
                            </tr>
                            <tr>    
                                <th>Tipo</th>
                                <th>Ontem</th>
                                <th>M&eacute;dia</th>                                
                                <th>Total</th>
                            </tr>
                        </thead>
                        <c:set var="item" value="" />
                        <c:set var="ontem" value="" />
                        <c:set var="media" value="" />
                        <c:set var="total" value="" />
                        <tbody>
                            <c:forEach var="lab" items="${fc.laboratorio}" varStatus="status">
                                <c:set var="item" value="${status.count}" />
                                <c:set var="ontem" value="${ontem + lab.ontem}" />
                                <c:set var="media" value="${media + fn:replace(lab.media,',','.')}" />
                                <c:set var="total" value="${acumulado + lab.acumulado}" />  
                                <tr>
                                    <td>${lab.ind_Unid}</td>
                                    <td>${lab.ontem}</td>
                                    <td>${lab.media}</td>                                   
                                    <td>${lab.acumulado}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                                <tr class="footer-table">
                                    <td>TOTAL</td>
                                    <td>${ontem}</td>
                                    <td><fmt:formatNumber minFractionDigits="2" maxFractionDigits="2" value="${media / item}"/></td>
                                    <td>${total}</td>
                                </tr>
                        </tfoot>
                    </table>
                </div>
                
                <br>
                <hr />
                <div class="table-responsive col-md-12">                    
                    <table class="table table-striped table-hover" cellspacing="0" cellpadding="0" >
                        <thead>
                            <tr>
                                <th colspan="4"><center>Consult&oacute;rios</center></th>
                            </tr>
                            <tr>    
                                <th>Tipo</th>
                                <th>Ontem</th>
                                <th>M&eacute;dia</th>                                
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="consultorio" items="${fc.consultorio}" >
                                <tr>
                                    <td>${consultorio.ind_Unid}</td>
                                    <td>${consultorio.ontem}</td>
                                    <td>${consultorio.media}</td>                                   
                                    <td>${consultorio.acumulado}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <br>
                <hr />
                <div class="table-responsive col-md-12">                    
                    <table class="table table-striped table-hover" cellspacing="0" cellpadding="0" >
                        <thead>
                            <tr>
                                <th colspan="4"><center>Ambulat&oacute;rio Cardiologia</center></th>
                            </tr>
                            <tr>    
                                <th>Exame</th>
                                <th>Ontem</th>
                                <th>M&eacute;dia</th>                                
                                <th>Acumulado</th>
                            </tr>
                        </thead>
                        <c:set var="item" value="" />
                        <c:set var="ontem" value="" />
                        <c:set var="media" value="" />
                        <c:set var="total" value="" />
                        <tbody>
                            <c:forEach var="cardiologia" items="${fc.ambulatorioCardiologia}" varStatus="status">
                                <c:set var="item" value="${status.count}" />
                                <c:set var="ontem" value="${ontem + cardiologia.ontem}" />
                                <c:set var="media" value="${media + cardiologia.media}" />
                                <c:set var="total" value="${total + cardiologia.acumulado}" />
                                <tr>
                                    <td>${cardiologia.ind_Unid}</td>
                                    <td>${cardiologia.ontem}</td>
                                    <td>${cardiologia.media}</td>                                   
                                    <td>${cardiologia.acumulado}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                                <tr class="footer-table">
                                    <td>TOTAL</td>
                                    <td>${ontem}</td>
                                    <td><fmt:formatNumber minFractionDigits="2" maxFractionDigits="2" value="${media / item}"/></td>
                                    <td>${total}</td>
                                </tr>
                        </tfoot>
                    </table>
                </div>
                
                <br>
                <hr />
                <div class="table-responsive col-md-12">                    
                    <table class="table table-striped table-hover" cellspacing="0" cellpadding="0" >
                        <thead>
                            <tr>
                                <th colspan="4"><center>Pronto Atendimento</center></th>
                            </tr>
                            <tr>    
                                <th>Tipo</th>
                                <th>Ontem</th>
                                <th>M&eacute;dia</th>                                
                                <th>Acumulado</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="pa" items="${fc.prontoAtendimento}" >
                                <tr>
                                    <td>${pa.ind_Unid}</td>
                                    <td>${pa.ontem}</td>
                                    <td>${pa.media}</td>                                   
                                    <td>${pa.acumulado}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                
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
        
        
        <script src="js/bootstrap.min.js"></script>
        <script src="js/email.js"></script>
    </body>
</html>
