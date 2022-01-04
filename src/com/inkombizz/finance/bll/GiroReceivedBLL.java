
package com.inkombizz.finance.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.dao.GiroReceivedDAO;
import com.inkombizz.finance.model.GiroReceived;
import com.inkombizz.finance.model.GiroReceivedField;
import com.inkombizz.finance.model.GiroReceivedTemp;
import java.util.Date;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class GiroReceivedBLL {
    
    public static final String MODULECODE = "004_FIN_GIRO_RECEIVED";
    public static final String MODULECODE_REJECTED = "004_FIN_GIRO_RECEIVED_REJECTED";
    
    private GiroReceivedDAO giroReceivedDAO;
    
    public GiroReceivedBLL(HBMSession hbmSession){
        this.giroReceivedDAO = new GiroReceivedDAO(hbmSession);
    }
    
    public ListPaging<GiroReceivedTemp> findData( Paging paging,String code,String giroStatus,Date firstDate,Date lastDate) throws Exception {
        try {
                     
            paging.setRecords(giroReceivedDAO.countData(code,giroStatus,firstDate,lastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<GiroReceivedTemp> listGiroReceivedTemp = giroReceivedDAO.findData(code,giroStatus,firstDate,lastDate,paging.getFromRow(), paging.getToRow());
            
            ListPaging<GiroReceivedTemp> listPaging = new ListPaging<GiroReceivedTemp>();
            
            listPaging.setList(listGiroReceivedTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(GiroReceived.class)
                            .add(Restrictions.eq(GiroReceivedField.CODE, headerCode));
             
            if(giroReceivedDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public List<GiroReceivedTemp> isUsedByBankReceived (String code ) throws Exception{
        try{
            
            return giroReceivedDAO.isUsedByBankReceived(code);
        }
        catch(Exception ex){
            ex.printStackTrace();
            throw ex;
        }
    }
    
    public Boolean isRejected(String code) throws Exception{
        try {
            return giroReceivedDAO.isRejected(code);
        } catch (HibernateException e) {
            e.printStackTrace();
            return Boolean.FALSE;
        }
    }
    
    public boolean isGiroNoAndBankCodeExist(String giroNo,String bankCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(GiroReceived.class)
                            .add(Restrictions.eq(GiroReceivedField.GIRONO, giroNo))
                            .add(Restrictions.eq(GiroReceivedField.BANKCODE, bankCode));
             
            if(giroReceivedDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public void save(GiroReceived giroReceived) throws Exception {
        try {
            giroReceivedDAO.save(giroReceived,MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(GiroReceived giroReceived) throws Exception{
        giroReceivedDAO.update(giroReceived, MODULECODE);
    }
    
    public void rejected(GiroReceived giroReceived) throws Exception{
        giroReceivedDAO.rejected(giroReceived, MODULECODE);
    }
    
    public void delete(String code) throws Exception {
        try {
            giroReceivedDAO.delete(code, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
}
