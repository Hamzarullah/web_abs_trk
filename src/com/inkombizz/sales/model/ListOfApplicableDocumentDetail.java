
package com.inkombizz.sales.model;

import com.inkombizz.common.BaseEntity;
import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "sal_list_of_applicable_document_detail")
public class ListOfApplicableDocumentDetail extends BaseEntity implements Serializable {
    
    @Id
    @Column(name = "Code")
    private String code="";
    
    @Column(name = "HeaderCode")
    private String headerCode="";
    
    @Column(name = "NameOfDocument")
    private String nameOfDocument="";
    
    @Column(name = "DocumentNo")
    private String documentNo="";
    
    @Column(name = "VersionEdition")
    private String versionEdition="";
    
//    @Column(name = "DocumentPath")
//    private String documentPath="";

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getHeaderCode() {
        return headerCode;
    }

    public void setHeaderCode(String headerCode) {
        this.headerCode = headerCode;
    }

    public String getNameOfDocument() {
        return nameOfDocument;
    }

    public void setNameOfDocument(String nameOfDocument) {
        this.nameOfDocument = nameOfDocument;
    }

    public String getDocumentNo() {
        return documentNo;
    }

    public void setDocumentNo(String documentNo) {
        this.documentNo = documentNo;
    }

    public String getVersionEdition() {
        return versionEdition;
    }

    public void setVersionEdition(String versionEdition) {
        this.versionEdition = versionEdition;
    }

//    public String getDocumentPath() {
//        return documentPath;
//    }
//
//    public void setDocumentPath(String documentPath) {
//        this.documentPath = documentPath;
//    }
    
    
}
