
package com.inkombizz.system.model;

import com.inkombizz.utils.DateUtils;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;


 @Entity
@Table(name = "sys_setup")
public class Setup implements Serializable{
    
    private String code = "";
    private String companyAcronym = "";
    private String companyName = "";
    private String headOfficeAddress = "";
    private String headOfficePhone1 = "";
    private String headOfficePhone2 = "";
    private String headOfficeFax = "";
    private String headOfficeZipCode = "";
    private String currencyCode = "";
    private String fontName1 = "";
    private String fontName2 = "";
    private String logoPath = "";
    private String logoName = "";
    private String lastProgramUpdated = "";
    private BigDecimal logoWidth=new BigDecimal(0.00);
    private BigDecimal logoHeight=new BigDecimal(0.00);
    private String excelPath = "";
    private String templatePath = "";
    private String pdfPath = "";
    private String reportPath = "";
    private String webHelpPath = "";
    private String webTitle = "";
    private String emailAddress = "";
    private String ftpUsername = "";
    private String ftpPassword = "";
    private String ftpHost = "";
    private BigDecimal vatPercent=new BigDecimal(0.00);
    private BigDecimal apAging1 = new BigDecimal(0.00);
    private BigDecimal apAging2 = new BigDecimal(0.00);
    private BigDecimal apAging3 = new BigDecimal(0.00);
    private BigDecimal apAging4 = new BigDecimal(0.00);
    private BigDecimal arAging1 = new BigDecimal(0.00);
    private BigDecimal arAging2 = new BigDecimal(0.00);
    private BigDecimal arAging3 = new BigDecimal(0.00);
    private BigDecimal arAging4 = new BigDecimal(0.00);
    private String defaultDiscountAccountCode = "";
    private String defaultOtherfeeAccountCode = "";
    private String defaultBranchCode = "";
    private String defaultRackTypeCode = "";
    private String coaPurchaseDepositCode;
    private String coaSalesDepositCode;
    private String createdBy = "";
    private Date createdDate = DateUtils.newDate(1900, 1, 1);
    private String updatedBy = "";
    private Date updatedDate = DateUtils.newDate(1900, 1, 1);
    
    @Id
    @Column(name = "code", length = 50, unique = true)
    public String getCode() {
        return code;
    }
    public void setCode(String code) {
        this.code = code;
    }
    
    @Column(name = "logoPath")
    public String getLogoPath() {
        return logoPath;
    }
    public void setLogoPath(String logoPath) {
        this.logoPath = logoPath;
    }

    @Column(name = "LogoName", length = 50)
    public String getLogoName() {
        return logoName;
    }

    public void setLogoName(String logoName) {
        this.logoName = logoName;
    }

    @Column(name = "LogoWidth")
    public BigDecimal getLogoWidth() {
        return logoWidth;
    }
    
    public void setLogoWidth(BigDecimal logoWidth) {
        this.logoWidth = logoWidth;
    }

    @Column(name = "LogoHeight")
    public BigDecimal getLogoHeight() {
        return logoHeight;
    }

    public void setLogoHeight(BigDecimal logoHeight) {
        this.logoHeight = logoHeight;
    }
    
    @Column(name = "companyacronym", length = 10)
    public String getCompanyAcronym() {
        return companyAcronym;
    }

    public void setCompanyAcronym(String companyAcronym) {
        this.companyAcronym = companyAcronym;
    }

    @Column(name = "WebTitle", length = 100)
    public String getWebTitle() {
        return webTitle;
    }

    public void setWebTitle(String webTitle) {
        this.webTitle = webTitle;
    }

