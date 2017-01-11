/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package beans;

/**
 *
 * @author carlos.brito
 */
public class Situacao {
    private String mes;
    private String contas;
    private String abertas;
    private String fechadas;
    private String valor_abertas;
    private String nao_protocoladas;
    private String protocoladas;

    public String getMes() {
        return mes;
    }

    public void setMes(String mes) {
        this.mes = mes;
    }

    public String getContas() {
        return contas;
    }

    public void setContas(String contas) {
        this.contas = contas;
    }

    public String getAbertas() {
        return abertas;
    }

    public void setAbertas(String abertas) {
        this.abertas = abertas;
    }

    public String getFechadas() {
        return fechadas;
    }

    public void setFechadas(String fechadas) {
        this.fechadas = fechadas;
    }

    public String getValor_abertas() {
        return valor_abertas;
    }

    public void setValor_abertas(String valor_abertas) {
        this.valor_abertas = valor_abertas;
    }

    public String getNao_protocoladas() {
        return nao_protocoladas;
    }

    public void setNao_protcoladas(String nao_protocoladas) {
        this.nao_protocoladas = nao_protocoladas;
    }

    public String getProtocoladas() {
        return protocoladas;
    }

    public void setProtocoladas(String protocoladas) {
        this.protocoladas = protocoladas;
    }
    
    
   
}
