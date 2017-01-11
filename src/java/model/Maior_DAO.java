/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import beans.Abertas;
import beans.Maior;
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
public class Maior_DAO {
    String sql;
    Connection conn;
    PreparedStatement stmt;
    List lista;
    ResultSet resultSet;
    
    public List<Maior> getMaior(){
        lista = new ArrayList();
        System.out.print("Contas Abertas: ");
        conn = ConnectionFactory.getConnection();
        sql = "SELECT IND " +
            "      ,DT_INTERNACAO " +
            "      ,atd " +
            "      ,INITCAP(NOME_PACIENTE) " +
            "      ,cast(IDADE as char(3)) IDADE " +
            "      ,INITCAP(CONVENIO) " +
            "      ,DBAADV.FNC_INIT_LETRAS(SETOR) " +
            "      ,PERMANENCIA " +
            "      ,TO_CHAR(VALOR,'999G999G999D99') VL_TOTAL " +
            "  FROM ( " +
            " " +
            "          SELECT 1 IND " +
            "                ,A.DT_ATENDIMENTO DT_INTERNACAO " +
            "                ,A.CD_ATENDIMENTO ATD " +
            "                ,P.NM_PACIENTE    NOME_PACIENTE " +
            "                ,C.NM_CONVENIO    CONVENIO " +
            "                ,fnc_retorna_unid_int(L.CD_LEITO) SETOR " +
            "                ,SUM(RF.VL_TOTAL_CONTA) VALOR " +
            "                ,TO_DATE(SYSDATE,'DD/MM/YY') - A.DT_ATENDIMENTO||' dia(s)' PERMANENCIA " +
            "                ,Fnc_Editor_Retorna_Metadados(A.CD_ATENDIMENTO,'NR_IDADE_PACIENTE')IDADE " +
            "            FROM DBAMV.REG_FAT  RF " +
            "                ,DBAMV.ATENDIME A " +
            "                ,DBAMV.PACIENTE P " +
            "                ,DBAMV.LEITO    L " +
            "                ,DBAMV.CONVENIO C " +
            "           WHERE A.CD_ATENDIMENTO = RF.CD_ATENDIMENTO " +
            "             AND A.CD_CONVENIO    = C.CD_CONVENIO " +
            "             AND A.CD_LEITO       = L.CD_LEITO " +
            "             AND A.CD_PACIENTE    = P.CD_PACIENTE " +
            "             AND A.TP_ATENDIMENTO = 'I' " +
            "             AND A.DT_ALTA IS NULL " +
            " " +
            "             GROUP BY " +
            "                      A.DT_ATENDIMENTO " +
            "                     ,A.CD_ATENDIMENTO " +
            "                     ,P.NM_PACIENTE " +
            "                     ,C.NM_CONVENIO " +
            "                     ,L.CD_LEITO " +
            "                     ,TO_DATE(SYSDATE,'DD/MM/YY') - A.DT_ATENDIMENTO " +
            "    ) " +
            " " +
            "     WHERE VALOR > 50000 " +
            " " +
            " " +
            "UNION " +
            " " +
            " " +
            " " +
            "SELECT 2 IND " +
            "      ,NULL " +
            "      ,NULL " +
            "      ,NULL " +
            "      ,NULL " +
            "      ,NULL " +
            "      ,NULL " +
            "      ,'Total:' " +
            "      ,TO_CHAR(SUM(VALOR),'999G999G999D99') VALOR " +
            " " +
            "  FROM ( " +
            "  SELECT 1 IND " +
            "                ,A.DT_ATENDIMENTO DT_INTERNACAO " +
            "                ,A.CD_ATENDIMENTO ATD " +
            "                ,P.NM_PACIENTE    NOME_PACIENTE " +
            "                ,C.NM_CONVENIO    CONVENIO " +
            "                ,(SELECT U.DS_UNID_INT FROM LEITO, UNID_INT U WHERE LEITO.CD_LEITO = L.CD_LEITO AND LEITO.CD_UNID_INT = U.CD_UNID_INT) SETOR " +
            "                ,SUM(RF.VL_TOTAL_CONTA) VALOR " +
            "                ,TO_DATE(SYSDATE,'DD/MM/YY') - A.DT_ATENDIMENTO||' dia(s)' PERMANENCIA " +
            "                ,Fnc_Editor_Retorna_Metadados(A.CD_ATENDIMENTO,'NR_IDADE_PACIENTE')IDADE " +
            "            FROM DBAMV.REG_FAT  RF " +
            "                ,DBAMV.ATENDIME A " +
            "                ,DBAMV.PACIENTE P " +
            "                ,DBAMV.LEITO    L " +
            "                ,DBAMV.CONVENIO C " +
            "           WHERE A.CD_ATENDIMENTO = RF.CD_ATENDIMENTO " +
            "             AND A.CD_CONVENIO    = C.CD_CONVENIO " +
            "             AND A.CD_LEITO       = L.CD_LEITO " +
            "             AND A.CD_PACIENTE    = P.CD_PACIENTE " +
            "             AND A.TP_ATENDIMENTO = 'I' " +
            "             AND A.DT_ALTA IS NULL " +
            "             GROUP BY " +
            "                      A.DT_ATENDIMENTO " +
            "                     ,A.CD_ATENDIMENTO " +
            "                     ,P.NM_PACIENTE " +
            "                     ,C.NM_CONVENIO " +
            "                     ,L.CD_LEITO " +
            "                     ,TO_DATE(SYSDATE,'DD/MM/YY') - A.DT_ATENDIMENTO " +
            "         ) " +
            "    WHERE VALOR > 50000 " +
            " " +
            " ORDER BY 1,8 DESC";
        
        try {
            stmt = conn.prepareStatement(sql);
            resultSet = stmt.executeQuery();
            
            while(resultSet.next()){
                Maior conta = new Maior();
                conta.setData(resultSet.getDate(2));
                conta.setAtendimento(resultSet.getString(3));
                conta.setPaciente(resultSet.getString(4));
                conta.setIdade(resultSet.getString(5));
                conta.setConvenio(resultSet.getString(6));
                conta.setSetor(resultSet.getString(7));
                conta.setPermanencia(resultSet.getString(8));
                conta.setValor(resultSet.getString(9));
                lista.add(conta);
            }
            conn.close();
        } catch (SQLException ex) {
            Logger.getLogger(Maior_DAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return lista;
    }
    
    
}
