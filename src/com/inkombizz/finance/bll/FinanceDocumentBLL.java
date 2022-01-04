
package com.inkombizz.finance.bll;

import com.inkombizz.common.ListPaging;
import com.inkombizz.common.Paging;
import com.inkombizz.dao.HBMSession;
import com.inkombizz.finance.dao.FinanceDocumentDAO;
import com.inkombizz.finance.model.FinanceDocumentTemp;
//import com.inkombizz.inventory.model.GoodsReceivedNoteDepositDetailTemp;
import java.util.Date;
import java.util.List;


public class FinanceDocumentBLL {
    
    private FinanceDocumentDAO financeDocumentDAO;
    
    public FinanceDocumentBLL(HBMSession hbmSession){
        this.financeDocumentDAO = new FinanceDocumentDAO(hbmSession);
    }
    
    public ListPaging<FinanceDocumentTemp> findFinanceDocument(Paging paging,FinanceDocumentTemp financeDocument) throws Exception{
        try{

            paging.setRecords(financeDocumentDAO.countData(financeDocument));
            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
            
            List<FinanceDocumentTemp> listFinanceDocumentTemp = financeDocumentDAO.findData(financeDocument,paging.getFromRow(), paging.getToRow());
            
            ListPaging<FinanceDocumentTemp> listPaging = new ListPaging<FinanceDocumentTemp>();
            listPaging.setList(listFinanceDocumentTemp);
            listPaging.setPaging(paging);
            
            return listPaging;
        }
        catch(Exception ex){
            ex.printStackTrace();
            return null;
        }
    }
    
//    public ListPaging<GoodsReceivedNoteDepositDetailTemp> findFinanceDeposit(Paging paging,String code,Date firstDate,Date lastDate) throws Exception{
//        try{
//
//            paging.setRecords(financeDocumentDAO.countDataDeposit(code,firstDate,lastDate));
//            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
//            
//            List<GoodsReceivedNoteDepositDetailTemp> listGoodsReceivedNoteDepositDetailTemp = financeDocumentDAO.findDataDeposit(code,firstDate,lastDate,paging.getFromRow(), paging.getToRow());
//            
//            ListPaging<GoodsReceivedNoteDepositDetailTemp> listPaging = new ListPaging<GoodsReceivedNoteDepositDetailTemp>();
//            listPaging.setList(listGoodsReceivedNoteDepositDetailTemp);
//            listPaging.setPaging(paging);
//            
//            return listPaging;
//        }
//        catch(Exception ex){
//            ex.printStackTrace();
//            return null;
//        }
//    }
//    
//    public ListPaging<GoodsReceivedNoteDepositDetailTemp> findFinanceDepositPayment(Paging paging,String code,Date firstDate,Date lastDate) throws Exception{
//        try{
//
//            paging.setRecords(financeDocumentDAO.countDataDepositPayment(code,firstDate,lastDate));
//            paging.setTotal((int)Math.ceil((double)paging.getRecords()/(double)paging.getRows()));
//            
//            List<GoodsReceivedNoteDepositDetailTemp> listGoodsReceivedNoteDepositDetailTemp = financeDocumentDAO.findDataDepositPayment(code,firstDate,lastDate,paging.getFromRow(), paging.getToRow());
//            
//            ListPaging<GoodsReceivedNoteDepositDetailTemp> listPaging = new ListPaging<GoodsReceivedNoteDepositDetailTemp>();
//            listPaging.setList(listGoodsReceivedNoteDepositDetailTemp);
//            listPaging.setPaging(paging);
//            
//            return listPaging;
//        }
//        catch(Exception ex){
//            ex.printStackTrace();
//            return null;
//        }
//    }
    
    public List<FinanceDocumentTemp> findDataFinanceExisting(String documentNo) throws Exception {
        try {
            
            List<FinanceDocumentTemp> listFinanceDocumentTemp = financeDocumentDAO.findDataFinanceExisting(documentNo);

            return listFinanceDocumentTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<FinanceDocumentTemp> findDataPaymentRequestExisting(String documentNo) throws Exception {
        try {
            
            List<FinanceDocumentTemp> listFinanceDocumentTemp = financeDocumentDAO.findDataPaymentRequestExisting(documentNo);
            
            return listFinanceDocumentTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
    
    public List<FinanceDocumentTemp> findDataPaymentRequestExistingBankPayment(String paymentRequestNo) throws Exception {
        try {
            
            List<FinanceDocumentTemp> listFinanceDocumentTemp = financeDocumentDAO.findDataPaymentRequestExistingBankPayment(paymentRequestNo);
            
            return listFinanceDocumentTemp;  
        }
        catch(Exception ex) {
            throw ex;
        }
    }
}
