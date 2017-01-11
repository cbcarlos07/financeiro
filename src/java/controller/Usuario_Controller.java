/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import model.Usuario_DAO;

/**
 *
 * @author carlos.brito
 */
public class Usuario_Controller {
    
    Usuario_DAO ud = new Usuario_DAO();
    
    public String recuperarEmpresa(String user){
        String empresa = ud.recuperarEmpresa(user);
        return empresa;
    }
    
    public String recuperarSenha(String user){
        String empresa = ud.recuperarSenha(user);
        return empresa;
    }
}
