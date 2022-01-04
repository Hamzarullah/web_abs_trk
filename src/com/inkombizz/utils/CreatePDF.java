//
//package com.inkombizz.utils;
//
//import com.inkombizz.action.BaseSession;
//import com.inkombizz.dao.HBMSession;
//import com.inkombizz.sales.model.Email;
//import com.inkombizz.sales.model.TransactionTemp;
//import java.io.File;
//import java.io.FileOutputStream;
//import java.io.IOException;
//import java.io.OutputStream;
//import java.math.BigDecimal;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//import javax.servlet.http.HttpServletRequest;
//import net.sf.jasperreports.engine.JRException;
//import net.sf.jasperreports.engine.JasperExportManager;
//import net.sf.jasperreports.engine.JasperFillManager;
//import net.sf.jasperreports.engine.JasperPrint;
//import org.apache.struts2.ServletActionContext;
//import org.hibernate.Hibernate;
//import org.hibernate.HibernateException;
//import org.hibernate.transform.Transformers;
//
//
//public class CreatePDF {
//    private HBMSession hbmSession;
//    static String reportPath = BaseSession.loadProgramSession().getSetup().getReportPath();
//
//    public CreatePDF(HBMSession session) {
//        this.hbmSession = session;
//    }
//    public void GeneratePDF(Email email, String filename) throws IOException, JRException{
//        try {
//            HttpServletRequest request = ServletActionContext.getRequest();
//            String logo = BaseSession.loadProgramSession().getSetup().getLogoPath();
//            String ttd = BaseSession.loadProgramSession().getSetup().getInvTtd();
//            String pathLogo = request.getRealPath("/"+logo);
//            String pathTtd = request.getRealPath("/"+ttd);
//        
//            String reportName = reportPath + "sales-invoice-print.jasper";
//            Map<String, Object> params = new HashMap<String, Object>();
//            params.put("prmCode", email.getCode());
//            params.put("prmLogo",pathLogo );
//            params.put("prmTtd",pathTtd );
//            String terbilang = findListInvoiceByCriteria(email.getCode());
//            params.put("terbilang", terbilang);
//            JasperPrint jasperPrint = JasperFillManager.fillReport(reportName, params, hbmSession.hSession.connection());
//            OutputStream output = new FileOutputStream(new File(BaseSession.loadProgramSession().getSetup().getPdfPath() +filename+"")); 
//            JasperExportManager.exportReportToPdfStream(jasperPrint, output); 
//            output.flush();
//            output.close();
//        }catch(Exception ex) {
//            ex.printStackTrace();
//        }
//    }
//    
//    public String findListInvoiceByCriteria(String invoiceCode){
//        try{
//        String qry = "SELECT sal_invoice.grandtotalamount as total "
//                + "from sal_invoice "
//                + "where sal_invoice.code = '"+invoiceCode+"'";
//         List <TransactionTemp> calculateResult = hbmSession.hSession.createSQLQuery(qry)
//                .addScalar("total", Hibernate.BIG_DECIMAL)
//                .setResultTransformer(Transformers.aliasToBean(TransactionTemp.class))
//                .list();  
//         
//            BigDecimal total = calculateResult.get(0).getTotal();
//            
//            Integer grandTotal = total.intValue();
//         
//         JavaTerbilang java = new JavaTerbilang(grandTotal, true);
//         
//    return java.get();
//        }
//        catch(HibernateException e){
//            throw e;
//        }
//    }
//}
