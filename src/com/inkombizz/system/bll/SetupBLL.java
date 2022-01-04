package com.inkombizz.system.bll;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.inkombizz.dao.HBMSession;
import com.inkombizz.system.dao.SetupDAO;
import com.inkombizz.system.model.Setup;

public class SetupBLL {
    
    public static final String MODULECODE = "008_SYS_SETUP";
    
    private SetupDAO setupDAO;
    
    public SetupBLL(HBMSession hbmSession) {
        this.setupDAO = new SetupDAO(hbmSession);
    }
    
    public List<Setup> getList() throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Setup.class);
            List<Setup> listSetup = setupDAO.findByCriteria(criteria);
            return listSetup;
        }
        catch(Exception ex) {
            throw ex;
        }
    }

    public Setup get(String code) throws Exception {
        try {
            return (Setup) setupDAO.get(code);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public SetupDAO getSetupDAO() {
        return setupDAO;
    }

    public void setSetupDAO(SetupDAO setupDAO) {
        this.setupDAO = setupDAO;
    }
    
}