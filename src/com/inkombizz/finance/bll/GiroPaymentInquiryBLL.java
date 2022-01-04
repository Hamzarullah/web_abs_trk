/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.bll;

/**
 *
 * @author Rayis
 */

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.dao.GiroPaymentInquiryDAO;
import com.inkombizz.finance.model.GiroPayment;
import com.inkombizz.finance.model.GiroPaymentField;
import com.inkombizz.finance.model.GiroPaymentInquiryTemp;
import java.util.Date;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class GiroPaymentInquiryBLL {
    
    public static final String MODULECODE = "004_FIN_GIRO_PAYMENT_INQUIRY";
    
    private GiroPaymentInquiryDAO giroPaymentInquiryDAO;
    
    public GiroPaymentInquiryBLL(HBMSession hbmSession){
        this.giroPaymentInquiryDAO = new GiroPaymentInquiryDAO(hbmSession);
    }
    
    public ListPaging<GiroPaymentInquiryTemp> findData(Paging paging,String code,String bankCode,String remark,String grpNo,String giroNo,
            String bankName,String refNo,String giroStatus,Date firstDate, Date lastDate,Date firstDueDate, Date lastDueDate) throws Exception {
        try {
//          count data header         
            paging.setRecords(giroPaymentInquiryDAO.countData(code,bankCode,remark,grpNo,giroNo,bankName,refNo,giroStatus,
                    firstDate,lastDate,firstDueDate,lastDueDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<GiroPaymentInquiryTemp> listGiroPaymentInquiryTemp = giroPaymentInquiryDAO.findData(code,bankCode,remark,grpNo,
                    giroNo,bankName,refNo,giroStatus,firstDate, lastDate,firstDueDate,lastDueDate,paging.getFromRow(), paging.getToRow());
            
            ListPaging<GiroPaymentInquiryTemp> listPaging = new ListPaging<GiroPaymentInquiryTemp>();
            
            listPaging.setList(listGiroPaymentInquiryTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public void save(GiroPayment giroPaymentInquiry) throws Exception {
        try {
            giroPaymentInquiryDAO.save(giroPaymentInquiry, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public GiroPaymentInquiryDAO getGiroPaymentInquiryDAO() {
        return giroPaymentInquiryDAO;
    }

    public void setGiroPaymentInquiryDAO(GiroPaymentInquiryDAO giroPaymentInquiryDAO) {
        this.giroPaymentInquiryDAO = giroPaymentInquiryDAO;
    }
     
    
    
}
