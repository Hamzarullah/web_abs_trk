<%-- 
    Document   : search-processedPart
    Created on : Aug 23, 2019, 9:59:08 AM
    Author     : jsone
--%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ taglib prefix="sjg" uri="/struts-jquery-grid-tags"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/aes.js"></script>
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
       
    var search_processedPart= '<%= request.getParameter("type") %>';
    var id_document = '<%= request.getParameter("iddoc") %>';
    var id_subdoc= '<%= request.getParameter("idsubdoc") %>'; 
    var item_material_code= '<%= request.getParameter("itemMaterialCode") %>'; 
    var item_material_name= '<%= request.getParameter("itemMaterialName") %>'; 
    var on_handstock= '<%= request.getParameter("onHandStock") %>'; 
    var booked= '<%= request.getParameter("booked") %>'; 
    var available= '<%= request.getParameter("available") %>'; 
    var book_quantity= '<%= request.getParameter("bookQuantity") %>'; 
    var uomCode= '<%= request.getParameter("uomCode") %>';
    var prQuantity= '<%= request.getParameter("prQuantity")%>';
    var rowLast= '<%= request.getParameter("rowLast") %>';
    
    jQuery(document).ready(function(){  
        
        if(id_document==="imrItemMaterialRequestBookedDetail"){
            $("#itemMaterialCode").val(item_material_code);
            $("#itemMaterialName").val(item_material_name);
            $("#onHandStock").val(on_handstock);
            $("#booked").val(booked);
            $("#available").val(available);
            $("#bookQuantity").val(book_quantity);
            $("#uomCode").val(uomCode);
            $("#uomCode2").val(uomCode);
            $("#uomCode3").val(uomCode);
            $("#uomCode4").val(uomCode);  
            $("#imrRequest").hide();
        }else{
            $("#itemMaterialCode").val(item_material_code);
            $("#itemMaterialName").val(item_material_name);
            $("#onHandStock").val(on_handstock);
            $("#uomCode").val(uomCode);
            $("#uomCode5").val(uomCode);
            $("#prQuantity").val(prQuantity);
            $("#imrBooked1").hide();
            $("#imrBooked2").hide();
            $("#imrBooked3").hide();
        }
        imrItemMaterialRequestBookedDetailRowId=rowLast;
        imrItemMaterialRequestDetailRowId=rowLast;
        
        $("#dlgProcessedPart_okButton").click(function(ev) { 
            var ids = jQuery("#dlgSelect_processedPart_grid").jqGrid('getDataIDs');
            var idsOpener = $("#"+id_document+"Input_grid",opener.document).jqGrid('getDataIDs');
            for(var i=0; i<ids.length; i++){
                let exist = false;
                var data = $("#dlgSelect_processedPart_grid").jqGrid('getRowData',ids[i]);
                for(var j=0; j<idsOpener.length; j++){
                    var dataExist = $("#"+id_document+"Input_grid",opener.document).jqGrid('getRowData',idsOpener[j]);
                    if(id_document === 'imrItemMaterialRequestBookedDetail'){
                        if($("#itemMaterialCode").val() === dataExist.imrItemMaterialRequestBookedDetailItemMaterialCode && data.partCode === dataExist.imrItemMaterialRequestBookedDetailPartCode && data.documentDetailCode === dataExist.imrItemMaterialRequestBookedDetailDocumentDetailCode){
                            exist = true;
                        }
                    }else if(id_document === 'imrItemMaterialRequestDetail'){
                         if($("#itemMaterialCode").val() === dataExist.imrItemMaterialRequestDetailItemMaterialCode && data.partCode === dataExist.imrItemMaterialRequestDetailPartCode && data.documentDetailCode === dataExist.imrItemMaterialRequestDetailDocumentDetailCode){
                            exist = true;
                        }
                    }
                }
                if(exist){
                    alert("Data has already exist");
                    return;
                }else{
                    if(id_document === 'imrItemMaterialRequestBookedDetail'){
                        var defRow = {
                            imrItemMaterialRequestBookedDetailDelete                      : "delete",
                            imrItemMaterialRequestBookedBOMDetailCode                     : data.bomDetailCode,
                            imrItemMaterialRequestBookedDetailItemMaterialCode            : item_material_code,
                            imrItemMaterialRequestBookedDetailItemMaterialName            : item_material_name,
                            imrItemMaterialRequestBookedDetailDocumentDetailCode          : data.documentDetailCode,
                            imrItemMaterialRequestBookedDetailItemFinishGoodsCode         : data.itemFinishGoodsCode,
                            imrItemMaterialRequestBookedDetailItemFinishGoodsRemark       : data.itemFinishGoodsRemark,
                            imrItemMaterialRequestBookedDetailItemPpoNo                   : data.itemPpoNo,
                            imrItemMaterialRequestBookedDetailPartNo                      : data.partNo,
                            imrItemMaterialRequestBookedDetailPartCode                    : data.partCode,
                            imrItemMaterialRequestBookedDetailPartName                    : data.partName,
                            imrItemMaterialRequestBookedDetailDrawingCode                 : data.drawingCode,
                            imrItemMaterialRequestBookedDetailDimension                   : data.dimension,
                            imrItemMaterialRequestBookedDetailRequiredLength              : data.requiredLength,
                            imrItemMaterialRequestBookedDetailMaterial                    : data.material,
                            imrItemMaterialRequestBookedDetailQuantity                    : data.quantity,
                            imrItemMaterialRequestBookedDetailRequirement                 : data.requirement,
                            imrItemMaterialRequestBookedDetailProcessedStatus             : data.processedStatus,
                            imrItemMaterialRequestBookedDetailRemark                      : data.remark,
                            imrItemMaterialRequestBookedDetailX                           : data.x,
                            imrItemMaterialRequestBookedDetailRevNo                       : data.revNo
                        };
                        
                        imrItemMaterialRequestBookedDetailRowId++;
                        window.opener.addRowDataMultiSelectedRequestBooked(imrItemMaterialRequestBookedDetailRowId,defRow);
                        
                    }else if(id_document === 'imrItemMaterialRequestDetail'){
                        var defRow = {
                            imrItemMaterialRequestDetailDelete                      : "delete",
                            imrItemMaterialRequestDetailBomDetailCode               : data.bomDetailCode,
                            imrItemMaterialRequestDetailItemMaterialCode            : item_material_code,
                            imrItemMaterialRequestDetailItemMaterialName            : item_material_name,
                            imrItemMaterialRequestDetailDocumentDetailCode          : data.documentDetailCode,
                            imrItemMaterialRequestDetailItemFinishGoodsCode         : data.itemFinishGoodsCode,
                            imrItemMaterialRequestDetailItemFinishGoodsRemark       : data.itemFinishGoodsRemark,
                            imrItemMaterialRequestDetailItemPpoNo                   : data.itemPpoNo,
                            imrItemMaterialRequestDetailPartNo                      : data.partNo,
                            imrItemMaterialRequestDetailPartCode                    : data.partCode,
                            imrItemMaterialRequestDetailPartName                    : data.partName,
                            imrItemMaterialRequestDetailDrawingCode                 : data.drawingCode,
                            imrItemMaterialRequestDetailDimension                   : data.dimension,
                            imrItemMaterialRequestDetailRequiredLength              : data.requiredLength,
                            imrItemMaterialRequestDetailMaterial                    : data.material,
                            imrItemMaterialRequestDetailQuantity                    : data.quantity,
                            imrItemMaterialRequestDetailRequirement                 : data.requirement,
                            imrItemMaterialRequestDetailProcessedStatus             : data.processedStatus,
                            imrItemMaterialRequestDetailRemark                      : data.remark,
                            imrItemMaterialRequestDetailX                           : data.x,
                            imrItemMaterialRequestDetailRevNo                       : data.revNo
                        };
                        
                        imrItemMaterialRequestDetailRowId++;
                        window.opener.addRowDataMultiSelectedRequest(imrItemMaterialRequestDetailRowId,defRow);
                        
                    }
                }
            }
            window.close();
        });

        $("#dlgProcessedPart_cancelButton").click(function(ev) { 
            data_search_processedPart = null;
            window.close();
        });
    
        $("#btn_dlg_ProcessedPartSearch").click(function(ev) {
            
            $("#dlgSearch_processedPart_grid").jqGrid("clearGridData");
            if(id_document==="imrItemMaterialRequestBookedDetail" || id_document==="imrItemMaterialRequestDetail"){
                var ids = jQuery("#processedPart_grid",opener.document).jqGrid('getDataIDs'); 
                var idt = jQuery("#dlgSearch_processedPart_grid").jqGrid('getDataIDs'); 
                var processedPartRowId = idt.length;

                for(var i=0; i<ids.length; i++){
                    var data = $("#processedPart_grid",opener.document).jqGrid('getRowData',ids[i]);
                    var defRow = {
                        bomDetailCode                   : data.imrProcessedBillOfMaterialBOMDetailCode,
                        documentDetailCode              : data.imrProcessedBillOfMaterialDetailDocumentDetailCode,
                        itemFinishGoodsCode             : data.imrProcessedBillOfMaterialDetailItemFinishGoodsCode,
                        itemFinishGoodsRemark           : data.imrProcessedBillOfMaterialDetailItemFinishGoodsRemark,
                        itemPpoNo                       : data.imrProcessedBillOfMaterialDetailItemPpoNo,
                        partNo                          : data.imrProcessedBillOfMaterialDetailPartNo,
                        partCode                        : data.imrProcessedBillOfMaterialDetailPartCode,
                        partName                        : data.imrProcessedBillOfMaterialDetailPartName,
                        drawingCode                     : data.imrProcessedBillOfMaterialDetailDrawingCode,
                        dimension                       : data.imrProcessedBillOfMaterialDetailDimension,
                        requiredLength                  : data.imrProcessedBillOfMaterialDetailRequiredLength,
                        material                        : data.imrProcessedBillOfMaterialDetailMaterial,
                        quantity                        : data.imrProcessedBillOfMaterialDetailQuantity,
                        requirement                     : data.imrProcessedBillOfMaterialDetailRequirement,
                        processedStatus                 : data.imrProcessedBillOfMaterialDetailProcessedStatus,
                        remark                          : data.imrProcessedBillOfMaterialDetailRemark,
                        x                               : data.imrProcessedBillOfMaterialDetailX,
                        revNo                           : data.imrProcessedBillOfMaterialDetailRevNo
                    };
                    
                    processedPartRowId++;
                    $("#dlgSearch_processedPart_grid").jqGrid("addRowData", processedPartRowId, defRow);
                    ev.preventDefault();
                }
            }
            $("#dlgSearch_processedPart_grid").trigger("reloadGrid");
        });
        
        $("#btn_dlg_ProcessedPartSelect").click(function(ev) { 

            var ids = jQuery("#dlgSearch_processedPart_grid").jqGrid('getDataIDs');
            var idsFix = jQuery("#dlgSelect_processedPart_grid").jqGrid('getDataIDs');
            var countFix = 0;
            for(var i=0;i<ids.length;i++){

                var exist = false;
                var dataSelect = $("#dlgSearch_processedPart_grid").jqGrid('getRowData',ids[i]);
                
                if($("input:checkbox[id='jqg_dlgSearch_processedPart_grid_"+ids[i]+"']").is(":checked")){
   
                    for(var j=0; j<idsFix.length; j++){
                        
                        var dataExist = $("#dlgSelect_processedPart_grid").jqGrid('getRowData',idsFix[j]);

                        if(dataSelect.code === dataExist.code){
                            exist = true;
                        }else{
                            countFix++;
                        }
                    }
                    if(exist){
                            alert("data was in grid");
                            return;
                    }else{
                        
                        var defRow = {
                            processedPartDelete          : "delete",
                            bomDetailCode                : dataSelect.bomDetailCode,
                            documentDetailCode           : dataSelect.documentDetailCode,
                            itemFinishGoodsCode          : dataSelect.itemFinishGoodsCode,
                            itemFinishGoodsRemark        : dataSelect.itemFinishGoodsRemark,
                            itemPpoNo                    : dataSelect.itemPpoNo,
                            partNo                       : dataSelect.partNo,
                            partCode                     : dataSelect.partCode,
                            partName                     : dataSelect.partName,
                            drawingCode                  : dataSelect.drawingCode,
                            dimension                    : dataSelect.dimension,
                            requiredLength               : dataSelect.requiredLength,
                            material                     : dataSelect.material,
                            quantity                     : dataSelect.quantity,
                            requirement                  : dataSelect.requirement,
                            processedStatus              : dataSelect.processedStatus,
                            remark                       : dataSelect.remark,
                            x                            : dataSelect.x,
                            revNo                        : dataSelect.revNo
                        };
                        
                        $("#dlgSelect_processedPart_grid").jqGrid("addRowData", countFix, defRow);
                        countFix++;
                        
                    }
                }
            }
            $("#dlgSearch_processedPart_grid").trigger("reloadGrid");
            
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
    
    function processedPartInputGrid_Delete_OnClick() {
    var selectDetailRowId = $("#dlgSelect_processedPart_grid").jqGrid('getGridParam', 'selrow');
      if (selectDetailRowId === null) {
        alertMessage("Please Select Row!");
        return;
      }
      $("#dlgSelect_processedPart_grid").jqGrid('delRowData', selectDetailRowId);
    }
        
</script>
<body>
<s:url id="remoteurlProcessedPartSearch" action="" />
<s:url id="remoteurlProcessedPartSelect" action="" />
    
    <div class="ui-widget">
        <s:form id="frmProcessedPartSearch">
        <table cellpadding="2" cellspacing="2">
            <tr>
                <td align="right">Item Material Code</td>
                <td><s:textfield id="itemMaterialCode" name="itemMaterialCode" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">Item Material Name</td>
                <td><s:textfield id="itemMaterialName" name="itemMaterialName" readonly="true"></s:textfield></td>
            </tr>
            <tr>
                <td align="right">On Hand Stock</td>
                <td><s:textfield id="onHandStock" name="onHandStock" readonly="true" cssStyle="text-align:right" size="10"></s:textfield>
                    <s:textfield id="uomCode" class="uomCode" name="uomCode" readonly="true" size="8"></s:textfield></td>
            </tr>
            <tr id="imrBooked1">
                <td align="right">Booked</td>
                <td><s:textfield id="booked" name="booked" readonly="true" cssStyle="text-align:right" size="10"></s:textfield>
                    <s:textfield id="uomCode2" name="uomCode2" readonly="true" size="8"></s:textfield></td>
            </tr>
            <tr id="imrBooked2">
                <td align="right">Available</td>
                <td><s:textfield id="available" name="available" readonly="true" cssStyle="text-align:right" size="10"></s:textfield>
                    <s:textfield id="uomCode3" name="uomCode3" readonly="true" size="8"></s:textfield></td>
            </tr>
            <tr id="imrBooked3">
                <td align="right">Book Quantity</td>
                <td><s:textfield id="bookQuantity" name="bookQuantity" readonly="true" cssStyle="text-align:right" size="10"></s:textfield>
                    <s:textfield id="uomCode4" name="uomCode4" readonly="true" size="8"></s:textfield></td>
            </tr>
            <tr id="imrRequest">
                <td align="right">PR Quantity</td>
                <td><s:textfield id="prQuantity" name="prQuantity" readonly="true" cssStyle="text-align:right" size="10"></s:textfield>
                    <s:textfield id="uomCode5" name="uomCode5" readonly="true" size="8"></s:textfield></td>
            </tr>
            <tr>
                <td colspan="2"><sj:a href="#" id="btn_dlg_ProcessedPartSearch" button="true">Search</sj:a></td>
            </tr>
        </table>
        </s:form>
    </div>
    
    <div class="ui-widget ui-widget-content">
        <sjg:grid
            id="dlgSearch_processedPart_grid"
            dataType="json"
            href="%{remoteurlProcessedPartSearch}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listProcessedPartTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            multiselect="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuProcessedPart').width()"
        >
            <sjg:gridColumn
                name="bomDetailCode" index="bomDetailCode" key="bomDetailCode" title="BOM Detail Code" width="220" sortable="true" hidden = "false"
            />
            <sjg:gridColumn
                name="documentDetailCode" index="documentDetailCode" key="documentDetailCode" title="Document Detail Code" width="220" sortable="true"
            />
            <sjg:gridColumn
                name="itemFinishGoodsCode" index="itemFinishGoodsCode" key="itemFinishGoodsCode" title="ItemFinishGoodsCode" width="220" sortable="true"
            />
            <sjg:gridColumn
                name="itemFinishGoodsRemark" index="itemFinishGoodsRemark" key="itemFinishGoodsRemark" title="ItemFinishGoodsRemark" width="220" sortable="true"
            />  
            <sjg:gridColumn
                name="itemPpoNo" index="itemPpoNo" key="itemPpoNo" title="Item PPO No" width="220" sortable="true"
            />  
            <sjg:gridColumn
                name="partNo" index="partNo" key="partNo" title="Part No" width="220" sortable="true"
            />  
            <sjg:gridColumn
                name="partCode" index="partCode" key="partCode" title="Part Code" width="220" sortable="true"
            />  
            <sjg:gridColumn
                name="partName" index="partName" key="partName" title="Part Name" width="220" sortable="true"
            />  
            <sjg:gridColumn
                name="drawingCode" index="drawingCode" key="drawingCode" title="Drawing Code/Standard" width="220" sortable="true"
            />  
            <sjg:gridColumn
                name="dimension" index="dimension" key="dimension" title="Dimension" width="220" sortable="true"
            />  
            <sjg:gridColumn
                name="requiredLength" index="requiredLength" key="requiredLength" title="Required Length" width="220" sortable="true"
            />  
            <sjg:gridColumn
                name="material" index="material" key="material" title="Material" width="220" sortable="true"
            />  
            <sjg:gridColumn
                name="quantity" index="quantity" key="quantity" title="Quantity/Bom" 
                width="150" align="right" formatoptions= "{ thousandsSeparator:','}"
                formatter="number" editrules="{ double: true }"
            />
            <sjg:gridColumn
                name="requirement" index="requirement" key="requirement" title="Requirement" width="220" sortable="true"
            /> 
            <sjg:gridColumn
                name="processedStatus" index="processedStatus" key="processedStatus" title="Processed Status" width="220" sortable="true"
            /> 
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="220" sortable="true"
            /> 
            <sjg:gridColumn
                name="x" index="x" key="x" title="X " width="220" sortable="true"
            /> 
            <sjg:gridColumn
                name="revNo" index="revNo" key="revNo" title="Rev No" width="220" sortable="true"
            /> 
        </sjg:grid >
        
    </div>
    <br></br>
    <sj:a href="#" id="btn_dlg_ProcessedPartSelect" button="true">Select</sj:a>
    <br></br>
    
    <sjg:grid
            id="dlgSelect_processedPart_grid"
            dataType="json"
            editurl="%{remoteurlProcessedPartSelect}"
            pager="true"
            navigator="true"
            navigatorView="false"
            navigatorRefresh="false"
            navigatorDelete="false"
            navigatorAdd="false"
            navigatorEdit="false"
            navigatorSearch="false"
            gridModel="listProcessedPartTemp"
            rowList="10,20,30"
            rowNum="10"
            viewrecords="true"
            rownumbers="true"
            shrinkToFit="false"
            width="$('#tabmnuProcessedPart').width()"
            editinline="true"
        >
            <sjg:gridColumn
                name="processedPartDelete" index="processedPartDelete" title="" width="50" align="center"
                editable="true" edittype="button"
                editoptions="{onClick:'processedPartInputGrid_Delete_OnClick()', value:'delete'}"
            />
            <sjg:gridColumn
                name="bomDetailCode" index="bomDetailCode" key="bomDetailCode" title="BOM Detail Code" width="220" sortable="true" hidden = "false"
            />
            <sjg:gridColumn
                name="documentDetailCode" index="documentDetailCode" key="documentDetailCode" title="Document Detail Code" width="220" sortable="true"
            />
            <sjg:gridColumn
                name="itemFinishGoodsCode" index="itemFinishGoodsCode" key="itemFinishGoodsCode" title="ItemFinishGoodsCode" width="220" sortable="true"
            />
            <sjg:gridColumn
                name="itemFinishGoodsRemark" index="itemFinishGoodsRemark" key="itemFinishGoodsRemark" title="ItemFinishGoodsRemark" width="220" sortable="true"
            />  
            <sjg:gridColumn
                name="itemPpoNo" index="itemPpoNo" key="itemPpoNo" title="Item PPO No" width="220" sortable="true"
            />  
            <sjg:gridColumn
                name="partNo" index="partNo" key="partNo" title="Part No" width="220" sortable="true"
            />  
            <sjg:gridColumn
                name="partCode" index="partCode" key="partCode" title="Part Code" width="220" sortable="true"
            />  
            <sjg:gridColumn
                name="partName" index="partName" key="partName" title="Part Name" width="220" sortable="true"
            />  
            <sjg:gridColumn
                name="drawingCode" index="drawingCode" key="drawingCode" title="Drawing Code/Standard" width="220" sortable="true"
            />  
            <sjg:gridColumn
                name="dimension" index="dimension" key="dimension" title="Dimension" width="220" sortable="true"
            />  
            <sjg:gridColumn
                name="requiredLength" index="requiredLength" key="requiredLength" title="Required Length" width="220" sortable="true"
            />  
            <sjg:gridColumn
                name="material" index="material" key="material" title="Material" width="220" sortable="true"
            />  
            <sjg:gridColumn
                name="quantity" index="quantity" key="quantity" title="Quantity/Bom" 
                width="150" align="right" formatoptions= "{ thousandsSeparator:','}"
                formatter="number" editrules="{ double: true }"
            />
            <sjg:gridColumn
                name="requirement" index="requirement" key="requirement" title="Requirement" width="220" sortable="true"
            /> 
            <sjg:gridColumn
                name="processedStatus" index="processedStatus" key="processedStatus" title="Processed Status" width="220" sortable="true"
            /> 
            <sjg:gridColumn
                name="remark" index="remark" key="remark" title="Remark" width="220" sortable="true"
            /> 
            <sjg:gridColumn
                name="x" index="x" key="x" title="X " width="220" sortable="true"
            /> 
            <sjg:gridColumn
                name="revNo" index="revNo" key="revNo" title="Rev No" width="220" sortable="true"
            /> 
        </sjg:grid >
    
    
    <sj:a href="#" id="dlgProcessedPart_okButton" button="true">Ok</sj:a>
    <sj:a href="#" id="dlgProcessedPart_cancelButton" button="true">Cancel</sj:a>
</body>
</html>


