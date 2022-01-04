package com.inkombizz.sales.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.dao.ListOfApplicableDocumentDAO;
import com.inkombizz.sales.model.ListOfApplicableDocument;
import com.inkombizz.sales.model.ListOfApplicableDocumentDetail;
import com.inkombizz.sales.model.ListOfApplicableDocumentField;
import java.util.List;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;


public class ListOfApplicableDocumentBLL {
    
    public static final String MODULECODE = "002_SAL_LIST_OF_APPLICABLE_DOCUMENT";
    
    private ListOfApplicableDocumentDAO listApplicableDocumentDAO;
    
    public ListOfApplicableDocumentBLL (HBMSession hbmSession){
        this.listApplicableDocumentDAO = new ListOfApplicableDocumentDAO(hbmSession);
    }
    
    public ListPaging<ListOfApplicableDocument> findData(Paging paging,ListOfApplicableDocument listApplicableDocument) throws Exception {
        try {
                     
            paging.setRecords(listApplicableDocumentDAO.countData(listApplicableDocument));
            paging.setTotal( (int) Math.ceil ((double) paging.getRecords() / (double) paging.getRows()));
            
            List<ListOfApplicableDocument> listListApplicableDocument = listApplicableDocumentDAO.findData(listApplicableDocument,paging.getFromRow(), paging.getToRow());
            
            ListPaging<ListOfApplicableDocument> listPaging = new ListPaging<ListOfApplicableDocument>();
            
            listPaging.setList(listListApplicableDocument);
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
            
            DetachedCriteria criteria = DetachedCriteria.forClass(ListOfApplicableDocument.class)
                            .add(Restrictions.eq(ListOfApplicableDocumentField.CODE, headerCode));
             
            if(listApplicableDocumentDAO.countByCriteria(criteria) > 0)
                 exist = true;
            
            return exist;
        }
        catch(Exception ex){
            throw ex;
        }
    }
    
    public List<ListOfApplicableDocumentDetail> findDataDetail(String headerCode) throws Exception {
        try {
            
            List<ListOfApplicableDocumentDetail> listApplicableDocumentDetail = listApplicableDocumentDAO.findDataDetail(headerCode);
            
            return listApplicableDocumentDetail;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
        
    public void save(ListOfApplicableDocument listApplicableDocument, List<ListOfApplicableDocumentDetail> listListOfApplicableDocumentDetail) throws Exception {
        try {
            listApplicableDocumentDAO.save(listApplicableDocument, listListOfApplicableDocumentDetail, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
    
    public void update(ListOfApplicableDocument listApplicableDocument, List<ListOfApplicableDocumentDetail> listListOfApplicableDocumentDetail) throws Exception {
        try {
            listApplicableDocumentDAO.update(listApplicableDocument, listListOfApplicableDocumentDetail, MODULECODE);
        }
        catch (Exception e) {
            throw e;
        }
    }
        
    public void delete(ListOfApplicableDocument listApplicableDocument) throws Exception{
        listApplicableDocumentDAO.delete(listApplicableDocument,MODULECODE);
    }
}