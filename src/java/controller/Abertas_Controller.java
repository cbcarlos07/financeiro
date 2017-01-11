/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import beans.Situacao;
import model.Abertas_DAO;
import java.util.List;

/**
 *
 * @author carlos.brito
 */
public class Abertas_Controller {
    Abertas_DAO ad = new Abertas_DAO();
    List lista;
    
    public List<Situacao> getContasInternacao(){
        lista = ad.getContasInternacao();
        return lista;
    }
    
    public List<Situacao> getProntoAtendimento(){
        lista = ad.getProntoAtendimento();
        return lista;
    }
    
    public List<Situacao> getConsultorio(){
        lista = ad.getConsultorio();
        return lista;
    }
    
    public List<Situacao> getLaboratorio(){
        lista = ad.getLaboratorio();
        return lista;
    }
    
    public List<Situacao> getDiagnostico(){
        lista = ad.getDiagnostico();
        return lista;
    }
}
