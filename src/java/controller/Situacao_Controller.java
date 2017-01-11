/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import beans.Abertas;
import model.Situacao_DAO;
import java.util.List;

/**
 *
 * @author carlos.brito
 */
public class Situacao_Controller {
    Situacao_DAO ad = new Situacao_DAO();
    List lista;
    
    public List<Abertas> getSituacaoInternacao(){
        lista = ad.getSituacaoInternacao();
        return lista;
    }
    
    public List<Abertas> getProntoAtendimento(){
        lista = ad.getProntoAtendimento();
        return lista;
    }
    
    public List<Abertas> getConsultorio(){
        lista = ad.getConsultorio();
        return lista;
    }
    
    public List<Abertas> getLaboratorio(){
        lista = ad.getLaboratorio();
        return lista;
    }
    
    public List<Abertas> getDiagnostico(){
        lista = ad.getDiagnostico();
        return lista;
    }
}
