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
      
    var search_dcasLegalRequirements_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    var rowLast= '<%= request.getParameter("rowLast") %>';
    
    jQuery(document).ready(function(){  
        $("#dlgDcasLegalRequirements_okButton").click(function(ev) { 
            var search_dcasLegalRequirements_LastRowId = rowLast;
            
            if (search_dcasLegalRequirements_type === "grid" ) {
                    var ids = jQuery("#dlgSearch_dcasLegalRequirements_grid").jqGrid('getDataIDs');
                    var idsOpener = jQuery("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
                    
                    for(var i=0;i<ids.length;i++){
                        var exist = false;
                        var data = $("#dlgSearch_dcasLegalRequirements_grid").jqGrid('getRowData',ids[i]);
                        
                        if($("input:checkbox[id='jqg_dlgSearch_dcasLegalRequirements_grid_"+ids[i]+"']").is(":checked")){
                            for(var j=0; j<idsOpener.length; j++){
                                var dataExist = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
                            }
                            
                            if(!exist){
                                search_dcasLegalRequirements_LastRowId++;
                                var defRow = {};
                                switch (id_document) {
                                    case "contractReviewDcasLegalRequirements":
                                        defRow = {
                                            contractReviewDcasLegalRequirementsDelete : "delete",
                                            contractReviewDcasLegalRequirementsCode   : data.code,
                                            contractReviewDcasLegalRequirementsName   : data.name

                                        };
                                        window.opener.addRowDataMultiSelectedDcasLegalRequirements(search_dcasLegalRequirements_LastRowId, defRow);

                                        break;
                                }
                            }
                        }
                    }   
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_dcasLegalRequirements.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_dcasLegalRequirements.name);
                
            }

            window.close();
        });

        $("#dlgDcasLegalRequirements_cancelButton").click(function(ev) { 
            data_search_dcasLegalRequirements = null;
            window.close();
        });
    
        $("#btn_dlg_DcasLegalRequirementsSearch").click(function(ev) {
            $("#dlgSearch_dcasLegalRequirements_grid").jqGrid("setGridParam",{url:"master/dcas-legal-requirements-data?" + $("#frmDcasLegalRequirementsSearch").serialize(), page:1});
            $("#dlgSearch_dcasLegalRequirements_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
     });
    
</script>
<body>
<s:url id="remoteurlDcasLegalRequirementsSearch" action="" />


    <div class="ui-widget">
        <s:form id="frmDcasLegalRequirementsSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="dcasLegalRequirementsSearchCode" name="dcasLegalRequirementsSearchCode" label="Code "></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Name</td>
                <td><s:textfield id="dcasLegalRequirementsSearchName" name="dcasLegalRequirementsSearchName" size="50"></s:textfield></td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_DcasLegalRequirementsSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_dcasLegalRequirements_grid"
            dataType="json"
            href="%{remoteurlDcasLegalRequirementsSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listDcasLegalRequirementsTemp"
            rowList="10,20,30"
            rowNum="10"
            multiselect = "true"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnudcasLegalRequirements').width()"
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
    <sj:a href="#" id="dlgDcasLegalRequirements_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgDcasLegalRequirements_cancelButton" button="true">Cancel</sj:a>
</body>
</html>