
package com.inkombizz.finance.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.dao.GiroReceivedRejectDAO;
import com.inkombizz.finance.model.GiroReceived;
import com.inkombizz.finance.model.GiroReceivedRejectTemp;
import java.util.Date;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class GiroReceivedRejectBLL {
    
    public static final String MODULECODE = "004_FIN_GIRO_RECEIVED_REJECT";
    
    private GiroReceivedRejectDAO giroReceivedRejectDAO;
    
    public GiroReceivedRejectBLL(HBMSession hbmSession){
        this.giroReceivedRejectDAO = new GiroReceivedRejectDAO(hbmSession);
    }
    
    public ListPaging<GiroReceivedRejectTemp> findData(Paging paging,String code,String bankCode,String remark,String grpNo,String giroNo,
            String bankName,String refNo,String giroStatus,Date firstDate, Date lastDate,Date firstDueDate, Date lastDueDate) throws Exception {
        try {
//          count data header         
            paging.setRecords(giroReceivedRejectDAO.countData(code,bankCode,remark,grpNo,giroNo,bankName,refNo,giroStatus,firstDate,
                    lastDate,firstDueDate,lastDueDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<GiroReceivedRejectTemp> listGiroReceivedRejectTemp = giroReceivedRejectDAO.findData(code,bankCode,remark,grpNo,
                    giroNo,bankName,refNo,giroStatus,firstDate, lastDate,firstDueDate,lastDueDate,paging.getFromRow(), paging.getToRow());
            
            ListPaging<GiroReceivedRejectTemp> listPaging = new ListPaging<GiroReceivedRejectTemp>();
            
            listPaging.setList(listGiroReceivedRejectTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public GiroReceivedRejectTemp get(String code) throws Exception {
        try {
            return GiroReceivedRejectDAO.get(code);
        }
        catch (Exception ex) {
            throw ex;
        }
    }
    
    public void save(GiroReceived giroReceivedReject) throws Exception {
        try {
            giroReceivedRejectDAO.save(giroReceivedReject, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
     
    
}
