
package com.inkombizz.finance.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import static com.inkombizz.finance.bll.GeneralJournalBLL.MODULECODE;
import java.util.Date;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import com.inkombizz.finance.dao.GeneralJournalDAO;
import com.inkombizz.finance.model.GeneralJournal;
import com.inkombizz.finance.model.GeneralJournalDetail;
import com.inkombizz.finance.model.GeneralJournalDetailTemp;
import com.inkombizz.finance.model.GeneralJournalField;
import com.inkombizz.finance.model.GeneralJournalTemp;

public class GeneralJournalBLL {
    
    public static final String MODULECODE = "004_FIN_GENERAL_JOURNAL";
    
    private GeneralJournalDAO generalJournalDAO;
    
    public GeneralJournalBLL(HBMSession hbmSession){
        this.generalJournalDAO = new GeneralJournalDAO(hbmSession);
    }
    
    
    public ListPaging<GeneralJournalTemp> findData(Paging paging,String code,String refNo,String remark,Date firstDate,Date lastDate) throws Exception {
        try {
                     
            paging.setRecords(generalJournalDAO.countData(code,refNo,remark,firstDate,lastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<GeneralJournalTemp> listGeneralJournalTemp = generalJournalDAO.findData(code,refNo,remark,firstDate,lastDate,paging.getFromRow(), paging.getToRow());
            
            ListPaging<GeneralJournalTemp> listPaging = new ListPaging<GeneralJournalTemp>();
            
            listPaging.setList(listGeneralJournalTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<GeneralJournalDetailTemp> findDataDetail(String headerCode) throws Exception {
        try {
            
            List<GeneralJournalDetailTemp> listGeneralJournalDetailTemp = generalJournalDAO.findDataDetail(headerCode);

            return listGeneralJournalDetailTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
       
    //check code dah ada di DB?
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(GeneralJournal.class)
                            .add(Restrictions.eq(GeneralJournalField.CODE, headerCode));
             
            if(generalJournalDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public void save(GeneralJournal generalJournal, List<GeneralJournalDetail> listGeneralJournalDetail, Double forexAmount) throws Exception {
        try {
            generalJournalDAO.save(generalJournal, listGeneralJournalDetail, forexAmount, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(GeneralJournal generalJournal, List<GeneralJournalDetail> listDetail, Double forexAmount) throws Exception{
        generalJournalDAO.update(generalJournal, listDetail, forexAmount, MODULECODE);
    }
          
    
    public void delete(String headerCode) throws Exception{
        generalJournalDAO.delete(headerCode, MODULECODE);
    }
}
