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
public class Financeiro {
    private String ind_Unid;
    private String ontem;
    private String media;
    private String acumulado;
    private String leito;
    private String total;

    public String getInd_Unid() {
        return ind_Unid;
    }

    public void setInd_Unid(String ind_Unid) {
        this.ind_Unid = ind_Unid;
    }

    public String getOntem() {
        return ontem;
    }

    public void setOntem(String ontem) {
        this.ontem = ontem;
    }

    public String getMedia() {
        return media;
    }

    public void setMedia(String media) {
        this.media = media;
    }

    public String getAcumulado() {
        return acumulado;
    }

    public void setAcumulado(String acumulado) {
        this.acumulado = acumulado;
    }

    public String getLeito() {
        return leito;
    }

    public void setLeito(String leito) {
        this.leito = leito;
    }

    public String getTotal() {
        return total;
    }

    public void setTotal(String total) {
        this.total = total;
    }
    
}
