/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import beans.Situacao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author carlos.brito
 */
public class Situacao_DAO {
    String sql;
    Connection conn;
    PreparedStatement stmt;
    List lista;
    ResultSet resultSet;
    
    public List<Situacao> getSituacaoInternacao(){
        lista = new ArrayList();
        System.out.print("Situacao Internação ");
        conn = ConnectionFactory.getConnection();
        sql = "SELECT MES " +
            "      ,CONTAS " +
            "      ,SEM_REM " +
            "      ,PORC_CONTAS " +
            " FROM ( " +
            " SELECT * FROM VDIC_SIT_CONTAS_INTERNACAO " +
            " WHERE ANO_ATENDIMENTO  = TO_CHAR(SYSDATE,'YYYY') " +
            "  AND ANO_CONTAS       = TO_CHAR(SYSDATE,'YYYY')" +
            " )";
        
        try {
            stmt = conn.prepareStatement(sql);
            resultSet = stmt.executeQuery();
            
            while(resultSet.next()){
                Situacao situacao = new Situacao();
                situacao.setMes(resultSet.getString(1));
                situacao.setContas(resultSet.getString(2));
                situacao.setAbertas(resultSet.getString(3));
                situacao.setFechadas(resultSet.getString(4));
                lista.add(situacao);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Situacao_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return lista;
    }
    
    
    public List<Situacao> getProntoAtendimento(){
        lista = new ArrayList();
        System.out.print("Situacao Pronto Atendimento ");
        conn = ConnectionFactory.getConnection();
        sql = "SELECT   MES," +
                "       CONTAS, " +
                "       NAO_PROTOC, " +
                "       PORC_PROTOC, " +
                "       SEM_REM, " +
                "       PORC_CONTAS " +
                " FROM ( " +
                "SELECT * FROM VDIC_SIT_CONTAS_URGENCIA " +
                "where ANO = TO_CHAR(SYSDATE,'YYYY')" +
                ")" +
                "ORDER BY 1";
        
        try {
            stmt = conn.prepareStatement(sql);
            resultSet = stmt.executeQuery();
            
            while(resultSet.next()){
                Situacao situacao = new Situacao();
                situacao.setMes(resultSet.getString(1));
                situacao.setContas(resultSet.getString(2));
                situacao.setNao_protcoladas(resultSet.getString(3));
                situacao.setProtocoladas(resultSet.getString(4));
                situacao.setAbertas(resultSet.getString(5));
                situacao.setFechadas(resultSet.getString(6));
                lista.add(situacao);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Situacao_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return lista;
    }
    
    
   public List<Situacao> getConsultorio(){
       System.out.print("Situacao Consultório ");
        lista = new ArrayList();
        conn = ConnectionFactory.getConnection();
        sql = "SELECT * FROM VDIC_SIT_CONTAS_CONSULTORIO " +
                "WHERE ANO = TO_CHAR(SYSDATE,'YYYY')";
        
        try {
            stmt = conn.prepareStatement(sql);
            resultSet = stmt.executeQuery();
            
            while(resultSet.next()){
                Situacao situacao = new Situacao();
                situacao.setMes(resultSet.getString(1));
                situacao.setContas(resultSet.getString(2));
                situacao.setNao_protcoladas(resultSet.getString(3));
                situacao.setProtocoladas(resultSet.getString(4));
                situacao.setAbertas(resultSet.getString(6));
                situacao.setFechadas(resultSet.getString(7));
                lista.add(situacao);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Situacao_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return lista;
    }
   
   public List<Situacao> getLaboratorio(){
       System.out.print("Situacao Laboratório ");
        lista = new ArrayList();
        conn = ConnectionFactory.getConnection();
        sql = "SELECT * FROM VDIC_SIT_CONTAS_LABORATORIO " +
              "WHERE ANO = TO_CHAR(SYSDATE,'YYYY')";
        
        try {
            stmt = conn.prepareStatement(sql);
            resultSet = stmt.executeQuery();
            
            while(resultSet.next()){
                Situacao situacao = new Situacao();
                situacao.setMes(resultSet.getString(1));
                situacao.setContas(resultSet.getString(2));
                situacao.setNao_protcoladas(resultSet.getString(3));
                situacao.setProtocoladas(resultSet.getString(4));
                situacao.setAbertas(resultSet.getString(6));
                situacao.setFechadas(resultSet.getString(7));
                lista.add(situacao);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Situacao_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return lista;
    }
   
   public List<Situacao> getDiagnostico(){
       System.out.print("Situacao Diagnóstico ");
        lista = new ArrayList();
        conn = ConnectionFactory.getConnection();
        sql = "SELECT * FROM VDIC_SIT_CONTAS_DIAGNOSTICO " +
                "WHERE ANO = TO_CHAR(SYSDATE,'YYYY')";
        
        try {
            stmt = conn.prepareStatement(sql);
            resultSet = stmt.executeQuery();
            
            while(resultSet.next()){
                Situacao situacao = new Situacao();
                situacao.setMes(resultSet.getString(1));
                situacao.setContas(resultSet.getString(2));
                situacao.setNao_protcoladas(resultSet.getString(3));
                situacao.setProtocoladas(resultSet.getString(4));
                situacao.setAbertas(resultSet.getString(6));
                situacao.setFechadas(resultSet.getString(7));
                lista.add(situacao);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Situacao_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return lista;
    }
}
