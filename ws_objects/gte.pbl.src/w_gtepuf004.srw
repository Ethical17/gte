$PBExportHeader$w_gtepuf004.srw
forward
global type w_gtepuf004 from window
end type
type cb_11 from commandbutton within w_gtepuf004
end type
type cb_10 from commandbutton within w_gtepuf004
end type
type pb_1 from picturebutton within w_gtepuf004
end type
type cb_6 from commandbutton within w_gtepuf004
end type
type cb_5 from commandbutton within w_gtepuf004
end type
type cb_7 from commandbutton within w_gtepuf004
end type
type cb_8 from commandbutton within w_gtepuf004
end type
type cb_9 from commandbutton within w_gtepuf004
end type
type cb_4 from commandbutton within w_gtepuf004
end type
type cb_3 from commandbutton within w_gtepuf004
end type
type cb_2 from commandbutton within w_gtepuf004
end type
type cb_1 from commandbutton within w_gtepuf004
end type
type dw_1 from datawindow within w_gtepuf004
end type
type dw_2 from datawindow within w_gtepuf004
end type
type dw_3 from datawindow within w_gtepuf004
end type
end forward

global type w_gtepuf004 from window
integer width = 4731
integer height = 2108
boolean titlebar = true
string title = "(W_gtepuf004) H.O. Purchase Indent "
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_11 cb_11
cb_10 cb_10
pb_1 pb_1
cb_6 cb_6
cb_5 cb_5
cb_7 cb_7
cb_8 cb_8
cb_9 cb_9
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
end type
global w_gtepuf004 w_gtepuf004

type variables
long ll_last,ll_cnt,ll_ctr
string ls_tmp_id,ls_cons,ls_spc_id,ls_filename
boolean lb_neworder, lb_query
double ld_cur_stock,ld_recpt_qnty,ld_budget_qnty,ld_lmonth_con,ld_ind_qnty,ld_fyind_qnty,ld_fyindcncl_qnty	
datetime ld_inddt 
datawindowchild idw_prod
datetime ld_dt, ld_date
integer li_temp, li_temp1

string ls_sender,ls_mail,ls_recipient,ls_cc,ls_bcc,ls_subject,ls_ack_ind,ls_message,ls_addattachment,ls_dt, ls_addattachment2, ls_body_text, ls_signature,ls_frdt,ls_file1
boolean lb_flag
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_cal_datediff (datetime fd_frdt, datetime fd_todt)
public function integer wf_check_duplicate_rec (string fs_con_id)
end prototypes

event ue_option();choose case gs_ueoption
	case "PRINT"
			OpenWithParm(w_print,this.dw_3)
	case "PRINTPREVIEW"
			this.dw_3.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
			this.dw_3.modify("datawindow.print.preview = no")
	case "ZOOM"
			SetPointer (HourGlass!)											
			OpenwithParm (w_zoom,dw_3)
			SetPointer (Arrow!)						
	case "SAVEAS"
			this.dw_3.saveas()
	case "FILTER"
			setnull(gs_filtertext)
			this.dw_3.setredraw(false)
			this.dw_3.setfilter(gs_filtertext)
			this.dw_3.filter()
			this.dw_3.groupcalc()
			if this.dw_3.rowcount() > 0 then;
				this.dw_3.setredraw(true)
			else
				Messagebox('Warning','Data Not Available In Given Criteria')
			end if
	case "SORT"
			setnull(gs_sorttext)
			this.dw_3.setredraw(false)
			this.dw_3.setsort(gs_sorttext)
			this.dw_3.sort()
			this.dw_3.groupcalc()
			if this.dw_3.rowcount() > 0 then;
				this.dw_3.setredraw(true)
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
	    isnull(dw_2.getitemnumber(fl_row,'inddet_quantity')) or dw_2.getitemnumber(fl_row,'inddet_quantity') = 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Product, Indent Quantity, Please Check !!!')
		 return -1
	end if
end if
return 1

end function

public function integer wf_cal_datediff (datetime fd_frdt, datetime fd_todt);double ld_hrs1

select round(((:fd_todt - :fd_frdt) * 24),2) into :ld_hrs1 from dual;

return ld_hrs1
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

on w_gtepuf004.create
this.cb_11=create cb_11
this.cb_10=create cb_10
this.pb_1=create pb_1
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_7=create cb_7
this.cb_8=create cb_8
this.cb_9=create cb_9
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.Control[]={this.cb_11,&
this.cb_10,&
this.pb_1,&
this.cb_6,&
this.cb_5,&
this.cb_7,&
this.cb_8,&
this.cb_9,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.dw_2,&
this.dw_3}
end on

on w_gtepuf004.destroy
destroy(this.cb_11)
destroy(this.cb_10)
destroy(this.pb_1)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_7)
destroy(this.cb_8)
destroy(this.cb_9)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
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

//this.tag = Message.StringParm
//ll_user_level = long(this.tag)

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

type cb_11 from commandbutton within w_gtepuf004
integer x = 1440
integer y = 8
integer width = 416
integer height = 100
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&SYNC TO HO"
end type

event clicked;string ls_indent_no
integer li_filenum, li_rec, li_ctr
long ll_pos
li_ctr=0;
setpointer(hourglass!) 
setnull(ls_indent_no)


	
if MessageBox("Send To HO", 'Do You Want To Send This Document ....?' ,Exclamation!, YesNo!, 1) = 1 then

	ls_indent_no=dw_1.getitemstring(dw_1.getrow(),'indent_id')
	
	
	declare p2 procedure for up_indent_garden_ho_merge(:gs_unit,:ls_indent_no);
		if sqlca.sqlcode = -1 then
			messagebox('SQL Error: During Procedure Declare of up_indent_garden_ho_merge',sqlca.sqlerrtext)					
			return 1
		end if

		execute p2;
		if sqlca.sqlcode = -1 then
			messagebox('SQL Error: During Procedure Execute of up_indent_garden_ho_merge',sqlca.sqlerrtext)
			return 1
		end if	

		
	dw_3.settransobject(sqlca)
	dw_3.retrieve('A','1',ls_indent_no,ls_dt,'Y')
				
	if dw_3.rowcount() = 0 then
			messagebox('Alert!','No data found between the entered dates !!!')
			return 1
	end if
					
					
	ls_filename=ls_indent_no
	if pos(ls_filename,"/") > 0 then
		do while pos(ls_filename,"/") > 0
			ls_filename = replace(ls_filename,pos(ls_filename,"/"),1,""); 
		loop
	end if;
					
	ls_file1 = "c:\temp\"+gs_garden_snm+"_Indnet "+ls_filename+".pdf"
	li_temp1 = dw_3.saveas(ls_file1,pdf!,true)
					
	if(li_temp1=-1) then 
		messagebox('Error','Error occured while saving PDF')
		return 1
	end if	
					
	select MD_SEND_BY, MD_TO, MD_CC, MD_BCC, MD_SUBJECT, MD_DETAIL, MD_SIGNATURE into :ls_sender, :ls_recipient, :ls_cc, :ls_bcc, :ls_subject, :ls_body_text, :ls_signature from FB_MAIL_MESSAGE_DETAIL where nvl(MD_EMAIL_IND,'N') = 'Y' and MD_MESS_ID = 4 ;
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
					
	ls_cc += gs_garden_mail
					
					
					
	ls_subject 	 = ls_subject +" "+ string(today())+" "+ gs_garden_nm
					
	ls_message	= "Dear Sir/Madam, "+gs_lfcr+gs_lfcr+ls_body_text +"  "+ gs_garden_nm +"  "+ " garden . Indent No. "+ ls_indent_no +gs_lfcr+gs_lfcr 
	ls_message	 = ls_message +gs_lfcr+"Your kind attention is required."+gs_lfcr					
	ls_message	 = ls_message +gs_lfcr+"Administrator"+gs_lfcr					
	ls_message	 = ls_message +gs_lfcr+gs_lfcr+gs_garden_nm+gs_lfcr+gs_garden_add+gs_lfcr+gs_lfcr			
	ls_message += ls_signature
	ls_addattachment = ls_file1
	n_web_mail lnvo_mail
	lnvo_mail = Create n_web_mail
	lb_flag = lnvo_mail.of_send_webmail_single(ls_sender,ls_recipient,ls_cc,ls_subject,ls_message,ls_bcc,ls_addattachment)
					
				
	setpointer(arrow!) 		
	messagebox('Confirmation','Total No Of Records : '+string(li_ctr))	
	dw_1.reset()
	dw_2.reset()
	return 1
