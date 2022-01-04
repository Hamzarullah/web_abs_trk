/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.finance.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.dao.GiroReceivedInquiryDAO;
import com.inkombizz.finance.model.GiroReceived;
import com.inkombizz.finance.model.GiroReceivedInquiryTemp;
import java.util.Date;
import java.util.List;

/**
 *
 * @author Rayis
 */
public class GiroReceivedInquiryBLL {
      
    public static final String MODULECODE = "004_FIN_GIRO_RECEIVED_INQUIRY";
    
    private GiroReceivedInquiryDAO giroReceivedInquiryDAO;
    
    public GiroReceivedInquiryBLL(HBMSession hbmSession){
        this.giroReceivedInquiryDAO = new GiroReceivedInquiryDAO(hbmSession);
    }
    
    public ListPaging<GiroReceivedInquiryTemp> findData(Paging paging,String code,String bankCode,String remark,String grpNo,String giroNo,
            String bankName,String refNo,String giroStatus,Date firstDate, Date lastDate,Date firstDueDate, Date lastDueDate) throws Exception {
        try {
//          count data header         
            paging.setRecords(giroReceivedInquiryDAO.countData(code,bankCode,remark,grpNo,giroNo,bankName,refNo,giroStatus,
                    firstDate,lastDate,firstDueDate,lastDueDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<GiroReceivedInquiryTemp> listGiroReceivedInquiryTemp = giroReceivedInquiryDAO.findData(code,bankCode,remark,grpNo,
                    giroNo,bankName,refNo,giroStatus,firstDate, lastDate,firstDueDate,lastDueDate,paging.getFromRow(), paging.getToRow());
            
            ListPaging<GiroReceivedInquiryTemp> listPaging = new ListPaging<GiroReceivedInquiryTemp>();
            
            listPaging.setList(listGiroReceivedInquiryTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public void save(GiroReceived giroReceivedInquiry) throws Exception {
        try {
            giroReceivedInquiryDAO.save(giroReceivedInquiry, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }

    public GiroReceivedInquiryDAO getGiroReceivedInquiryDAO() {
        return giroReceivedInquiryDAO;
    }

    public void setGiroReceivedInquiryDAO(GiroReceivedInquiryDAO giroReceivedInquiryDAO) {
        this.giroReceivedInquiryDAO = giroReceivedInquiryDAO;
    }
     
}
