
package com.inkombizz.finance.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.dao.GiroPaymentRejectDAO;
import com.inkombizz.finance.model.GiroPayment;
import com.inkombizz.finance.model.GiroPaymentField;
import com.inkombizz.finance.model.GiroPaymentRejectTemp;
import java.util.Date;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class GiroPaymentRejectBLL {
    
    public static final String MODULECODE = "004_FIN_GIRO_PAYMENT";
    
    private GiroPaymentRejectDAO giroPaymentRejectDAO;
    
    public GiroPaymentRejectBLL(HBMSession hbmSession){
        this.giroPaymentRejectDAO = new GiroPaymentRejectDAO(hbmSession);
    }
    
    public ListPaging<GiroPaymentRejectTemp> findData(Paging paging,String code,String bankCode,String remark,String grpNo,String giroNo,
            String bankName,String refNo,String giroStatus,Date firstDate, Date lastDate,Date firstDueDate, Date lastDueDate) throws Exception {
        try {
//          count data header         
            paging.setRecords(giroPaymentRejectDAO.countData(code,bankCode,remark,grpNo,giroNo,bankName,refNo,giroStatus,
                    firstDate,lastDate,firstDueDate,lastDueDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<GiroPaymentRejectTemp> listGiroPaymentRejectTemp = giroPaymentRejectDAO.findData(code,bankCode,remark,grpNo,
                    giroNo,bankName,refNo,giroStatus,firstDate, lastDate,firstDueDate,lastDueDate,paging.getFromRow(), paging.getToRow());
            
            ListPaging<GiroPaymentRejectTemp> listPaging = new ListPaging<GiroPaymentRejectTemp>();
            
            listPaging.setList(listGiroPaymentRejectTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public void save(GiroPayment giroPaymentRejected) throws Exception {
        try {
            giroPaymentRejectDAO.save(giroPaymentRejected, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public GiroPaymentRejectDAO getGiroPaymentRejectDAO() {
        return giroPaymentRejectDAO;
    }

    public void setGiroPaymentRejectDAO(GiroPaymentRejectDAO giroPaymentRejectDAO) {
        this.giroPaymentRejectDAO = giroPaymentRejectDAO;
    }
     
    
    
}
