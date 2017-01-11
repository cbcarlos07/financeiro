/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import beans.Financeiro;
import java.util.List;
import model.Indicador_DAO;

/**
 *
 * @author carlos.brito
 */
public class Indicador_Controller {
    Indicador_DAO fd = new Indicador_DAO();
    List lista;
    
    public List<Financeiro> getLeitos(){
        lista = fd.getLeitos();
        return lista;
    }
    
    public List<Financeiro> getPacienteInternado(){
        lista = fd.getPacienteInternado();
        return lista;
    }
    
    public List<Financeiro> getCentroCirurgico(){
        lista = fd.getCentroCirurgico();
        return lista;
    }

    public List<Financeiro> getHemodinamica(){
        lista = fd.getHemodinamica();
        return lista;
    }
    
    public List<Financeiro> getDiagnoticoImagem(){
        lista = fd.getDiagnoticoImagem();
        return lista;
    }
    
    public List<Financeiro> getLaboratorio(){
        lista = fd.getLaboratorio();
        return lista;
    }
    
    public List<Financeiro> getConsultorio(){
        lista = fd.getConsultorio();
        return lista;
    }
    
    public List<Financeiro> getAmbulatorioCardiologia(){
        lista = fd.getAmbulatorioCardiologia();
        return lista;
    }
    
    public List<Financeiro> getProntoAtendimento(){
        lista = fd.getProntoAtendimento();
        return lista;
    }
    
    
    
}
