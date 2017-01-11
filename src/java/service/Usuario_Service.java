/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import controller.Usuario_Controller;

/**
 *
 * @author carlos.brito
 */
public class Usuario_Service {
    Usuario_Controller uc = new Usuario_Controller();
    public String recuperarEmpresa(String user){
        String empresa = uc.recuperarEmpresa(user);
        return empresa;
    }
    
    public String recuperarSenha(String user){
        String pwd = uc.recuperarSenha(user);
        return pwd;
    }
}
