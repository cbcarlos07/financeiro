/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import beans.Financeiro;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author carlos.brito
 */
public class Financeiro_DAO {
    String sql;
    Connection conn;
    PreparedStatement stmt;
    List lista;
    ResultSet resultSet;
    
    public List<Financeiro> getLeitos(){
        System.out.print("Leitos: ");
        lista = new ArrayList();
        sql =   "  SELECT 1 ind, " +
                "       NULL, " +
                "       INDICADOR INDICADOR,  " +
                "       ONTEM,  " +
                "       MEDIA,  " +
                "       null ACUMULADO  " +
                "  FROM VDIC_HAM_INDICADOR_LEITOS " +
                "        " +
                " UNION " +
                "        " +
                " " +
                "SELECT 2 ind, " +
                "      IND, " +
                "      INDICADOR,  " +
                "      TO_CHAR(ONTEM, '999G990') ONTEM,  " +
                "      TO_CHAR(MEDIA, '999G990D99') MEDIA,  " +
                "      TO_CHAR(ACUMULADO, '999G990') ACUMULADO " +
                " FROM DBAMV.VDIC_HAM_INDICADOR_MOV_LEITO " +
                "ORDER BY 1,2";
        
        conn = ConnectionFactory.getConnection();
        try {
            stmt = conn.prepareStatement(sql);
            resultSet = stmt.executeQuery();
            while(resultSet.next()){
                Financeiro financeiro = new Financeiro();
                financeiro.setInd_Unid(resultSet.getString("INDICADOR"));
                financeiro.setOntem(resultSet.getString("ONTEM"));
                financeiro.setMedia(resultSet.getString("MEDIA"));
                financeiro.setAcumulado(resultSet.getString("ACUMULADO"));
                lista.add(financeiro);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Financeiro_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista;
        
    }
    
    
    public List<Financeiro> getPacienteInternado(){
        System.out.print("Pacientes Internados: ");
        lista = new ArrayList();
        sql =   " SELECT UNIDADE UNIDADE, LEITOS, PACIENTE_DIA_ONTEM, PACIENTE_MEDIA, PACIENTE_DIA_ACUMULADO " +
                " FROM VDIC_HAM_EMAIL_INDICADOR_PAC ";
        
        conn = ConnectionFactory.getConnection();
        try {
            stmt = conn.prepareStatement(sql);
            resultSet = stmt.executeQuery();
            while(resultSet.next()){
                Financeiro financeiro = new Financeiro();
                financeiro.setInd_Unid(resultSet.getString("UNIDADE"));
                financeiro.setLeito(resultSet.getString("LEITOS"));
                financeiro.setOntem(resultSet.getString("PACIENTE_DIA_ONTEM"));
                financeiro.setMedia(resultSet.getString("PACIENTE_MEDIA"));                
                financeiro.setAcumulado(resultSet.getString("PACIENTE_DIA_ACUMULADO"));
                lista.add(financeiro);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Financeiro_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista; 
    }
    
    
      public List<Financeiro> getCentroCirurgico(){
          System.out.print("Centro Cirúrgico: ");
        lista = new ArrayList();
        sql =   " SELECT INITCAP(CENTRO_CIRURGICO) CENTRO_CIRURGICO, ONTEM, MEDIA, TOTAL " +
                    "FROM VDIC_HAM_INDICADOR_CC ";
        
        conn = ConnectionFactory.getConnection();
        try {
            stmt = conn.prepareStatement(sql);
            resultSet = stmt.executeQuery();
            while(resultSet.next()){
                Financeiro financeiro = new Financeiro();
                financeiro.setInd_Unid(resultSet.getString("CENTRO_CIRURGICO"));
                financeiro.setOntem(resultSet.getString("ONTEM"));
                financeiro.setMedia(resultSet.getString("MEDIA"));                
                financeiro.setAcumulado(resultSet.getString("TOTAL"));
                lista.add(financeiro);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Financeiro_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista; 
    }
    
    
      public List<Financeiro> getHemodinamica(){
          System.out.print("Hemodinâmica: ");
        lista = new ArrayList();
        sql =   " SELECT INITCAP(HEMODINAMICA) HEMODINAMICA, DIA, MEDIA, ACUMULADO " +
                "FROM VDIC_HAM_INDICADOR_HEMO";
        
        conn = ConnectionFactory.getConnection();
        try {
            stmt = conn.prepareStatement(sql);
            resultSet = stmt.executeQuery();
            while(resultSet.next()){
                Financeiro financeiro = new Financeiro();
                financeiro.setInd_Unid(resultSet.getString("HEMODINAMICA"));
                financeiro.setOntem(resultSet.getString("DIA"));
                financeiro.setMedia(resultSet.getString("MEDIA"));                
                financeiro.setAcumulado(resultSet.getString("ACUMULADO"));
                lista.add(financeiro);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Financeiro_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista; 
    }
      
    public List<Financeiro> getDiagnoticoImagem(){
        System.out.print("Diagnóstico por Imagem: ");
        lista = new ArrayList();
        sql =   " SELECT INITCAP(LOCAL) LOCAL, ONTEM, MEDIA, ACUMULADO " +
                "FROM VDIC_HAM_INDICADOR_DIAG";
        
        conn = ConnectionFactory.getConnection();
        try {
            stmt = conn.prepareStatement(sql);
            resultSet = stmt.executeQuery();
            while(resultSet.next()){
                Financeiro financeiro = new Financeiro();
                financeiro.setInd_Unid(resultSet.getString("LOCAL"));
                financeiro.setOntem(resultSet.getString("ONTEM"));
                financeiro.setMedia(resultSet.getString("MEDIA"));                
                financeiro.setAcumulado(resultSet.getString("ACUMULADO"));
                lista.add(financeiro);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Financeiro_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista; 
    }
     
   public List<Financeiro> getLaboratorio(){
       System.out.print("Laboratório: ");
        lista = new ArrayList();
        sql =   " SELECT INITCAP(TIPO) TIPO, ONTEM, MEDIA, ACUMULADO " +
                    "FROM VDIC_HAM_INDICADOR_LABORATORIO";
        
        conn = ConnectionFactory.getConnection();
        try {
            stmt = conn.prepareStatement(sql);
            resultSet = stmt.executeQuery();
            while(resultSet.next()){
                Financeiro financeiro = new Financeiro();
                financeiro.setInd_Unid(resultSet.getString("TIPO"));
                financeiro.setOntem(resultSet.getString("ONTEM"));
                financeiro.setMedia(resultSet.getString("MEDIA"));                
                financeiro.setAcumulado(resultSet.getString("ACUMULADO"));
                lista.add(financeiro);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Financeiro_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista; 
    }
    
   
   public List<Financeiro> getConsultorio(){
       System.out.print("Consultório: ");
        lista = new ArrayList();
        sql =   "SELECT INITCAP(TIPO) TIPO, ONTEM, MEDIA, ACUMULADO " +
                "FROM VDIC_HAM_INDICADOR_AMB";
        
        conn = ConnectionFactory.getConnection();
        try {
            stmt = conn.prepareStatement(sql);
            resultSet = stmt.executeQuery();
            while(resultSet.next()){
                Financeiro financeiro = new Financeiro();
                financeiro.setInd_Unid(resultSet.getString("TIPO"));
                financeiro.setOntem(resultSet.getString("ONTEM"));
                financeiro.setMedia(resultSet.getString("MEDIA"));                
                financeiro.setAcumulado(resultSet.getString("ACUMULADO"));
                lista.add(financeiro);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Financeiro_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista; 
    }
   
   
   public List<Financeiro> getAmbulatorioCardiologia(){
       System.out.print("Ambulatório Cardiologia: ");
        lista = new ArrayList();
        sql =   "SELECT FNC_INIT_LETRAS(EXAME) EXAME, ONTEM, MEDIA, ACUMULADO " +
                "FROM VDIC_HAM_INDICADOR_CARDIOLOGIA";
        
        conn = ConnectionFactory.getConnection();
        try {
            stmt = conn.prepareStatement(sql);
            resultSet = stmt.executeQuery();
            while(resultSet.next()){
                Financeiro financeiro = new Financeiro();                
                financeiro.setInd_Unid(resultSet.getString("EXAME"));
                financeiro.setOntem(resultSet.getString("ONTEM"));
                financeiro.setMedia(resultSet.getString("MEDIA"));                
                financeiro.setAcumulado(resultSet.getString("ACUMULADO"));
                lista.add(financeiro);
            }
            conn.close();
        } catch (SQLException ex) {
            //System.out.println("Erro: "+ex.printStackTrace());
            System.out.println("Erro: "+ex.getMessage());
            Logger.getLogger(Financeiro_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista; 
    }
      
   
   public List<Financeiro> getProntoAtendimento(){
       System.out.print("Pronto Atendimento: ");
        lista = new ArrayList();
        sql =   "SELECT TIPO, ONTEM, MEDIA, ACUMULADO " +
                 "FROM VDIC_HAM_INDICADOR_PA";
        
        conn = ConnectionFactory.getConnection();
        try {
            stmt = conn.prepareStatement(sql);
            resultSet = stmt.executeQuery();
            while(resultSet.next()){
                Financeiro financeiro = new Financeiro();
                financeiro.setInd_Unid(resultSet.getString("TIPO"));
                financeiro.setOntem(resultSet.getString("ONTEM"));
                financeiro.setMedia(resultSet.getString("MEDIA"));                
                financeiro.setAcumulado(resultSet.getString("ACUMULADO"));
                lista.add(financeiro);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Financeiro_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lista; 
    }
      
}// FIM DA CLASSE
