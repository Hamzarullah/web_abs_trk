
package com.inkombizz.sales.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.dao.SalesQuotationDAO;
import com.inkombizz.sales.model.SalesQuotation;
import com.inkombizz.sales.model.SalesQuotationDetail;
import com.inkombizz.sales.model.SalesQuotationDetailTemp;
import com.inkombizz.sales.model.SalesQuotationField;
import com.inkombizz.sales.model.SalesQuotationTemp;
import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

public class SalesQuotationBLL {
    
    public static final String MODULECODE = "002_SAL_SALES_QUOTATION";
    public static final String MODULECODE_STATUS = "002_SAL_SALES_QUOTATION_STATUS";
    
    private SalesQuotationDAO salesQuotationDAO;
    
    public SalesQuotationBLL(HBMSession hbmSession){
        this.salesQuotationDAO = new SalesQuotationDAO(hbmSession);
    }
    
    public ListPaging<SalesQuotationTemp> findData(Paging paging,String code,String remark, String refNo, String customerCode,String customerName, String endUserCode, String endUserName, String status, String active, Date firstDate, Date lastDate) throws Exception {
        try {
                     
            paging.setRecords(salesQuotationDAO.countData(code,remark, refNo, customerCode,customerName, endUserCode, endUserName, status, active, firstDate, lastDate));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<SalesQuotationTemp> listSalesQuotationTemp = salesQuotationDAO.findData(code,remark, refNo, customerCode,customerName,endUserCode, endUserName, status, active,paging.getFromRow(), paging.getToRow(), firstDate, lastDate);
            
            ListPaging<SalesQuotationTemp> listPaging = new ListPaging<SalesQuotationTemp>();
            
            listPaging.setList(listSalesQuotationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public ListPaging<SalesQuotationTemp> findSearchData(Paging paging,SalesQuotationTemp salesQuotationTemp) throws Exception {
        try {
                     
            paging.setRecords(salesQuotationDAO.countSearchData(salesQuotationTemp));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<SalesQuotationTemp> listSalesQuotationTemp = salesQuotationDAO.findSearchData(salesQuotationTemp,paging.getFromRow(), paging.getToRow());
            
            ListPaging<SalesQuotationTemp> listPaging = new ListPaging<SalesQuotationTemp>();
            
            listPaging.setList(listSalesQuotationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     
        public ListPaging<SalesQuotationTemp> findDataArray(Paging paging,SalesQuotationTemp salesQuotationTemp, String concat) throws Exception {
        try {
                     
            paging.setRecords(salesQuotationDAO.countDataArray(salesQuotationTemp, concat));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<SalesQuotationTemp> listSalesQuotationTemp = salesQuotationDAO.findDataArray(salesQuotationTemp,concat,paging.getFromRow(), paging.getToRow());
            
            ListPaging<SalesQuotationTemp> listPaging = new ListPaging<SalesQuotationTemp>();
            
            listPaging.setList(listSalesQuotationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     
        public ListPaging<SalesQuotationDetailTemp> findDataDetailArray(Paging paging, String concat) throws Exception {
        try {
                     
            paging.setRecords(salesQuotationDAO.countDataDetailArray(concat));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<SalesQuotationDetailTemp> listSalesQuotationDetailTemp = salesQuotationDAO.findDataArrayDetail(concat,paging.getFromRow(), paging.getToRow());
            
            ListPaging<SalesQuotationDetailTemp> listPaging = new ListPaging<SalesQuotationDetailTemp>();
            
            listPaging.setList(listSalesQuotationDetailTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
     
    public ListPaging<SalesQuotationTemp> findStatusData(Paging paging,String code,String remark, String refNo, String customerCode,String customerName,String salQuoStatus, String validStatus, Date fromDate,Date upToDate) throws Exception {
        try {
            DetachedCriteria criteria = DetachedCriteria.forClass(SalesQuotation.class);           
    
            paging.setRecords(salesQuotationDAO.countDataStatus(code, remark, refNo, customerCode,customerName, salQuoStatus, validStatus, fromDate,upToDate));
            
            criteria.setProjection(null);
            criteria.setResultTransformer(Criteria.ROOT_ENTITY);
            
            criteria = paging.addOrderCriteria(criteria);          
 
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<SalesQuotationTemp> listRequestForQuotationTemp = salesQuotationDAO.findDataStatus(code, remark, refNo, customerCode,customerName, salQuoStatus, validStatus, fromDate,upToDate,paging.getFromRow(),paging.getToRow());
            
            ListPaging<SalesQuotationTemp> listPaging = new ListPaging<SalesQuotationTemp>();
            
            listPaging.setList(listRequestForQuotationTemp);
            listPaging.setPaging(paging);
            
            return listPaging;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<SalesQuotationDetailTemp> findDataDetail(String headerCode) throws Exception {
        try {
            
            List<SalesQuotationDetailTemp> listSalesQuotationDetailTemp = salesQuotationDAO.findDataDetail(headerCode);
            
            return listSalesQuotationDetailTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<SalesQuotationDetailTemp> findDataDetail(ArrayList arrSalesQuotationNo) throws Exception {
        try {
            
            List<SalesQuotationDetailTemp> listSalesQuotationDetailTemp = salesQuotationDAO.findDataDetail(arrSalesQuotationNo);
            
            return listSalesQuotationDetailTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
//    public List<SalesQuotationTemp> findDataSales(ArrayList<String> SQCode) throws Exception{
//        try{            
//            
//            List<SalesQuotationTemp> listSalesQuotationTemp = salesQuotationDAO.findDataSales(SQCode);
//            
//            return listSalesQuotationTemp;
//        }
//        catch(Exception ex){
//            ex.printStackTrace();
//            return null;
//        }
//    }
    
    public void saveRevise(SalesQuotation salesQuotation, List<SalesQuotationDetail> listSalesQuotationDetail) throws Exception {
        try {
            salesQuotationDAO.saveRevise(salesQuotation,listSalesQuotationDetail, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    public boolean isExist(String headerCode) throws Exception{
        try{            
            boolean exist = false;
            
            DetachedCriteria criteria = DetachedCriteria.forClass(SalesQuotation.class)
                            .add(Restrictions.eq(SalesQuotationField.CODE, headerCode));
             
            if(salesQuotationDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public void save(SalesQuotation salesQuotation, List<SalesQuotationDetail> listSalesQuotationDetail) throws Exception {
        try {
            salesQuotationDAO.save(salesQuotation, listSalesQuotationDetail, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(SalesQuotation salesQuotation, List<SalesQuotationDetail> listDetail) throws Exception{
        try{
            salesQuotationDAO.update(salesQuotation, listDetail, MODULECODE);
        }catch(Exception e){
            throw e;
        }
    }
    
    public void delete(String code) throws Exception{
        try{
            salesQuotationDAO.delete(code, MODULECODE);
        }catch(Exception e){
            throw e;
        }
    }
    
    public List<SalesQuotationDetailTemp> importExcel(String valveType, File sqExcel) throws Exception {
        try {
            return salesQuotationDAO.exportExcel(valveType, sqExcel, MODULECODE);
        } catch (Exception e){
            throw e;
        }
    }
    
    public SalesQuotation get(String code) throws Exception {
        try {
            return (SalesQuotation) salesQuotationDAO.get(code);
        }
        catch (Exception e) {
            throw e;
        }
    } 
    
     public void approval(String salesQuotationCode,String salQuoStatus,String salQuoRemark,String salQuoReason) throws Exception {
        try {
            salesQuotationDAO.approval(salesQuotationCode, salQuoStatus, salQuoRemark, salQuoReason, MODULECODE_STATUS);
        } catch (Exception e) {
            throw e;
        }
    }

}
