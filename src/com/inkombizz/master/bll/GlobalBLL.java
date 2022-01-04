
package com.inkombizz.master.bll;

import com.inkombizz.dao.HBMSession;
import com.inkombizz.master.dao.GlobalDAO;
import com.inkombizz.master.model.Global;
import java.util.List;


public class GlobalBLL {
    
    private GlobalDAO globalDAO;
    
    public GlobalBLL(HBMSession hbmSession){
        this.globalDAO=new GlobalDAO(hbmSession);
    }
    
    public List<Global> usedBranch(String code) throws Exception {
        try {
            return (List<Global>) globalDAO.usedBranch(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public List<Global> usedCity(String code) throws Exception {
        try {
            return (List<Global>) globalDAO.usedCity(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public List<Global> usedSalesman(String code) throws Exception {
        try {
            return (List<Global>) globalDAO.usedCity(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public List<Global> usedCountry(String code) throws Exception {
        try {
            return (List<Global>) globalDAO.usedCountry(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
}
