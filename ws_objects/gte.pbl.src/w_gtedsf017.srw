$PBExportHeader$w_gtedsf017.srw
forward
global type w_gtedsf017 from window
end type
type cb_3 from commandbutton within w_gtedsf017
end type
type cb_2 from commandbutton within w_gtedsf017
end type
type cb_1 from commandbutton within w_gtedsf017
end type
type dw_1 from datawindow within w_gtedsf017
end type
end forward

global type w_gtedsf017 from window
integer width = 3803
integer height = 2280
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtedsf017 w_gtedsf017

type variables
long ll_ctr,ll_id
string ls_code,ls_type,ls_name
end variables

forward prototypes
public function integer wf_genjson_ptu (string fs_docno, integer fs_rowno)
public function integer wf_callapi_ptu (string fs_json_string, string fs_docno, integer fs_ptuid)
public function integer wf_genjson_depo (string fs_docno, integer fs_rowno)
public function integer wf_callapi_depo (string fs_json_string, string fs_docno, integer fs_depo)
end prototypes

public function integer wf_genjson_ptu (string fs_docno, integer fs_rowno);string ls_invoiceno, ls_invdate
long ll_source, ll_supplier,ll_ptu_cd
string ls_garden, ls_packinvoice, ls_grade
long ll_season,ll_bagfrom, ll_bagnoto, ll_packages
string ls_head,ls_details,ls_itemlist,ls_file
double  ld_netwt

string ls_json_string, ls_rec,ls_string
long li_filenum,ls_len,ls_check


select distinct nvl(SI_TAXINVNO, SI_DELVCHNO), SI_DATE
into :ls_invoiceno,:ls_invdate
from fb_saleinvoice
where nvl(SI_TAXINVNO, SI_DELVCHNO)=:fs_docno ;

 if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while selecting header data : '+sqlca.sqlerrtext)
	rollback using sqlca;
	return -1;
elseif sqlca.sqlcode = 100 then
	messagebox('Warning','No invoice s found')
	rollback using sqlca;
	return -1;
end if

if isnull(ls_invoiceno) then 
	ls_invoiceno = 'null';
else
	ls_invoiceno = '"'+ls_invoiceno+'"'
end if

if isnull(ls_invdate) then 
	ls_invdate = 'null';
else
	ls_invdate = '"'+ls_invdate+'"'
end if

if(gs_garden_snm='MV') then 
	ll_source= 16;
	ll_supplier= 1099;
else
	ll_supplier= 1072;
 	ll_source= 9;
end if

 ll_ptu_cd= dw_1.getitemnumber(fs_rowno,'id');
 
 declare c2 cursor for
 select SID_SEASON,to_char(unit_id),to_char(DTP_LOTNO),to_char(TMP_ID),SID_SRNOSTART, SID_SRNOEND,SID_SRNOEND-SID_SRNOSTART+1 , ((nvl(DTPD_INDWT,0)) * ((nvl(SID_SRNOEND,0) - nvl(SID_SRNOSTART,0)) +1)) netwt
	from fb_saleinvoice a, fb_sidetails b ,(select unit_id from fb_gardenmaster where UNIT_ACTIVE_IND='Y') c,fb_dtpdetails d ,fb_dailyteapacked e
	where a.SI_ID=b.SI_ID and nvl(SI_TAXINVNO, SI_DELVCHNO)=:fs_docno and b.DTPD_ID=d.DTPD_ID and d.DTP_ID=e.DTP_ID ;
 open c2;
 if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while opening cursor c2 : '+sqlca.sqlerrtext)
	rollback using sqlca;
	return -1