end if	


end event

type cb_10 from commandbutton within w_gtepuf004
boolean visible = false
integer x = 1445
integer y = 12
integer width = 366
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Send To HO"
end type

event clicked;string ls_hindent,ls_indent, ls_indentdate, ls_desc, ls_active, ls_delvtype, ls_rcno, ls_rcdate, ls_hlflag,ls_entry, ls_entrydt, ls_unitid,ls_spid, ls_rec,ls_excessind,ls_sp_name,ls_indent_no
double ld_indqnty,ld_recvqnty,ld_cnclqnty,ld_stkinhand,ls_lastmonthcons,ld_budgetqty,ld_indentrecvtodt
integer li_filenum, li_rec, li_ctr
long ll_pos

string ls_indentdet,ls_spname,ls_remark,ls_indentreqdate,ls_purpose,ls_jsonstr,ls_itemliststr,lshdrstr,ls_responsestring 

li_ctr=0;
setpointer(hourglass!) 

setnull(ls_hindent);setnull(ls_indent);setnull(ls_indentdate);setnull(ls_desc);setnull(ls_active);setnull(ls_delvtype);setnull(ls_rcno);setnull(ls_rcdate);
setnull(ls_hlflag);setnull(ls_entry);setnull(ls_entrydt);setnull(ls_unitid);

setnull(ls_indent_no)


	
if MessageBox("Send To HO", 'Do You Want To Send This Document ....?' ,Exclamation!, YesNo!, 1) = 1 then

