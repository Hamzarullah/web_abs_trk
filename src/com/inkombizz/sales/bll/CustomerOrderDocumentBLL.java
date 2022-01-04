
package com.inkombizz.sales.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.sales.dao.CustomerOrderDocumentDAO;
import com.inkombizz.sales.model.CustomerOrderDocument;
import com.inkombizz.sales.model.CustomerOrderDocumentDetail;
import java.util.List;


public class CustomerOrderDocumentBLL {
    
    private CustomerOrderDocumentDAO customerOrderDocumentDAO;
    
    public CustomerOrderDocumentBLL(HBMSession hbmSession){
        this.customerOrderDocumentDAO = new CustomerOrderDocumentDAO(hbmSession);
    }
    
    public ListPaging<CustomerOrderDocument> findCustomerOrderDocument(Paging paging,CustomerOrderDocument customerOrderDocument) throws Exception{
        try{
            
            paging.setRecords(customerOrderDocumentDAO.countData(customerOrderDocument));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<CustomerOrderDocument> listCustomerOrderDocument = customerOrderDocumentDAO.findData(customerOrderDocument,paging.getFromRow(), paging.getToRow());
            
            ListPaging<CustomerOrderDocument> listPaging = new ListPaging<CustomerOrderDocument>();
            listPaging.setList(listCustomerOrderDocument);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<CustomerOrderDocumentDetail> findCustomerOrderDocumentDetail(CustomerOrderDocument customerOrderDocument) throws Exception{
        try{
            List<CustomerOrderDocumentDetail> listCustomerOrderDocumentDetail = customerOrderDocumentDAO.findDataDetail(customerOrderDocument);
            
            return listCustomerOrderDocumentDetail;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
}
