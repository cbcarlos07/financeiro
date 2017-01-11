/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author carlos.brito
 */
public class Usuario_DAO {
    PreparedStatement stmt;
    ResultSet  resultSet;
    Connection conn;
    String sql;
    public String recuperarEmpresa(String user){
        String empresa = "";
        conn = ConnectionFactory.getConnection();
        
        sql = "SELECT   " +
                "  E.DS_MULTI_EMPRESA EMPRESA   " +
                "  FROM    " +
                "  DBASGU.USUARIOS                  U   " +
                "  ,DBAMV.USUARIO_MULTI_EMPRESA     M   " +
                "  ,DBAMV.MULTI_EMPRESAS            E   " +
                "    WHERE   " +
                "    U.CD_USUARIO = ?   " +
                "    AND  U.CD_USUARIO = M.CD_ID_USUARIO ";
        
        
        
        try {
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user);
            resultSet = stmt.executeQuery();
            if(resultSet.next()){
                empresa = resultSet.getString(1);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Usuario_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return empresa;
    }
    
    public String recuperarSenha(String user){
        String senha = "";
        conn = ConnectionFactory.getConnection();
        
        sql = "select dbaadv.senhausuariomv(?) SENHA FROM DUAL";
        
        
        
        try {
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user);
            resultSet = stmt.executeQuery();
            if(resultSet.next()){
                senha = resultSet.getString(1);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Usuario_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return senha;
    }
    
}
