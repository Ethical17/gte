$PBExportHeader$w_einvget_dboard.srw
forward
global type w_einvget_dboard from window
end type
type sle_1 from singlelineedit within w_einvget_dboard
end type
type st_1 from statictext within w_einvget_dboard
end type
type cbx_2 from checkbox within w_einvget_dboard
end type
type cb_4 from commandbutton within w_einvget_dboard
end type
type cb_2 from commandbutton within w_einvget_dboard
end type
type dw_1 from datawindow within w_einvget_dboard
end type
end forward

global type w_einvget_dboard from window
integer width = 4859
integer height = 2444
boolean titlebar = true
string title = "E-invoicing Cancellation dashboard"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
sle_1 sle_1
st_1 st_1
cbx_2 cbx_2
cb_4 cb_4
cb_2 cb_2
dw_1 dw_1
end type
global w_einvget_dboard w_einvget_dboard

type variables
long ll_cnt, ll_cnt1,ix,ll_user_level,ll_last,ll_last1, ll_ctr, li_temp
string ls_acsaleno, ls_aucsaleno, ls_ausid,ls_spmanid,ls_spid,ls_spbid,ls_invno,ls_grade, ls_temp, ls_ac_dt,ls_appr_ind,ls_tmp_id, ls_saleno, ls_file
string ls_aus_id, ls_brok, ls_iss_locn, ls_rec_locn, ls_iss_gstn, ls_rec_gstn, ls_hsn, ls_iss_gstin, ls_rec_gstin, ls_aprv_by, ls_yrmn
long ll_stno,ll_endno,ll_nochest,ll_season, ll_rec
boolean lb_neworder, lb_query
double ld_saleval,ld_due,ld_bankchrg, ld_amount, ld_totval, ld_paid, ld_balamt,ld_bnkchrgproportion, ld_chqamt,ld_net,ld_brokerage, ld_cgst_per, ld_sgst_per, ld_igst_per,ld_cgst_amt, ld_sgst_amt, ld_igst_amt, ld_inspchrg,ld_miscchrg
datetime ld_dt, ld_aus_dt,ld_aus_date, ld_prompt_dt, ld_acsaledt, ld_aprv_dt
end variables

forward prototypes
public function integer wf_callapi (string fs_docno)
end prototypes

event ue_option();choose case gs_ueoption
	case "PRINT"
			OpenWithParm(w_print,this.dw_1)
	case "PRINTPREVIEW"
			this.dw_1.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
			this.dw_1.modify("datawindow.print.preview = no")
	case "SAVEAS"
			this.dw_1.saveas()
	case "FILTER"
			setnull(gs_filtertext)
			this.dw_1.setredraw(false)
			this.dw_1.setfilter(gs_filtertext)
			this.dw_1.filter()
			this.dw_1.groupcalc()
			if this.dw_1.rowcount() > 0 then;
				this.dw_1.setredraw(true)
			else
				Messagebox('Warning','Data Not Available In Given Criteria')
			end if
	case "SORT"
			setnull(gs_sorttext)
			this.dw_1.setredraw(false)
			this.dw_1.setsort(gs_sorttext)
			this.dw_1.sort()
			this.dw_1.groupcalc()
			if this.dw_1.rowcount() > 0 then;
				this.dw_1.setredraw(true)
			else
				Messagebox('Warning','Data Not Available In Given Criteria')
			end if
end choose


end event

public function integer wf_callapi (string fs_docno);Integer li_rc, li_StatusCode
String ls_ContentType, ls_body, ls_string, ls_text, ls_json_string, ls_responsestring, ls_rec, ls_place, ls_from_gst
long li_filenum
HttpClient lnv_HttpClient
lnv_HttpClient = Create HttpClient
////// JSON response parsing
String ls_Error, ls_response, ls_qrcode, ls_irn, ls_response_status, ls_errormessage, ls_ackno, ls_ackdt, ls_doctype, ls_docno, ls_docdt
LONG ll_errorrecord, ll_errorrecordDET, ll_rootitem
Blob lblb_blob
JsonPackage lnv_package
JsonParser lnv_JsonParser 
lnv_package = create JsonPackage
lnv_JsonParser = Create JsonParser


select distinct SGSTIN, DOCTYP, DOCNO, to_char(DOCDT, 'dd/mm/yyyy') into :ls_from_gst, :ls_doctype, :ls_docno, :ls_docdt from fb_einvoice where docno = :fs_docno;
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while getting seller gst : '+sqlca.sqlerrtext)
	rollback using sqlca;
	return -1
