package com.inkombizz.system.dao;

import com.inkombizz.dao.HBMSession;
import com.inkombizz.system.model.Setup;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;

public class SetupDAO {
    private HBMSession hbmSession;
    
    public SetupDAO(HBMSession session){
        this.hbmSession = session;
    }
    
    public List<Setup> findByCriteria(DetachedCriteria dc){
        try{
            Criteria criteria = dc.getExecutableCriteria(hbmSession.hSession);
            
            return criteria.list();
        }
        catch(HibernateException e){
            throw e;
        }
    }
    
    public Setup get(String code) {
        try {
            return (Setup) hbmSession.hSession.get(Setup.class, code);
        }
        catch (HibernateException e) {
            throw e;
        }
    }  
    
    
}
