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
    
    var search_assetRegistration_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
//    var id_assetRegistration= '<%= request.getParameter("idcit") %>';
    
    
    jQuery(document).ready(function(){  
        
        $("#dlgAssetRegistration_okButton").click(function(ev) { 
            
            selectedRowId = $("#dlgSearch_assetRegistration_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row AssetRegistration!");
                return;
            }

            var data_search_assetRegistration = $("#dlgSearch_assetRegistration_grid").jqGrid('getRowData', selectedRowId);

            if (search_assetRegistration_type === "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"AssetRegistrationCode",opener.document).val(data_search_assetRegistration.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"AssetRegistrationName", data_search_assetRegistration.name);           
            }
            else {
                $("#"+id_document+"\\.assetRegistration\\.code",opener.document).val(data_search_assetRegistration.code);
                $("#"+id_document+"\\.assetRegistration\\.name",opener.document).val(data_search_assetRegistration.name);
            }

            window.close();
        });


        $("#dlgAssetRegistration_cancelButton").click(function(ev) { 
            data_search_assetRegistration = null;
            window.close();
        });
    
    
        $("#btn_dlg_AssetRegistrationSearch").click(function(ev) {
            $("#dlgSearch_assetRegistration_grid").jqGrid("setGridParam",{url:"master/asset-registration-data?" + $("#frmAssetRegistrationSearch").serialize(), page:1});
            $("#dlgSearch_assetRegistration_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        
     });
    
</script>
    
<body>
<s:url id="remoteurlAssetRegistrationSearch" action="" />
        <div class="ui-widget">
            <s:form id="frmAssetRegistrationSearch">
            <table cellpadding="2" cellspacing="2">
                <tr>
                    <td align="right">Code</td>
                    <td><s:textfield id="assetRegistrationSearchCode" name="assetRegistrationSearchCode" label="Code "></s:textfield></td>
                </tr>
                <tr>
                    <td align="right">Name</td>
                    <td><s:textfield id="assetRegistrationSearchName" name="assetRegistrationSearchName" size="50"></s:textfield></td>
                </tr>
                <tr>
                    <td colspan="2"><sj:a href="#" id="btn_dlg_AssetRegistrationSearch" button="true">Search</sj:a></td>
                </tr>
                <td align="right">
                    <s:textfield id="assetRegistrationSearchActiveStatus" name="assetRegistrationSearchActiveStatus" readonly="false" size="5" style="display:none" value="true"></s:textfield>
                </td>
            </table>
            </s:form>
        </div>

        <div class="ui-widget ui-widget-content">
            <sjg:grid
                id="dlgSearch_assetRegistration_grid"
                dataType="json"
                href="%{remoteurlAssetRegistrationSearch}"
                pager="true"
                navigator="true"
                navigatorView="false"
                navigatorRefresh="false"
                navigatorDelete="false"
                navigatorAdd="false"
                navigatorEdit="false"
                navigatorSearch="false"
                gridModel="listAssetRegistrationTemp"
                rowList="10,20,30"
                rowNum="10"
                viewrecords="true"
                rownumbers="true"
                shrinkToFit="false"
                width="$('#tabmnuassetRegistration').width()"
            >
                <sjg:gridColumn
                    name="code" index="code" key="code" title="Code" width="100" sortable="true"
                />
                <sjg:gridColumn
                    name="name" index="name" title="Name" width="330" sortable="true"
                />
                <sjg:gridColumn
                    name="activeStatus" index="activeStatus" title="Active" width="50" formatter="checkbox" align="center"
                />
            </sjg:grid >

        </div>
            <br/>
            <br/>

            <sj:a href="#" id="dlgAssetRegistration_okButton" button="true">Ok</sj:a>
            <sj:a href="#" id="dlgAssetRegistration_cancelButton" button="true">Cancel</sj:a>
            
    </body>
</html>