elseif sqlca.sqlcode = 100 then
	messagebox('Warning','No invoice found for this docno')
	rollback using sqlca;
	return -1	
end if

if left(ls_from_gst,2) = '18' then
	ls_place = 'ASS'
elseif left(ls_from_gst,2) = '19' then
	ls_place = 'WEB'
elseif left(ls_from_gst,2) = '16' then
	ls_place = 'TRI'	
end if


////////////////////////////////////////////////////////////////////////////////////

//ls_json_string = '{	"Version": "1.1","Irn": null,"TranDtls": {"TaxSch": "GST","SupTyp": "B2B","RegRev": "Y","EcmGstin": null,"IgstOnIntra": "N"	},"DocDtls": {"DocTyp":"INV","DocNo": "789873","DocDt": "14/08/2020"},"SellerDtls": {"SGstin": "29AAACD5108M000","SLglNm": "ABC company pvt ltd","STrdNm": "ABC company pvt ltd",		"SAddr1": "Building Flat no Road Street","SAddr2": "Address 2 of the supplier","SLoc": "GANDHINAGAR","SPin": 560002,"SStcd": "29","SPh": "9898989898","SEm": "abc1235@gmail.com"},	"BuyerDtls": {"BGstin": "29CXGPM0212D1ZW","BLglNm": "XYZ company pvt ltd","BTrdNm": "XYZ company pvt ltd","BAddr1": "NO 1061 3RD CROSS NEAR ST MARYS SCHOOL","BAddr2": "KALYAN NAGAR T DASARAHALLI","BLoc": "BANGALORE","BPin": 560019,"BStcd": "29","BPos": "29","BPh": "9898989898","BEm": "abc1235@gmail.com"},	"DispDtls": {"DisTrdNm": "ABC company pvt ltd","DisAddr1": "7th block, kuvempu layout","DisAddr2": "Address 2 of the supplier","DisLoc": "Bangalore","DisPin": 560043,"DisStcd": "29"},	"ShipDtls": {"ShipGstin": "28AAACG0569P1Z3","ShipLglNm": "CBE company pvt ltd","ShipTrdNm": "CBE company pvt ltd","ShipAddr1": "7th block, kuvempu layout","ShipAddr2": "Address 2 of the supplier","ShipLoc": "Bangalore","ShipPin": 560043,"ShipStcd": "28"},	"ItemList": [{"SlNo": "1","PrdDesc": "FORMULA 1 NUTRITIONAL SHAKE MIX-VANILLA","IsServc": "N","HsnCd": "21069099","Barcde": null,"BchDtls": {"BchNm": null,"BchExpDt": null,"BchWrDt": null},"Qty": 3.68,"FreeQty": 0,"Unit": "UNT","UnitPrice": 7.18,"TotAmt": 26.42,"Discount": 10,"PreTaxVal": 16.42,"AssAmt": 16.42,"GstRt": 18,"IgstAmt": 0,"CgstAmt": 1.47,"SgstAmt": 1.47,"CesRt": 0,"CesAmt": 0,"CesNonAdvlAmt": 0,"StateCesRt": 0,"StateCesAmt": 0,"StateCesNonAdvlAmt": 0,"OthChrg": 0,"TotItemVal": 19.36,"OrdLineRef": "NONE","OrgCntry": null,"PrdSlNo": "1247","AttribDtls": [{"AttNm": null,"AttVal": null}]}],	"PayDtls": {"PayNm": null,"PayAcctDet": null,"PayMode": null,"PayFinInsBr": null,"PayTerm": null,"PayInstr": null,"PayCrtrn": null,"PayDirDr": null,"PayCrDay": 0,"PayPaidAmt": 0,"PayPaymtDue": 0},	"RefDtls": {"RefInvRm": "NOT NEEDED","DocPerdDtls": {"InvStDt": "01/02/2020","InvEndDt": "20/02/2020"},"PrecDocDtls": [{"InvNo": "2672","InvDt": "20/02/2020","OthRefNo": "1114534"}],"ContrDtls": [{"RecAdvRefr": "376237","RecAdvDt": "22/02/2020","TendRefr": "333","ContrRefr": "444","ExtRefr": "563","ProjRefr": "222","PORefr": "111","PORefDt": "20/02/2020"}]},	"AddlDocDtls": [{"Url": "www","Docs": "scuh76bhdw","InfoDtls": "No details"}],	"ExpDtls": {"ExpShipBNo": "123456","ExpShipBDt": "01/03/2020","ExpPort": "123","ExpRefClm": "N","ExpForCur": "007","ExpCntCode": "12","ExpDuty": 123},"EwbDtls": {"TransId": "27AAACB0446L1ZS","TransName": "BLUE DART EXPRESS LIMITED","TransMode": "1","Distance": 110,"TransDocNo": "123","TransDocDt": "12/08/2020","VehNo": "KA01AB1234","VehType": "R"	}}'