    @Column(name = "EmailAddress")
    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress;
    }
    
    @Column(name = "companyname", length = 100)
    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    @Column(name = "headofficeaddress")
    public String getHeadOfficeAddress() {
        return headOfficeAddress;
    }

    public void setHeadOfficeAddress(String headOfficeAddress) {
        this.headOfficeAddress = headOfficeAddress;
    }

    @Column(name = "headofficefax", length = 20)
    public String getHeadOfficeFax() {
        return headOfficeFax;
    }

    public void setHeadOfficeFax(String headOfficeFax) {
        this.headOfficeFax = headOfficeFax;
    }

    @Column(name = "headofficephone1", length = 20)
    public String getHeadOfficePhone1() {
        return headOfficePhone1;
    }

    public void setHeadOfficePhone1(String headOfficePhone1) {
        this.headOfficePhone1 = headOfficePhone1;
    }

    @Column(name = "headofficephone2", length = 20)
    public String getHeadOfficePhone2() {
        return headOfficePhone2;
    }

    public void setHeadOfficePhone2(String headOfficePhone2) {
        this.headOfficePhone2 = headOfficePhone2;
    }

    @Column(name = "headofficezipcode", length = 20)
    public String getHeadOfficeZipCode() {
        return headOfficeZipCode;
    }

    public void setHeadOfficeZipCode(String headOfficeZipCode) {
        this.headOfficeZipCode = headOfficeZipCode;
    }

    @Column (name = "currencycode")
    public String getCurrencyCode() {
        return currencyCode;
    }

    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }

    @Column (name = "WebHelpPath")
    public String getWebHelpPath() {
        return webHelpPath;
    }

    public void setWebHelpPath(String webHelpPath) {
        this.webHelpPath = webHelpPath;
    }
    
    @Column (name = "createdby")
    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    @Column (name = "createddate")
    @Temporal(javax.persistence.TemporalType.DATE)
    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    @Column (name = "updatedby")
    public String getUpdatedBy() {
        return updatedBy;
    }

    public void setUpdatedBy(String updatedBy) {
        this.updatedBy = updatedBy;
    }

    @Column (name = "updateddate")
    @Temporal(javax.persistence.TemporalType.DATE)
    public Date getUpdatedDate() {
        return updatedDate;
    }

    public void setUpdatedDate(Date updatedDate) {
        this.updatedDate = updatedDate;
    }

    public String getFtpUsername() {
        return ftpUsername;
    }

    public void setFtpUsername(String ftpUsername) {
        this.ftpUsername = ftpUsername;
    }

    public String getFtpPassword() {
        return ftpPassword;
    }

    public void setFtpPassword(String ftpPassword) {
        this.ftpPassword = ftpPassword;
    }

    public String getFtpHost() {
        return ftpHost;
    }

    public void setFtpHost(String ftpHost) {
        this.ftpHost = ftpHost;
    }

    @Column(name = "vatPercent")
     public BigDecimal getVatPercent() {
        return vatPercent;
    }

    public void setVatPercent(BigDecimal vatPercent) {
        this.vatPercent = vatPercent;
    }
    
    @Column(name = "excelPath", length = 100)
    public String getExcelPath() {
        return excelPath;
    }
    
    public void setExcelPath(String excelPath) {
        this.excelPath = excelPath;
    }

    @Column(name = "templatePath", length = 100)
    public String getTemplatePath() {
        return templatePath;
    }

    public void setTemplatePath(String templatePath) {
        this.templatePath = templatePath;
    }

    @Column(name = "PDFPath")
    public String getPdfPath() {
        return pdfPath;
    }

    public void setPdfPath(String pdfPath) {
        this.pdfPath = pdfPath;
    }

    @Column(name = "ReportPath")
    public String getReportPath() {
        return reportPath;
    }

    public void setReportPath(String reportPath) {
        this.reportPath = reportPath;
    }

    @Column(name = "fontName1", length = 100)
    public String getFontName1() {
        return fontName1;
    }

    public void setFontName1(String fontName1) {
        this.fontName1 = fontName1;
    }

    @Column(name = "fontName2", length = 100)
    public String getFontName2() {
        return fontName2;
    }

    public void setFontName2(String fontName2) {
        this.fontName2 = fontName2;
    }

    @Column(name = "ApAging1")
    public BigDecimal getApAging1() {
        return apAging1;
    }

    public void setApAging1(BigDecimal apAging1) {
        this.apAging1 = apAging1;
    }

    @Column(name = "ApAging2")
    public BigDecimal getApAging2() {
        return apAging2;
    }

    public void setApAging2(BigDecimal apAging2) {
        this.apAging2 = apAging2;
    }

    @Column(name = "ApAging3")
    public BigDecimal getApAging3() {
        return apAging3;
    }

    public void setApAging3(BigDecimal apAging3) {
        this.apAging3 = apAging3;
    }

    @Column(name = "ApAging4")
    public BigDecimal getApAging4() {
        return apAging4;
    }

    public void setApAging4(BigDecimal apAging4) {
        this.apAging4 = apAging4;
    }

    @Column(name = "ArAging1")
    public BigDecimal getArAging1() {
        return arAging1;
    }

    public void setArAging1(BigDecimal arAging1) {
        this.arAging1 = arAging1;
    }

    @Column(name = "ArAging2")
    public BigDecimal getArAging2() {
        return arAging2;
    }

    public void setArAging2(BigDecimal arAging2) {
        this.arAging2 = arAging2;
    }

    @Column(name = "ArAging3")
    public BigDecimal getArAging3() {
        return arAging3;
    }

    public void setArAging3(BigDecimal arAging3) {
        this.arAging3 = arAging3;
    }

    @Column(name = "ArAging4")
    public BigDecimal getArAging4() {
        return arAging4;
    }

    public void setArAging4(BigDecimal arAging4) {
        this.arAging4 = arAging4;
    }

    @Column(name = "DefaultDiscountAccountCode")
    public String getDefaultDiscountAccountCode() {
        return defaultDiscountAccountCode;
    }

    public void setDefaultDiscountAccountCode(String defaultDiscountAccountCode) {
        this.defaultDiscountAccountCode = defaultDiscountAccountCode;
    }

    @Column(name = "DefaultOtherfeeAccountCode")
    public String getDefaultOtherfeeAccountCode() {
        return defaultOtherfeeAccountCode;
    }

    public void setDefaultOtherfeeAccountCode(String defaultOtherfeeAccountCode) {
        this.defaultOtherfeeAccountCode = defaultOtherfeeAccountCode;
    }

    @Column(name = "DefaultBranchCode")
    public String getDefaultBranchCode() {
        return defaultBranchCode;
    }

    public void setDefaultBranchCode(String defaultBranchCode) {
        this.defaultBranchCode = defaultBranchCode;
    }

    @Column(name = "CoaPurchaseDepositCode")
    public String getCoaPurchaseDepositCode() {
        return coaPurchaseDepositCode;
    }

    public void setCoaPurchaseDepositCode(String coaPurchaseDepositCode) {
        this.coaPurchaseDepositCode = coaPurchaseDepositCode;
    }

    @Column(name = "CoaSalesDepositCode")
    public String getCoaSalesDepositCode() {
        return coaSalesDepositCode;
    }

    public void setCoaSalesDepositCode(String coaSalesDepositCode) {
        this.coaSalesDepositCode = coaSalesDepositCode;
    }

    
    @Column(name = "LastProgramUpdated")
    public String getLastProgramUpdated() {
        return lastProgramUpdated;
    }

    public void setLastProgramUpdated(String lastProgramUpdated) {
        this.lastProgramUpdated = lastProgramUpdated;
    }
    
    @Column(name = "DefaultRackTypeCode")
    public String getDefaultRackTypeCode() {
        return defaultRackTypeCode;
    }

    public void setDefaultRackTypeCode(String defaultRackTypeCode) {
        this.defaultRackTypeCode = defaultRackTypeCode;
    }
}