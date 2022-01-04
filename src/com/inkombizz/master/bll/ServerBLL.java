
package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.ServerDAO;
import com.inkombizz.master.model.Server;
import com.inkombizz.master.model.ServerField;
import com.inkombizz.master.model.ServerTemp;


public class ServerBLL {
    
    public final String MODULECODE = "006_MST_SERVER";
    
    private ServerDAO serverDAO;
    
    public ServerBLL(HBMSession hbmSession){
        this.serverDAO=new ServerDAO(hbmSession);
    }
    
    public ListPaging<ServerTemp> findData(String code, String name,String active,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Server.class);           
    
            paging.setRecords(serverDAO.countData(code,name,active));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ServerTemp> listServerTemp = serverDAO.findData(code,name,active, paging.getFromRow(), paging.getToRow());
            
            ListPaging<ServerTemp> listPaging = new ListPaging<ServerTemp>();
            
            listPaging.setList(listServerTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public ServerTemp findData(String code) throws Exception {
        try {
            return (ServerTemp) serverDAO.findData(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public ServerTemp findData(String code,boolean active) throws Exception {
        try {
            return (ServerTemp) serverDAO.findData(code,active);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void save(Server server) throws Exception {
        try {
            serverDAO.save(server, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(Server server) throws Exception {
        try {
            serverDAO.update(server, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void delete(String code) throws Exception {
        try {
            serverDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    } 
 
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Server.class)
                            .add(Restrictions.eq(ServerField.CODE, code));
             
            if(serverDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
}
