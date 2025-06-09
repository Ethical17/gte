$PBExportHeader$w_gtepuf005.srw
forward
global type w_gtepuf005 from window
end type
type cb_11 from commandbutton within w_gtepuf005
end type
type dw_3 from datawindow within w_gtepuf005
end type
type cb_10 from commandbutton within w_gtepuf005
end type
type cb_9 from commandbutton within w_gtepuf005
end type
type cb_8 from commandbutton within w_gtepuf005
end type
type cb_7 from commandbutton within w_gtepuf005
end type
type cb_5 from commandbutton within w_gtepuf005
end type
type cb_6 from commandbutton within w_gtepuf005
end type
type cbx_1 from checkbox within w_gtepuf005
end type
type em_1 from editmask within w_gtepuf005
end type
type st_1 from statictext within w_gtepuf005
end type
type dw_2 from datawindow within w_gtepuf005
end type
type cb_4 from commandbutton within w_gtepuf005
end type
type cb_3 from commandbutton within w_gtepuf005
end type
type cb_2 from commandbutton within w_gtepuf005
end type
type cb_1 from commandbutton within w_gtepuf005
end type
type dw_1 from datawindow within w_gtepuf005
end type
end forward

global type w_gtepuf005 from window
integer width = 4942
integer height = 2492
boolean titlebar = true
string title = "(W_gtepuf005) Purchase Invoice H.O."
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_11 cb_11
dw_3 dw_3
cb_10 cb_10
cb_9 cb_9
cb_8 cb_8
cb_7 cb_7
cb_5 cb_5
cb_6 cb_6
cbx_1 cbx_1
em_1 em_1
st_1 st_1
dw_2 dw_2
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtepuf005 w_gtepuf005

type variables
long ll_ctr,ll_cnt,ll_last,ll_user_level
integer li_flag
string ls_temp,ls_tmp_id,ls_appr_ind,ls_indent_id,ls_sup_id,ls_ac_dt, ls_sp_id,ls_spname,ls_iss_locn,ls_rec_locn,ls_hsn_cd,ls_iss_gstnno, ls_sup_invno, ls_cnno
boolean lb_neworder, lb_query
double ld_tot_val,ld_insurance,ld_freight,ld_other,ld_net_amt,ld_saletax,ld_discount,ld_unit_price,ld_qnty,ld_efunit_price,ld_amount, ld_cgst_per, ld_sgst_per, ld_igst_per,ld_cess_rate,ld_cess_amt, ld_toll_per
datawindowchild idw_prod
datetime ld_date, ld_hopi_dt,ld_stock_dt, ld_indent_dt
string ls_sql,ls_path,ls_destination, ls_file, ls_file2
string ls_sender,ls_mail,ls_recipient,ls_cc,ls_bcc,ls_subject,ls_ack_ind,ls_message,ls_addattachment, ls_addattachment2, ls_body_text, ls_signature//ls_dt,
boolean lb_flag
string ls_msg,ls_text
double ld_balqty

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_con_id)
public function integer wf_upd_indent_recvqnty (string fs_indent_id, string fs_sp_id, double fd_po_quantity, string fs_rec_old)
public function integer wf_cal_netamt (string fs_field, double fd_val)
public function integer wf_mail (string fs_hopi_id)
end prototypes

event ue_option();choose case gs_ueoption
	case "PRINT"
			OpenWithParm(w_print,this.dw_1)
	case "PRINTPREVIEW"
			this.dw_1.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
			this.dw_1.modify("datawindow.print.preview = no")
	case "ZOOM"
			SetPointer (HourGlass!)											
			OpenwithParm (w_zoom,dw_1)
			SetPointer (Arrow!)						
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