elseif sqlca.sqlcode = 0 then
	setnull(ll_season); setnull(ls_garden); setnull(ls_packinvoice); setnull(ls_grade); setnull(ll_bagfrom); setnull(ll_bagnoto); setnull(ll_packages); setnull(ld_netwt);
	ls_details = ""
	ls_itemlist = '['
	fetch c2 into :ll_season, :ls_garden, :ls_packinvoice, :ls_grade, :ll_bagfrom, :ll_bagnoto, :ll_packages, :ld_netwt;
	do while sqlca.sqlcode <> 100
		
		
		if isnull(ll_season) then ll_season = 0;
		
		
		if isnull(ls_garden) then 
			ls_garden = 'null';
		else
			ls_garden = '"'+ls_garden+'"'
		end if
		
		if isnull(ls_packinvoice) then 
			ls_packinvoice = 'null';
		else
			ls_packinvoice = '"'+ls_packinvoice+'"'
		end if
		
		if isnull(ls_grade) then 
			ls_grade = 'null';
		else
			ls_grade = '"'+ls_grade+'"'
		end if
		
		if isnull(ll_bagfrom) then ll_bagfrom = 0;
		
		if isnull(ll_bagnoto) then ll_bagnoto = 0;
		
		if isnull(ll_packages) then ll_packages = 0;
		
		if isnull(ld_netwt) then ld_netwt = 0;

		
		ls_details = ls_details + '{"SEASON":'+string(ll_season)+',"Garden": '+ls_garden+',"Invoice": '+ls_packinvoice+',"Grade":'+ls_grade+',"BagNoFrom":'+string(ll_bagfrom)+',"BagNoTo":'+string(ll_bagnoto)+',"Packages":'+string(ll_packages)+',"NetWeight":'+string(ld_netwt)+',"type":"G"},'
		
		setnull(ll_season); setnull(ls_garden); setnull(ls_packinvoice); setnull(ls_grade); setnull(ll_bagfrom); setnull(ll_bagnoto); setnull(ll_packages); setnull(ld_netwt); 
		fetch c2 into :ll_season, :ls_garden, :ls_packinvoice, :ls_grade, :ll_bagfrom, :ll_bagnoto, :ll_packages, :ld_netwt;
	loop
	close c2;
	
	
	ls_itemlist =left(ls_details,(len(ls_details)-2)) +'}' ;	
end if

ls_head = '[{"source": '+string(ll_source)+',"supplier": '+string(ll_supplier)+',"invoiceno": '+ls_invoiceno+',"InvoiceDate":'+ls_invdate+',"ptu_cd":'+string(ll_ptu_cd)+'}]'


ls_json_string = '{	"header": '+ls_head+',"details":[ '+ls_itemlist+']}';

if fileexists("c:\temp\PTU"+string(today(),"_ddmmyy_")+string(now(),"hhmmss")+".json") = true then
	filedelete("c:\temp\PTU"+string(today(),"-ddmmyy_")+string(now(),"hhmmss")+".json")
end if

ls_file = "c:\temp\PTU"+string(today(),"_ddmmyy_")+string(now(),"hhmmss")+".json"

li_filenum =  fileopen(ls_file,linemode!,write!,lockreadwrite!,replace!)

ls_rec = ls_json_string


filewrite(li_filenum,ls_rec)
fileclose(li_filenum) 

if isnull(ls_json_string) then
	messagebox('Warning','JSON string is null')
	rollback using sqlca;
	return -1
end if

if (dw_1.getitemstring(fs_rowno,'type')='P') then
	if wf_callapi_ptu(ls_json_string,fs_docno,ll_ptu_cd) = -1 then
		rollback using sqlca;
		return -1;
	end if
end if


end function

public function integer wf_callapi_ptu (string fs_json_string, string fs_docno, integer fs_ptuid);Integer li_rc, li_StatusCode
String ls_ContentType, ls_body, ls_string, ls_text, ls_json_string, ls_responsestring, ls_file, ls_rec
long li_filenum
Blob lblb_blob
HttpClient lnv_HttpClient
lnv_HttpClient = Create HttpClient
string ls_json,ls_temp_json
long ll_return, ll_batch, i, ll_from, ll_to, ll_rank

lnv_HttpClient.SetRequestHeader("Content-Type", "application/json;charset=UTF-8")
li_rc = lnv_HttpClient.SendRequest("POST", "https://luxmitea.com/PTUAPI/api/BulkTeaInsert",fs_json_string,EncodingUTF8!)//Global Live
//li_rc = lnv_HttpClient.SendRequest("POST", "http://125.16.91.172/PTUAPI/api/BulkTeaInsert",fs_json_string,EncodingUTF8!)//Global
//li_rc = lnv_HttpClient.SendRequest("POST", "http://localhost/PTUAPI/api/BulkTeaInsert",fs_json_string,EncodingUTF8!)//LOcal

