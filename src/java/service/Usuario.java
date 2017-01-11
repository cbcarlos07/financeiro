/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package service;

import controller.Usuario_Controller;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONArray;
import org.json.JSONObject;
import java.io.PrintWriter;

/**
 *
 * @author carlos.brito
 */
@WebServlet("/usuario")
public class Usuario extends HttpServlet {
    Usuario_Controller uc = new Usuario_Controller();
    JSONObject json = new JSONObject();
    JSONArray jsonArray = new JSONArray(); 
    PrintWriter out ;
   
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
         out = resp.getWriter();
        String login = req.getParameter("usuario").toUpperCase();
        String acao  = req.getParameter("acao");
        String senha = "";
        try{
            senha = req.getParameter("senha").toUpperCase();
        }catch(Exception e){}
        char action = acao.charAt(0);
        switch(action){
            case 'E':
                recuperarEmpresa(login);
                break;
            case 'L':
                login(login, senha, req);
                break;
        }
    }
     public  void recuperarEmpresa(String user){
         System.out.println("User: "+user);
         String empresa = uc.recuperarEmpresa(user);
         json.put("response", empresa);
         //System.out.println("Empresa: "+empresa);
         jsonArray.put(json);
         out.print(json);
         
         
    }
    
   private void login(String user, String senha, HttpServletRequest req ){
     HttpSession session ;
     String pwd = uc.recuperarSenha(user);
       System.out.println("User login: "+user);
     if(pwd.equals(senha)){
          session =  req.getSession();
          session.setAttribute("user", user);
          out.print("1");
     }else{
         out.print("0");
     }
  }
     
     
}