public function integer wf_check_fillcol (integer fl_row);//if dw_1.rowcount() > 0 and fl_row > 0 then
//	if (isnull(dw_1.getitemstring(fl_row,'machine_id')) or  len(dw_1.getitemstring(fl_row,'machine_id'))=0 or &
//		 isnull(dw_1.getitemdatetime(fl_row,'peg_date'))) then
//	    messagebox('Warning: One Of The Following Fields Are Blank','Machine ID, Run Date, Please Check !!!')
//		 return -1
//	end if
//end if
if dw_2.rowcount() > 0 and fl_row > 0 then
	if (isnull(dw_2.getitemstring(fl_row,'sp_id')) or  len(dw_2.getitemstring(fl_row,'sp_id'))=0 or &
	    isnull(dw_2.getitemstring(fl_row,'hopi_hsn_no')) or  len(dw_2.getitemstring(fl_row,'hopi_hsn_no'))=0 or &
	    isnull(dw_2.getitemnumber(fl_row,'hopi_quantity')) or dw_2.getitemnumber(fl_row,'hopi_quantity') = 0 or &
		  isnull(dw_2.getitemnumber(fl_row,'hopi_unitprice')) or dw_2.getitemnumber(fl_row,'hopi_unitprice') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Product, HSN No, Quantity,Unit Price Please Check !!!')
	    return -1
	end if
end if
return 1

end function

public function integer wf_check_duplicate_rec (string fs_con_id);long fl_row
string ls_con_id1
datetime ld_run_dt1

dw_2.SelectRow(0, FALSE)
if dw_2.rowcount() > 1 then
	for fl_row = 1 to (dw_2.rowcount() - 1)
		ls_con_id1 = dw_2.getitemstring(fl_row,'sp_id')
		
		if ls_con_id1 = fs_con_id  then
			dw_2.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_upd_indent_recvqnty (string fs_indent_id, string fs_sp_id, double fd_po_quantity, string fs_rec_old);double ld_temp_recqty, ld_temp_indqty

	select distinct SP_TOLLER_PER into :ld_toll_per from fb_storeproduct where sp_id = :fs_sp_id;
	if sqlca.sqlcode = -1 then
		messagebox('Sql Error During getting Tollerance detail : ',sqlca.sqlerrtext);
		return -1;
	end if
	
	if isnull(ld_toll_per) then ld_toll_per = 0;
	
	select distinct 'x' into :ls_temp from fb_indentdetails b
  	 where INDENT_ID= :fs_indent_id and SP_ID = :fs_sp_id  and
		      exists (select distinct INDENT_ID from fb_indent a where a.INDENT_ID=INDENT_ID and a.INDENT_HOLOCALFLAG='1' ); 
 
	if sqlca.sqlcode = -1 then
		messagebox('Sql Error During geting stock detail : ',sqlca.sqlerrtext);
		return -1;
	elseif sqlca.sqlcode = 100 then
		messagebox('Missing Indent/Item','The Indent Detail Not found in Indent Master, Please checck..!');
		return -1;
	end if
	
		if fs_rec_old = 'N' then	
			select nvl(INDDET_RECEIVEDQUANTITY,0), nvl(INDDET_QUANTITY,0) into :ld_temp_recqty, :ld_temp_indqty from fb_indentdetails 
			where INDENT_ID= :fs_indent_id and SP_ID = :fs_sp_id and 
			exists (select distinct INDENT_ID from fb_indent  a where a.INDENT_ID=INDENT_ID and a.INDENT_HOLOCALFLAG='1' );
			
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error During geting recieved quantity : ',sqlca.sqlerrtext);
				return -1;
			elseif sqlca.sqlcode  = 100 then
				messagebox('Missing Indent/Item','No such item found, Please check..!');
				return -1;
			elseif sqlca.sqlcode = 0 then
				
				if (ld_temp_recqty + fd_po_quantity)  > ld_temp_indqty + (ld_temp_indqty * ld_toll_per/100) then
					messagebox('Warning','Recieved quantity can not be greater than Indent Quantity '+ string(ld_toll_per)+'Tolerance %')
					return -1
				end if
			
				update fb_indentdetails b set INDDET_RECEIVEDQUANTITY = nvl(INDDET_RECEIVEDQUANTITY,0) + nvl(:fd_po_quantity,0)
				where INDENT_ID= :fs_indent_id and SP_ID = :fs_sp_id and
				exists (select distinct INDENT_ID from fb_indent  a where a.INDENT_ID=INDENT_ID and a.INDENT_HOLOCALFLAG='1' );
			end if			
			 
		else 
			update fb_indentdetails b set INDDET_RECEIVEDQUANTITY = nvl(INDDET_RECEIVEDQUANTITY,0) - nvl(:fd_po_quantity,0) 
			 where INDENT_ID= :fs_indent_id and SP_ID = :fs_sp_id and
			            exists (select distinct INDENT_ID from fb_indent a where a.INDENT_ID=INDENT_ID and a.INDENT_HOLOCALFLAG='1' );
			
		end if;
		
		if sqlca.sqlcode = -1 then
			messagebox('Sql Error During Received Quantity Update : ',sqlca.sqlerrtext);
			return -1;
		end if;	

  return 1;
end function

public function integer wf_cal_netamt (string fs_field, double fd_val);
	ld_tot_val =dw_2.getitemnumber(1,'tot_val')

	if fs_field = 'hopi_freight' then
	    	ld_freight = fd_val
	else
	    	ld_freight =dw_1.getitemnumber(dw_1.getrow(),'hopi_freight')
	end if
	if fs_field = 'hopi_insurance' then
		ld_insurance = fd_val
	else
		ld_insurance =dw_1.getitemnumber(dw_1.getrow(),'hopi_insurance')
	end if
	if fs_field = 'hopi_otheramo' then
		ld_other  = fd_val
	else
		ld_other =dw_1.getitemnumber(dw_1.getrow(),'hopi_otheramo') 
	end if
	
	if isnull(ld_tot_val) then ld_tot_val = 0;
	if isnull(ld_freight) then ld_freight = 0;
	if isnull(ld_insurance) then ld_insurance = 0;
	if isnull(ld_other) then ld_other = 0;
	
	
     ld_net_amt= ld_tot_val + ld_freight + ld_other + ld_insurance
	if isnull(ld_net_amt) then ld_net_amt = 0;
     dw_1.setitem(dw_1.getrow(),'HOPI_NETAMO',ld_net_amt)
	dw_1.setitem(dw_1.getrow(),'HOPI_AMOCHARGED',ld_net_amt)
	dw_1.setitem(dw_1.getrow(),'HOPI_AMODUE',ld_net_amt)	
	
return 1
end function

public function integer wf_mail (string fs_hopi_id);integer li_filenum, li_rec, li_ctr 
integer li_temp, li_temp2
string ls_hopi_dt
li_ctr=0;
setpointer(hourglass!) 


If not DirectoryExists ("c:\temp") Then
	CreateDirectory ("c:\temp")
End If

dw_3.settransobject(sqlca)
dw_3.retrieve(fs_hopi_id)

select to_char(hopi_date,'dd/mm/yyyy') into :ls_hopi_dt from fb_hopurchaseinvoice where hopi_id = :fs_hopi_id;
 if sqlca.sqlcode = -1 then
	messagebox('Error: During Invoice date select',sqlca.sqlerrtext)
	rollback using sqlca;
	return -1
elseif sqlca.sqlcode = 100 then
	messagebox('Warning','No invoice found')
	rollback using sqlca;
	return -1
end if

if fileexists("c:\temp\"+gs_garden_snm+"_"+fs_hopi_id+".xlsx") = true then
	filedelete("c:\temp\"+gs_garden_snm+"_"+fs_hopi_id+".xlsx")
end if

if fileexists("c:\temp\"+gs_garden_snm+"_"+fs_hopi_id+".pdf") = true then
	filedelete("c:\temp\"+gs_garden_snm+"_"+fs_hopi_id+".pdf")
end if

ls_file = "c:\temp\"+gs_garden_snm+"_"+fs_hopi_id+".xlsx"
li_temp = dw_3.saveas(ls_file,XLSX!,true)

ls_file2 = "c:\temp\"+gs_garden_snm+"_"+fs_hopi_id+".pdf"
li_temp2 = dw_3.saveas(ls_file2,pdf!,true)


select MD_SEND_BY, MD_TO, MD_CC, MD_BCC, MD_SUBJECT, MD_DETAIL, MD_SIGNATURE into :ls_sender, :ls_recipient, :ls_cc, :ls_bcc, :ls_subject, :ls_body_text, :ls_signature from FB_MAIL_MESSAGE_DETAIL where nvl(MD_EMAIL_IND,'N') = 'Y' and MD_MESS_ID = 2 ;
if sqlca.sqlcode = -1 then
	messagebox('Error','Error occured while fetching mail parameters - '+sqlca.sqlerrtext)
	return 1
elseif sqlca.sqlcode = 100 then
	messagebox('Warning','No parameters found for mail')
	return 1
end if

if isnull(ls_sender)	then
	messagebox('Warning','Sender Email is blank')
	return 1
end if

if isnull(ls_recipient)	then
	messagebox('Warning','Sender Email is blank')
	return 1
end if

if isnull(ls_cc) then ls_cc = ""

if isnull(ls_bcc) then ls_bcc = ""

if isnull(ls_subject) then ls_subject = ""

if isnull(ls_body_text) then ls_body_text = ""

if isnull(ls_signature) then ls_signature = ""

//ls_sender  =  'erpsupport@luxmitea.com'


//ls_recipient = 'purchase@luxmigroup.in; aniruddha@luxmigroup.in; dipsarkar@luxmigroup.in;'
//ls_cc='sghosh@luxmigroup.in; prabhat.kumar@obeetee.com; khalid.mateen@obeetee.com; '
ls_cc += gs_garden_mail

//ls_recipient = 'khalid.mateen@obeetee.com;'
//ls_cc = 'sghosh@luxmigroup.in; prabhat.kumar@obeetee.com;'


ls_addattachment = ls_file

ls_addattachment2 = ls_file2

ls_subject 	 = ls_subject + ls_hopi_dt+" "+ gs_garden_nm

ls_message	= "Dear Sir/Madam, "+gs_lfcr+gs_lfcr+ls_body_text+gs_lfcr+gs_lfcr
ls_message	 = ls_message +gs_lfcr+"Your kind attention is required."+gs_lfcr

ls_message	 = ls_message +gs_lfcr+"Administrator"+gs_lfcr

ls_message	 = ls_message +gs_lfcr+gs_lfcr+gs_garden_nm+gs_lfcr+gs_garden_add+gs_lfcr+gs_lfcr

ls_message += ls_signature

n_web_mail lnvo_mail
	
lnvo_mail = Create n_web_mail

lb_flag = lnvo_mail.of_send_webmail(ls_sender,ls_recipient,ls_cc,ls_subject,ls_message,ls_bcc,ls_addattachment2,ls_addattachment) 
//lnvo_mail.of_send_webmail_chilkat(ls_sender,ls_recipient,ls_cc,ls_subject,ls_message,ls_bcc,ls_addattachment) 

if lb_flag = True then
	update fb_hopurchaseinvoice set hopi_mail_ind = 'Y' where hopi_id = :fs_hopi_id;
	
	 if sqlca.sqlcode = -1 then
		messagebox('Error: During Update Send Date',sqlca.sqlerrtext)
		rollback using sqlca;
		return -1
	end if
	
	update FB_MAIL_MESSAGE_DETAIL set MD_SENT_DATE = sysdate  where nvl(MD_EMAIL_IND,'N') = 'Y' and MD_MESS_ID = 2 ;
	 if sqlca.sqlcode = -1 then
		messagebox('Error: During Update Send Date',sqlca.sqlerrtext)
		rollback using sqlca;
		return -1
	end if
	
	commit;
else
	rollback;
end if
setpointer(arrow!) 

return 1


end function

on w_gtepuf005.create
this.cb_11=create cb_11
this.dw_3=create dw_3
this.cb_10=create cb_10
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cbx_1=create cbx_1
this.em_1=create em_1
this.st_1=create st_1
this.dw_2=create dw_2
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_11,&
this.dw_3,&
this.cb_10,&
this.cb_9,&
this.cb_8,&
this.cb_7,&
this.cb_5,&
this.cb_6,&
this.cbx_1,&
this.em_1,&
this.st_1,&
this.dw_2,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtepuf005.destroy
destroy(this.cb_11)
destroy(this.dw_3)
destroy(this.cb_10)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cbx_1)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;//dw_1.modify("t_co.text = '"+gs_CO_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if


dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
lb_query = false	
lb_neworder = false

dw_2.GetChild ("sp_id", idw_prod)
idw_prod.settransobject(sqlca)	

this.tag = Message.StringParm
ll_user_level = long(this.tag)

if ll_user_level =1 then
	em_1.visible = true
     cbx_1.visible = true
	cb_6.visible = true
	st_1.visible = true	  
else
	em_1.visible = false
     cbx_1.visible = false
	cb_6.visible = false
	st_1.visible = false	  	
end if	


end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if
IF KeyDown(KeyF1!) THEN
	cb_1.triggerevent(clicked!)
end if
IF KeyDown(KeyF2!) THEN
	cb_2.triggerevent(clicked!)
end if
IF KeyDown(KeyF3!) THEN
	if dw_1.rowcount() > 0  then
		cb_3.triggerevent(clicked!)
	end if
end if
end event

type cb_11 from commandbutton within w_gtepuf005
boolean visible = false
integer x = 3296
integer y = 4
integer width = 343
integer height = 104
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "A/C Process"
end type

event clicked;setpointer(hourglass!)
 n_fames luo_fames
 luo_fames = Create n_fames
 
 if isdate(em_1.text) = false then
	messagebox('Error :','Please Enter Valid Account Process date')
	rollback using sqlca;
	return 1;
else
	ls_ac_dt=em_1.text
end if;	

if f_check_mep(ls_ac_dt) = -1 then return 1

select max(DS_DATE) into :ld_stock_dt from fb_daily_stock;

 if date(ls_ac_dt) < date(ld_stock_dt) then
	MESSAGEBOX('Error:','The Posting date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy'))
	return 1;
end if;	
	 if date(ls_ac_dt) > date(today()) then
		MESSAGEBOX('Error:','The Issue date Should be Less than equal to Current System Date i.e. '+string(today(),'dd/mm/yyyy'))
		return 1;
	end if;

select distinct 'x' into :ls_temp from FB_SERIAL_NO 
where SN_DOC_TYPE in ('JV','CV','BV','RCIN') and SN_ACCT_YEAR=to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm');

if sqlca.sqlcode = 100 then
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'RCIN', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	commit using sqlca;
end if

string ls_hopi
double ld_qty,ld_rate,ld_amt,ld_oth_amt,ld_tot_amt

if f_check_fin_yr(datetime(ls_ac_dt)) = -1 then;	return 1;end if;

for ll_ctr = 1 to dw_1.rowcount() 
	if dw_1.getitemstring(ll_ctr,'appr_flag') = 'Y'  and isnull(dw_1.getitemstring(ll_ctr,'hopi_vou_no'))=true then
		ls_hopi = dw_1.getitemstring(ll_ctr,'hopi_id')
		
		if date(ls_ac_dt) < date('01/07/2017') then 
		
			declare c1 cursor  for 
			 select  b.SP_ID SP_ID, HOPI_QUANTITY, HOPI_EFFECTIVEUNITPRICE,
						 decode(nvl(b.HOPI_SALETAX,0),0,(hopi_effectiveunitprice* HOPI_QUANTITY),(hopi_effectiveunitprice* HOPI_QUANTITY)+((hopi_effectiveunitprice* HOPI_QUANTITY)*(b.HOPI_SALETAX/100))) Amount,
					  (decode(nvl(b.HOPI_SALETAX,0),0,(hopi_effectiveunitprice* HOPI_QUANTITY),(hopi_effectiveunitprice* HOPI_QUANTITY)+((hopi_effectiveunitprice* HOPI_QUANTITY)*(b.HOPI_SALETAX/100))))*((nvl(HOPI_FREIGHT,0)+nvl(HOPI_INSURANCE,0)+nvl(HOPI_OTHERAMO,0))/totamt) other_val 
				from fb_hopurchaseinvoice a,fb_hopidetails b ,
						  (select hopi_id, round(SUM(decode(nvl(HOPI_SALETAX,0),0,(hopi_effectiveunitprice* HOPI_QUANTITY),(hopi_effectiveunitprice* HOPI_QUANTITY)+((hopi_effectiveunitprice* HOPI_QUANTITY)*(HOPI_SALETAX/100)))),2) totamt from fb_hopidetails group by hopi_id) x
				where a.hopi_id = b.hopi_id  and a.HOPI_ID = x.HOPI_ID and b.HOPI_ID = :ls_hopi
				order by 1,2	;
				
			open c1; 
				
			if sqlca.sqlcode = -1 then 
					messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return 1; 
			else 
				
				setnull(ls_sp_id); ld_qty=0;ld_rate=0;ld_amt=0;ld_oth_amt=0;ld_tot_amt=0
	
				fetch c1 into :ls_sp_id,:ld_qty,:ld_rate,:ld_amt,:ld_oth_amt;
				
				do while sqlca.sqlcode <> 100 
						
						if isnull(ld_oth_amt) then ld_oth_amt=0
						if isnull(ld_amt) then ld_amt=0
						ld_tot_amt = (ld_amt + ld_oth_amt)
						
						ld_rate =  (ld_tot_amt / ld_qty)
						
						//received qnty  update in indent
						if wf_upd_indent_recvqnty(dw_1.getitemstring(ll_ctr,'indent_id'),ls_sp_id,ld_qty,'N') = -1 then 
							rollback using sqlca;
							return 1
						end if;
						///update Stock Quantity
						
						if luo_fames.wf_upd_dailystock(ls_hopi,ls_ac_dt,ls_sp_id,ld_qty,ld_rate, ld_tot_amt ,'HO Purchase Invoice','R','N',gs_storeid) = -1 then 
							rollback using sqlca;
							return 1;
						end if;			
						
					setnull(ls_sp_id); ld_qty=0;ld_rate=0;ld_amt=0;ld_oth_amt=0;ld_tot_amt=0
				
					fetch c1 into :ls_sp_id,:ld_qty,:ld_rate,:ld_amt,:ld_oth_amt;
				 
				loop;
			end if
			///create JV 
			if luo_fames.wf_remittancekind_tostore(dw_1.getitemstring(ll_ctr,'hopi_id'),ls_ac_dt) = -1 then 
				rollback using sqlca;
				return 1;
			end if;
		else	//if date(ls_ac_dt) < date('01/07/2017') then 
//			change on 30052018
//			 select  b.SP_ID SP_ID, HOPI_QUANTITY, HOPI_EFFECTIVEUNITPRICE,
//					 ((hopi_effectiveunitprice* HOPI_QUANTITY)+(nvl(HOPI_CGST_AMT,0) + nvl(HOPI_SGST_AMT,0) + nvl(HOPI_IGST_AMT,0))) Amount,
//				  ((hopi_effectiveunitprice* HOPI_QUANTITY)+(nvl(HOPI_CGST_AMT,0) + nvl(HOPI_SGST_AMT,0) + nvl(HOPI_IGST_AMT,0)))*((nvl(HOPI_FREIGHT,0)+nvl(HOPI_INSURANCE,0)+nvl(HOPI_OTHERAMO,0))/totamt) other_val 
//			from fb_hopurchaseinvoice a,fb_hopidetails b ,
//					  (select hopi_id, round(SUM(((hopi_effectiveunitprice* HOPI_QUANTITY)+(nvl(HOPI_CGST_AMT,0) + nvl(HOPI_SGST_AMT,0) + nvl(HOPI_IGST_AMT,0)))),2) totamt from fb_hopidetails group by hopi_id) x
//			where a.hopi_id = b.hopi_id  and a.HOPI_ID = x.HOPI_ID and b.HOPI_ID = :ls_hopi
//			order by 1,2			
			declare c2 cursor  for 
			select  b.SP_ID SP_ID, HOPI_QUANTITY, HOPI_EFFECTIVEUNITPRICE,
					 ((hopi_effectiveunitprice* HOPI_QUANTITY) + (nvl(HOPI_CESS_RATE,0) * nvl(HOPI_QUANTITY,0))) Amount,
				  ((hopi_effectiveunitprice* HOPI_QUANTITY) + (nvl(HOPI_CESS_RATE,0) * nvl(HOPI_QUANTITY,0)))*((nvl(HOPI_FREIGHT,0)+nvl(HOPI_INSURANCE,0)+nvl(HOPI_OTHERAMO,0))/totamt) other_val 
			from fb_hopurchaseinvoice a,fb_hopidetails b ,
					  (select hopi_id, round(SUM((hopi_effectiveunitprice* HOPI_QUANTITY) + (nvl(HOPI_CESS_RATE,0) * nvl(HOPI_QUANTITY,0))),2) totamt from fb_hopidetails group by hopi_id) x
			where a.hopi_id = b.hopi_id  and a.HOPI_ID = x.HOPI_ID and b.HOPI_ID = :ls_hopi
			order by 1,2;
				
			open c2; 
				
			if sqlca.sqlcode = -1 then 
					messagebox('Sql Error : During Opening Cursor C2 : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return 1; 
			else 
				
				setnull(ls_sp_id); ld_qty=0;ld_rate=0;ld_amt=0;ld_oth_amt=0;ld_tot_amt=0
	
				fetch c2 into :ls_sp_id,:ld_qty,:ld_rate,:ld_amt,:ld_oth_amt;
				
				do while sqlca.sqlcode <> 100 
						
						if isnull(ld_oth_amt) then ld_oth_amt=0
						if isnull(ld_amt) then ld_amt=0
//						ld_tot_amt = (ld_amt + ld_oth_amt)						
//						ld_rate =  (ld_tot_amt / ld_qty)

						ld_tot_amt = truncate((ld_amt + ld_oth_amt),2)
						ld_rate =  truncate((ld_tot_amt / ld_qty),2)
						
						//received qnty  update in indent		
						setnull(ls_indent_id);
						ls_indent_id=dw_1.getitemstring(ll_ctr,'indent_id')
						declare p2 procedure for up_hopo_stock (:ls_hopi,:ls_ac_dt,:ls_indent_id,:ls_sp_id,:ld_qty,:ld_rate,:ld_tot_amt,'HO Purchase Invoice','R',:gs_storeid);
						
						//execute up_hopo_stock ('HOPI0000001922','11/09/2024','AD/HO/000054-24','CSP09377',700,2.25,1575,'HO Purchase Invoice','R','FD001',:ls_msg)
			
						if sqlca.sqlcode = -1 then
							 messagebox('SQL Error: During Procedure Declare of up_hopo_stock',sqlca.sqlerrtext)
							 return 1
						end if
						
						execute p2;
						//messagebox('Check',ls_msg)
						if sqlca.sqlcode = -1 then
							 messagebox('SQL Error: During Procedure Execute of up_hopo_stock',sqlca.sqlerrtext)
							 return 1
						end if

//				ls_text =" execute up_hopo_stock('"+ls_indent_id+"','"+ls_sp_id+"',"+string(ld_qty)+","+string(ld_rate)+","+string(ld_tot_amt)+",'"+gs_storeid+"',ls_msg)"
//				execute immediate :ls_text using sqlca;
//				if sqlca.sqlcode = -1 then
//					messagebox('SQL ERROR: During PLUCKING SUMARY PF View Creation',sqlca.sqlerrtext)
//					return
//				end if
//			messagebox('Check',ls_msg)
						
						
						
//						if wf_upd_indent_recvqnty(dw_1.getitemstring(ll_ctr,'indent_id'),ls_sp_id,ld_qty,'N') = -1 then 
//							rollback using sqlca;
//							return 1
//						end if;
						
						///update Stock Quantity						
//						if luo_fames.wf_upd_dailystock(ls_hopi,string(dw_1.getitemdatetime(ll_ctr,'hopi_date'),'dd/mm/yyyy'),ls_sp_id,ld_qty,ld_rate, ld_tot_amt ,'HO Purchase Invoice','R','N',gs_storeid) = -1 then 
//							rollback using sqlca;
//							return 1;
//						end if;			
						
					setnull(ls_sp_id); ld_qty=0;ld_rate=0;ld_amt=0;ld_oth_amt=0;ld_tot_amt=0
				
					fetch c2 into :ls_sp_id,:ld_qty,:ld_rate,:ld_amt,:ld_oth_amt;
				 
				loop;
			end if
			///create JV 
			if luo_fames.wf_remittancekind_tostore_gst(dw_1.getitemstring(ll_ctr,'hopi_id'),ls_ac_dt) = -1 then 
				rollback using sqlca;
				return 1;
			end if;
		end if  //if date(ls_ac_dt) < date('01/07/2017') then 
	end if
next	
	
dw_1.update( )

commit using sqlca;
DESTROY n_fames
messagebox('Information;',' JV Created Successfully')
//for ll_ctr = 1 to dw_1.rowcount() 
//	if dw_1.getitemstring(ll_ctr,'appr_flag') = 'Y'  and isnull(dw_1.getitemstring(ll_ctr,'hopi_vou_no'))=true then
//		ls_hopi = dw_1.getitemstring(ll_ctr,'hopi_id')
//		if  isnull(dw_1.getitemstring(ll_ctr,'ho_po_id')) = false and (isnull(dw_1.getitemstring(ll_ctr,'hopi_mail_ind')) = true or dw_1.getitemstring(ll_ctr,'hopi_mail_ind') = 'N') then
//			li_flag =  wf_mail(ls_hopi)
//		end if
//	end if
//next
dw_1.reset()
dw_2.reset()
cb_6.enabled = false
setpointer(arrow!)
end event

type dw_3 from datawindow within w_gtepuf005
boolean visible = false
integer x = 4539
integer y = 180
integer width = 320
integer height = 400
integer taborder = 40
string title = "none"
string dataobject = "dw_gtepuf005b"
boolean livescroll = true
end type

type cb_10 from commandbutton within w_gtepuf005
integer x = 2994
integer y = 8
integer width = 265
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Import"
end type

event clicked;integer l_fnum
long l_flen,l_bytes_read,l_rec_len,l_count,l_fexit, l_ctr1
string l_byte,l_rec_val,ls_filename,lf_fnamed,ls_id,ls_sn,ls_dt,ls_sid,ls_sild, ls_oldmail
string l_field0,l_field1,l_field2,l_field3

setnull(ls_oldmail)
l_count = 0
l_fexit = GetFileOpenName("Select File", &
		+ ls_filename, lf_fnamed, "CSV", &
		+ "CSV Files (*.CSV),*.CSV")

lf_fnamed = upper(left(lf_fnamed,len(lf_fnamed) - 4))

setpointer(HourGlass!)

IF l_fexit = 1 THEN 	
	open(w_import_rows_information)
	l_flen = filelength(ls_filename) 
	l_fnum = fileopen(ls_filename)
	l_bytes_read = fileread(l_fnum,l_byte)
	do while l_bytes_read <> -100
			l_rec_val = l_byte
			l_rec_len = len(l_rec_val)
			l_rec_val = right(l_rec_val,l_rec_len)
			l_field0  = f_get_string_position(l_rec_val,',')
			l_field1    = f_get_string_position(l_rec_val,',')
			l_field2    = f_get_string_position(l_rec_val,',')
			l_field3    = f_get_string_position(l_rec_val,',')			
			 
			if len(l_field1) > 0 then
				if l_count = 0 then
					select distinct 'x' into :ls_temp from fb_hopo_import where po_id = trim(:l_field0) ;
					if sqlca.sqlcode = -1 then
						messagebox('Error occured while checking existing records',sqlca.sqlerrtext)
						rollback using sqlca;
						close(w_import_rows_information)
						fileclose(l_fnum)
						return 1	
					elseif sqlca.sqlcode = 0 then
						messagebox('Warning','PO ID '+l_field0+ ' already exist in system') 
						rollback using sqlca;
						close(w_import_rows_information)
						fileclose(l_fnum)
						return 1	
					end if
				end if
				
				select distinct 'X' into :ls_temp from fb_indent where indent_id=:l_field2;
				if sqlca.sqlcode = -1 then
					messagebox('Error occured while checking existing records in Indent',sqlca.sqlerrtext)
						rollback using sqlca;
						close(w_import_rows_information)
						fileclose(l_fnum)
						return 1	
				elseif sqlca.sqlcode = 100 then
					messagebox('Error','Indent No'+ l_field2 +'is incorrect in CSV for PO Number'+l_field0 )
						rollback using sqlca;
						close(w_import_rows_information)
						fileclose(l_fnum)
						return 1	
				end if
				
//				select distinct 'X' into :ls_temp from (select distinct a.INDENT_ID, a.INDENT_DATE from fb_indent a,fb_indentdetails b where a.INDENT_ID=b.INDENT_ID and nvl(INDENT_HOLOCALFLAG,'0')='1' and  nvl(inddet_quantity,0) >(nvl(inddet_receivedquantity,0)+nvl(INDDET_CANCELQUANTITY,0)) and
//     					 not exists ( select distinct 'x' from fb_hopurchaseinvoice  where INDENT_ID=A.indent_id and HOPI_VOU_NO is null)) a,(select distinct INDENT_ID from fb_hopo_import where INDENT_ID=:l_field2 ) b
//						where a.indent_id = b.indent_id  and a.indent_id=:l_field2;
//				if sqlca.sqlcode = -1 then
//					messagebox('Error occured while checking existing records of PO',sqlca.sqlerrtext)
//					rollback using sqlca;
//					close(w_import_rows_information)
//					fileclose(l_fnum)
//					return 1	
//				elseif sqlca.sqlcode = 100 then
//					messagebox('Error','Indent No '+ l_field2 +' All item has been received' )
//					rollback using sqlca;
//					close(w_import_rows_information)
//					fileclose(l_fnum)
//					return 1	
//				end if
				
				
             		insert into fb_hopo_import (PO_ID, PO_DATE, INDENT_ID, INDENT_DATE, INVOICE_IND)
				values (:l_field0,to_date(:l_field1,'dd/mm/yyyy'),:l_field2,to_date(:l_field3,'dd/mm/yyyy'),'N');
                     
				if sqlca.sqlcode = -1 then
					messagebox("SQL Error : At Insert ",SQLCA.SQLErrtext,Information!)
					rollback using sqlca;
					close(w_import_rows_information)
				   fileclose(l_fnum)
					return 1
				end if
			end if		
			 
		
			l_bytes_read = fileread(l_fnum,l_byte)
			l_count = l_count + 1
			w_import_rows_information.sle_1.text= string(l_count) 
			
	loop
	commit using sqlca;
	fileclose(l_fnum)
	close(w_import_rows_information)
	setpointer(arrow!) 
	messagebox("Import File Information",'Total ' + string(l_count) + ' Rows Imported.....')
else
	setpointer(arrow!) 
	messagebox("file","File Does Not Exists -> " + ls_filename)
end if

return 1


end event

type cb_9 from commandbutton within w_gtepuf005
integer x = 4389
integer y = 28
integer width = 123
integer height = 88
integer taborder = 100
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = ">>"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.ScrolltoRow(dw_1.rowcount())
	dw_1.setcolumn('ind')
end if
end event

type cb_8 from commandbutton within w_gtepuf005
integer x = 4270
integer y = 28
integer width = 123
integer height = 88
integer taborder = 90
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = ">"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.ScrollnextRow()
	dw_1.setcolumn('ind')
end if
end event

type cb_7 from commandbutton within w_gtepuf005
integer x = 4151
integer y = 28
integer width = 123
integer height = 88
integer taborder = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "<"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.ScrollPriorRow()
dw_1.setcolumn('ind')
end if
end event

type cb_5 from commandbutton within w_gtepuf005
integer x = 4032
integer y = 28
integer width = 123
integer height = 88
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "<<"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.ScrolltoRow(1)
	dw_1.setcolumn('ind')
end if
end event

type cb_6 from commandbutton within w_gtepuf005
integer x = 2597
integer y = 8
integer width = 343
integer height = 104
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "A/C Process"
end type

event clicked;setpointer(hourglass!)
 n_fames luo_fames
 luo_fames = Create n_fames
 
 if isdate(em_1.text) = false then
	messagebox('Error :','Please Enter Valid Account Process date')
	rollback using sqlca;
	return 1;
else
	ls_ac_dt=em_1.text
end if;	

if f_check_mep(ls_ac_dt) = -1 then return 1

select max(DS_DATE) into :ld_stock_dt from fb_daily_stock;

 if date(ls_ac_dt) < date(ld_stock_dt) then
	MESSAGEBOX('Error:','The Posting date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy'))
	return 1;
end if;	
	 if date(ls_ac_dt) > date(today()) then
		MESSAGEBOX('Error:','The Issue date Should be Less than equal to Current System Date i.e. '+string(today(),'dd/mm/yyyy'))
		return 1;
	end if;

select distinct 'x' into :ls_temp from FB_SERIAL_NO 
where SN_DOC_TYPE in ('JV','CV','BV','RCIN') and SN_ACCT_YEAR=to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm');

if sqlca.sqlcode = 100 then
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'JV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'BV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'CV', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	INSERT INTO FB_SERIAL_NO ( SN_DOC_TYPE, SN_SRL_NO, SN_ACCT_YEAR ) VALUES ( 'RCIN', 0, to_char(to_date(:ls_ac_dt,'dd/mm/yyyy'),'yyyymm')); 
	commit using sqlca;
end if

string ls_hopi
double ld_qty,ld_rate,ld_amt,ld_oth_amt,ld_tot_amt

if f_check_fin_yr(datetime(ls_ac_dt)) = -1 then;	return 1;end if;

for ll_ctr = 1 to dw_1.rowcount() 
	if dw_1.getitemstring(ll_ctr,'appr_flag') = 'Y'  and isnull(dw_1.getitemstring(ll_ctr,'hopi_vou_no'))=true then
		ls_hopi = dw_1.getitemstring(ll_ctr,'hopi_id')
		
		if date(ls_ac_dt) < date('01/07/2017') then 
		
			declare c1 cursor  for 
			 select  b.SP_ID SP_ID, HOPI_QUANTITY, HOPI_EFFECTIVEUNITPRICE,
						 decode(nvl(b.HOPI_SALETAX,0),0,(hopi_effectiveunitprice* HOPI_QUANTITY),(hopi_effectiveunitprice* HOPI_QUANTITY)+((hopi_effectiveunitprice* HOPI_QUANTITY)*(b.HOPI_SALETAX/100))) Amount,
					  (decode(nvl(b.HOPI_SALETAX,0),0,(hopi_effectiveunitprice* HOPI_QUANTITY),(hopi_effectiveunitprice* HOPI_QUANTITY)+((hopi_effectiveunitprice* HOPI_QUANTITY)*(b.HOPI_SALETAX/100))))*((nvl(HOPI_FREIGHT,0)+nvl(HOPI_INSURANCE,0)+nvl(HOPI_OTHERAMO,0))/totamt) other_val 
				from fb_hopurchaseinvoice a,fb_hopidetails b ,
						  (select hopi_id, round(SUM(decode(nvl(HOPI_SALETAX,0),0,(hopi_effectiveunitprice* HOPI_QUANTITY),(hopi_effectiveunitprice* HOPI_QUANTITY)+((hopi_effectiveunitprice* HOPI_QUANTITY)*(HOPI_SALETAX/100)))),2) totamt from fb_hopidetails group by hopi_id) x
				where a.hopi_id = b.hopi_id  and a.HOPI_ID = x.HOPI_ID and b.HOPI_ID = :ls_hopi
				order by 1,2	;
				
			open c1; 
				
			if sqlca.sqlcode = -1 then 
					messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
					rollback using sqlca; 
					return 1; 
			else 
				
				setnull(ls_sp_id); ld_qty=0;ld_rate=0;ld_amt=0;ld_oth_amt=0;ld_tot_amt=0
	
				fetch c1 into :ls_sp_id,:ld_qty,:ld_rate,:ld_amt,:ld_oth_amt;
				
				do while sqlca.sqlcode <> 100 
						
						if isnull(ld_oth_amt) then ld_oth_amt=0
						if isnull(ld_amt) then ld_amt=0
						ld_tot_amt = Truncate( (ld_amt + ld_oth_amt),2)
						
						ld_rate =  Truncate( (ld_tot_amt / ld_qty),2)
						
						//received qnty  update in indent
						if wf_upd_indent_recvqnty(dw_1.getitemstring(ll_ctr,'indent_id'),ls_sp_id,ld_qty,'N') = -1 then 
							rollback using sqlca;
							return 1
						end if;
						///update Stock Quantity
						
						if luo_fames.wf_upd_dailystock(ls_hopi,string(dw_1.getitemdatetime(ll_ctr,'hopi_date'),'dd/mm/yyyy'),ls_sp_id,ld_qty,ld_rate, ld_tot_amt ,'HO Purchase Invoice','R','N',gs_storeid) = -1 then 
							rollback using sqlca;
							return 1;
						end if;			
						
					setnull(ls_sp_id); ld_qty=0;ld_rate=0;ld_amt=0;ld_oth_amt=0;ld_tot_amt=0
				
					fetch c1 into :ls_sp_id,:ld_qty,:ld_rate,:ld_amt,:ld_oth_amt;
				 
				loop;
			end if
			///create JV 
			if luo_fames.wf_remittancekind_tostore(dw_1.getitemstring(ll_ctr,'hopi_id'),ls_ac_dt) = -1 then 
				rollback using sqlca;
				return 1;
			end if;
		else	
			declare p2 procedure for up_hopo_stock (:ls_hopi,:ls_ac_dt,'HO Purchase Invoice',:gs_storeid,:gs_user,:gs_CO_ID,:gs_garden_snm);			
			if sqlca.sqlcode = -1 then
				 messagebox('SQL Error: During Procedure Declare of up_hopo_stock',sqlca.sqlerrtext)
				 return 1
			end if
						
			execute p2;
			if sqlca.sqlcode = -1 then
				messagebox('SQL Error: During Procedure Execute of up_hopo_stock',sqlca.sqlerrtext)
				 return 1
			end if

		end if  //if date(ls_ac_dt) < date('01/07/2017') then 
	end if
next	
	
dw_1.update( )

commit using sqlca;
DESTROY n_fames
messagebox('Information;',' JV Created Successfully')
for ll_ctr = 1 to dw_1.rowcount() 
	if dw_1.getitemstring(ll_ctr,'appr_flag') = 'Y'  and isnull(dw_1.getitemstring(ll_ctr,'hopi_vou_no'))=true then
		ls_hopi = dw_1.getitemstring(ll_ctr,'hopi_id')
		if  isnull(dw_1.getitemstring(ll_ctr,'ho_po_id')) = false and (isnull(dw_1.getitemstring(ll_ctr,'hopi_mail_ind')) = true or dw_1.getitemstring(ll_ctr,'hopi_mail_ind') = 'N') then
			li_flag =  wf_mail(ls_hopi)
		end if
	end if
next
dw_1.reset()
dw_2.reset()
cb_6.enabled = false
setpointer(arrow!)
end event

type cbx_1 from checkbox within w_gtepuf005
integer x = 1138
integer y = 24
integer width = 475
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Un Approved"
boolean checked = true
end type

type em_1 from editmask within w_gtepuf005
integer x = 2158
integer y = 20
integer width = 411
integer height = 84
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean dropdowncalendar = true
end type

event modified;if isdate(em_1.text) = false then 
	messagebox('Error At Process date','Please Enter Account Process date...!')
	cb_6.enabled = false	
	return 1
else
	ls_temp=em_1.text
	if cb_3.enabled = true then
		messagebox('Warning!','You Have Made Some Changes, Please Save First !!!');
		return 1
	end if
	if dw_1.getitemstring(dw_1.getrow(),'appr_flag') = 'Y' then
		cb_6.enabled = true
	end if
end if;	
end event

type st_1 from statictext within w_gtepuf005
integer x = 1646
integer y = 32
integer width = 498
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = " A/C Process Date :"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_gtepuf005
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 18
integer y = 1012
integer width = 4859
integer height = 1256
integer taborder = 40
string dataobject = "dw_gtepuf005a"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_2.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_2.deleterow(dw_2.getrow())
	end if
	if dw_2.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event ue_keydwn;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_2.deleterow(dw_2.getrow())
	end if
	if dw_2.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event itemchanged;if lb_query = false then
	
	ls_indent_id = dw_1.getitemstring(dw_1.getrow(),'indent_id')
	
	select indent_date into :ld_indent_dt from fb_indent where indent_id = :ls_indent_id;
	
	if sqlca.sqlcode = -1 then
		messagebox('Error','Error occured while checking indent date : '+sqlca.sqlerrtext)
		return 1
	elseif sqlca.sqlcode = 100 then
		messagebox('Warning','No indent found')
		return 1
	end if
	
	if isnull(dw_1.getitemstring(dw_1.getrow(),'ho_po_id')) and date(ld_indent_dt) >= date('01/07/2020') then
		messagebox('Warning', 'Kindly import HO PO CSV file for this invoice and select HO PO ID to proceed.')
		return 1
	end if
	
	if dwo.name = 'sp_id' then
		ld_hopi_dt = dw_1.getitemdatetime(dw_1.getrow(),'hopi_date')
		ls_sp_id = trim(data)
		ls_iss_locn = dw_1.getitemstring(dw_1.getrow(),'hopi_iss_locn')
		
		
		select max(DS_DATE) into :ld_stock_dt from fb_daily_stock where  DS_ITEM_CD = :ls_sp_id;
		
		select sp_name into :ls_spname from fb_storeproduct where sp_id = :ls_sp_id;
	
		 if date(ld_hopi_dt) < date(ld_stock_dt) then
			MESSAGEBOX('Error:','The Purchase invoice date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy')+' Of Item '+ls_spname+' ('+ls_sp_id+')')
			return 1;
		end if;	
	
		if isnull(ls_iss_locn) or len(ls_iss_locn) = 0 then
			messagebox('Warning!','Supplier State / From State Is Blank, Please Check !!!')
		end if
		
		if  wf_check_duplicate_rec(data) = -1 then return 1
		 dw_2.setitem(row,'hopi_quantity',idw_prod.getitemnumber(idw_prod.getrow(),'bal'))			 
		 dw_2.setitem(row,'hopi_quantity_bal',idw_prod.getitemnumber(idw_prod.getrow(),'bal'))
		 
		select SP_HSN_NO into :ls_hsn_cd from fb_storeproduct where sp_id =  :ls_sp_id;
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
			return 1
//			elseif sqlca.sqlcode = 100 then 
//				messagebox('Error','Item HSN Code Missing, Please Check !!!')
//				return 1
		end if;	
		dw_2.setitem(row,'hopi_hsn_no',ls_hsn_cd)		 
	end if
	
	if row = dw_2.rowcount() and dwo.name <> 'del_flag'  then
		dw_2.insertrow(0)
	end if

	 if dwo.name = 'hopi_quantity' then 
		ld_qnty = double(data)
		ld_balqty=dw_2.getitemnumber(row,'hopi_quantity_bal');
		if(ld_qnty>ld_balqty) then
			messagebox('Warning','Recive Quantity greater than Balance qty')
			return 1 ;
		end if		
	else
		ld_qnty =dw_2.getitemnumber(row,'hopi_quantity')
	end if
	
	if dwo.name = 'hopi_cess_rate' then
		ld_cess_rate =double(data)
		ld_cess_amt =  (ld_qnty *  ld_cess_rate)
		dw_2.setitem(row,'hopi_cess_amount',ld_cess_amt)
	else
		ld_cess_rate =dw_2.getitemnumber(row,'hopi_cess_rate')
	end if
	
	if dwo.name = 'hopi_unitprice' then
		ld_unit_price = double(data)
		
			select nvl(HM_CGST_RATE,0), nvl(HM_SGST_RATE,0), nvl(HM_IGST_RATE,0) into :ld_cgst_per, :ld_sgst_per, :ld_igst_per
			from fb_hsn_master where HM_HSN_code = :ls_hsn_cd and trunc(:ld_hopi_dt) between trunc(HM_FROM_DT) and trunc(nvl(HM_TO_DT,sysdate)) and HM_APPROVED_DT is not null;
			
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
				return 1
//			elseif sqlca.sqlcode = 100 then 
//				messagebox('Error','Item HSN Code/Rate Is Missing, Please Check !!!')
//				return 1
			end if;
			select SUP_GSTN_STCD into :ls_iss_locn from fb_supplier where sup_id =  :ls_sup_id;
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
				return 1
			end if;				
			
			select SP_HSN_NO into :ls_hsn_cd from fb_storeproduct where sp_id =  :ls_sp_id;
			if sqlca.sqlcode = -1 then 
				messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
				return 1
			elseif sqlca.sqlcode = 100 then 
				messagebox('Error','Item HSN Code Missing, Please Check !!!')
				return 1
			end if;	
			if isnull(ls_iss_locn) or len(ls_iss_locn) = 0 then
				messagebox('Error','Supplier Sate Code No Update, Please Update Now !!!')
				return 1
			end if
				
			if isnull(gs_gstn_stcd) or len(gs_gstn_stcd) = 0 then
				messagebox('Error','Garden Sate Code No Update, Please Update Now !!!')
				return 1
			end if
			
		
			ld_efunit_price = (ld_unit_price - (ld_unit_price *(ld_discount/100)))
			dw_2.setitem(row,'hopi_effectiveunitprice',ld_efunit_price)
		
			
			ld_amount = (ld_qnty * ld_efunit_price ) + (ld_qnty *  ld_cess_rate)
			
//			if ls_iss_locn = gs_gstn_stcd then
//				ld_igst_per = 0
//			elseif ls_iss_locn <> gs_gstn_stcd then
//				ld_cgst_per = 0; ld_sgst_per = 0;
//			end if
			
//			if ld_igst_per > 0 then
//				ld_cgst_per = 0
//				ld_sgst_per = 0
//				dw_2.setitem(row,'hopi_cgst_per',0)
//				dw_2.setitem(row,'hopi_sgst_per',0)
//				dw_2.setitem(row,'hopi_igst_amt',(ld_amount *(ld_igst_per/100))) 
//				dw_2.setitem(row,'hopi_igst_per',ld_igst_per)
//				ld_amount=ld_amount+(ld_amount *(ld_igst_per/100)) + (ld_qnty *  ld_cess_rate)
//				dw_2.setitem(row,'hopi_cgst_amt',0) 
//				dw_2.setitem(row,'hopi_sgst_amt',0) 
//			elseif ld_cgst_per > 0 or ld_sgst_per > 0 then
//				ld_igst_per = 0
//				dw_2.setitem(row,'hopi_igst_per',0)
//				dw_2.setitem(row,'hopi_cgst_amt',(ld_amount *(ld_cgst_per/100))) 
//				dw_2.setitem(row,'hopi_sgst_amt',(ld_amount *(ld_sgst_per/100))) 
//				dw_2.setitem(row,'hopi_cgst_per',ld_cgst_per) 
//				dw_2.setitem(row,'hopi_sgst_per',ld_sgst_per) 				
//				dw_2.setitem(row,'hopi_igst_amt',0) 			
//				ld_amount=ld_amount+(ld_amount *(ld_cgst_per/100))+(ld_amount *(ld_sgst_per/100))	+ (ld_qnty *  ld_cess_rate)
//			elseif ld_igst_per = 0 and ld_cgst_per = 0 and ld_sgst_per = 0 then
//				ld_igst_per = 0
//				ld_cgst_per = 0
//				ld_sgst_per = 0
//				dw_2.setitem(row,'hopi_igst_per',0)
//				dw_2.setitem(row,'hopi_cgst_amt',0) 
//				dw_2.setitem(row,'hopi_sgst_amt',0) 
//				dw_2.setitem(row,'hopi_cgst_per',0) 
//				dw_2.setitem(row,'hopi_sgst_per',0) 				
//				dw_2.setitem(row,'hopi_igst_amt',0) 			
//				ld_amount=ld_amount + (ld_qnty *  ld_cess_rate)				
//			end if		
	     dw_2.setitem(row,'amount',ld_amount)
		wf_cal_netamt('det',0)
			
	else
		ld_unit_price =dw_2.getitemnumber(row,'hopi_unitprice')
	end if
	
	if dwo.name = 'hopi_effectiveunitprice' then
		ld_efunit_price = double(data)
	else
		ld_efunit_price =dw_2.getitemnumber(row,'hopi_effectiveunitprice')		
	end if
	
	if dwo.name = 'hopi_discount' then
		ld_discount = double(data)
	else
		ld_discount =dw_2.getitemnumber(row,'hopi_discount')
	end if
	
	if dwo.name = 'hopi_saletax' then
		ld_saletax=double(data)
	else
		ld_saletax =dw_2.getitemnumber(row,'hopi_saletax')
	end if
	
	if dwo.name = 'hopi_cgst_per' then
		ld_cgst_per = double(data)
	else
		ld_cgst_per =dw_2.getitemnumber(row,'hopi_cgst_per')
	end if

	if dwo.name = 'hopi_sgst_per' then
		ld_sgst_per = double(data)
	else
		ld_sgst_per =dw_2.getitemnumber(row,'hopi_sgst_per')
	end if

	if dwo.name = 'hopi_igst_per' then
		ld_igst_per = double(data)
	else
		ld_igst_per =dw_2.getitemnumber(row,'hopi_igst_per')
	end if
	
	if dwo.name = 'hopi_discount' or  dwo.name = 'hopi_quantity' or dwo.name = 'hopi_cess_rate'  or dwo.name = 'hopi_effectiveunitprice' or dwo.name = 'hopi_saletax' or dwo.name = 'hopi_cgst_per' or dwo.name = 'hopi_sgst_per' or dwo.name = 'hopi_igst_per' then
		if isnull(ld_discount) then ld_discount=0
		if isnull(ld_unit_price) then ld_unit_price=0
		if isnull(ld_qnty) then  ld_qnty=0
		
		ld_efunit_price = (ld_unit_price - (ld_unit_price *(ld_discount/100)))
		dw_2.setitem(row,'hopi_effectiveunitprice',ld_efunit_price)
	
		ld_amount = (ld_qnty * ld_efunit_price ) + (ld_qnty *  ld_cess_rate)
//		if isnull(ld_saletax) then  ld_saletax=0
//		ld_amount=ld_amount+(ld_amount *(ld_saletax/100))
//================		
		if isnull(ld_saletax) then  ld_saletax=0
		if isnull(ld_cgst_per) then  ld_cgst_per=0
		if isnull(ld_sgst_per) then  ld_sgst_per=0
		if isnull(ld_igst_per) then  ld_igst_per=0
		
		ld_hopi_dt = dw_1.getitemdatetime(1,'hopi_date')
		ls_iss_locn = dw_1.getitemstring(1,'hopi_iss_locn')
		ls_rec_locn = dw_1.getitemstring(1,'hopi_rec_locn')
		ls_sup_id = dw_1.getitemstring(1,'sup_id')
		
		if date(ld_hopi_dt) > date('30/06/2017') then
			ld_saletax = 0
			dw_2.setitem(row,'hopi_saletax',0)
			
//			select SUP_GSTN_STCD into :ls_iss_locn from fb_supplier where sup_id =  :ls_sup_id;
//			if sqlca.sqlcode = -1 then 
//				messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
//				return 1
//			end if;				
//			
//			select SP_HSN_NO into :ls_hsn_cd from fb_storeproduct where sp_id =  :ls_sp_id;
//			if sqlca.sqlcode = -1 then 
//				messagebox('Sql Error','Error During Getting HSN Code : '+sqlca.sqlerrtext)
//				return 1
//			elseif sqlca.sqlcode = 100 then 
//				messagebox('Error','Item HSN Code Missing, Please Check !!!')
//				return 1
//			end if;	
//			if isnull(ls_iss_locn) or len(ls_iss_locn) = 0 then
//				messagebox('Error','Supplier Sate Code No Update, Please Update Now !!!')
//				return 1
//			end if
//				
//			if isnull(gs_gstn_stcd) or len(gs_gstn_stcd) = 0 then
//				messagebox('Error','Garden Sate Code No Update, Please Update Now !!!')
//				return 1
//			end if
//			
//			
//			if ls_iss_locn = gs_gstn_stcd then
//				ld_igst_per = 0
//			elseif ls_iss_locn <> gs_gstn_stcd then
//				ld_cgst_per = 0; ld_sgst_per = 0;
//			end if
//			
//			if ld_igst_per > 0 then
//				ld_cgst_per = 0
//				ld_sgst_per = 0
//				dw_2.setitem(row,'hopi_cgst_per',0)
//				dw_2.setitem(row,'hopi_sgst_per',0)
//				dw_2.setitem(row,'hopi_igst_amt',(ld_amount *(ld_igst_per/100))) 
//				dw_2.setitem(row,'hopi_igst_per',ld_igst_per)
//				ld_amount=ld_amount+(ld_amount *(ld_igst_per/100)) + (ld_qnty *  ld_cess_rate)
//				dw_2.setitem(row,'hopi_cgst_amt',0) 
//				dw_2.setitem(row,'hopi_sgst_amt',0) 
//			elseif ld_cgst_per > 0 or ld_sgst_per > 0 then
//				ld_igst_per = 0
//				dw_2.setitem(row,'hopi_igst_per',0)
//				dw_2.setitem(row,'hopi_cgst_amt',(ld_amount *(ld_cgst_per/100))) 
//				dw_2.setitem(row,'hopi_sgst_amt',(ld_amount *(ld_sgst_per/100))) 
//				dw_2.setitem(row,'hopi_cgst_per',ld_cgst_per) 
//				dw_2.setitem(row,'hopi_sgst_per',ld_sgst_per) 				
//				dw_2.setitem(row,'hopi_igst_amt',0) 			
//				ld_amount=ld_amount+(ld_amount *(ld_cgst_per/100))+(ld_amount *(ld_sgst_per/100))	+ (ld_qnty *  ld_cess_rate)
//			elseif ld_igst_per = 0 and ld_cgst_per = 0 and ld_sgst_per = 0 then
//				ld_igst_per = 0
//				ld_cgst_per = 0
//				ld_sgst_per = 0
//				dw_2.setitem(row,'hopi_igst_per',0)
//				dw_2.setitem(row,'hopi_cgst_amt',0) 
//				dw_2.setitem(row,'hopi_sgst_amt',0) 
//				dw_2.setitem(row,'hopi_cgst_per',0) 
//				dw_2.setitem(row,'hopi_sgst_per',0) 				
//				dw_2.setitem(row,'hopi_igst_amt',0) 			
//				ld_amount=ld_amount + (ld_qnty *  ld_cess_rate)			
//			end if
		else
			ld_amount=ld_amount+(ld_amount *(ld_saletax/100))
		end if		
//================		
		
	     dw_2.setitem(row,'amount',ld_amount)
		wf_cal_netamt('det',0)
	end if

cb_3.enabled = true
end if;
end event

type cb_4 from commandbutton within w_gtepuf005
integer x = 814
integer y = 12
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

type cb_3 from commandbutton within w_gtepuf005
integer x = 544
integer y = 12
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 
if dw_2.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

if dw_2.rowcount() > 1 then
	if (isnull(dw_2.getitemstring(dw_2.rowcount(),'sp_id')) or len(dw_2.getitemstring(dw_2.rowcount(),'sp_id')) = 0) then 
		dw_2.deleterow(dw_2.rowcount())
	end if;
end if


IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	for ll_ctr = dw_2.rowcount() to 1 step -1
		if dw_2.getitemstring(ll_ctr,'del_flag') = 'Y' and dw_2.rowcount() = dw_2.getitemnumber(ll_ctr,'sel_row') then
			messagebox('Warning!','You Cannot Delete All Records From Detail Section !!!')
			return 1
		elseif dw_2.getitemstring(ll_ctr,'del_flag') = 'Y' and dw_2.rowcount() <> dw_2.getitemnumber(ll_ctr,'sel_row') then
			dw_2.deleterow(ll_ctr)
		end if
	next	
	
	if dw_2.rowcount() = 0 then
		messagebox('Error','Records Should Be Available In Detail Block')
		return
	end if
	
	if isnull(dw_1.getitemstring(dw_1.getrow(),'hopi_vou_no')) or len(dw_1.getitemstring(dw_1.getrow(),'hopi_vou_no')) = 0 then
		if (isnull(dw_1.getitemstring(dw_1.getrow(),'hopi_desc')) or isnull(dw_1.getitemstring(dw_1.getrow(),'hopi_desc')) or &
			isnull(dw_1.getitemstring(dw_1.getrow(),'indent_id')) or isnull(dw_1.getitemdatetime(dw_1.getrow(),'hopi_date')) or &
			isnull(dw_1.getitemstring(dw_1.getrow(),'hopi_rcno')) or isnull(dw_1.getitemdatetime(dw_1.getrow(),'hopi_rcdate')) or &
			isnull(dw_1.getitemstring(dw_1.getrow(),'hopi_cnno')) or isnull(dw_1.getitemdatetime(dw_1.getrow(),'hopi_cn_date')) or &
			isnull(dw_1.getitemnumber(dw_1.getrow(),'hopi_tcs_per')) or isnull(dw_1.getitemnumber(dw_1.getrow(),'hopi_tcs_amt')) or &
			isnull(dw_1.getitemstring(dw_1.getrow(),'hopi_carrier_name')) or len(dw_1.getitemstring(dw_1.getrow(),'hopi_carrier_name')) = 0 or &
			isnull(dw_1.getitemstring(dw_1.getrow(),'sup_id'))) then
			messagebox('Warning:','One Of The Fields Are Blank : Description, Indent Id, Supplier Id, RC no., RC date, CN No., CN date, Carrier name, TCS % and TCS Amt. !!!')
			dw_1.setfocus()
			dw_1.setcolumn('hopi_desc')
			return
		end if
	end if
//	ls_sup_id = dw_1.getitemstring(dw_1.getrow(),'sup_id')
//	
//	select SUP_ADD into :ls_temp from fb_supplier  where SUP_ID = :ls_sup_id and ACSUBLEDGER_ID is not null;
//	
//	if sqlca.sqlcode = -1 then
//		messagebox('Error During Select Of Supplier Address',sqlca.sqlerrtext)
//		rollback using sqlca;
//		return 1
//	elseif sqlca.sqlcode = 100 then
//		messagebox('Warning!','Subledger For The Supplier Is Blank, Please Update First !!!')
//		rollback using sqlca;
//		return 1
//	end if	

	
		if dw_2.rowcount() > 0 then
			for ll_ctr = 1 to dw_2.rowcount( ) 
				IF wf_check_fillcol(ll_ctr) = -1 THEN 
					return 1
				end if
			next	
		end if
	
		if lb_neworder = true then
			ll_last =0
			if ll_last=0 then
				select nvl(MAX(substr(hopi_id,5,10)),0) into :ll_last from fb_hopurchaseinvoice;
			end if
	
			ll_last = ll_last + 1
			ls_tmp_id = 'HOPI'+string(ll_last,'0000000000') 
			dw_1.setitem(dw_1.getrow(),'hopi_id',ls_tmp_id)	
		//	dw_1.setitem(dw_1.getrow(),'hopi_date',datetime(today()))
			dw_1.setitem(dw_1.getrow(),'hopi_mandate',dw_1.getitemdatetime(dw_1.getrow(),'hopi_date'))
			
			ls_sup_invno = dw_1.getitemstring(dw_1.getrow(),'hopi_rcno')
			ls_cnno = dw_1.getitemstring(dw_1.getrow(),'hopi_cnno')
			if isnull(ls_sup_invno) then ls_sup_invno = 'x';
			if isnull(ls_cnno) then ls_cnno = 'x';
			
			if ls_sup_invno = ls_cnno then
				messagebox('Error !!','Supplier Invoice No and CN No Cannot Be Same, Please Check !!!')
				return 1
			end if

			
		else
			ls_tmp_id =dw_1.getitemstring(dw_1.getrow(),'hopi_id')
		end if
		
		for ll_cnt = 1 to dw_2.rowcount()	
			dw_2.setitem(ll_cnt,'hopi_id',ls_tmp_id)				
		next		
		if lb_neworder = true then
			Messagebox('Information!','HO Purchase Invoice No Generated Is ('+ls_tmp_id+')')
		end if
	if dw_1.update(true,false) = 1 then
		if dw_2.update(true,false) = 1 then
			dw_2.resetupdate();
			dw_1.resetupdate();
			commit using sqlca;
			cb_3.enabled = false
			cb_1.enabled = true
			dw_1.reset()
			dw_2.reset()
		else
			rollback using sqlca;
			return 1
		end if
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
end if 
end event

type cb_2 from commandbutton within w_gtepuf005
integer x = 279
integer y = 12
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Query"
end type

event clicked;if cbx_1.checked then
	ls_appr_ind = 'Y';
else
	ls_appr_ind = 'N';
end if

if cb_2.text = "&Query" then
	if dw_1.modifiedcount() > 0 or dw_2.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	lb_query = true
	lb_neworder = true
	dw_1.reset()
	dw_2.reset()
   	cb_3.enabled = false
  	cb_5.enabled = false
	cb_7.enabled = false
	cb_8.enabled = false
	cb_9.enabled = false
	cb_1.enabled = false
	dw_1.settaborder('hopi_id',5)
	dw_1.settaborder('hopi_date',7)
	dw_1.settaborder('hopi_desc',10)
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('hopi_id')
	cb_2.text = "&Run"
	cb_3.enabled = false
else
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user,ls_appr_ind)
 	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
   	cb_5.enabled = true
   	cb_7.enabled = true
   	cb_8.enabled = true
   	cb_9.enabled = true
	cb_1.enabled = true
	dw_1.settaborder('hopi_id',0)
	dw_1.settaborder('hopi_date',0)	
end if
lb_neworder = false

end event

type cb_1 from commandbutton within w_gtepuf005
integer x = 14
integer y = 12
integer width = 265
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&New"
end type

event clicked;if lb_neworder = false then
	if dw_1.modifiedcount() > 0 then
		if messagebox("Confirmation","Row has been modified, Do You Want To Add New Record ...!",question!,yesno!,1) = 2 then
			return
		end if
	end if
	dw_1.reset()
	dw_2.reset()
end if
///check Purchase invoice for previous date A/c posting	
//	select distinct 'x' into :ls_temp from fb_hopurchaseinvoice
//	where  trunc(HOPI_DATE) < trunc(sysdate) and nvl(HOPI_VOU_NO,'N')='N' ;
//	
//	if sqlca.sqlcode = -1 then 
//	      messagebox('Sql Error','Error During check Purchase invoice for previous date A/c posting : '+sqlca.sqlerrtext)
//	      return 1
//	elseif sqlca.sqlcode = 0 then 
//	     messagebox('Error','Previous Date Purchase invoice Already Available for  A/c Posting : ')
//		return 1
//	end if;	
//
dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false


if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	//dw_1.setitem(dw_1.getrow(),'hopi_date',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'hopi_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'hopi_entry_dt',datetime(today()))
	dw_1.setcolumn('hopi_date')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	//dw_1.setitem(dw_1.getrow(),'hopi_date',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'hopi_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'hopi_entry_dt',datetime(today()))
	dw_1.setcolumn('hopi_date')
end if
cb_1.enabled = false

end event

type dw_1 from datawindow within w_gtepuf005
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer x = 18
integer y = 120
integer width = 4512
integer height = 880
integer taborder = 30
string dataobject = "dw_gtepuf005"
boolean hscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'hopi_entry_by',gs_user)
		dw_1.setitem(newrow,'hopi_entry_dt',datetime(today()))
		dw_1.setcolumn('hopi_desc')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if dwo.name = 'hopi_desc' and lb_query = false then
	ld_hopi_dt = dw_1.getitemdatetime(row,'hopi_date')
	
	select distinct 'x' into :ls_temp from fb_hopurchaseinvoice	where  trunc(HOPI_DATE) < trunc(:ld_hopi_dt) and nvl(HOPI_VOU_NO,'N')='N' ;
	
	if sqlca.sqlcode = -1 then 
	      messagebox('Sql Error','Error During check Purchase invoice for previous date A/c posting : '+sqlca.sqlerrtext)
	      return 1
	elseif sqlca.sqlcode = 0 then 
	     messagebox('Error','Previous Date Purchase invoice Already Available for  A/c Posting : ')
		return 1
	end if;	
	select max(DS_DATE) into :ld_stock_dt from fb_daily_stock;
	
	 if date(ld_hopi_dt) < date(ld_stock_dt) then
		MESSAGEBOX('Error:','The Purchase invoice date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy'))
		return 1;
	end if;	

	
	if lb_neworder = true and dw_2.rowcount() = 0 then		
		dw_2.setfocus()
		dw_2.insertrow(0)
		dw_1.setfocus()
		dw_1.setcolumn('hopi_desc')		
	end if;	
