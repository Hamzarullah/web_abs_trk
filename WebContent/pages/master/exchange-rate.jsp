
<%@page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@taglib prefix="sjg" uri="/struts-jquery-grid-tags" %>

<script type="text/javascript" src="<s:url value="/js/jquery.json-2.2.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.validate.min.js"/>"></script>
<link href="css/pagestyle.css" rel="stylesheet" type="text/css" />

<style>
    #exchangeRate_grid_pager_center{
        display: none;
    }
    #lblCommandNext{
        color: red;
    }
</style>

<script type="text/javascript">
    var exchangeRate_gridlastSel = -1;
    var flagConfirmExchangeRate=false;
    var 
        txtExchangeRateCode=$("#exchangeRate\\.code"),
        txtExchangeRateCurrencyCode=$("#exchangeRate\\.currency\\.code"),
        txtExchangeRateCurrencyName=$("#exchangeRate\\.currency\\.name"),
        txtExchangeRateTransactionDate=$("#exchangeRate\\.transactionDate"),
        dtpExchangeRateTransactionDatefrom=$("#exchangeRate\\.transactionDateFrom"),
        dtpExchangeRateTransactionDateTo=$("#exchangeRate\\.transactionDateTo"),
        txtExchangeRateExchangeRate=$("#exchangeRate\\.exchangeRate"),
        chkExchangeRateActiveStatus=$("exchangeRate\\.activeStatus"),
        txtExchangeRateCreatedBy = $("#exchangeRate\\.createdBy"),
        txtExchangeRateCreatedDate = $("#exchangeRate\\.createdDate"),
        
        allFields=$([])
            .add(txtExchangeRateCode)
            .add(txtExchangeRateCurrencyCode)
            .add(txtExchangeRateCurrencyName)
            .add(txtExchangeRateTransactionDate)
            .add(txtExchangeRateExchangeRate)
            .add(chkExchangeRateActiveStatus)
            .add(txtExchangeRateCreatedBy)
            .add(txtExchangeRateCreatedDate);


    function reloadGridRateBI(){
        $("#exchangeRate_grid").trigger("reloadGrid");
    };
    
    
    $(document).ready(function (){
        hoverButton();
        $("#lblCommandNext").hide();
        flagConfirmExchangeRate=false;
        $("#exchangeRate\\.exchangeRate").keyup(function(e){
            $(this).val(function(index, value) {
                 value = value.replace(/,/g,""); 
                 return numberWithCommas(value); 
            });
        });

        $("#exchangeRate\\.exchangeRate").change(function(e){
            var exRateTax=$("#exchangeRate\\.exchangeRate").val();
            if(exRateTax===""){
               $("#exchangeRate\\.exchangeRate").val("0.00");
            }
            $(this).val(function(index,value) {
                value = value.replace(/,/g,""); 
                return formatNumber(parseFloat(value),2); 
            });
        });
        
        $("#btnExchangeRateNew").click(function(ev){
            showInput("exchangeRate");
            hideInput("exchangeRateSearch");
            
            txtExchangeRateCode.attr("readonly",false);
            ev.preventDefault();
        });
        
        $("#btnExchangeRateSave").click(function(ev) {
            if(exchangeRate_gridlastSel !== -1) {
                $('#exchangeRate_grid').jqGrid("saveRow",exchangeRate_gridlastSel);
            }
            
            if(flagConfirmExchangeRate===true){
                var   url = "master/exchange-rate-save-update";
                var params;

                var currency=$("#exchangeRate\\.currency\\.code").val();
                var listExchangeRateToConfirm=[];

                var ids = jQuery("#exchangeRate_grid").jqGrid('getDataIDs'); 

                for(var dt=0;dt<ids.length;dt++){
                    var exchangeRateGrid= $("#exchangeRate_grid").jqGrid('getRowData',ids[dt]); 

                    var exchangeRateFormat=exchangeRateGrid.exchangeRate.replace(/,/g, "");
                    var transactionDateGridValue=exchangeRateGrid.transactionDate;
                    var transactionDateGridFormatValues= transactionDateGridValue.split('/');
                    var transactionDateGridFormat = transactionDateGridFormatValues[1]+"-"+transactionDateGridFormatValues[0]+"-"+transactionDateGridFormatValues[2];              

                    var ExchangeRateData={
                       code             :"BI/"+currency+"/"+transactionDateGridFormat.toString().replace(/-/g,""),
                       currency         :{code:currency},
                       transactionDate  :exchangeRateGrid.transactionDate,
                       exchangeRate     :exchangeRateFormat,
                       activeStatus     :1
                    };
                    listExchangeRateToConfirm[dt]=ExchangeRateData;
                }


                params="listExchangeRateToConfirmJSon=" + $.toJSON(listExchangeRateToConfirm);

                $.post(url, params, function(data) {
                    if (data.error) {
                        alert(data.errorMessage);
                        return;
                    }
                    var dynamicDialog= $(
                            '<div id="conformBoxError">'+
                                '<span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;">'+
                                    '</span>'+data.message+'<span style="float:left; margin:0 7px 20px 0;">'+
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
                                    allFields.val('').removeClass('ui-state-error');
                                    var url = "master/exchange-rate";
                                    var params = "";

                                    pageLoad(url, params, "#tabmnuEXCHANGE_RATE");
                                }
                            }]
                    });
                });
            }else{
                alertMessage("Please Confirm!",$("#btnExchangeRateConfirm"));
            }
        });
        
        
        $("#btnExchangeRateCancel").click(function(ev) {
            hideInput("exchangeRate");
            showInput("exchangeRateSearch");
            allFields.val('').removeClass('ui-state-error');
            ev.preventDefault();
        });
        
        $('#btnExchangeRateRefresh').click(function(ev) {
            $("#exchangeRate_grid").jqGrid("clearGridData");
            $("#exchangeRate_grid").jqGrid("setGridParam",{url:"master/exchange-rate-search-data?"});
            $("#exchangeRate_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
        
        $('#btnExchangeRate_search').click(function(ev) {
            $("#exchangeRate_grid").jqGrid("clearGridData");
            $("#exchangeRate_grid").jqGrid("setGridParam",{url:"master/exchange-rate-search-data?" + $("#frmExchangeRateSearchInput").serialize()});
            $("#exchangeRate_grid").trigger("reloadGrid");
            ev.preventDefault();
        });
       
        $('#exchangeRate_btnCurrency').click(function(ev) {
            window.open("./pages/search/search-currency.jsp?iddoc=exchangeRate&idsubdoc=currency","Search", "width=600, height=500");
        });
        
        function setFieldExchageRateBIGrid(){
            var colExchangeRate = jQuery("#exchangeRate_grid").jqGrid('getColProp','exchangeRate');
            
            if(txtExchangeRateCurrencyCode.val()==="IDR"){
                colExchangeRate.editable=false;
            }else{
                colExchangeRate.editable=true;
            }
        }
        
        function numberWithCommas(x) {
            var parts = x.toString().split(".");

            parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            return parts.join(".");
        }  
        
        function formatDateExchangeRate(){
            var transactionDateFrom=$("#exchangeRate\\.transactionDateFrom").val();
            var dateFromValues= transactionDateFrom.split('/');
            var transactionDateFromValue = dateFromValues[1]+"/"+dateFromValues[0]+"/"+dateFromValues[2];
            dtpExchangeRateTransactionDatefrom.val(transactionDateFromValue);
            
            var transactionDateTo=$("#exchangeRate\\.transactionDateTo").val();
            var dateToValues= transactionDateTo.split('/');
            var transactionDateToValue = dateToValues[1]+"/"+dateToValues[0]+"/"+dateToValues[2];
            dtpExchangeRateTransactionDateTo.val(transactionDateToValue);
        }
        
        function loadDetailExchangeRate() {
            setFieldExchageRateBIGrid();
            formatDateExchangeRate();
        
            var dat1=new Date(dtpExchangeRateTransactionDatefrom.val());
            var dat2=new Date(dtpExchangeRateTransactionDateTo.val());
            var diff=Math.abs(dat1.getTime() - dat2.getTime());
            var diffDay=Math.ceil(diff/(1000 * 3600 * 24));
            var arrDate=[];
            var arrDataTransactionDate=new Array();
            var arrDataTransactionDate1=new Array();
            var arrDataExchangeRate=[];
            var arrDisplay=[];
            
            var url = "exchange-rate-confirm-data";
            var params = $("#frmExchangeRateInput").serialize();
            
            $.getJSON(url, params, function(data) {
                var re2=/-/gi;
                
                for(var x=0;x<data.listExchangeRateToConfirm.length;x++){
                    arrDataTransactionDate.push(data.listExchangeRateToConfirm[x].transactionDate.toString().replace("T00:00:00",""));
                    arrDataExchangeRate.push(data.listExchangeRateToConfirm[x].exchangeRate);
                   
                }
                
                for(var d=0;d<arrDataTransactionDate.length;d++){
                    arrDataTransactionDate1.push(arrDataTransactionDate[d].toString().replace(re2,"/"));
                }

                while(dat1<=dat2){
                    var dd = (dat1.getDate() < 10 ? "0" : "")+(dat1.getDate());
                    var mm = (dat1.getMonth()+1 < 10 ? "0" : "")+(dat1.getMonth()+1);
                    var y = dat1.getFullYear();
                    arrDate.push(y+"/"+mm+"/"+dd);
                  
                    var newdt=dat1.setDate(dat1.getDate()+1);
                    dat1=new Date(newdt);
                }
                                
                for(var xy=0;xy<arrDate.length;xy++){
                    var exRate="0.00";
                    for(var yx=0;yx<arrDataTransactionDate1.length;yx++){
                        
                        if(arrDate[xy]===arrDataTransactionDate1[yx]){
                            exRate=arrDataExchangeRate[yx];
                        }
                    }
                    var arrDateFormat;
                    var splitDate=arrDate[xy].toString().split('/');
                   
                    arrDateFormat=splitDate[2]+"/"+splitDate[1]+"/"+splitDate[0];
                    
                    arrDisplay.push({transactionDate:arrDateFormat,exchangeRate:exRate});
                }
                
                exchangeRatelastRowId=0;
                for (var i=0; i<diffDay+1; i++) {
                    var defRow={};
                    exchangeRatelastRowId++;
                    if((arrDisplay[i].transactionDate)===""){
                        return;
                    }
                    $("#exchangeRate_grid").jqGrid("addRowData", exchangeRatelastRowId,defRow);
                    $("#exchangeRate_grid").jqGrid('setRowData',exchangeRatelastRowId,{
                        transactionDate : arrDisplay[i].transactionDate,
                        exchangeRate    : arrDisplay[i].exchangeRate
                    });
                }  

            });
            formatDateExchangeRate();
        }
       
        $("#btnExchangeRateUnConfirm").css("display", "none");
        $('#confirmedExchangeRate').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
        
        $("#btnExchangeRateConfirm").click(function(ev) {
                if(txtExchangeRateCurrencyName.val()==="") {
                    alertMessage("Currency Cannot Be Empty!",txtExchangeRateCurrencyCode);
                    return;
                }
                
                if(validateRangeDate()===false){
                    return;
                }
                
                if(txtExchangeRateCurrencyCode.val()==="IDR"){
                    txtExchangeRateExchangeRate.attr("readonly",true);
                    txtExchangeRateExchangeRate.val("1.00");
                    $("#lblCommandNextBI").show();
                }else{
                    txtExchangeRateExchangeRate.attr("readonly",false);
                    txtExchangeRateExchangeRate.val("0.00");
                    $("#lblCommandNextBI").hide();
                }
                
                loadDetailExchangeRate();
                flagConfirmExchangeRate=true;
                $("#btnExchangeRateUnConfirm").css("display", "block");
                $("#btnExchangeRateConfirm").css("display", "none");
                $('#headerInputExchangeRate').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
                $('#confirmedExchangeRate').unblock();
                
        });
        
        $("#btnExchangeRateUnConfirm").click(function(ev) {
            var url = "master/exchange-rate";
            var params = "";
                   
            pageLoad(url, params, "#tabmnuEXCHANGE_RATE");
                   
            $("#exchangeRate_grid").jqGrid('clearGridData');
            flagConfirmExchangeRate=false;
            $("#btnExchangeRateUnConfirm").css("display", "none");
            $("#btnExchangeRateConfirm").css("display", "block");
            $('#headerInputExchangeRate').unblock();
            $('#confirmedExchangeRate').block({ message: null, overlayCSS:{ backgroundColor: '#000', opacity: 0.1, cursor: null}});
            
        });
        
        $("#btnExchangeRateNext").click(function(ev) {
            var ids = jQuery("#exchangeRate_grid").jqGrid('getDataIDs');
            var nextExchangeRate=removeCommas($("#exchangeRate\\.exchangeRate").val());
            
            var arrData=[];
            for(var rw=0;rw<ids.length;rw++){
                var data=$("#exchangeRate_grid").jqGrid('getRowData',ids[rw]);
                
                var ExchageRateBI={
                    transactionDate : data.transactionDate,
                    exchangeRate    : nextExchangeRate
                };
                arrData[rw]=ExchageRateBI;
            }
            
            $("#exchangeRate_grid").jqGrid('clearGridData');
            
            exchangeRatelastRowId=0;
                for (var i=0; i<ids.length; i++) {
                    var defRow={};
                    exchangeRatelastRowId++;
                    
                    $("#exchangeRate_grid").jqGrid("addRowData", exchangeRatelastRowId,defRow);
                    
                    $("#exchangeRate_grid").jqGrid('setRowData',exchangeRatelastRowId,{
                        transactionDate : arrData[i].transactionDate,
                        exchangeRate    : arrData[i].exchangeRate
                    });
                }  
        });
        
        $.subscribe("exchangeRate_grid_onSelect", function(event, data) {
            
            var selectedRowID = $("#exchangeRate_grid").jqGrid("getGridParam", "selrow");
               
            if(selectedRowID!==exchangeRate_gridlastSel) {
                   
                $('#exchangeRate_grid').jqGrid("saveRow",exchangeRate_gridlastSel); 
                $('#exchangeRate_grid').jqGrid("editRow",selectedRowID,true); 
                   
                exchangeRate_gridlastSel=selectedRowID;
                   
            }
            else
                $('#exchangeRate_grid').jqGrid("saveRow",selectedRowID);
                              
        });
        
    });
    
     //validasi
    function validateRangeDate(){
        var isValidRange=true;
        var transactionDateFrom=$("#exchangeRate\\.transactionDateFrom").val();
        var dateFromValues= transactionDateFrom.split('/');
        var transactionDateFromValue =new Date(dateFromValues[1]+"/"+dateFromValues[0]+"/"+dateFromValues[2]);
        var transactionDateTo=$("#exchangeRate\\.transactionDateTo").val();
        var dateToValues= transactionDateTo.split('/');
        var transactionDateToValue =new Date(dateToValues[1]+"/"+dateToValues[0]+"/"+dateToValues[2]);

        if(transactionDateFromValue > transactionDateToValue){
            isValidRange=false;
            alertMessage("Period From Date Cannot Greater Then To Date!");
        }
        return isValidRange;
    }
    
    
        
</script>


<b>EXCHANGE RATE</b>
<hr>
<br class="spacer"/>
       
    <div id="exchangeRateInput" class="content ui-widget">
        <s:form id="frmExchangeRateInput">
            <table cellpadding="2" cellspacing="2" id="headerInputExchangeRate">
                <tr>
                    <td align="right"><B>Code *</B></td>
                    <td>
                        <script type = "text/javascript">
                                
                            txtExchangeRateCurrencyCode.change(function(ev) {
                                if(txtExchangeRateCurrencyCode.val()===""){
                                    txtExchangeRateCurrencyCode.val("");
                                    txtExchangeRateCurrencyName.val("");
                                    return;
                                }
                                var url = "master/currency-get";
                                var params = "currency.code=" + txtExchangeRateCurrencyCode.val();
                                    params += "&currency.activeStatus=TRUE";
                                $.post(url, params, function(result) {
                                    var data = (result);
                                    if (data.currencyTemp){
                                        txtExchangeRateCurrencyCode.val(data.currencyTemp.code);
                                        txtExchangeRateCurrencyName.val(data.currencyTemp.name);
                                    }
                                    else{
                                        alertMessage("Currency Not Found!",txtExchangeRateCurrencyCode);
                                        txtExchangeRateCurrencyCode.val("");
                                        txtExchangeRateCurrencyName.val("");
                                    }
                                });
                            });
                            
                        </script>
                            <div class="searchbox ui-widget-header">
                                <s:textfield id="exchangeRate.currency.code" name="currency.code" size="15"></s:textfield>
                                <sj:a id="exchangeRate_btnCurrency" href="#" openDialog="">&nbsp;&nbsp;<span class="ui-icon ui-icon-search"/></sj:a>
                            </div>
                            <s:textfield id="exchangeRate.currency.name" name="exchangeRate.currency.name" size="40" readonly="true"></s:textfield> 
                    </td>
                </tr>
                <tr>
                    <td align="right"><B>Period *</B></td>
                    <td>
                    <sj:datepicker id="exchangeRate.transactionDateFrom" name="transactionDateFrom" required="true" cssClass="required" size="40" showOn="focus" value="today" displayFormat="dd/mm/yy"></sj:datepicker>
                    <B>Up To *</B>
                    <sj:datepicker id="exchangeRate.transactionDateTo" name="transactionDateTo" required="true" cssClass="required" size="40"  showOn="focus" value="today" displayFormat="dd/mm/yy"></sj:datepicker></td>
                </tr>
            </table>
        </s:form>
        <table>
            <tr>
                <td>
                    <sj:a href="#" id="btnExchangeRateConfirm" button="true">Confirm</sj:a>
                    <sj:a href="#" id="btnExchangeRateUnConfirm" button="true">UnConfirm</sj:a>
                </td>
            </tr>

            <td><s:textfield id="exchangeRate.createdBy"  name="exchangeRate.createdBy" size="20" style="display:none"></s:textfield></td>
            <td><s:textfield id="exchangeRate.createdDate" name="exchangeRate.createdDate" size="20" style="display:none"></s:textfield></td>
        </table>
    </div>

    <s:url id="remotedetailurlExchangeRate" action="" />
    <div>
        <table id="confirmedExchangeRate">
            <tr>
                <td>
                    <table>
                        <tr>
                            <td align="right"><b>Exchange Rate *</b></td>
                            <td><s:textfield style="text-align:right" id="exchangeRate.exchangeRate" name="exchangeRate.exchangeRate" required="true" cssClass="required" size="25" value="0"></s:textfield></td>
                            <td>
                                <sj:a href="#" id="btnExchangeRateNext" button="true">Next</sj:a>
                            </td>
                            <td id="lblCommandNextBI"><label>Press Button Next To Set Value IDR</label></td>
                        </tr>
                    </table>
                    <br/>
                </td>
            </tr>
            <tr>
                <td>
                    <div id="exchangeRateGrid">
                    <sjg:grid
                        id="exchangeRate_grid"
                        dataType="local"
                        pager="true"
                        navigator="false"
                        navigatorView="false"
                        navigatorRefresh="false"
                        navigatorDelete="false"
                        navigatorAdd="false"
                        navigatorEdit="false"
                        gridModel="listExchangeRate"
                        viewrecords="true"
                        rownumbers="true"
                        shrinkToFit="false"
                        editinline="true"
                        editurl="%{remotedetailurlExchangeRate}"
                        onSelectRowTopics="exchangeRate_grid_onSelect"
                        >
                            <sjg:gridColumn
                                name="transactionDate" index="transactionDate" title="Date" 
                                sortable="false" align="center"
                                formatter="date" formatoptions="{newformat : 'm/d/Y', srcformat : 'Y/m/d'}" 
                                width="80" editrules="{date: false, required:false}"
                                editoptions="{size:12, maxlength: 19, dataInit: function(elem){$(elem).datepicker({dateFormat:'mm/dd/yy'});}}"
                            />
                            <sjg:gridColumn
                                name="exchangeRate" index="exchangeRate" key="exchangeRate" title="Exchange Rate" width="200" 
                                sortable="true" align="right" formatter="number" editable="true" edittype="text"
                                editrules="{ double: true }" formatoptions= "{ thousandsSeparator:','}"
                            />
                    </sjg:grid>
                </div>  
                </td>
            </tr>
        </table>
    </div>
    <br class="spacer"/>       
    <div>
        <sj:a href="#" id="btnExchangeRateSave" button="true">Save</sj:a>
    </div>
    
     
                   