if li_rc = 1 then
	 // Obtain the response status
		 li_StatusCode = lnv_HttpClient.GetResponseStatusCode()
		 if li_StatusCode = 200 then
			// Obtain the header
			//ls_ContentType = lnv_HttpClient.GetResponseHeader("Content-Type") // Obtain the specifid header
			lnv_HttpClient.GetResponseBody(ls_responsestring)
			if ls_responsestring="1" then
			
			update fb_saleinvoice set TYPE='P', ID=:fs_ptuid, SEND_DT=sysdate where nvl(SI_TAXINVNO, SI_DELVCHNO)=:fs_docno ;
					if sqlca.sqlcode = -1 then
						messagebox('Error','Error occured while updating PTU Send Indicator'+sqlca.sqlerrtext)
						rollback using sqlca;
						return -1;
					end if
					commit using sqlca;
			elseif ls_responsestring="2" then
				messagebox('Error','Error occured while Inserting Data In PTU Contact IT Department'+sqlca.sqlerrtext)
				return -1;
			elseif ls_responsestring="3" then
				messagebox('Error','Garden Not Mapped'+sqlca.sqlerrtext)
				return -1;
			elseif ls_responsestring="4" then
				messagebox('Error','Grade Not Mapped'+sqlca.sqlerrtext)
				return -1;
			else
				messagebox('Error','Unkown Error Ocured '+sqlca.sqlerrtext)
				return -1;
			end if
			
			//messagebox('Message',ls_responsestring)
			ll_from = ll_from + ll_batch
			ll_to = ll_to + ll_batch
		else
			lnv_HttpClient.GetResponseBody(ls_responsestring)
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
	

		messagebox('Confirmation','Data Posted Sucessfully  !!!!!')

SetPointer(Arrow!)
end function

public function integer wf_genjson_depo (string fs_docno, integer fs_rowno);string ls_invoiceno, ls_invdate
long ll_source, ll_supplier,ll_ptu_cd
string ls_garden, ls_packinvoice, ls_grade
long ll_seasons,ll_bagfrom, ll_bagnoto, ll_packages,ll_depo_cd
string ls_head,ls_details,ls_itemlist,ls_file
double  ld_netwt

string ls_json_string, ls_rec,ls_string
long li_filenum,ls_len,ls_check


declare c1 cursor for

select to_char(unit_id),to_char(TMP_ID),SID_SEASON,to_char(DTP_LOTNO),SID_SRNOEND-SID_SRNOSTART+1 , ((nvl(DTPD_INDWT,0)) * ((nvl(SID_SRNOEND,0) - nvl(SID_SRNOSTART,0)) +1)) netwt,
nvl(SI_TAXINVNO, SI_DELVCHNO), SI_DATE
from fb_saleinvoice a, fb_sidetails b ,(select unit_id from fb_gardenmaster where UNIT_ACTIVE_IND='Y') c,fb_dtpdetails d ,fb_dailyteapacked e
where a.SI_ID=b.SI_ID and nvl(SI_TAXINVNO, SI_DELVCHNO)=:fs_docno and b.DTPD_ID=d.DTPD_ID and d.DTP_ID=e.DTP_ID ;

Open c1;
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while opening cursor c2 : '+sqlca.sqlerrtext)
	rollback using sqlca;
	return -1