end if

if dwo.name = 'hopi_date'   then
	ld_hopi_dt = datetime(data)
	select distinct 'x' into :ls_temp from fb_hopurchaseinvoice	where  trunc(HOPI_DATE) < trunc(:ld_hopi_dt) and nvl(HOPI_VOU_NO,'N')='N' ;
	
	if sqlca.sqlcode = -1 then 
	      messagebox('Sql Error','Error During check Purchase invoice for previous date A/c posting : '+sqlca.sqlerrtext)
	      return 1
	elseif sqlca.sqlcode = 0 then 
	     messagebox('Error','Previous Date Purchase invoice Already Available for  A/c Posting : ')
		return 1
	end if;	
	
	
	select distinct 'x' into :ls_temp from fb_hopurchaseinvoice a, fb_indent b where a.indent_id = b.indent_id and trunc(indent_date) >= to_date('01/07/2020','dd/mm/yyyy') and HOPI_VOU_NO is not null and nvl(hopi_mail_ind,'N')='N' ;
	
	if sqlca.sqlcode = -1 then 
	      messagebox('Sql Error','Error During check Purchase invoice for Mailing Status : '+sqlca.sqlerrtext)
	      return 1
	elseif sqlca.sqlcode = 0 then 
//	     messagebox('Error','Previous date Purchase invoice already available for sending HO')
//		return 1
messagebox('Warning','Previous date Purchase invoice already available for sending HO Kindly Send')
	end if;	
	
	
	select max(DS_DATE) into :ld_stock_dt from fb_daily_stock;
	
	 if date(ld_hopi_dt) < date(ld_stock_dt) then
		MESSAGEBOX('Error:','The Purchase invoice date Should be greater than equal to Last Stock Transaction Date i.e. '+string(ld_stock_dt,'dd/mm/yyyy'))
		return 1;
	end if;	

	 if date(ld_hopi_dt) > date(today()) then
		MESSAGEBOX('Error:','The Purchase invoice date Should be Less than equal to Current System Date i.e. '+string(today(),'dd/mm/yyyy'))
		return 1;
	end if;
	
	select max(hopi_date) into :ld_date from fb_hopurchaseinvoice;  		
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Maximum Purchase Invoice Date',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
	
	if ld_date > datetime(data) then
		messagebox('Warning!','Purchase Invoice Date Should Be >= '+string(ld_date,'dd/mm/yyyy')+', Please Check !!!')
		return 1
	end if
