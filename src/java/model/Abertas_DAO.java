/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import beans.Abertas;
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
public class Abertas_DAO {
    String sql;
    Connection conn;
    PreparedStatement stmt;
    List lista;
    ResultSet resultSet;
    
    public List<Abertas> getContasInternacao(){
        lista = new ArrayList();
        System.out.print("Contas Internação:  ");
        conn = ConnectionFactory.getConnection();
        sql = "SELECT MES,CONTAS,SEM_REM AS ABERTAS,PORC_CONTAS AS PORC_FECHADAS,RS_SEM_REMESSA RS_ABERTAS FROM VDIC_SIT_CONTAS_INTERNACAO" +
              " WHERE ANO_ATENDIMENTO  = NVL('2016',TO_CHAR(SYSDATE,'YYYY'))" +
              "  AND ANO_CONTAS       = NVL('2016',TO_CHAR(SYSDATE,'YYYY')) " +
              " ORDER BY 1";
        
        try {
            stmt = conn.prepareStatement(sql);
            resultSet = stmt.executeQuery();
            
            while(resultSet.next()){
                Abertas aberta = new Abertas();
                aberta.setMes(resultSet.getString(1));
                aberta.setContas(resultSet.getString(2));
                aberta.setAbertas(resultSet.getString(3));
                aberta.setFechadas(resultSet.getString(4));                
                aberta.setAbertas_rs(resultSet.getString(5));
                lista.add(aberta);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Abertas_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return lista;
    }
    
    
    public List<Abertas> getProntoAtendimento(){
        lista = new ArrayList();
        System.out.print("Contas Pronto Atendimento: ");
        conn = ConnectionFactory.getConnection();
        sql = "SELECT MES " +
            "      ,SUM(CONTAS) CONTAS " +
            "      ,CASE " +
            "         WHEN MES = '05/2015' OR MES = '06/2015' " +
            "           THEN 0 " +
            "         ELSE " +
            "            SUM(NAO_PROTOC) " +
            "       END NAO_PROTOC " +
            "      ,TO_CHAR((SUM(PROTOC)*100)/(SUM(CONTAS)),'9909D99')||'%' PORC_PROTOC " +
            "      ,SUM(SEM_REM)    SEM_REM " +
            "      ,TO_CHAR((SUM(EM_REM)*100)/(SUM(CONTAS)),'990D99')||'%' PORC_CONTAS " +
            "      ,'R$ '||TO_CHAR(SUM(RS_SEM_REMESSA),'999G999G990D99') RS_ABERTAS " +
            " FROM ( " +
            " SELECT * FROM VDIC_SIT_CONTAS_EXT_PA " +
            " WHERE TIPO_ATD   = 'U' AND ANO_ATENDIMENTOS = nvl('2016',TO_CHAR(SYSDATE,'YYYY')) " +
            " ) " +
            " GROUP BY MES " +
            " ORDER BY 1";
        
        try {
            stmt = conn.prepareStatement(sql);
            resultSet = stmt.executeQuery();
            
            while(resultSet.next()){
                Abertas aberta = new Abertas();
                aberta.setMes(resultSet.getString(1));
                aberta.setContas(resultSet.getString(2));
                aberta.setNao_protoc(resultSet.getString(3));
                aberta.setPorc_protoc(resultSet.getString(4));
                aberta.setAbertas(resultSet.getString(5));
                aberta.setFechadas(resultSet.getString(6));
                aberta.setAbertas_rs(resultSet.getString(7));
                lista.add(aberta);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Abertas_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return lista;
    }
    
    
   public List<Abertas> getConsultorio(){
       System.out.print("Contas Consultório ");
        lista = new ArrayList();
        conn = ConnectionFactory.getConnection();
        sql = "SELECT MES " +
            "      ,CONTAS " +
            "      ,NAO_PROTOC " +
            "      ,PORC_PROTOC " +
            "      ,SEM_REM " +
            "      ,PORC_CONTAS " +
            "      ,'R$ '||TO_CHAR(SUM(RS_ABERTAS),'999G999G990D99') RS_ABERTAS " +
            "  FROM VDIC_SIT_CONTAS_CONSULTORIO " +
            " WHERE ANO = NVL('2016',TO_CHAR(SYSDATE,'YYYY')) " +
            "  GROUP BY MES " +
            "        ,CONTAS " +
            "        ,NAO_PROTOC " +
            "        ,PORC_PROTOC " +
            "        ,SEM_REM " +
            "        ,PORC_CONTAS " +
            "  ORDER BY 1";
        
        try {
            stmt = conn.prepareStatement(sql);
            resultSet = stmt.executeQuery();
            
            while(resultSet.next()){
                Abertas aberta = new Abertas();
                aberta.setMes(resultSet.getString(1));
                aberta.setContas(resultSet.getString(2));
                aberta.setNao_protoc(resultSet.getString(3));
                aberta.setPorc_protoc(resultSet.getString(4));
                aberta.setAbertas(resultSet.getString(5));
                aberta.setFechadas(resultSet.getString(6));
                aberta.setAbertas_rs(resultSet.getString(7));
                lista.add(aberta);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Abertas_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return lista;
    }
   
   public List<Abertas> getLaboratorio(){
       System.out.print("Contas Laboratório ");
        lista = new ArrayList();
        conn = ConnectionFactory.getConnection();
        sql = "SELECT MES " +
                "      ,CONTAS " +
                "      ,NAO_PROTOC " +
                "      ,PORC_PROTOC " +
                "      ,SEM_REM " +
                "      ,PORC_CONTAS " +
                "      ,'R$ '||TO_CHAR(SUM(RS_ABERTAS),'999G999G990D99') RS_ABERTAS " +
                "  FROM VDIC_SIT_CONTAS_LABORATORIO " +
                " WHERE ANO = NVL('2016',TO_CHAR(SYSDATE,'YYYY')) " +
                "   GROUP BY MES " +
                "        ,CONTAS " +
                "        ,NAO_PROTOC " +
                "        ,PORC_PROTOC " +
                "        ,SEM_REM " +
                "        ,PORC_CONTAS " +
                "   ORDER BY 1";
        
        try {
            stmt = conn.prepareStatement(sql);
            resultSet = stmt.executeQuery();
            
            while(resultSet.next()){
                Abertas aberta = new Abertas();
                aberta.setMes(resultSet.getString(1));
                aberta.setContas(resultSet.getString(2));
                aberta.setNao_protoc(resultSet.getString(3));
                aberta.setPorc_protoc(resultSet.getString(4));
                aberta.setAbertas(resultSet.getString(5));
                aberta.setFechadas(resultSet.getString(6));
                aberta.setAbertas_rs(resultSet.getString(7));
                lista.add(aberta);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Abertas_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return lista;
    }
   
   public List<Abertas> getDiagnostico(){
       System.out.print("Contas Diagnóstico ");
        lista = new ArrayList();
        conn = ConnectionFactory.getConnection();
        sql = "SELECT MES " +
                "      ,CONTAS " +
                "      ,NAO_PROTOC " +
                "      ,PORC_PROTOC " +
                "      ,SEM_REM " +
                "      ,PORC_CONTAS " +
                "      ,'R$ '||TO_CHAR(SUM(RS_ABERTAS),'999G999G990D99') RS_ABERTAS FROM VDIC_SIT_CONTAS_DIAGNOSTICO " +
                "WHERE ANO = NVL('2016',TO_CHAR(SYSDATE,'YYYY')) " +
                "   GROUP BY MES " +
                "        ,CONTAS " +
                "        ,NAO_PROTOC " +
                "        ,PORC_PROTOC " +
                "        ,SEM_REM " +
                "        ,PORC_CONTAS " +
                "   ORDER BY 1";
        
        try {
            stmt = conn.prepareStatement(sql);
            resultSet = stmt.executeQuery();
            
            while(resultSet.next()){
                Abertas aberta = new Abertas();
                aberta.setMes(resultSet.getString(1));
                aberta.setContas(resultSet.getString(2));
                aberta.setNao_protoc(resultSet.getString(3));
                aberta.setPorc_protoc(resultSet.getString(4));
                aberta.setAbertas(resultSet.getString(5));
                aberta.setFechadas(resultSet.getString(6));
                aberta.setAbertas_rs(resultSet.getString(7));
                lista.add(aberta);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Abertas_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return lista;
    }
}
