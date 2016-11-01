/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var mensagem = $('.modal-body');
var originalModal = $('#send-modal').clone();  

function enviar(){
        
        jQuery('#form-mail').submit(function(){
         
        //alert('Submit');
        //var dados = jQuery( this ).serialize();
        var email = document.getElementById("email").value;
        
        
        //var cracha = $('#cracha').value;
        //alert("Usuario: "+usuario+" Senha: "+senha);    
        //console.log("Usuario: "+usuario+" Senha: "+senha);    
        jQuery.ajax({
                type: "POST",
                url: "email.jsp",
                beforeSend: carregando,
                data: {
                    'email' : email
                   
                },
                error: errosend(),
                success: function( data )
                {
                    //var retorno = data.retorno;
                    //alert(retorno);

                    console.log("Data: "+data);
                    sucesso();
                   
                }
        });

        return false;
        });
    }
    
    

function carregando(){
        var mensagem = $('.modal-body');
        var title = $('.modal-title');
        var footer = $('.modal-footer');
        
        //alert('Carregando: '+mensagem);
        title.empty().html('Aguarde enquanto o e-mail é enviado').fadeIn("fast");
        footer.empty().html('').fadeIn("fast");
        mensagem.empty().html('<center><img src="img/email3.gif" width="90" height="90"></center>').fadeIn("fast");
        setTimeout(function (){
            
        },300);
        
  }

  function errosend(){
        var mensagem = $('.modal-body');
        var title = $('.modal-title');
        title.empty().html('Oops algum erro ocorreu!').fadeIn("fast");                
        mensagem.empty().html('<p class="alert alert-danger"><strong>Opa!</strong> Por favor, verifique o e-mail informado</p>').fadeIn("fast");
}
function sucesso(){
        var mensagem = $('.modal-body');
        var title = $('.modal-title');
        var modal = $('#send-modal');
        
        title.empty().html('E-mail enviado com sucesso!').fadeIn("fast");                
        mensagem.empty().html('<center><img src="img/confirm.gif" width="120" height="120"></center>').fadeIn("fast");                
        setTimeout(function (){
            
            modal.modal('hide');
            modal.replaceWith(originalModal);
            location.reload();
        },1500);
        //window.setTimeout()
        //delay(2000);
}