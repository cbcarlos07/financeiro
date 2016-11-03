/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
//import servicos.MensagensAviso;
/**
 *
 * @author Brito
 */
public final class ConnectionFactory {
    
      
    public static Connection getConnection(){
		Connection connection = null;
                String url= null;
		try{
                        
                        
			
                         Class.forName("oracle.jdbc.driver.OracleDriver");
                         url ="jdbc:oracle:thin:@//ip-do-servidor/servico";
                        connection = DriverManager.getConnection(url,"usuario-do-banco","senha-do-banco");
			
			System.out.println("Conectado com sucesso");
		}catch (SQLException e) {
			e.printStackTrace();
		}
		catch (ClassNotFoundException e) {
                        
                        e.printStackTrace();
                        
		}
                 
            //    System.out.println(url);
		return connection;
	}

    
    
}