ls_indent_no=dw_1.getitemstring(dw_1.getrow(),'indent_id')

		DECLARE c1 CURSOR FOR
		
		select INDENT_ID,to_char(INDENT_DATE,'dd-mon-yyyy') INDENT_DATE,INDENT_DESC,INDENT_ACTIVE,INDENT_DELIVERYTYPE,INDENT_RCNO,to_char(INDENT_RCDATE,'dd-mon-yyyy') INDENT_RCDATE,
				 INDENT_HOLOCALFLAG,INDENT_ENTRY_BY,to_char(INDENT_ENTRY_DT,'dd-mon-yyyy') INDENT_ENTRY_DT,b.UNIT_ID
		 from fb_indent a,(select UNIT_ID, UNIT_NAME from  fb_gardenmaster where UNIT_ACTIVE_IND='Y') b  where INDENT_HOLOCALFLAG='1' and INDENT_ROSEND_DT is null and indent_id=:ls_indent_no; 
		
		 open c1;
		
		 if sqlca.sqlcode = 0 then
			
			lshdrstr  = '{'
			fetch c1 into :ls_indent,:ls_indentdate, :ls_desc, :ls_active, :ls_delvtype, :ls_rcno, :ls_rcdate, :ls_hlflag,:ls_entry, :ls_entrydt, :ls_unitid;
		
			do while sqlca.sqlcode <> 100		        
				ls_hindent = ls_indent
				if isnull(ls_indent) then 
					ls_indent = 'null';
				else
					ls_indent = '"'+ls_indent+'"'
				end if
				
				if isnull(ls_indentdate) then 
					ls_indentdate = 'null';
				else
					ls_indentdate = '"'+ls_indentdate+'"'
				end if
				
				if isnull(ls_desc) then 
					ls_desc = 'null';
				else
					ls_desc = '"'+ls_desc+'"'
				end if
				
				if isnull(ls_active) then 
					ls_active = 'null';
				else
					ls_active = '"'+ls_active+'"'
				end if
				
				if isnull(ls_delvtype) then 
					ls_delvtype = 'null';
				else
					ls_delvtype = '"'+ls_delvtype+'"'
				end if
				
				if isnull(ls_rcno) then 
					ls_rcno = 'null';
				else
					ls_rcno = '"'+ls_rcno+'"'
				end if
				
				if isnull(ls_rcdate) then 
					ls_rcdate = 'null';
				else
					ls_rcdate = '"'+ls_rcdate+'"'
				end if
				
				if isnull(ls_hlflag) then 
					ls_hlflag = 'null';
				else
					ls_hlflag = '"'+ls_hlflag+'"'
				end if
				
				if isnull(ls_entry) then 
					ls_entry = 'null';
				else
					ls_entry = '"'+ls_entry+'"'
				end if
				
				if isnull(ls_entrydt) then 
					ls_entrydt = 'null';
				else
					ls_entrydt = '"'+ls_entrydt+'"'
				end if
				
				if isnull(ls_unitid) then 
					ls_unitid = 'null';
					
					messagebox('Error','Error occured while getting garden ID')
					return 1
				else
					ls_unitid = '"'+ls_unitid+'"'
				end if
				
				lshdrstr = lshdrstr + '"INDENT_ID": '+ls_indent+','
				lshdrstr = lshdrstr + '"INDENT_DATE": '+ls_indentdate+','
				lshdrstr = lshdrstr + '"INDENT_DESC": '+ls_desc+','
				lshdrstr = lshdrstr + '"INDENT_ACTIVE": '+ls_active+','
				lshdrstr = lshdrstr + '"INDENT_DELIVERYTYPE": '+ls_delvtype+','
				lshdrstr = lshdrstr + '"INDENT_RCNO": '+ls_rcno+','
				lshdrstr = lshdrstr + '"INDENT_RCDATE": '+ls_rcdate+','
				lshdrstr = lshdrstr + '"INDENT_HOLOCALFLAG": '+ls_hlflag+','
				lshdrstr = lshdrstr + '"INDENT_ENTRY_BY": '+ls_entry+','
				lshdrstr = lshdrstr + '"INDENT_ENTRY_DT": '+ls_entrydt+','
				lshdrstr = lshdrstr + '"UNIT_ID": '+ls_unitid+','
				lshdrstr = lshdrstr + '"SENDBY":  "'+gs_user+'",'
				
					 
				setnull(ls_rec);setnull(ls_spid);setnull(ls_sp_name); setnull(ls_excessind);ld_indqnty = 0; ld_recvqnty = 0; ld_cnclqnty = 0;
				setnull(ls_indentdet);setnull(ls_spname);setnull(ls_remark);setnull(ls_indentreqdate);setnull(ls_purpose);ld_stkinhand=0;ls_lastmonthcons=0;ld_budgetqty=0;ld_indentrecvtodt=0;
				lshdrstr = lshdrstr +  '"ItemList":   ['
				DECLARE c2 CURSOR FOR
				  
					select INDENT_ID,a.SP_ID,SP_NAME,INDDET_QUANTITY,INDDET_RECEIVEDQUANTITY,INDENT_STOCKINHAND,INDENT_LASTMONTHCONS,INDENT_BUDGETQUANTITY,
								INDENT_RECEIVEDTODATE,INDDET_REMARKS,to_char(INDDET_REQDATE,'dd-mon-yyyy') INDDET_REQDATE,INDDET_PURPOSE,INDDET_CANCELQUANTITY, nvl(INDDET_EXCESS_QNTY,'N') INDDET_EXCESS_QNTY 
					from fb_indentdetails a,fb_storeproduct b where a.SP_ID = b.SP_ID and INDENT_Id=:ls_hindent;
				  
				 open c2;
				 
				if sqlca.sqlcode = -1 then
					messagebox('Error','Error occured while opening cursor c2 : '+sqlca.sqlerrtext)
					rollback using sqlca;
					return -1
				elseif sqlca.sqlcode = 0 then					
					fetch c2 into :ls_indentdet,:ls_spid,:ls_sp_name,:ld_indqnty,:ld_recvqnty,:ld_stkinhand,:ls_lastmonthcons,:ld_budgetqty,:ld_indentrecvtodt,:ls_remark,:ls_indentreqdate,:ls_purpose,:ld_cnclqnty,:ls_excessind;
				
					do while sqlca.sqlcode <> 100 
				
					
					lshdrstr = lshdrstr + '{'
					
							if isnull(ls_indentdet) then 
								ls_indentdet = 'null';
							else
								ls_indentdet = '"'+ls_indentdet+'"'
							end if
							
							if isnull(ls_spid) then 
								ls_spid = 'null';
							else
								ls_spid = '"'+ls_spid+'"'
							end if
							
							if isnull(ls_sp_name) then 
								ls_sp_name = 'null';
							else
								ls_sp_name = '"'+ls_sp_name+'"'
							end if
							
							if isnull(ls_excessind) then 
								ls_excessind = 'null';
							else
								ls_excessind = '"'+ls_excessind+'"'
							end if
							
							if isnull(ld_indqnty) then 
								ld_indqnty = 0;
							end if
							
							if isnull(ld_stkinhand) then 
								ld_stkinhand = 0;
							end if
							
							if isnull(ls_lastmonthcons) then 
								ls_lastmonthcons = 0;
							end if
						
							if isnull(ld_recvqnty) then 
								ld_recvqnty = 0;
							end if
							
							if isnull(ld_cnclqnty) then 
								ld_cnclqnty = 0;
							end if
							
							if isnull(ld_budgetqty) then 
								ld_budgetqty = 0;
							end if
							
							if isnull(ld_indentrecvtodt) then 
								ld_indentrecvtodt = 0;
							end if
							
							if isnull(ls_remark) then 
								ls_remark = 'null';
							else
								ls_remark = '"'+ls_remark+'"'
							end if
							
							if isnull(ls_indentreqdate) then 
								ls_indentreqdate = 'null';
							else
								ls_indentreqdate = '"'+ls_indentreqdate+'"'
							end if
							
							if isnull(ls_purpose) then 
								ls_purpose = 'null';
							else
								ls_purpose = '"'+ls_purpose+'"'
							end if
						
						
							lshdrstr = lshdrstr + '"INDENT_ID": '+ls_indentdet+','
							lshdrstr = lshdrstr + '"SP_ID": '+ls_spid+','
							lshdrstr = lshdrstr + '"SP_NAME": '+ls_sp_name+','
							lshdrstr = lshdrstr + '"INDDET_QUANTITY": '+string(ld_indqnty) + ','
							lshdrstr = lshdrstr + '"INDDET_RECEIVEDQUANTITY": '+string(ld_recvqnty)+','
							lshdrstr = lshdrstr + '"INDENT_STOCKINHAND": '+string(ld_stkinhand)+','
							lshdrstr = lshdrstr + '"INDENT_LASTMONTHCONS": '+string(ls_lastmonthcons)+','
							lshdrstr = lshdrstr + '"INDENT_BUDGETQUANTITY": '+string(ld_budgetqty)+','
							lshdrstr = lshdrstr + '"INDENT_RECEIVEDTODATE": '+string(ld_indentrecvtodt)+','
							lshdrstr = lshdrstr + '"INDDET_REMARKS": '+ls_remark+','
							lshdrstr = lshdrstr + '"INDDET_REQDATE": '+ls_indentreqdate+','
							lshdrstr = lshdrstr + '"INDDET_PURPOSE": '+ls_purpose+','
							lshdrstr = lshdrstr + '"INDDET_CANCELQUANTITY": '+string(ld_cnclqnty)+','
							lshdrstr = lshdrstr + '"INDDET_EXCESS_QNTY": '+ls_excessind+''
						
						
							lshdrstr = lshdrstr + '},'	
							
						setnull(ls_rec);setnull(ls_spid);setnull(ls_sp_name); setnull(ls_excessind);ld_indqnty = 0; ld_recvqnty = 0; ld_cnclqnty = 0;
						setnull(ls_indentdet);setnull(ls_spname);setnull(ls_remark);setnull(ls_indentreqdate);setnull(ls_purpose);ld_stkinhand=0;ls_lastmonthcons=0;ld_budgetqty=0;ld_indentrecvtodt=0;
							
				  
					fetch c2 into :ls_indentdet,:ls_spid,:ls_sp_name,:ld_indqnty,:ld_recvqnty,:ld_stkinhand,:ls_lastmonthcons,:ld_budgetqty,:ld_indentrecvtodt,:ls_remark,:ls_indentreqdate,:ls_purpose,:ld_cnclqnty,:ls_excessind;
					
					loop
					
					close c2;
					
					lshdrstr = mid(lshdrstr,1,len(lshdrstr)-1);	
					lshdrstr =  lshdrstr + ']'
				else
					messagebox('Error: During Opening of Cursor c2',sqlca.sqlerrtext)
					return 1
				end if
				li_ctr++					
				
				setnull(ls_hindent);setnull(ls_indent);setnull(ls_indentdate);setnull(ls_desc);setnull(ls_active);setnull(ls_delvtype);setnull(ls_rcno);setnull(ls_rcdate);
				setnull(ls_hlflag);setnull(ls_entry);setnull(ls_entrydt);setnull(ls_unitid);
			
		  fetch c1 into :ls_indent,:ls_indentdate, :ls_desc, :ls_active, :ls_delvtype, :ls_rcno, :ls_rcdate, :ls_hlflag,:ls_entry, :ls_entrydt, :ls_unitid; 
		 
		  loop
		
		lshdrstr = lshdrstr + '}'
		close c1;
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning:' ,'No Data Found')
			return 1
		else 
			messagebox('Error: During Opening of Cursor',sqlca.sqlerrtext)
			return 1
		end if
		
		if(len(lshdrstr)=2) then
			messagebox('Warning:' ,'No Data Found')
			return 1
		end if
		
		ls_jsonstr = lshdrstr
		
		if fileexists("c:\temp\"+"a"+string(today(),"_ddmmyy_")+string(now(),"hhmmss")+".json") = true then
			filedelete("c:\temp\"+"a"+string(today(),"-ddmmyy_")+string(now(),"hhmmss")+".json")
		end if
		
		string ls_file = "c:\temp\"+"a"+string(today(),"_ddmmyy_")+string(now(),"hhmmss")+".json"
		
		li_filenum =  fileopen(ls_file,linemode!,write!,lockreadwrite!,replace!)
		
		ls_rec = ls_jsonstr
		
		
		filewriteex(li_filenum,ls_rec)
		fileclose(li_filenum) 
		///// API CALL
		
		HttpClient lnv_HttpClient
		lnv_HttpClient = Create HttpClient
		integer li_rc, li_StatusCode
			
		lnv_HttpClient.SetRequestHeader("Content-Type", "application/json;charset=UTF-8")		
		li_rc = lnv_HttpClient.SendRequest("POST", "https://luxmitea.com/PTUAPI/api/indent",ls_jsonstr,EncodingUTF8!)
		//li_rc = lnv_HttpClient.SendRequest("POST", "http://localhost:56833/api/indent",ls_jsonstr,EncodingUTF8!)
				
		if li_rc = 1 then
			 // Obtain the response status
				 li_StatusCode = lnv_HttpClient.GetResponseStatusCode()
				 if li_StatusCode = 200 then
					
					update fb_indent set INDENT_ROSEND_DT = sysdate where indent_id=:ls_indent_no;
					
					if sqlca.sqlcode = -1 then
						messagebox('Error: During Update Send Date',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
					commit using sqlca;
					
					
					ls_frdt = string(today(),'dd/mm/yyyy')

					select to_char(to_date((decode(sign(to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'mm')) - 4),-1,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy'))-1,to_number(to_char(to_date(:ls_frdt,'dd/mm/yyyy'),'yyyy')))||'0401'),'yyyymmdd'),'dd/mm/yyyy') 
					into :ls_dt
					from dual;
					
					
					
					dw_3.settransobject(sqlca)
					
					dw_3.retrieve('A','1',ls_indent_no,ls_dt,'Y')
				
					if dw_3.rowcount() = 0 then
						messagebox('Alert!','No data found between the entered dates !!!')
						return 1
					end if
					
					
					ls_filename=ls_indent_no
					if pos(ls_filename,"/") > 0 then
						do while pos(ls_filename,"/") > 0
				 		ls_filename = replace(ls_filename,pos(ls_filename,"/"),1,""); 
						loop
					end if;
					
					ls_file1 = "c:\temp\"+gs_garden_snm+"_Indnet "+ls_filename+".pdf"
					li_temp1 = dw_3.saveas(ls_file1,pdf!,true)
					
					if(li_temp1=-1) then 
						messagebox('Error','Error occured while saving PDF')
						return 1
					end if	
					
					select MD_SEND_BY, MD_TO, MD_CC, MD_BCC, MD_SUBJECT, MD_DETAIL, MD_SIGNATURE into :ls_sender, :ls_recipient, :ls_cc, :ls_bcc, :ls_subject, :ls_body_text, :ls_signature from FB_MAIL_MESSAGE_DETAIL where nvl(MD_EMAIL_IND,'N') = 'Y' and MD_MESS_ID = 4 ;
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
					
					ls_cc += gs_garden_mail
					
					
					
					ls_subject 	 = ls_subject +" "+ string(today())+" "+ gs_garden_nm
					
					ls_message	= "Dear Sir/Madam, "+gs_lfcr+gs_lfcr+ls_body_text +"  "+ gs_garden_nm +"  "+ " garden . Indent No. "+ ls_indent_no +gs_lfcr+gs_lfcr 
					ls_message	 = ls_message +gs_lfcr+"Your kind attention is required."+gs_lfcr
					
					ls_message	 = ls_message +gs_lfcr+"Administrator"+gs_lfcr
					
					ls_message	 = ls_message +gs_lfcr+gs_lfcr+gs_garden_nm+gs_lfcr+gs_garden_add+gs_lfcr+gs_lfcr
					
					ls_message += ls_signature
					
					ls_addattachment = ls_file1
					n_web_mail lnvo_mail
						
					lnvo_mail = Create n_web_mail
					
					lb_flag = lnvo_mail.of_send_webmail_single(ls_sender,ls_recipient,ls_cc,ls_subject,ls_message,ls_bcc,ls_addattachment)
					
				else
					lnv_HttpClient.GetResponseBody(ls_responsestring)
					
					lb_flag = lnvo_mail.of_send_webmail_noattachment(ls_sender,'piyush@luxmigroup.in;prabhat.kumar@luxmigroup.in','','Error in Indent Post ' + gs_garden_nm,ls_responsestring,'')
					
					
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
		setpointer(arrow!) 		
		messagebox('Confirmation','Total No Of Records : '+string(li_ctr))	
		dw_1.reset()
		dw_2.reset()
		return 1
	end if	


end event

type pb_1 from picturebutton within w_gtepuf004
integer x = 1531
integer y = 776
integer width = 123
integer height = 92
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string pointer = "HyperLink!"
string picturename = "refresh.bmp"
alignment htextalign = left!
string powertiptext = "Click Here To Refress Product ID"
end type

event clicked;idw_prod.settransobject(sqlca)	
idw_prod.retrieve()
ls_spc_id = dw_2.getitemstring(dw_2.getrow(),'spc_id')
idw_prod.SetFilter ("spc_id = '"+trim(ls_spc_id)+"'") 
idw_prod.filter( )
end event

type cb_6 from commandbutton within w_gtepuf004
integer x = 1102
integer y = 12
integer width = 329
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Make CSV"
end type

event clicked;string ls_rec_ty,ls_indent, ls_indentdate, ls_desc, ls_active, ls_delvtype, ls_rcno, ls_rcdate, ls_hlflag,ls_entry, ls_entrydt, ls_unitid,ls_spid, ls_rec,ls_excessind,ls_sp_name
double ld_indqnty,ld_recvqnty,ld_cnclqnty
integer li_filenum, li_rec, li_ctr
long ll_pos

li_ctr=0;
setpointer(hourglass!) 

setnull(ls_rec_ty);setnull(ls_indent);setnull(ls_indentdate);setnull(ls_desc);setnull(ls_active);setnull(ls_delvtype);setnull(ls_rcno);setnull(ls_rcdate);
setnull(ls_hlflag);setnull(ls_entry);setnull(ls_entrydt);setnull(ls_unitid);

if fileexists("c:\temp\hoindent"+string(today(),'yyyymmdd')+".csv") = true then
	filedelete("c:\temp\hoindent"+string(today(),'yyyymmdd')+".csv")
end if
li_filenum =  fileopen("c:\temp\hoindent"+string(today(),'yyyymmdd')+".csv",linemode!,write!,lockreadwrite!,replace!)



DECLARE c1 CURSOR FOR
select 'SH',INDENT_ID, to_char(INDENT_DATE,'dd/mm/yyyy'), INDENT_DESC, INDENT_ACTIVE, INDENT_DELIVERYTYPE, 
           INDENT_RCNO, to_char(INDENT_RCDATE,'dd/mm/yyyy'), INDENT_HOLOCALFLAG, INDENT_ENTRY_BY, to_char(INDENT_ENTRY_DT,'dd/mm/yyyy'),:gs_unit 
from fb_indent 
where INDENT_HOLOCALFLAG='1' and INDENT_ROSEND_DT is null ; 

 open c1;

 if sqlca.sqlcode = 0 then
   fetch c1 into :ls_rec_ty,:ls_indent,:ls_indentdate, :ls_desc, :ls_active, :ls_delvtype, :ls_rcno, :ls_rcdate, :ls_hlflag,:ls_entry, :ls_entrydt, :ls_unitid;

	do while sqlca.sqlcode <> 100		        
		
		if isnull(ls_rec_ty) then; ls_rec_ty=""; end if;
		if isnull(ls_indent) then; ls_indent=""; end if;
		if isnull(ls_indentdate) then; ls_indentdate=""; end if;		
   		if isnull(ls_desc) then; ls_desc=""; end if;
   		if isnull(ls_active) then; ls_active=""; end if;
		if isnull(ls_delvtype) then; ls_delvtype=""; end if;
		if isnull(ls_rcno) then; ls_rcno=""; end if;
   		if isnull(ls_rcdate) then; ls_rcdate=""; end if;
		if isnull(ls_hlflag) then; ls_hlflag=""; end if;
		if isnull(ls_entry) then; ls_entry=""; end if;
		if isnull(ls_entrydt) then; ls_entrydt =""; end if;
		if isnull(ls_unitid) then; ls_unitid=""; end if;											                                                          																																									                                     

			
		ls_rec = ls_rec_ty +","
		if ls_indent="" then  ls_rec = ls_rec + "," else	ls_rec = ls_rec+ls_indent + ","
		ls_rec = ls_rec + ls_indentdate +","
		if ls_desc = "" then 
			ls_rec = ls_rec + "," 
		else
			do while pos(ls_desc,",") > 0
				ll_pos = pos(ls_desc,",") 
				ls_desc = replace(ls_desc,ll_pos,1," ")
			loop
			ls_rec = ls_rec+ls_desc + ","
		end if
		ls_rec = ls_rec + ls_active +","+ ls_delvtype +","+ ls_rcno +","+ ls_rcdate +","
		ls_rec = ls_rec + trim(ls_hlflag) +","+ trim(ls_entry) +"," 
		ls_rec = ls_rec + ls_entrydt+","+ls_unitid 
		
		filewrite(li_filenum,ls_rec)
		
		setnull(ls_rec);setnull(ls_spid);setnull(ls_sp_name); setnull(ls_excessind);ld_indqnty = 0; ld_recvqnty = 0; ld_cnclqnty = 0;//setnull(ls_indent); 
			  
		DECLARE c2 CURSOR FOR
		select 'SL', b.INDENT_ID, b.SP_ID, c.SP_NAME, INDDET_QUANTITY, INDDET_RECEIVEDQUANTITY,INDDET_CANCELQUANTITY,nvl(INDDET_EXCESS_QNTY,'N') 
          from fb_indent a,fb_indentdetails b, fb_storeproduct c 
          where a.INDENT_ID=b.INDENT_ID and b.sp_id = c.sp_id and INDENT_HOLOCALFLAG='1' and INDENT_ROSEND_DT is null and a.INDENT_ID =:ls_indent;
		  
		 open c2;
		
		 if sqlca.sqlcode = 0 then
	
			fetch c2 into :ls_rec_ty,:ls_indent,:ls_spid,:ls_sp_name,:ld_indqnty,:ld_recvqnty,:ld_cnclqnty,:ls_excessind;
		
			do while sqlca.sqlcode <> 100 
		
					if isnull(ls_rec_ty) then; ls_rec_ty=""; end if;
					if isnull(ls_indent) then; ls_indent=""; end if;
					if isnull(ls_spid) then; ls_spid=""; end if;
					if isnull(ls_sp_name) then
						ls_sp_name=""
					elseif pos(ls_sp_name,",") > 0 then
						ll_pos = pos(ls_sp_name,",") 
						ls_sp_name = replace(ls_sp_name,ll_pos,1," ")
						do while pos(ls_sp_name,",") > 0
							ll_pos = pos(ls_sp_name,",") 
							ls_sp_name = replace(ls_sp_name,ll_pos,1," ")
						loop
					end if;		
		              if isnull(ld_indqnty) then; ld_indqnty = 0; end if;
					if isnull(ld_recvqnty) then; ld_recvqnty = 0; end if;
					if isnull(ld_cnclqnty) then; ld_cnclqnty = 0; end if;
					if isnull(ls_excessind) then; ls_excessind=""; end if;			
							
				ls_rec = ls_rec_ty +","+ ls_indent +","
				ls_rec = ls_rec + ls_spid +","+  string(ls_sp_name) + "," + string(ld_indqnty) +","+ string(ld_recvqnty) +","+ string(ld_cnclqnty)+","+ string(ls_excessind)
				
				filewrite(li_filenum,ls_rec)
				
				setnull(ls_rec);setnull(ls_indent); setnull(ls_spid);setnull(ls_excessind); ld_indqnty = 0; ld_recvqnty = 0; ld_cnclqnty = 0;
        
			fetch c2 into :ls_rec_ty,:ls_indent,:ls_spid,:ls_sp_name,:ld_indqnty,:ld_recvqnty,:ld_cnclqnty,:ls_excessind;
			
			loop
			close c2;
		else
			messagebox('Error: During Opening of Cursor c2',sqlca.sqlerrtext)
			return 1
		end if
		
		update fb_indent set INDENT_ROSEND_DT = sysdate where INDENT_ID = :ls_indent;
		
		 if sqlca.sqlcode = -1 then
			messagebox('Error: During Update Send Date',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
		li_rec++
		li_ctr++
		
		setnull(ls_rec_ty);setnull(ls_indent);setnull(ls_indentdate);setnull(ls_desc);setnull(ls_active);setnull(ls_delvtype);setnull(ls_rcno);setnull(ls_rcdate);
         setnull(ls_hlflag);setnull(ls_entry);setnull(ls_entrydt);setnull(ls_unitid);
	
  fetch c1 into :ls_rec_ty,:ls_indent,:ls_indentdate, :ls_desc, :ls_active, :ls_delvtype, :ls_rcno, :ls_rcdate, :ls_hlflag,:ls_entry, :ls_entrydt, :ls_unitid;
 
   loop
	close c1;
else
	messagebox('Error: During Opening of Cursor',sqlca.sqlerrtext)
	return 1
end if

	fileclose(li_filenum)

setpointer(arrow!) 
//commit using sqlca;
messagebox('Confirmation','Total No Of Records : '+string(li_ctr))
return 1



end event

type cb_5 from commandbutton within w_gtepuf004
integer x = 3954
integer y = 20
integer width = 123
integer height = 88
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "<<"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrolltoRow(1)
end if
end event

type cb_7 from commandbutton within w_gtepuf004
integer x = 4073
integer y = 20
integer width = 123
integer height = 88
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "<"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrollPriorRow()
end if

end event

type cb_8 from commandbutton within w_gtepuf004
integer x = 4192
integer y = 20
integer width = 123
integer height = 88
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = ">"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrollnextRow()
end if
end event

type cb_9 from commandbutton within w_gtepuf004
integer x = 4311
integer y = 20
integer width = 123
integer height = 88
integer taborder = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = ">>"
end type

event clicked;if dw_1.rowcount() > 0 then
	dw_1.setcolumn('ind')
	dw_1.ScrolltoRow(dw_1.rowcount())
end if
end event

type cb_4 from commandbutton within w_gtepuf004
integer x = 809
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

type cb_3 from commandbutton within w_gtepuf004
integer x = 544
integer y = 12
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
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

if dw_2.rowcount() > 1 then
	if (isnull(dw_2.getitemstring(dw_2.rowcount(),'sp_id')) or len(dw_2.getitemstring(dw_2.rowcount(),'sp_id')) = 0) then 
		dw_2.deleterow(dw_2.rowcount())
	end if;
end if



IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	for ll_cnt = dw_2.rowcount() to 1 step -1
		if dw_2.getitemstring(ll_cnt,'del_flag') = 'Y' and dw_2.rowcount() = dw_2.getitemnumber(ll_cnt,'sel_row') then
			messagebox('Warning!','You Cannot Delete All Records From Detail Section !!!')
			return 1
		elseif dw_2.getitemstring(ll_cnt,'del_flag') = 'Y' and dw_2.rowcount() <> dw_2.getitemnumber(ll_cnt,'sel_row') then
			dw_2.deleterow(ll_cnt)
		end if
	next	
	
	if dw_2.rowcount() = 0 then
		messagebox('Error','Records Should Be Available In Detail Block')
		return
	end if

	if (isnull(dw_1.getitemstring(dw_1.getrow(),'indent_deliverytype')) or isnull(dw_1.getitemstring(dw_1.getrow(),'indent_deliverytype')) or &
		isnull(dw_1.getitemstring(dw_1.getrow(),'indent_desc'))) then
		messagebox('Warning:','One Of The Fields Are Blank : Delivery Type, Indent Description !!!')
		dw_1.setfocus()
		dw_1.setcolumn('indent_deliverytype')
		return
	end if
	
	if dw_2.rowcount() > 0 then
		for ll_ctr = 1 to dw_2.rowcount( ) 
			IF wf_check_fillcol(ll_ctr) = -1 THEN 
				return 1
			end if
		next	
	end if
	
	if lb_neworder = true then
		ll_last =0
		ld_dt = dw_1.getitemdatetime(dw_1.getrow(),'indent_date')
		if date(ld_dt) > date('31/03/2022') then
			if ll_last=0 then
				//select nvl(MAX(sn_srl_no),0) + 1 into :ll_last from fb_serial_no where sn_doc_type = 'IND' and SN_ACCT_YEAR = substr(to_char(:ld_dt,'dd/mm/yyyy'),7,4);
				ll_last = f_get_lastno('INDHO',string(ld_dt,'YYYY'))
				if ll_last <= 0 then
					messagebox('Error At Last No Getting',sqlca.sqlerrtext)
					return 1
				end if			
			end if
			
			ls_tmp_id = gs_garden_snm+'/HO/'+string(ll_last,'000000')+'-'+string(ld_dt,'YY')
			dw_1.setitem(dw_1.getrow(),'indent_id',ls_tmp_id)	
		else	
			if ll_last=0 then
				select nvl(MAX(substr(indent_id,4,10)),0) into :ll_last from fb_indent where indent_id like 'IND0%';
			end if
			ll_last = ll_last + 1
			ls_tmp_id = 'IND'+string(ll_last,'0000000000') 
			dw_1.setitem(dw_1.getrow(),'indent_id',ls_tmp_id)	
			//dw_1.setitem(dw_1.getrow(),'indent_date',datetime(today()))			
		end if


		for ll_ctr = 1 to dw_2.rowcount()
			dw_2.setitem(ll_ctr,'indent_id',ls_tmp_id)
		next
		
	ELSE
		ls_tmp_id=''
		ls_tmp_id=dw_1.getitemstring(dw_1.getrow() ,'indent_id')
		
		for ll_ctr = 1 to dw_2.rowcount()
			dw_2.setitem(ll_ctr,'indent_id',ls_tmp_id)
		next
	end if	
	if lb_neworder = true then
		Messagebox('Information!','HO Indent No Generated Is ('+ls_tmp_id+')')
	end if
	if dw_1.update(true,false) = 1 then
		if dw_2.update(true,false) = 1 then
			if dw_1.getitemstatus(dw_1.getrow(),0,primary!) = NewModified! or dw_1.getitemstatus(dw_1.getrow(),0,primary!) = New! then		
				if date(ld_dt) > date('31/03/2022') then
					if ll_last > 0 then
						///update last no
						if f_upd_lastno('INDHO',string(ld_dt,'YYYY'),ll_last) = -1 then
							rollback using sqlca;			
							return 1
						end if	
					end if
				end if
			end if
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
	
//	dw_2.update();
//	dw_1.update();
//	commit using sqlca;
//	cb_3.enabled = false
//	dw_1.reset()
//	dw_2.reset()

else
	return
end if 
end event

type cb_2 from commandbutton within w_gtepuf004
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

event clicked;if cb_2.text = "&Query" then
	if dw_1.modifiedcount() > 0 or dw_2.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	lb_query = true
	lb_neworder = true
	dw_1.settaborder('indent_id',5)
//	dw_1.settaborder('indent_date',7)
	dw_1.reset()
	dw_2.reset()
   	cb_3.enabled = false
  	cb_5.enabled = false
	cb_7.enabled = false
	cb_8.enabled = false
	cb_9.enabled = false
	cb_1.enabled = false
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('indent_id')
	cb_2.text = "&Run"
	cb_3.enabled = false
else
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user)
 	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	dw_1.settaborder('indent_id',0)
	dw_1.settaborder('indent_date',0)
   	cb_5.enabled = true
   	cb_7.enabled = true
   	cb_8.enabled = true
   	cb_9.enabled = true
	cb_1.enabled = true	
end if
lb_neworder = false

end event

type cb_1 from commandbutton within w_gtepuf004
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

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'indent_date',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'indent_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'indent_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'indent_holocalflag','1')
	dw_1.setitem(dw_1.getrow(),'INDENT_ACTIVE','1')
	dw_1.setcolumn('indent_date')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'indent_date',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'indent_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'indent_entry_dt',datetime(today()))
	dw_1.setcolumn('indent_date')
end if
cb_1.enabled = false

end event

type dw_1 from datawindow within w_gtepuf004
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer y = 116
integer width = 4654
integer height = 576
integer taborder = 30
string dataobject = "dw_gtepuf004"
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
		dw_1.setitem(newrow,'indent_entry_by',gs_user)
		dw_1.setitem(newrow,'indent_entry_dt',datetime(today()))
		dw_1.setitem(dw_1.getrow(),'indent_holocalflag','1')
		dw_1.setitem(dw_1.getrow(),'INDENT_ACTIVE','1')
	     dw_1.setcolumn('indent_deliverytype')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if dwo.name = 'indent_deliverytype' and lb_query = false then
	if lb_neworder = true and dw_2.rowcount() = 0 then
		dw_2.setfocus()
		dw_2.insertrow(0)
		dw_1.setfocus()
		dw_1.setcolumn('indent_deliverytype')		
	end if;	
end if

if dwo.name = 'indent_date'   then
	ld_dt = datetime(data)
	
	if date(ld_dt) > date(today()) then
		messagebox('Warning!','Indent Date Should Not Be > Current Date, Please Check !!!')
		return 1
	end if
	
	select max(indent_date) into :ld_date from fb_indent where INDENT_HOLOCALFLAG = '1';  		
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Maximum Indent Date',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
	
	if ld_date > ld_dt then
		messagebox('Warning!','Indent Date Should Be >= '+string(ld_date,'dd/mm/yyyy')+', Please Check !!!')
		return 1
	end if
	
end if

dw_1.setitem(row,'indent_entry_by',gs_user)
dw_1.setitem(row,'indent_entry_dt',datetime(today()))

cb_3.enabled = true

end event

event rowfocuschanged;if lb_query = false then
	if lb_neworder = false  then
		if dw_1.rowcount() > 0 then
			dw_2.reset()
			dw_2.retrieve( dw_1.getitemstring(dw_1.getrow(),'INDENT_ID'))
		end if
	end if
end if
end event

type dw_2 from datawindow within w_gtepuf004
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer y = 700
integer width = 4658
integer height = 1280
integer taborder = 40
string dataobject = "dw_gtepuf004a"
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

event itemchanged;if dwo.name = 'spc_id' then
	ls_spc_id = data
	idw_prod.SetFilter ("spc_id = '"+trim(data)+"'") 
	idw_prod.filter( )
end if


if dwo.name = 'sp_id' then
	ls_cons = data
	if  wf_check_duplicate_rec(ls_cons) = -1 then return 1	
	
	//check for Standard Item Mapping
//	 select distinct a.sp_id into :ls_cons from fb_storeproduct a  where a.SSP_ID is not null and a.SP_ID=:ls_cons;
//	   if sqlca.sqlcode = -1 then
//		messagebox('Sql Error During select  Standard Mapped Item  : ',sqlca.sqlerrtext);
//		return 1;
//	  elseif sqlca.sqlcode = 100 then	
//		messagebox('Warrning !','Standard Item Not Mapped For This Item,Please Check...!!');
//	   end if;	 	
     	
	//current stock and last month consumption Shyamguri T.E. = :gs_storeid 
	select sum(decode(ds_rec_ind,'I',-1,1)*ds_QTY) curr_stock,sum(decode(to_char(ds_date,'yyyymm'),to_char(add_months(sysdate,-1),'yyyymm'),(decode(ds_rec_ind,'I',1,0) * nvl(ds_QTY,0)),0)) last_mon_con
	    into  :ld_cur_stock,:ld_lmonth_con
	   from fb_daily_stock
	 where trunc(ds_date) <= trunc(sysdate) and ds_item_cd=:ls_cons and DS_SECTION_ID=:gs_storeid  ;
	  
	  if sqlca.sqlcode = -1 then
		messagebox('Sql Error During select  current stock  : ',sqlca.sqlerrtext);
		return 1;
	elseif sqlca.sqlcode = 0 then	
		 if isnull(ld_cur_stock) then ld_cur_stock=0		
		 if isnull(ld_lmonth_con) then ld_lmonth_con=0	
		dw_2.setitem(row,'indent_stockinhand',ld_cur_stock)
	     dw_2.setitem(row,'indent_lastmonthcons',ld_lmonth_con)
	elseif sqlca.sqlcode = 100 then	
		dw_2.setitem(row,'indent_stockinhand',0)
	     dw_2.setitem(row,'indent_lastmonthcons',0)
	end if;	 	
	
	////Total receipt Quantity for this financial year 
	select sum(decode(ds_rec_ind,'R',1,0) * ds_QTY) recv   into :ld_recpt_qnty
	   from fb_daily_stock
	 where trunc(ds_date) <= trunc(sysdate) and ds_item_cd=:ls_cons and DS_SECTION_ID= :gs_storeid  and
	            to_number(to_char(ds_date,'yyyymm')) between ((decode(sign(to_number(to_char(sysdate,'mm')) - 4),-1,to_number(to_char(sysdate,'yyyy')) -1,to_number(to_char(sysdate,'yyyy'))) * 100)+04) and 
																 		  ((decode(sign(to_number(to_char(sysdate,'mm')) - 4),-1,to_number(to_char(sysdate,'yyyy')),to_number(to_char(sysdate,'yyyy')) + 1) * 100)+03) 
	  group by ds_item_cd;
	  
     
	  if sqlca.sqlcode = -1 then
		messagebox('Sql Error During select  total receipt Quantity  : ',sqlca.sqlerrtext);
		return 1;
	elseif sqlca.sqlcode = 0 then	
		 if isnull(ld_recpt_qnty) then ld_recpt_qnty=0			
		dw_2.setitem(row,'indent_receivedtodate',ld_recpt_qnty)
	elseif sqlca.sqlcode = 100 then	
		dw_2.setitem(row,'indent_receivedtodate',0)
	end if;	 			
	
	
	  ////current Budget quantity
//	select sum(nvl(MSB_JANQUANTITY,0)+nvl(MSB_FEBQUANTITY,0)+nvl(MSB_MARQUANTITY,0)+nvl(MSB_APRQUANTITY,0)+nvl(MSB_MAYQUANTITY,0)+nvl(MSB_JUNQUANTITY,0)+
//	   			   nvl(MSB_JULQUANTITY,0)+nvl(MSB_AUGQUANTITY,0)+nvl(MSB_SEPQUANTITY,0)+nvl(MSB_OCTQUANTITY,0)+nvl(MSB_NOVQUANTITY,0)+nvl(MSB_DECQUANTITY,0))budget_qnty      
//  	 into :ld_budget_qnty
//		from FB_MONTHLYSTOREBUDGET 
//	where SP_ID=:ls_cons and 
//      		MSB_YEAR between (decode(sign(to_number(substr(to_char(sysdate,'yyyymm'),5,2)) - 4),-1,to_number(substr(to_char(sysdate,'yyyymm'),1,4))-1,to_number(substr(to_char(sysdate,'yyyymm'),1,4)))) and
//									   (decode(sign(to_number(substr(to_char(sysdate,'yyyymm'),5,2)) - 4),-1,to_number(substr(to_char(sysdate,'yyyymm'),1,4))-1,to_number(substr(to_char(sysdate,'yyyymm'),1,4))));
	  
  select sum(decode(to_number(substr(to_char(sysdate,'yyyymm'),5,2)),4,(nvl(MSB_APRQUANTITY,0)),0)+
		   decode(to_number(substr(to_char(sysdate,'yyyymm'),5,2)),5,(nvl(MSB_APRQUANTITY,0)+nvl(MSB_MAYQUANTITY,0)),0)+
		   decode(to_number(substr(to_char(sysdate,'yyyymm'),5,2)),6,(nvl(MSB_APRQUANTITY,0)+nvl(MSB_MAYQUANTITY,0)+nvl(MSB_JUNQUANTITY,0)),0)+
	       decode(to_number(substr(to_char(sysdate,'yyyymm'),5,2)),7,(nvl(MSB_APRQUANTITY,0)+nvl(MSB_MAYQUANTITY,0)+nvl(MSB_JUNQUANTITY,0)+nvl(MSB_JULQUANTITY,0)),0)+
	       decode(to_number(substr(to_char(sysdate,'yyyymm'),5,2)),8,(nvl(MSB_APRQUANTITY,0)+nvl(MSB_MAYQUANTITY,0)+nvl(MSB_JUNQUANTITY,0)+nvl(MSB_JULQUANTITY,0)+nvl(MSB_AUGQUANTITY,0)),0)+
	       decode(to_number(substr(to_char(sysdate,'yyyymm'),5,2)),9,(nvl(MSB_APRQUANTITY,0)+nvl(MSB_MAYQUANTITY,0)+nvl(MSB_JUNQUANTITY,0)+nvl(MSB_JULQUANTITY,0)+nvl(MSB_AUGQUANTITY,0)+nvl(MSB_SEPQUANTITY,0)),0)+
	       decode(to_number(substr(to_char(sysdate,'yyyymm'),5,2)),10,(nvl(MSB_APRQUANTITY,0)+nvl(MSB_MAYQUANTITY,0)+nvl(MSB_JUNQUANTITY,0)+nvl(MSB_JULQUANTITY,0)+nvl(MSB_AUGQUANTITY,0)+nvl(MSB_SEPQUANTITY,0)+nvl(MSB_OCTQUANTITY,0)),0)+
	       decode(to_number(substr(to_char(sysdate,'yyyymm'),5,2)),11,(nvl(MSB_APRQUANTITY,0)+nvl(MSB_MAYQUANTITY,0)+nvl(MSB_JUNQUANTITY,0)+nvl(MSB_JULQUANTITY,0)+nvl(MSB_AUGQUANTITY,0)+nvl(MSB_SEPQUANTITY,0)+nvl(MSB_OCTQUANTITY,0)+nvl(MSB_NOVQUANTITY,0)+nvl(MSB_DECQUANTITY,0)),0)+
	       decode(to_number(substr(to_char(sysdate,'yyyymm'),5,2)),12,(nvl(MSB_APRQUANTITY,0)+nvl(MSB_MAYQUANTITY,0)+nvl(MSB_JUNQUANTITY,0)+nvl(MSB_JULQUANTITY,0)+nvl(MSB_AUGQUANTITY,0)+nvl(MSB_SEPQUANTITY,0)+nvl(MSB_OCTQUANTITY,0)+nvl(MSB_NOVQUANTITY,0)+nvl(MSB_DECQUANTITY,0)),0)+
		  decode(to_number(substr(to_char(sysdate,'yyyymm'),5,2)),1,(nvl(MSB_JANQUANTITY,0)+nvl(MSB_APRQUANTITY,0)+nvl(MSB_MAYQUANTITY,0)+nvl(MSB_JUNQUANTITY,0)+nvl(MSB_JULQUANTITY,0)+nvl(MSB_AUGQUANTITY,0)+nvl(MSB_SEPQUANTITY,0)+nvl(MSB_OCTQUANTITY,0)+nvl(MSB_NOVQUANTITY,0)+nvl(MSB_DECQUANTITY,0)),0)+
           decode(to_number(substr(to_char(sysdate,'yyyymm'),5,2)),2,(nvl(MSB_JANQUANTITY,0)+nvl(MSB_FEBQUANTITY,0)+nvl(MSB_APRQUANTITY,0)+nvl(MSB_MAYQUANTITY,0)+nvl(MSB_JUNQUANTITY,0)+nvl(MSB_JULQUANTITY,0)+nvl(MSB_AUGQUANTITY,0)+nvl(MSB_SEPQUANTITY,0)+nvl(MSB_OCTQUANTITY,0)+nvl(MSB_NOVQUANTITY,0)+nvl(MSB_DECQUANTITY,0)),0)+
		  decode(to_number(substr(to_char(sysdate,'yyyymm'),5,2)),3,(nvl(MSB_JANQUANTITY,0)+nvl(MSB_FEBQUANTITY,0)+nvl(MSB_MARQUANTITY,0)+nvl(MSB_APRQUANTITY,0)+nvl(MSB_MAYQUANTITY,0)+nvl(MSB_JUNQUANTITY,0)+nvl(MSB_JULQUANTITY,0)+nvl(MSB_AUGQUANTITY,0)+nvl(MSB_SEPQUANTITY,0)+nvl(MSB_OCTQUANTITY,0)+nvl(MSB_NOVQUANTITY,0)+nvl(MSB_DECQUANTITY,0)),0))budget_qnty      
  into :ld_budget_qnty
from FB_MONTHLYSTOREBUDGET 
where SP_ID=:ls_cons and 
	  MSB_YEAR between (decode(sign(to_number(substr(to_char(sysdate,'yyyymm'),5,2)) - 4),-1,to_number(substr(to_char(sysdate,'yyyymm'),1,4))-1,to_number(substr(to_char(sysdate,'yyyymm'),1,4)))) and
					   (decode(sign(to_number(substr(to_char(sysdate,'yyyymm'),5,2)) - 4),-1,to_number(substr(to_char(sysdate,'yyyymm'),1,4))-1,to_number(substr(to_char(sysdate,'yyyymm'),1,4))));
						
	  if sqlca.sqlcode = -1 then
		messagebox('Sql Error During select  Budget Quantity  : ',sqlca.sqlerrtext);
		return 1;
	elseif sqlca.sqlcode = 0 then	
		 if isnull(ld_budget_qnty) then ld_budget_qnty=0			
		dw_2.setitem(row,'indent_budgetquantity',ld_budget_qnty)
	elseif sqlca.sqlcode = 100 then	
		dw_2.setitem(row,'indent_budgetquantity',0)	
	end if;	 	

end if

if dwo.name = 'inddet_quantity' then
	ld_ind_qnty = double(data)
	ls_cons = dw_2.getitemstring(row,'sp_id') 
	ld_budget_qnty = dw_2.getitemnumber(row,'indent_budgetquantity') 
	ld_inddt=dw_1.getitemdatetime(dw_1.getrow(),'indent_date') 	
	
	setnull(ld_fyind_qnty)
	setnull(ld_fyindcncl_qnty)
	
	//check for excess quantity	
	select sum(nvl(INDDET_QUANTITY,0)),sum(nvl(INDDET_CANCELQUANTITY,0))   into  :ld_fyind_qnty,:ld_fyindcncl_qnty 	
     from fb_indent a,fb_indentdetails b
   where a.INDENT_ID=b.INDENT_ID and INDENT_HOLOCALFLAG='1' and b.SP_ID= :ls_cons and
             trunc(INDENT_DATE) between to_date('01/04'||decode(sign(to_number(to_char(:ld_inddt,'mm'))-4),-1,decode(sign(to_number(to_char(:ld_inddt,'mm'))-3),1,0,to_number(to_char(:ld_inddt,'YYYY'))-1),to_number(to_char(:ld_inddt,'YYYY'))),'dd/mm/yyyy') and
	                                                     to_date('31/03'||(decode(sign(to_number(to_char(:ld_inddt,'mm'))-4),-1,decode(sign(to_number(to_char(:ld_inddt,'mm'))-3),1,0,to_number(to_char(:ld_inddt,'YYYY'))-1),to_number(to_char(:ld_inddt,'YYYY')))+1),'dd/mm/yyyy');

	if sqlca.sqlcode = -1 then
		messagebox('Sql Error During select  Financial Year Indent : ',sqlca.sqlerrtext);
		return 1; 
	elseif sqlca.sqlcode = 0 then	
		 if isnull(ld_fyind_qnty) then ld_fyind_qnty=0		
		 if isnull(ld_fyindcncl_qnty) then ld_fyindcncl_qnty=0	
		 
		 if  (ld_fyind_qnty - ld_fyindcncl_qnty) + ld_ind_qnty > ld_budget_qnty then
			dw_2.setitem(row,'inddet_excess_qnty','Y')
		else
			dw_2.setitem(row,'inddet_excess_qnty','N')
		end if
		
	elseif sqlca.sqlcode = 100 then	
		dw_2.setitem(row,'inddet_excess_qnty','N')
	end if;	 	
end if;



if row = dw_2.rowcount() and dwo.name <> 'del_flag'  then
		dw_2.insertrow(0)
end if
cb_3.enabled = true
end event

type dw_3 from datawindow within w_gtepuf004
boolean visible = false
integer x = 5
integer y = 120
integer width = 4649
integer height = 1856
integer taborder = 70
string title = "none"
string dataobject = "dw_gtepur001h"
boolean livescroll = true
end type

