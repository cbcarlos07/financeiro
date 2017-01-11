<%-- 
    Document   : menu
    Created on : 16/11/2016, 13:44:05
    Author     : carlos.brito
--%>
<nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href=".">Indicadores - ${user}</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-right">                       
                        <li role="presentation" class="dropdown">
                            <a  href="indicador" >Indicadores</a>
                            <ul class="dropdown-menu">
                                <li><a href="indicador" >Indicadores</a></li>
                                <li><a href="#" class="email" data-nome="email-indicador.jsp" data-email="osmir.alves@ham.org.br,ciro.filho@ham.org.br,guilherme.macedo@ham.org.br" data-toggle="modal" data-target="#send-modal" >E-mail</a></li>
                            </ul>
                        </li>
                        <li role="presentation" class="dropdown">
                            <a  href="situacao" >Situa&ccedil;&atilde;o das Contas</a>
                             <ul class="dropdown-menu">
                                <li><a href="situacao" >Situa&ccedil;&atilde;o das Contas</a></li>
                                <li><a href="#" class="email" data-nome="email-situacao.jsp" data-email="time.contas@ham.org.br" data-toggle="modal" data-target="#send-modal" >E-mail</a></li>
                            </ul>
                        </li>
                        <li role="presentation" class="dropdown">
                            <a  href="maior" >Contas > 50 mil</a>
                             <ul class="dropdown-menu">
                                <li><a href="contas" >Contas > 50 mil</a></li>
                                <li><a href="#" class="email" data-nome="email-contas.jsp" data-email="osmir.alves@ham.org.br,ciro.filho@ham.org.br,ronaldo.quintana@ham.org.br,andreia.barbosa@ham.org.br" data-toggle="modal" data-target="#send-modal" >E-mail</a></li>
                            </ul>
                        </li>
                        <li role="presentation" class="dropdown">
                            <a  href="abertas" >Contas Abertas</a>
                             <ul class="dropdown-menu">
                                <li><a href="abertas" >Contas Abertas</a></li>
                                <li><a href="#" class="email" data-nome="email-abertas.jsp" data-email="osmir.alves@ham.org.br,ciro.filho@ham.org.br,ronaldo.quintana@ham.org.br,andreia.barbosa@ham.org.br" data-toggle="modal" data-target="#send-modal" >E-mail</a></li>
                            </ul>
                        </li>
                         <li role="presentation" class="dropdown">
                            <a  href="sair" class="active">Sair</a>
                            
                        </li>
                    </ul>
                </div>
            </div>
        </nav>