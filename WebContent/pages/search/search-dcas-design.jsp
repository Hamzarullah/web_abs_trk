<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">        
        <sj:head
            loadAtOnce="true"
            compressed="false"
            jqueryui="true"
            jquerytheme="cupertino"
            loadFromGoogle="false"
            debug="true" />

    <script type="text/javascript" src="../../js/jquery.layout.js"></script>
    <script type="text/javascript" src="../../js/jquery_ready.js"></script>
    <script type="text/javascript" src="../../js/jquery.block.ui.js"></script>
    <script type="text/javascript" src="../../js/jquery.json-2.2.min.js"></script>
    <script type="text/javascript" src="../../js/jquery.validate.min.js"></script>

    <link href="../../css/mainstyle.css" rel="stylesheet" type="text/css" />
    <link href="../../css/pagestyle.css" rel="stylesheet" type="text/css" />
    <style>
        html {
            overflow: scroll;
        }
    </style>
    
<script type = "text/javascript">
      
    var search_dcasDesign_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    var rowLast= '<%= request.getParameter("rowLast") %>';
    
    jQuery(document).ready(function(){  
        $("#dlgDcasDesign_okButton").click(function(ev) { 
            var search_dcasDesign_LastRowId = rowLast;
            
            if (search_dcasDesign_type === "grid" ) {
                    var ids = jQuery("#dlgSearch_dcasDesign_grid").jqGrid('getDataIDs');
                    var idsOpener = jQuery("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
                    
                    for(var i=0;i<ids.length;i++){
                        var exist = false;
                        var data = $("#dlgSearch_dcasDesign_grid").jqGrid('getRowData',ids[i]);
                        
                        if($("input:checkbox[id='jqg_dlgSearch_dcasDesign_grid_"+ids[i]+"']").is(":checked")){
                            for(var j=0; j<idsOpener.length; j++){
                                var dataExist = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
                            }
                            
                            if(!exist){
                                search_dcasDesign_LastRowId++;
                                var defRow = {};
                                switch (id_document) {
                                    case "contractReviewDcasDesign":
                                        defRow = {
                                            contractReviewDcasDesignDelete : "delete",
                                            contractReviewDcasDesignCode   : data.code,
                                            contractReviewDcasDesignName   : data.name

                                        };
                                        window.opener.addRowDataMultiSelectedDcasDesign(search_dcasDesign_LastRowId, defRow);

                                        break;
                                }
                            }
                        }
                    }   
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_dcasDesign.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_dcasDesign.name);
                
            }

            window.close();
        });

        $("#dlgDcasDesign_cancelButton").click(function(ev) { 
            data_search_dcasDesign = null;
            window.close();
        });
    
        $("#btn_dlg_DcasDesignSearch").click(function(ev) {
            $("#dlgSearch_dcasDesign_grid").jqGrid("setGridParam",{url:"master/dcas-design-data?" + $("#frmDcasDesignSearch").serialize(), page:1});
            $("#dlgSearch_dcasDesign_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
     });
    
</script>
<body>
<s:url id="remoteurlDcasDesignSearch" action="" />


    <div class="ui-widget">
        <s:form id="frmDcasDesignSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="dcasDesignSearchCode" name="dcasDesignSearchCode" label="Code "></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Name</td>
                <td><s:textfield id="dcasDesignSearchName" name="dcasDesignSearchName" size="50"></s:textfield></td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_DcasDesignSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_dcasDesign_grid"
            dataType="json"
            href="%{remoteurlDcasDesignSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listDcasDesignTemp"
            rowList="10,20,30"
            rowNum="10"
            multiselect = "true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnudcasDesign').width()"
        >
        <sjg:gridColumn
            name="code" index="code" key="code" title="Code" width="100" sortable="true"
        />
        <sjg:gridColumn
            name="name" index="name" title="Name" width="300" sortable="true"
        />
        <sjg:gridColumn
            name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
        />       
        </sjg:grid >
        
    </div>
<br></br>
    <sj:a href="#" id="dlgDcasDesign_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgDcasDesign_cancelButton" button="true">Cancel</sj:a>
</body>
</html>