end if;	

if dwo.name = 'indent_id' or dwo.name = 'ho_po_id' then
	if dwo.name = 'indent_id' then ls_indent_id = data ;
	if dwo.name = 'ho_po_id' then 
		select indent_id into :ls_indent_id from fb_hopo_import where po_id = :data;
		if sqlca.sqlcode = -1 then
			messagebox('Error','Error occured while selecting Indent ID from HOPO Import table : '+sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning','No such PO found in table')
			rollback using sqlca;
			return 1
		end if
		dw_1.setitem(row,'indent_id',ls_indent_id)
	end if
	
	dw_2.reset()
	if lb_neworder = true and dw_2.rowcount() = 0 then
		dw_2.setfocus()
		dw_2.insertrow(0)
		dw_1.setfocus()
	end if
	select distinct indent_id into :ls_temp from fb_indentdetails  
	where indent_id=:ls_indent_id and (inddet_quantity>(nvl(inddet_receivedquantity,0)+nvl(INDDET_CANCELQUANTITY,0)));
	
	if sqlca.sqlcode = -1 then 
	      messagebox('Sql Error','Error During Getting Indent ID  : '+sqlca.sqlerrtext)
	      rollback using sqlca;
	      return 1
	elseif sqlca.sqlcode = 100 then 
	     messagebox('Error','Indent ID Not Available In Indent Master or Indent has been recieved completely : '+sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if;	
	
	idw_prod.SetFilter ("indent_id = '"+trim(ls_indent_id)+"'") 
	idw_prod.filter( )

end if;

if dwo.name = 'sup_id'  or dwo.name = 'sup_id_1' then
	ls_sup_id = data
	
//	select SUP_ADD into :ls_temp from fb_supplier  where SUP_ID = :ls_sup_id and ACSUBLEDGER_ID is not null;
	
	select SUP_ADD, SUP_GSTN_STCD, SUP_GSTNNO into :ls_temp, :ls_iss_locn, :ls_iss_gstnno from fb_supplier  where SUP_ID = :ls_sup_id;
	
	if sqlca.sqlcode = -1 then
		messagebox('Error During Select Of Supplier Address',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode = 100 then
		messagebox('Warning!','Address Or GSTIN For The Supplier Is Blank, Please Update First !!!')
//		rollback using sqlca;
//		return 1
	end if
		if isnull(ls_iss_locn) or len(ls_iss_locn) = 0 then
			messagebox('Warning!','GSTIN State Of The Supplier Is Blank, Please Update First !!!')
			rollback using sqlca;
			return 1
		end if
		if isnull(ls_iss_gstnno) or len(ls_iss_gstnno) = 0 then
			messagebox('Warning!','GSTIN No Of The Supplier Is Blank, Please Update First !!!')
			//dw_1.setitem(row,'hopi_rev_chrg','Yes')
		end if		
//	end if	
	dw_1.setitem(row,'hopi_iss_locn',ls_iss_locn)
	dw_1.setitem(row,'hopi_rec_locn',gs_gstn_stcd)	
	
	dw_1.setitem(row,'sup_add',ls_temp)	
	ls_iss_locn = dw_1.getitemstring(row,'hopi_iss_locn')
	ls_rec_locn = dw_1.getitemstring(row,'hopi_rec_locn')
	
	if isnull(ls_iss_locn) or len(ls_iss_locn) = 0 or isnull(ls_rec_locn) or len(ls_rec_locn) = 0 then
		messagebox('Warning !!!','Please Check Issue And Receiving Location !!!')
		return 1
	end if		
end if;	

if dwo.name = 'appr_flag' then
	if data = 'N' or isnull(data) then
		cb_6.enabled = false
	end if
end if

if dwo.name = 'hopi_mail_ind' then
	if data = 'Y' then
		wf_mail(dw_1.getitemstring(row,'hopi_id'))
	end if
end if

if dwo.name = 'hopi_rcno' then
	if f_check_special_char_2(data) = -1 then return 1;
end if

dw_1.setitem(row,'hopi_entry_by',gs_user)
dw_1.setitem(row,'hopi_entry_dt',datetime(today()))
                                                                         
 if dwo.name = 'hopi_freight' or dwo.name = 'hopi_insurance' or  dwo.name = 'hopi_otheramo' then
	wf_cal_netamt(dwo.name,double(data))
 end if 
if dwo.name <> 'appr_flag' then
	cb_3.enabled = true
end if
end event

event rowfocuschanged;if lb_query = false then
	if lb_neworder = false  then
		if dw_1.rowcount() > 0 then
			dw_2.reset()
			dw_2.retrieve(dw_1.getitemstring(dw_1.getrow(),'hopi_id'))
			
			idw_prod.settransobject(sqlca)
			if not isnull(dw_1.getitemstring(dw_1.getrow(),'indent_id')) then
				idw_prod.SetFilter ("indent_id = '"+trim(dw_1.getitemstring(dw_1.getrow(),'indent_id'))+"'") 
				idw_prod.retrieve( ) 
			end if
		end if
	end if
end if

end event

