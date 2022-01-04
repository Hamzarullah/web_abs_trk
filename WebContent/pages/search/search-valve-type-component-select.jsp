
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
      
    var search_valveTypeComponent_type= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>';
    
    jQuery(document).ready(function(){  
        $("#dlgValveTypeComponent_okButton").click(function(ev) { 
            selectedRowId = $("#dlgSearch_valveTypeComponent_grid").jqGrid("getGridParam","selrow");

            if(selectedRowId === null){
                alert("Please Select Row ValveTypeComponent!");
                return;
            }
            
             var data_search_valveTypeComponent = $("#dlgSearch_valveTypeComponent_grid").jqGrid('getRowData', selectedRowId);
            
              if (search_valveTypeComponent_type=== "grid" ) {
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                var idsOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
                
                for(var j=0;j<idsOpener.length;j++){
                    var dataOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
                    
                    switch(id_document){
                        case "valveTypeComponent":
                            if(data_search_valveTypeComponent.code === dataOpener.valveTypeComponentCode){
                                alertMsg("Code "+data_search_valveTypeComponent.code+" Has Been Existing In Grid!");
                                return;
                            }
                            break; 
                    }
                }
                var selectedRowID = $("#"+id_document+"Input_grid",opener.document).jqGrid("getGridParam", "selrow");
                $("#"+selectedRowID+"_"+id_document+"Code",opener.document).val(data_search_valveTypeComponent.code);
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ValveTypeComponentCode", data_search_valveTypeComponent.code);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"ValveTypeComponentName", data_search_valveTypeComponent.name);           
                $("#"+id_document+"Input_grid",opener.document).jqGrid("setCell", selectedRowID, id_document+"Name", data_search_valveTypeComponent.name);           
                
            }else if(search_valveTypeComponent_type=== "multi" ){
                var $grid = $("#dlgSearch_valveTypeComponent_grid"), selIds = $grid.jqGrid("getGridParam", "selarrrow"), i, n,
                    cellValues = [];
                for (i = 0, n = selIds.length; i < n; i++) {
                    var defRow = {
                        code    : $grid.jqGrid("getCell", selIds[i], "code"),
                        name    : $grid.jqGrid("getCell", selIds[i], "name")
                    };
                    cellValues.push(defRow);
                }             
                window.opener.addRowDataMultiSelectedValveTypeComponent(cellValues);
            }
            else {
                $("#"+id_document+"\\."+id_subdoc+"\\.code",opener.document).val(data_search_valveTypeComponent.code);
                $("#"+id_document+"\\."+id_subdoc+"\\.name",opener.document).val(data_search_valveTypeComponent.name);
                
            }

            window.close();
        });

        $("#dlgValveTypeComponent_cancelButton").click(function(ev) { 
            data_search_valveTypeComponent = null;
            window.close();
        });
    
        $("#btn_dlg_ValveTypeComponentSearch").click(function(ev) {
            $("#dlgSearch_valveTypeComponent_grid").jqGrid("setGridParam",{url:"master/valve-type-component-data?" + $("#frmValveTypeComponentSearch").serialize(), page:1});
            $("#dlgSearch_valveTypeComponent_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
     });
     
      function alertMsg(txt_message){
        var dynamicDialog= $(
        '<div id="conformBoxError">'+
            '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                '</span>'+txt_message+'<span style="float:left; margin:0 7px 20px 0;">'+
            '</span>' +
        '</div>');

        dynamicDialog.dialog({
            title : "Attention!",
            closeOnEscape: false,
            modal : true,
            width: 400,
            resizable: false,
            closeText: "hide",
            buttons : 
            [{
                text : "OK",
                click : function() {
                    $(this).dialog("close");
                }
            }]
        });
    }
    
</script>
<seal>
<s:url id="remoteurlValveTypeComponentSearch" action="" />

    <div class="ui-widget">
        <s:form id="frmValveTypeComponentSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Code</td>
                <td><s:textfield id="valveTypeComponentSearchCode" name="valveTypeComponentSearchCode" label="Code "></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Name</td>
                <td><s:textfield id="valveTypeComponentSearchName" name="valveTypeComponentSearchName" size="50"></s:textfield></td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_ValveTypeComponentSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_valveTypeComponent_grid"
            dataType="json"
            href="%{remoteurlValveTypeComponentSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            multiselect = "true"
            gridModel="listValveTypeComponentTemp"
            rowNum="10000"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuvalveTypeComponent').width()"
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
    <sj:a href="#" id="dlgValveTypeComponent_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgValveTypeComponent_cancelButton" button="true">Cancel</sj:a>
</seal>
</html>