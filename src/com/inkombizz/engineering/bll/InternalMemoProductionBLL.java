/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.inkombizz.engineering.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.engineering.dao.InternalMemoProductionDAO;
import com.inkombizz.engineering.model.InternalMemoProduction;
import com.inkombizz.engineering.model.InternalMemoProductionDetail;
import com.inkombizz.engineering.model.InternalMemoProductionDetailTemp;
import com.inkombizz.engineering.model.InternalMemoProductionField;
import com.inkombizz.engineering.model.InternalMemoProductionTemp;
import java.util.Date;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author ikb
 */
public class InternalMemoProductionBLL {
     public static final String MODULECODE = "011_ENG_INTERNAL_MEMO_PRODUCTION";
     public static final String MODULECODE_APPROVAL = "011_ENG_INTERNAL_MEMO_PRODUCTION_APPROVAL";
     public static final String MODULECODE_CLOSING = "011_ENG_INTERNAL_MEMO_PRODUCTION_CLOSING";
    
    private InternalMemoProductionDAO internalMemoProductionDAO;
    
    public InternalMemoProductionBLL(HBMSession hbmSession){
      this.internalMemoProductionDAO = new InternalMemoProductionDAO(hbmSession);
    }
 
    public ListPaging<InternalMemoProductionTemp> findData(Paging paging,String code,String customerCode,String customerName, String refNo, String remark, Date firstDate, Date lastDate) throws Exception {
        try {
                     
            paging.setRecords(internalMemoProductionDAO.countData(code,customerCode,customerName, refNo, remark, firstDate, lastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<InternalMemoProductionTemp> listInternalMemoTemp = internalMemoProductionDAO.findData(code,customerCode,customerName, refNo, remark, paging.getFromRow(), paging.getToRow(), firstDate, lastDate);
            
            ListPaging<InternalMemoProductionTemp> listPaging = new ListPaging<InternalMemoProductionTemp>();
            
            listPaging.setList(listInternalMemoTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     
    public ListPaging<InternalMemoProductionTemp> findDataApproval(Paging paging,String code,String customerCode,String customerName, String refNo, String remark, String approvalStatus, Date firstDate, Date lastDate) throws Exception {
        try {
                     
            paging.setRecords(internalMemoProductionDAO.countDataApproval(code,customerCode,customerName, refNo, remark, approvalStatus, firstDate, lastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<InternalMemoProductionTemp> listInternalMemoTemp = internalMemoProductionDAO.findDataApproval(code,customerCode,customerName, refNo, remark, approvalStatus, paging.getFromRow(), paging.getToRow(), firstDate, lastDate);
            
            ListPaging<InternalMemoProductionTemp> listPaging = new ListPaging<InternalMemoProductionTemp>();
            
            listPaging.setList(listInternalMemoTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     
    public ListPaging<InternalMemoProductionTemp> findDataClosing(Paging paging,String code,String customerCode,String customerName, String refNo, String remark, String closingStatus, Date firstDate, Date lastDate) throws Exception {
        try {
                     
            paging.setRecords(internalMemoProductionDAO.countDataClosing(code,customerCode,customerName, refNo, remark, closingStatus, firstDate, lastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<InternalMemoProductionTemp> listInternalMemoTemp = internalMemoProductionDAO.findDataClosing(code,customerCode,customerName, refNo, remark, closingStatus, paging.getFromRow(), paging.getToRow(), firstDate, lastDate);
            
            ListPaging<InternalMemoProductionTemp> listPaging = new ListPaging<InternalMemoProductionTemp>();
            
            listPaging.setList(listInternalMemoTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     
    public List<InternalMemoProductionDetailTemp> findDataDetail(String headerCode,String customerCode) throws Exception {
        try {
            
            List<InternalMemoProductionDetailTemp> listInternalMemoProductionDetailTemp = internalMemoProductionDAO.findDataDetail(headerCode,customerCode);
            
            return listInternalMemoProductionDetailTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(InternalMemoProduction.class)
                            .add(Restrictions.eq(InternalMemoProductionField.CODE, headerCode));
             
            if(internalMemoProductionDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public void save(InternalMemoProduction internalMemoProduction, List<InternalMemoProductionDetail> listInternalMemoProductionDetail) throws Exception {
        try {
            internalMemoProductionDAO.save(internalMemoProduction, listInternalMemoProductionDetail, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(InternalMemoProduction internalMemoProduction, List<InternalMemoProductionDetail>  listInternalMemoProductionDetail) throws Exception{
        try{
            internalMemoProductionDAO.update(internalMemoProduction, listInternalMemoProductionDetail, MODULECODE);
        }catch(Exception e){
            throw e;
        }
    }
    
    public void delete(String code) throws Exception{
        try{
            internalMemoProductionDAO.delete(code, MODULECODE);
        }catch(Exception e){
            throw e;
        }
    }
    
    public void approval(InternalMemoProduction internalMemoProduction) throws Exception {
        try {
            internalMemoProductionDAO.approval(internalMemoProduction,MODULECODE_APPROVAL);
        } catch (Exception e) {
            throw e;
        }
    }
    
    public void closing(InternalMemoProduction internalMemoProduction) throws Exception {
        try {
            internalMemoProductionDAO.closing(internalMemoProduction,MODULECODE_CLOSING);
        } catch (Exception e) {
            throw e;
        }
    }
}