////////////////////////////////////////////////////////////////////////////////////
//main
lnv_HttpClient.SetRequestHeader("Ocp-Apim-Subscription-Key","7774783a863940438ca4cc2d5c1af765");
lnv_HttpClient.SetRequestHeader("Gstin",ls_from_gst);
lnv_HttpClient.SetRequestHeader("sourcetype","ERP");
lnv_HttpClient.SetRequestHeader("referenceno","WEP002017");
lnv_HttpClient.SetRequestHeader("outputtype","JSON");
lnv_HttpClient.SetRequestHeader("Location",ls_place);
lnv_HttpClient.SetRequestHeader("Content-Type","application/json");
lnv_HttpClient.SetRequestHeader("SignedValue","N");

//sandbox
//lnv_HttpClient.SetRequestHeader("Ocp-Apim-Subscription-Key","d2443b75a2ad49b6880c2a94d3678369");
//lnv_HttpClient.SetRequestHeader("Gstin","29AAACD5108M000");
//lnv_HttpClient.SetRequestHeader("sourcetype","ERP");
//lnv_HttpClient.SetRequestHeader("referenceno","WEP001");
//lnv_HttpClient.SetRequestHeader("outputtype","JSON");
//lnv_HttpClient.SetRequestHeader("Location","BNG");
//lnv_HttpClient.SetRequestHeader("Content-Type","application/json");

li_rc = lnv_HttpClient.SendRequest("GET", "https://api.wepgst.com/asp/rg/Einvoice/v1.03/GetIRN/Doc?DOCTYPE="+ls_doctype+"&DOCNO="+ls_docno+"&DOCDT="+ls_docdt)

//sandbox
//li_rc = lnv_HttpClient.SendRequest("POST", "https://api.wepgst.com/asp/sa/Einvoice/v1.03/CancelIRN", fs_json_string, EncodingUTF8!)

// Obtain the response message
if li_rc = 1 then
 // Obtain the response status
 li_StatusCode = lnv_HttpClient.GetResponseStatusCode()
 	if li_StatusCode = 200 then
		// Obtain the header
		ls_ContentType = lnv_HttpClient.GetResponseHeader("Content-Type") // Obtain the specifid header
	
		// Obtain the response data
		//lnv_HttpClient.GetResponseBody(ls_string, EncodingUTF8!) // Encoding of the response data is known to be EncodingUTF8!.
		lnv_HttpClient.GetResponseBody(ls_responsestring) // No encoding is specified, because encoding of the response data is unknown


//============================================================================================