elseif sqlca.sqlcode = 0 then
	setnull(ls_garden);setnull(ls_grade);setnull(ll_seasons);setnull(ls_packinvoice); setnull(ll_packages); setnull(ld_netwt);setnull(ls_invoiceno);setnull(ls_invdate);
	ls_details = ""
	ls_itemlist = '['
	fetch c1 into  :ls_garden,:ls_grade, :ll_seasons, :ls_packinvoice, :ll_packages, :ld_netwt, :ls_invoiceno, :ls_invdate;
	
	do while sqlca.sqlcode <> 100

		if isnull(ll_seasons) then ll_seasons = 0;
	
		if isnull(ls_garden) then 
			ls_garden = 'null';
		else
			ls_garden = '"'+ls_garden+'"'
		end if
		
		if isnull(ls_packinvoice) then 
			ls_packinvoice = 'null';
		else
			ls_packinvoice = '"'+ls_packinvoice+'"'
		end if
		
		if isnull(ls_grade) then 
			ls_grade = 'null';
		else
			ls_grade = '"'+ls_grade+'"'
		end if
		
		if isnull(ll_packages) then ll_packages = 0;
		
		if isnull(ld_netwt) then ld_netwt = 0;
		
		if isnull(ls_invoiceno) then 
			ls_invoiceno = 'null';
		else
			ls_invoiceno = '"'+ls_invoiceno+'"'
		end if

		if isnull(ls_invdate) then 
			ls_invdate = 'null';
		else
			ls_invdate = '"'+ls_invdate+'"'
		end if
		
		ll_depo_cd= dw_1.getitemnumber(fs_rowno,'id');
		
		ls_details = ls_details + '{"SEASON":'+string(ll_seasons)+',"Garden": '+ls_garden+',"Invoice": '+ls_packinvoice+',"Grade":'+ls_grade+',"Packages":'+string(ll_packages)+',"NetWeight":'+string(ld_netwt)+',"Invno":'+string(ls_invoiceno)+',"InvDate":'+ls_invdate+',"DepoCd":'+string(ll_depo_cd)+'},'
		
		setnull(ls_garden);setnull(ls_grade);setnull(ll_seasons);setnull(ls_packinvoice); setnull(ll_packages); setnull(ld_netwt);setnull(ls_invoiceno);setnull(ls_invdate);
		fetch c1 into  :ls_garden,:ls_grade, :ll_seasons, :ls_packinvoice, :ll_packages, :ld_netwt, :ls_invoiceno, :ls_invdate;

		
		loop
		close c1;

	ls_itemlist =left(ls_details,(len(ls_details)-2)) +'}' 
end if


ls_json_string = '{	"details":[ '+ls_itemlist+']}';

//--------------------------------------------------------------------------
if fileexists("c:\temp\PTU"+string(today(),"_ddmmyy_")+string(now(),"hhmmss")+".json") = true then
	filedelete("c:\temp\PTU"+string(today(),"-ddmmyy_")+string(now(),"hhmmss")+".json")
end if

ls_file = "c:\temp\PTU"+string(today(),"_ddmmyy_")+string(now(),"hhmmss")+".json"


li_filenum =  fileopen(ls_file,linemode!,write!,lockreadwrite!,replace!)

ls_rec = ls_json_string


filewrite(li_filenum,ls_rec)
fileclose(li_filenum) 
//
//--------------------------------------------------------------------------
if isnull(ls_json_string) then
	messagebox('Warning','JSON string is null')
	rollback using sqlca;
	return -1

end if

if (dw_1.getitemstring(fs_rowno,'type')='D') then
	if wf_callapi_depo(ls_json_string,fs_docno,ll_ptu_cd) = -1 then
		rollback using sqlca;
		return -1;
	end if
end if

end function

public function integer wf_callapi_depo (string fs_json_string, string fs_docno, integer fs_depo);Integer li_rc, li_StatusCode
String ls_ContentType, ls_body, ls_string, ls_text, ls_json_string, ls_responsestring, ls_file, ls_rec
long li_filenum
Blob lblb_blob
HttpClient lnv_HttpClient
lnv_HttpClient = Create HttpClient
string ls_json,ls_temp_json
long ll_return, ll_batch, i, ll_from, ll_to, ll_rank

lnv_HttpClient.SetRequestHeader("Content-Type", "application/json;charset=UTF-8")
li_rc = lnv_HttpClient.SendRequest("POST", "https://luxmitea.com/PTUAPI/api/BulkTeaInsertDepo",fs_json_string,EncodingUTF8!)//LOcal
//li_rc = lnv_HttpClient.SendRequest("POST", "http://125.16.91.172/PTUAPI/api/BulkTeaInsert",fs_json_string,EncodingUTF8!)//Global
//li_rc = lnv_HttpClient.SendRequest("POST", "http://localhost/PTUAPI/api/BulkTeaInsertDepo",fs_json_string,EncodingUTF8!)//LOcal
//li_rc = lnv_HttpClient.SendRequest("GET", "http://localhost/PTUAPI/api/SALESDATA",gs_user,EncodingUTF8!)//LOcal

