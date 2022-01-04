package com.inkombizz.security.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.JoinColumn;

@Entity
@Table(name = "scr_menu")
public class Menu implements Serializable {
    private String code;
    private String text;
    private String classes;
    private String parentCode;
    private String link;
    private Double sortNO;

    public static String BEAN_NAME = "Menu";
    public static String TABLE_NAME = "scr_menu";

    @Id
    @Column(name = "Code", length = 50, unique = true)
    public String getCode() {
            return code;
    }
    public void setCode(String code) {
            this.code = code;
    }

    @Column(name = "text", length = 50)
    public String getText() {
            return text;
    }
    public void setText(String text) {
            this.text = text;
    }

    @Column(name = "Classes", length = 50)
    public String getClasses() {
            return classes;
    }
    public void setClasses(String classes) {
            this.classes = classes;
    }

    @Column(name = "ParentCode", length = 50)
    public String getParentCode() {
            return parentCode;
    }
    public void setParentCode(String parentCode) {
            this.parentCode = parentCode;
    }

    @Column(name = "Link", length = 50)
    public String getLink() {
            return link;
    }
    public void setLink(String link) {
            this.link = link;
    }

    @Column(name = "sortNo", length = 50)
    public Double getSortNO() {
        return sortNO;
    }

    public void setSortNO(Double sortNO) {
        this.sortNO = sortNO;
    }

}