//	if fileexists("c:\temp\"+"response"+string(today(),"_ddmmyy_")+string(now(),"hhmmss")+".json") = true then
//		filedelete("c:\temp\"+"response"+string(today(),"-ddmmyy_")+string(now(),"hhmmss")+".json")
//	end if
//
//	ls_file = "c:\temp\"+"response"+string(today(),"_ddmmyy_")+string(now(),"hhmmss")+".json"
//	
//	li_filenum =  fileopen(ls_file,linemode!,write!,lockreadwrite!,replace!)
//	
//	ls_rec = ls_responsestring
//	
//	filewriteex(li_filenum,ls_rec)
//	fileclose(li_filenum) 
	
	
//============================================================================================
		ls_error = lnv_package.LoadString(ls_responsestring)		
		
		
		if Len(ls_error) = 0 then
			ls_response = lnv_package.GetValue("OutputResponse")
			//dw_1.ImportJson(ls_response)
		else
			Messagebox("Error while loading API Response", ls_Error)
			return -1
		end if
		
		ls_Error = lnv_package.LoadString(ls_response)
		
		if Len(ls_Error) = 0 then
			ls_response_status = lnv_package.GetValue("Status")
			if ls_response_status = "0" then				
					ls_error = lnv_JsonParser.LoadString(ls_response)
					if Len(ls_Error) = 0 then
						ll_rootitem = lnv_JsonParser.getRootItem()
						ll_errorrecord = lnv_JsonParser.getItemArray(ll_rootitem,"ErrorRecords")
						if ll_errorrecord = -1 then
							ll_errorrecord = lnv_JsonParser.getItemArray(ll_rootitem,"ErrorDetails")
							if ll_errorrecord = -1 then
								Messagebox("Error occured while getting response array", ls_errormessage)
								return -1
							end if
						end if
						ll_errorrecorddet = lnv_JsonParser.GetChildItem(ll_errorrecord, 1)
						if ll_errorrecorddet = -1 then
							Messagebox("Error occured while getting child item of array", ls_errormessage)
							return -1
						end if					
						ls_errormessage = lnv_JsonParser.GetItemString(ll_errorrecorddet,"errormessage")
						Messagebox("Warning : Get Einvoice Failed", ls_errormessage)
						return -1
					else
						Messagebox("Error occured while loading response in parser", ls_Error)
						return -1
					end if
			else
				ls_ackno = lnv_package.GetValue("AckNo")
				ls_ackdt = lnv_package.GetValue("AckDt")			
				ls_qrcode = lnv_package.GetValue("SignedQRCode")
				ls_irn = lnv_package.GetValue("Irn")
			end if
		else
			Messagebox("Error while loading Output Reponse", ls_Error)
			return -1
		end if
		/////////////// QR generation	
		li_rc = lnv_HttpClient.SendRequest("GET", "http://chart.apis.google.com/chart?cht=qr&chs=230x230&chof=gif&&chl="+ls_qrcode+"&choe=UTF-8&")
		
		// Obtain the response message
		if li_rc = 1 then
			// Obtain the response status
			li_StatusCode = lnv_HttpClient.GetResponseStatusCode()
			if li_StatusCode = 200 then
				// Obtain the header
				ls_ContentType = lnv_HttpClient.GetResponseHeader("Content-Type") // Obtain the specifid header
		
				// Obtain the response data
		
				lnv_HttpClient.GetResponseBody(lblb_blob) // Obtain the response data and convert to a blob
				update fb_einvoice set qr_code = :lblb_blob, irn = :ls_irn, ackno = :ls_ackno, ackdt =  to_date(:ls_ackdt,'yyyy-mm-dd hh24:mi:ss') where docno = :fs_docno;
				if sqlca.sqlcode = -1 then
					messagebox('Error','Error occured while updating IRN and QR Code'+sqlca.sqlerrtext)
					rollback using sqlca;
					return -1;
				end if
				commit using sqlca;
				messagebox('Message','Get Einvoice has been successful for Tax-Invoice No. : '+fs_docno)
				dw_1.reset()
				return 1
			end if
		elseif li_rc = -1 then
			messagebox('Error','Error occured while API Posting : General Error')
			return -1
		elseif li_rc = -2 then
			messagebox('Error','Error occured while API Posting : Invalid URL')
			return -1
		elseif li_rc = -3 then
			messagebox('Error','Error occured while API Posting : Cannot connect to the Internet')
			return -1
		elseif li_rc = -4 then
			messagebox('Error','Error occured while API Posting : Timed out')
			return -1
		elseif li_rc = -5 then
			messagebox('Error','Error occured while API Posting : Code conversion failed')
			return -1
		elseif li_rc = -6 then
			messagebox('Error','Error occured while API Posting : Unsupported character sets')
			return -1		
		else 
			messagebox('Error','Error occured while API Posting : Unknown Error')
			return -1
		end if			
		/////////////// QR closing
	else
		messagebox('Error','Unsuccessful Response')
		return -1
	end if
elseif li_rc = -1 then
	messagebox('Error','Error occured while API Posting : General Error')
	return -1
elseif li_rc = -2 then
	messagebox('Error','Error occured while API Posting : Invalid URL')
	return -1
elseif li_rc = -3 then
	messagebox('Error','Error occured while API Posting : Cannot connect to the Internet')
	return -1
elseif li_rc = -4 then
	messagebox('Error','Error occured while API Posting : Timed out')
	return -1
elseif li_rc = -5 then
	messagebox('Error','Error occured while API Posting : Code conversion failed')
	return -1