if li_rc = 1 then
	 // Obtain the response status
		 li_StatusCode = lnv_HttpClient.GetResponseStatusCode()
		 if li_StatusCode = 200 then
			// Obtain the header
			//ls_ContentType = lnv_HttpClient.GetResponseHeader("Content-Type") // Obtain the specifid header
			lnv_HttpClient.GetResponseBody(ls_responsestring)
			if ls_responsestring="1" then
			
			update fb_saleinvoice set TYPE='P', ID=:fs_depo, SEND_DT=sysdate where nvl(SI_TAXINVNO, SI_DELVCHNO)=:fs_docno ;
					if sqlca.sqlcode = -1 then
						messagebox('Error','Error occured while updating PTU Send Indicator'+sqlca.sqlerrtext)
						rollback using sqlca;
						return -1;
					end if
					commit using sqlca;
			elseif ls_responsestring="2" then
				messagebox('Error','Error occured while Inserting Data In PTU Contact IT Department'+sqlca.sqlerrtext)
				return -1;
			elseif ls_responsestring="3" then
				messagebox('Error','Garden Not Mapped'+sqlca.sqlerrtext)
				return -1;
			elseif ls_responsestring="4" then
				messagebox('Error','Grade Not Mapped'+sqlca.sqlerrtext)
				return -1;
			else
				messagebox('Error','Unkown Error Ocured '+sqlca.sqlerrtext)
				return -1;
			end if
			
			//messagebox('Message',ls_responsestring)
			ll_from = ll_from + ll_batch
			ll_to = ll_to + ll_batch
		else
			lnv_HttpClient.GetResponseBody(ls_responsestring)
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
	

		messagebox('Confirmation','Data Posted Sucessfully  !!!!!')

SetPointer(Arrow!)
end function

on w_gtedsf017.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtedsf017.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_3 from commandbutton within w_gtedsf017
integer x = 498
integer y = 28
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Send"
end type

event clicked;setpointer(hourglass!)

string ls_invoiceno

if dw_1.rowcount() > 0 then
	if MessageBox("Send To PTU", 'Do You Want To Send This Document To PTU ....?' ,Exclamation!, YesNo!, 1) = 1 then
		for ll_ctr = dw_1.rowcount() to 1 step -1
			ls_invoiceno=dw_1.getitemstring(ll_ctr,'invoiceno')
				if(len(string(dw_1.getitemnumber(ll_ctr,'id'))) > 0 and dw_1.getitemstring(ll_ctr,'type')='P') then			
					if wf_genjson_ptu(ls_invoiceno,ll_ctr) = -1 then
						rollback using sqlca;
						return 1;
					end if
				elseif(len(string(dw_1.getitemnumber(ll_ctr,'id'))) > 0 and dw_1.getitemstring(ll_ctr,'type')='D') then
					if wf_genjson_depo(ls_invoiceno,ll_ctr) = -1 then
						rollback using sqlca;
						return 1;
					end if
				end if
		next
	end if	
else 
	messagebox('Alert!','No data found !!!')
	return 1
end if
end event

type cb_2 from commandbutton within w_gtedsf017
integer x = 896
integer y = 28
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_gtedsf017
integer x = 101
integer y = 28
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Run"
end type

event clicked;dw_1.settransobject(sqlca)

setpointer(hourglass!)

dw_1.retrieve(gs_garden_snm)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found For the Entered Date !!!')
	return 1
end if

setpointer(arrow!)
end event

type dw_1 from datawindow within w_gtedsf017
integer x = 37
integer y = 156
integer width = 3410
integer height = 2000
integer taborder = 10
string title = "none"
string dataobject = "dw_gtedsf017"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;if dwo.name="id" then
	ls_code = (data)
	
	select type,name into :ls_type,:ls_name from fb_ptu_loc where id=:ls_code;
	if sqlca.sqlcode = -1 then
			messagebox('Error: During Getting PTU Location ',sqlca.sqlerrtext)
			rollback using sqlca;
			return -1
	elseif sqlca.sqlcode = 0 then
			dw_1.setitem(row,'type',ls_type)		
	end if	
	
end if
end event

