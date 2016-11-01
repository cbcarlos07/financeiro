/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package auth;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

/**
 *
 * @author carlos.brito
 */
public class Autenticar extends Authenticator{
    private PasswordAuthentication authentication;

    public Autenticar(String login, String password) {
        authentication = new PasswordAuthentication(login, password);
    }

    protected PasswordAuthentication getPasswordAuthentication() {
        return authentication;
    }
}