elseif li_rc = -6 then
	messagebox('Error','Error occured while API Posting : Unsupported character sets')
	return -1
else 
	messagebox('Error','Error occured while API Posting : Unknown Error')
	return -1
end if




//  messagebox('Warning',ls_responsestring)// Obtain the response data and convert to a blob
//  
//	if fileexists("c:\temp\"+"response"+string(today(),"_ddmmyy_")+string(now(),"hhmmss")+".json") = true then
//		filedelete("c:\temp\"+"response"+string(today(),"-ddmmyy_")+string(now(),"hhmmss")+".json")
//	end if
//
//	ls_file = "c:\temp\"+"response"+string(today(),"_ddmmyy_")+string(now(),"hhmmss")+".json"
//	
//	li_filenum =  fileopen(ls_file,linemode!,write!,lockreadwrite!,replace!)
//	
//	ls_rec = ls_responsestring
//	
//	filewrite(li_filenum,ls_rec)
//	fileclose(li_filenum) 
		  

end function

on w_einvget_dboard.create
this.sle_1=create sle_1
this.st_1=create st_1
this.cbx_2=create cbx_2
this.cb_4=create cb_4
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.sle_1,&
this.st_1,&
this.cbx_2,&
this.cb_4,&
this.cb_2,&
this.dw_1}
end on

on w_einvget_dboard.destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.cbx_2)
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false
dw_1.modify("t_co.text = '"+gs_co_name+"'")
//dw_1.modify("t_gnm.text = '"+gs_co_nameadd+"'")

this.tag = Message.StringParm
ll_user_level = long(this.tag)

end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if
IF KeyDown(KeyF2!) THEN
	cb_2.triggerevent(clicked!)
end if

end event

type sle_1 from singlelineedit within w_einvget_dboard
integer x = 453
integer y = 12
integer width = 704
integer height = 92
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_einvget_dboard
integer x = 18
integer y = 28
integer width = 599
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tax Invoice No. : "
boolean focusrectangle = false
end type

type cbx_2 from checkbox within w_einvget_dboard
boolean visible = false
integer x = 3845
integer y = 24
integer width = 352
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select &All"
end type

event clicked;if cbx_2.text = 'Select &All' then
	cbx_2.text = '&Undo'
	for ll_rec=1 to dw_1.rowcount()
		dw_1.setitem(ll_rec,'appr_flag','Y')
		dw_1.setitem(ll_rec,'ati_confirm_by',gs_user)
		dw_1.setitem(ll_rec,'ati_confirm_dt',datetime(today()))
	next
else
	cbx_2.text = 'Select &All'
	for ll_rec=1 to dw_1.rowcount()
		 dw_1.setitem(ll_rec,'appr_flag','N')
		 setnull(ls_aprv_by);setnull(ld_aprv_dt);
		 dw_1.setitem(ll_rec,'ati_confirm_by',ls_aprv_by)
		 dw_1.setitem(ll_rec,'ati_confirm_dt',ld_aprv_dt)		
	next
end if

end event

type cb_4 from commandbutton within w_einvget_dboard
integer x = 1467
integer y = 8
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;if dw_1.modifiedcount() > 0 or dw_1.deletedcount() > 0 then
	IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
		close(parent)
	else
		return
	end if
else
	close(parent)
end if
end event

type cb_2 from commandbutton within w_einvget_dboard
integer x = 1202
integer y = 8
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
end type

event clicked;string ls_docno

if isnull(sle_1.text) or len(sle_1.text) = 0 then
	messagebox('Warning','Kindly enter a valid Tax Invoice Number')
	return 1
end if

ls_docno = sle_1.text

dw_1.Retrieve(ls_docno)

if dw_1.rowcount() = 0 then
	messagebox('Message','No invoices found')
end if
end event

type dw_1 from datawindow within w_einvget_dboard
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer y = 116
integer width = 4197
integer height = 2124
integer taborder = 30
string dataobject = "dw_einvget_dboard"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;string ls_taxinv
if dwo.name = 'einv_ind' and data = 'Y' then
	setpointer(hourglass!)
	ls_taxinv = dw_1.getitemstring(row,'docno')
	if MessageBox("Get E-invoice Alert", 'Do You Want To Get E-invoice Data for this Invoice....?' ,Exclamation!, YesNo!, 1) = 1 then
		if wf_callapi(ls_taxinv) = -1 then
			rollback using sqlca;
			return 1;
		end if
	end if
end if

end event

