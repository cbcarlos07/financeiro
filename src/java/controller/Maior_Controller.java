/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import beans.Maior;
import model.Maior_DAO;
import java.util.List;

/**
 *
 * @author carlos.brito
 */
public class Maior_Controller {
    Maior_DAO cd = new Maior_DAO();
    List lista;
    
    public List<Maior> getMaior(){
        lista = cd.getMaior();
        return lista;
    }
    
}
