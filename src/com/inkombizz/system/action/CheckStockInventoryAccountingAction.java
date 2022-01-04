//
//package com.inkombizz.system.action;
//
//import com.inkombizz.action.BaseSession;
//import com.inkombizz.common.enumeration.EnumAuthorizationString;
//import com.inkombizz.dao.HBMSession;
////import com.inkombizz.master.bll.SerialNoDetailBLL;
//import com.inkombizz.utils.DateUtils;
//import com.inkombizz.utils.Globalize;
//import static com.opensymphony.xwork2.Action.SUCCESS;
//import com.opensymphony.xwork2.ActionSupport;
//import java.io.ByteArrayInputStream;
//import java.io.ByteArrayOutputStream;
//import java.io.InputStream;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.text.SimpleDateFormat;
//import java.util.Date;
//import org.apache.poi.hssf.usermodel.HSSFFont;
//import org.apache.poi.hssf.usermodel.HSSFWorkbook;
//import org.apache.poi.ss.usermodel.Cell;
//import org.apache.poi.ss.usermodel.CellStyle;
//import org.apache.poi.ss.usermodel.DataFormat;
//import org.apache.poi.ss.usermodel.Font;
//import org.apache.poi.ss.usermodel.Row;
//import org.apache.poi.ss.usermodel.Sheet;
//import org.apache.poi.ss.usermodel.Workbook;
//import org.apache.struts2.convention.annotation.Action;
//import org.apache.struts2.convention.annotation.Result;
//import org.apache.struts2.convention.annotation.Results;
//
//
//@Results({
//    @Result(name="success", location="system/check-stock-inventory-accounting.jsp"),
//    @Result(name="redirect", type="redirect", location="../pages/noauthority.jsp"),
//    @Result(name="XLS", type="stream", params={"contentDisposition", "attachment;filename=CheckStockInventoryAccounting.xls"})
//})
//public class CheckStockInventoryAccountingAction extends ActionSupport{
//    
//    private static final long serialVersionUID = 1L;
//    
//    protected HBMSession hbmSession = new HBMSession();
//    private Date checkStockInventoryAccountingDateFirst;
//    private Date checkStockInventoryAccountingDateLast;
//    private InputStream inputStream ;
//    
//    @Override
//    public String execute() {
//        try {
//            SerialNoDetailBLL serialNoDetailBLL = new SerialNoDetailBLL(hbmSession);            
//            if (!BaseSession.loadProgramSession().hasAuthority(serialNoDetailBLL.MODULECODE_CHECK_IVT_ACC, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.VIEW), hbmSession)) {
//                return "redirect";
//            }           
//            
//            checkStockInventoryAccountingDateFirst = DateUtils.getFirstDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
//            checkStockInventoryAccountingDateLast = DateUtils.getLastDateOfMonth(BaseSession.loadProgramSession().getPeriodYear(), BaseSession.loadProgramSession().getPeriodMonth());
//            return SUCCESS;
//        }
//        catch(Exception ex) {
//            return SUCCESS;
//        }
//    }
//    
//    @Action("check-stock-inventory-accounting-xls")
//    public String exportXLS() {
//        try {
//            SerialNoDetailBLL serialNoDetailBLL = new SerialNoDetailBLL(hbmSession);   
//            if (!BaseSession.loadProgramSession().hasAuthority(serialNoDetailBLL.MODULECODE_CHECK_IVT_ACC, EnumAuthorizationString.toString(EnumAuthorizationString.ENUM_AuthorizationString.PRINT), hbmSession)) {
//                return "redirect";
//            }
//            
//            SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
//            SimpleDateFormat DATE_FORMAT_INA = new SimpleDateFormat("dd/MM/yyyy H:mm:ss");
//                                    
//            String firstDatePeriod = DATE_FORMAT.format(checkStockInventoryAccountingDateFirst);
//            String lastDatePeriod = DATE_FORMAT.format(checkStockInventoryAccountingDateLast);
//            
//            String firstDatePeriodINA = DATE_FORMAT_INA.format(checkStockInventoryAccountingDateFirst);
//            String lastDatePeriodINA = DATE_FORMAT_INA.format(checkStockInventoryAccountingDateLast);
//            
//            
//            Workbook wb = new HSSFWorkbook();
//            DataFormat format = wb.createDataFormat();
//            Sheet sheet = wb.createSheet("sheet 1");
//            
//            Font font = wb.createFont();
//            font.setFontName("Times New Roman");
//            font.setFontHeightInPoints((short)11);
//
//            Font fontHeader = wb.createFont();
//            fontHeader.setFontName("Times New Roman");
//            fontHeader.setFontHeightInPoints((short)11);
//            fontHeader.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
//
//            Font fontDetail = wb.createFont();
//            fontDetail.setFontName("Times New Roman");
//            fontDetail.setFontHeightInPoints((short)11);
//
//            CellStyle csHeader = wb.createCellStyle();
//            csHeader.setAlignment(csHeader.ALIGN_LEFT);
//            csHeader.setVerticalAlignment(csHeader.VERTICAL_CENTER);
//            csHeader.setFont(fontHeader);
//
//            CellStyle csNumeric = wb.createCellStyle();
//            csNumeric.setAlignment(csNumeric.ALIGN_RIGHT);
//            csNumeric.setVerticalAlignment(csNumeric.VERTICAL_CENTER);
//            csNumeric.setDataFormat(format.getFormat("#,##0.00"));
//            csNumeric.setFont(font);
//            
//            CellStyle csNumericDetail_Left = wb.createCellStyle();
//            csNumericDetail_Left.setWrapText(true);
//            csNumericDetail_Left.setAlignment(csNumericDetail_Left.ALIGN_RIGHT);
//            csNumericDetail_Left.setVerticalAlignment(csNumericDetail_Left.VERTICAL_CENTER);
//            csNumericDetail_Left.setBorderLeft(csNumericDetail_Left.BORDER_THIN);
//            csNumericDetail_Left.setFont(fontDetail);
//
//            CellStyle csIntegerDetail = wb.createCellStyle();
//            csIntegerDetail.setWrapText(true);
//            csIntegerDetail.setAlignment(csIntegerDetail.ALIGN_CENTER);
//            csIntegerDetail.setVerticalAlignment(csIntegerDetail.VERTICAL_CENTER);
//            csIntegerDetail.setFont(fontDetail);
//
//            CellStyle csIntegerDetail_Left = wb.createCellStyle();
//            csIntegerDetail_Left.setWrapText(true);
//            csIntegerDetail_Left.setAlignment(csIntegerDetail_Left.ALIGN_CENTER);
//            csIntegerDetail_Left.setVerticalAlignment(csIntegerDetail_Left.VERTICAL_CENTER);
//            csIntegerDetail_Left.setBorderLeft(csIntegerDetail_Left.BORDER_THIN);
//            csIntegerDetail_Left.setFont(fontDetail);
//
//            CellStyle csIntegerDetail_Left_Medium = wb.createCellStyle();
//            csIntegerDetail_Left_Medium.setWrapText(true);
//            csIntegerDetail_Left_Medium.setAlignment(csIntegerDetail_Left_Medium.ALIGN_CENTER);
//            csIntegerDetail_Left_Medium.setVerticalAlignment(csIntegerDetail_Left_Medium.VERTICAL_CENTER);
//            csIntegerDetail_Left_Medium.setBorderLeft(csIntegerDetail_Left_Medium.BORDER_MEDIUM);
//            csIntegerDetail_Left_Medium.setFont(fontDetail);
//
//            CellStyle csString = wb.createCellStyle();
//            csString.setWrapText(true);
//            csString.setAlignment(csString.ALIGN_LEFT);
//            csString.setVerticalAlignment(csString.VERTICAL_CENTER);
//            csString.setFont(font);
//
//            CellStyle csStringDetail_Left = wb.createCellStyle();
//            csStringDetail_Left.setWrapText(true);
//            csStringDetail_Left.setAlignment(csStringDetail_Left.ALIGN_LEFT);
//            csStringDetail_Left.setVerticalAlignment(csStringDetail_Left.VERTICAL_CENTER);
//            csStringDetail_Left.setBorderLeft(csStringDetail_Left.BORDER_THIN);
//            csStringDetail_Left.setFont(fontDetail);
//
//            CellStyle csStringDetail_Center_Left = wb.createCellStyle();
//            csStringDetail_Center_Left.setWrapText(true);
//            csStringDetail_Center_Left.setAlignment(csStringDetail_Center_Left.ALIGN_CENTER);
//            csStringDetail_Center_Left.setVerticalAlignment(csStringDetail_Center_Left.VERTICAL_CENTER);
//            csStringDetail_Center_Left.setFont(fontDetail);
//
//            CellStyle csStringDetail_Center_Left_Border_left = wb.createCellStyle();
//            csStringDetail_Center_Left_Border_left.setWrapText(true);
//            csStringDetail_Center_Left_Border_left.setAlignment(csStringDetail_Center_Left_Border_left.ALIGN_CENTER);
//            csStringDetail_Center_Left_Border_left.setVerticalAlignment(csStringDetail_Center_Left_Border_left.VERTICAL_CENTER);
//            csStringDetail_Center_Left_Border_left.setBorderLeft(csStringDetail_Center_Left_Border_left.BORDER_THIN);
//            csStringDetail_Center_Left_Border_left.setFont(fontDetail);
//
//            CellStyle csStringDetail_LeftRight = wb.createCellStyle();
//            csStringDetail_LeftRight.setAlignment(csStringDetail_LeftRight.ALIGN_LEFT);
//            csStringDetail_LeftRight.setVerticalAlignment(csStringDetail_LeftRight.VERTICAL_CENTER);
//            csStringDetail_LeftRight.setFont(fontDetail);
//            
//            Row row;
//            Cell cell;	
//            
//            row = sheet.createRow((short) 0);
//            cell = row.createCell(Globalize.getCell("A"));
//            cell.setCellValue("Periode : "+firstDatePeriodINA+" - "+lastDatePeriodINA);
//            cell.setCellStyle(csStringDetail_LeftRight);
//            
//            row = sheet.createRow((short) 1);
//            cell = row.createCell(Globalize.getCell("A"));
//            cell.setCellValue("Document");
//            cell.setCellStyle(csHeader);
//
//            cell = row.createCell(Globalize.getCell("B"));
//            cell.setCellValue("Tanggal");
//            cell.setCellStyle(csHeader);
//
//            cell = row.createCell(Globalize.getCell("C"));
//            cell.setCellValue("Inventory Amount");
//            cell.setCellStyle(csHeader);
//
//            cell = row.createCell(Globalize.getCell("D"));
//            cell.setCellValue("Accounting Amount(Debit)");
//            cell.setCellStyle(csHeader);
//
//            cell = row.createCell(Globalize.getCell("E"));
//            cell.setCellValue("Accounting Amount(Credit)");
//            cell.setCellStyle(csHeader);
//
//            cell = row.createCell(Globalize.getCell("F"));
//            cell.setCellValue("Accounting(Debit-Credit)");
//            cell.setCellStyle(csHeader);
//                
//            int defRow = 1;
//            int initRow = defRow;
//            
//            PreparedStatement Statement = null;
//            ResultSet rs = null;
//            
//            Connection conn = hbmSession.hSession.connection();
//            
//            String query="CALL usp_check_inventory_accounting('"+firstDatePeriod+"','"+lastDatePeriod+"')";
//            Statement = conn.prepareStatement(
//                query
//            ); 
//            rs = Statement.executeQuery();
//            
//            
//            while(rs.next()) {
//                                
//                initRow++;
//                
//                row = sheet.createRow(initRow);
//                cell = row.createCell(Globalize.getCell("A"));
//                cell.setCellValue(rs.getString("code"));
//                cell.setCellStyle(csStringDetail_LeftRight);
//                
//                cell = row.createCell(Globalize.getCell("B"));
////                cell.setCellValue(DATE_FORMAT_INA.format(rs.getString("TransactionDate")));
//                cell.setCellValue(rs.getString("TransactionDate"));
//                cell.setCellStyle(csStringDetail_LeftRight);
//
//                cell = row.createCell(Globalize.getCell("C"));
//                cell.setCellValue(rs.getFloat("AmountInventory"));
//                cell.setCellStyle(csNumeric);
//                
//                cell = row.createCell(Globalize.getCell("D"));
//                cell.setCellValue(rs.getFloat("Debit"));
//                cell.setCellStyle(csNumeric);
//                
//                cell = row.createCell(Globalize.getCell("E"));
//                cell.setCellValue(rs.getFloat("Credit"));
//                cell.setCellStyle(csNumeric);
//                
//                cell = row.createCell(Globalize.getCell("F"));
//                cell.setCellValue(rs.getFloat("Balance"));
//                cell.setCellStyle(csNumeric);
//                
//                
//            }
//            
//            for (int i=1; i<=5; i++){
//                sheet.autoSizeColumn(i);
//            }
//            
//            ByteArrayOutputStream baos = new ByteArrayOutputStream();
//            wb.write(baos);
//            baos.flush();
//            byte[] bte = baos.toByteArray();
//            
//            this.inputStream = new ByteArrayInputStream(bte,0,bte.length);
//            baos.close();
//            
//           return "XLS";
//            
//        }
//        catch(Exception ex) {
//            ex.printStackTrace();
//            return "XLS";
//        }
//    }
//    public HBMSession getHbmSession() {
//        return hbmSession;
//    }
//
//    public void setHbmSession(HBMSession hbmSession) {
//        this.hbmSession = hbmSession;
//    }
//    
//    public Date getCheckStockInventoryAccountingDateFirst() {
//        return checkStockInventoryAccountingDateFirst;
//    }
//
//    public void setCheckStockInventoryAccountingDateFirst(Date checkStockInventoryAccountingDateFirst) {
//        this.checkStockInventoryAccountingDateFirst = checkStockInventoryAccountingDateFirst;
//    }
//
//    public Date getCheckStockInventoryAccountingDateLast() {
//        return checkStockInventoryAccountingDateLast;
//    }
//
//    public void setCheckStockInventoryAccountingDateLast(Date checkStockInventoryAccountingDateLast) {
//        this.checkStockInventoryAccountingDateLast = checkStockInventoryAccountingDateLast;
//    }
//
//    public InputStream getInputStream() {
//        return inputStream;
//    }
//
//    public void setInputStream(InputStream inputStream) {
//        this.inputStream = inputStream;
//    }
//    
//    
//}
