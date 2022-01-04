

package com.inkombizz.master.bll;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.common.enumeration.EnumTriState.Enum_TriState;
import com.inkombizz.dao.HBMSession;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.master.dao.JournalDAO;
import com.inkombizz.master.model.Journal;
import com.inkombizz.master.model.JournalChartOfAccount;
import com.inkombizz.master.model.JournalChartOfAccountTemp;
import com.inkombizz.master.model.JournalField;
import com.inkombizz.master.model.JournalTemp;


public class JournalBLL {
    
    public static final String MODULECODE = "006_MST_JOURNAL";
    
    private JournalDAO journalDAO;
    
    public JournalBLL(HBMSession hbmSession){
        this.journalDAO=new JournalDAO(hbmSession);
    }
    
    public ListPaging<Journal> get (Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Journal.class);           
            
            paging.setRecords(journalDAO.countByCriteria(criteria));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<Journal> listDivision = journalDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
            
            ListPaging<Journal> listPaging = new ListPaging<Journal>();
            
            listPaging.setList(listDivision);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<JournalTemp> getData (String code, String name,Paging paging) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(Journal.class);           
            
            paging.setRecords(journalDAO.countData(code,name));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
            
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<JournalTemp> JournalTemp = journalDAO.findData(code,name, paging.getFromRow(), paging.getToRow());
            
            ListPaging<JournalTemp> listPaging = new ListPaging<JournalTemp>();
            
            listPaging.setList(JournalTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<JournalChartOfAccountTemp> listDataDetail(String journalCode) throws Exception{
        try{
            
            List<JournalChartOfAccountTemp> listJournalDetailTemp = journalDAO.findDataDetail(journalCode);
            
            return listJournalDetailTemp;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<JournalChartOfAccountTemp> listDataGetDetail(String journalCode) throws Exception{
        try{
             List<JournalChartOfAccountTemp> listJournalDetailTemp = journalDAO.findDataGetDetail(journalCode);
            return listJournalDetailTemp;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public JournalTemp get(String code) throws Exception {
        try {
            return (JournalTemp) journalDAO.get(code);
        }
        catch (Exception e) {
            throw e;
        }
    }
      
    public void save(Journal journal,List<JournalChartOfAccount> listJournalChartOfAccount) throws Exception {
        try {
            journalDAO.save(journal,listJournalChartOfAccount,MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }  
    
    
//    public void update(Journal journal,List<JournalDetailTemp> listJournalDetailTemp) throws Exception {
//        try {
//            journalDAO.update(journal,listJournalDetailTemp, MODULECODE);
//        }
//        catch (Exception e) {
//            throw e;
//        }
//    }
      
//    public void delete(String code) throws Exception {
//        try {
//            journalDAO.delete(code, MODULECODE);
//        }
//        catch (Exception e) {
//            throw e;
//        }
//    }
    
//    public ListPaging<Journal> search(Paging paging, String code, String name, Enum_TriState activeStatus) throws Exception {
//        try {
//            DetachedCriteria criteria = DetachedCriteria.forClass(Journal.class)
//                    .add(Restrictions.like(JournalField.CODE, code + "%" ))
//                    .add(Restrictions.like(JournalField.NAME, "%" + name + "%"));
//            
//            if(activeStatus != activeStatus.ALL){
//                if (activeStatus == activeStatus.YES)
//                criteria.add(Restrictions.eq(JournalField.ACTIVESTATUS,true));
//            else if (activeStatus == activeStatus.NO)
//                criteria.add(Restrictions.eq(JournalField.ACTIVESTATUS, false));
//            }
//            
//            paging.setRecords(journalDAO.countByCriteria(criteria));
//            criteria.setProjection(null);
//            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
//            criteria = paging.addOrderCriteria(criteria);
//            
//            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
//            
//            List<Journal> listDivision = journalDAO.findByCriteria(criteria, paging.getFromRow(), paging.getToRow());
//            
//            ListPaging<Journal> listPaging = new ListPaging<Journal>();
//            
//            listPaging.setList(listDivision);
//            listPaging.setPaging(paging);
//            
//            return listPaging;  
//        }
//        catch(Exception ex) {
//            throw ex;
//        }
//    }
     
    
    public boolean isExist(String code) throws Exception{
        try{
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(Journal.class)
                            .add(Restrictions.eq(JournalField.CODE, code));
             
            if(journalDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
//    public boolean isExistToDelete(String code) throws Exception{
//        try{
//            boolean exist = false;
//             
//            if(journalDAO.checkIsExistToDeleteInvoice(code) > 0){
//                 exist = true;
//                }
//          
//            return exist;
//        }
//        catch(Exception ex){
//            throw ex;
//        }
//    }
    
//    public void saveDetail(List<JournalDetailTemp> listJournalDetailTemp) throws Exception {
//        try {
//            journalDAO.saveDetail(listJournalDetailTemp);
//        } catch (Exception e){
//            throw e;
//        }
//    }
}
