$PBExportHeader$w_gtelaf026.srw
forward
global type w_gtelaf026 from window
end type
type cb_4 from commandbutton within w_gtelaf026
end type
type cb_3 from commandbutton within w_gtelaf026
end type
type cb_2 from commandbutton within w_gtelaf026
end type
type cb_1 from commandbutton within w_gtelaf026
end type
type dw_1 from datawindow within w_gtelaf026
end type
end forward

global type w_gtelaf026 from window
integer width = 3566
integer height = 2280
boolean titlebar = true
string title = "(w_gtelaf026) Electric Advance"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtelaf026 w_gtelaf026

type variables
long ll_ctr, ll_cnt,l_ctr,ll_user_level, ll_grpid, ll_nod, ll_now
string ls_temp,ls_tmp_id,ls_last,ls_count,ls_labour_id
boolean lb_neworder, lb_query
double ld_amount, ld_nolab, ld_amtpm, ld_amtpw
datetime ld_dt,ld_todt

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (long fl_grpid, datetime fd_billdt, datetime fd_billdtto)
end prototypes

public function integer wf_check_fillcol (integer fl_row);if dw_1.rowcount() > 0 and fl_row > 0 then
	if (isnull(dw_1.getitemnumber(fl_row,'ea_grpid')) or dw_1.getitemnumber(fl_row,'ea_grpid') = 0 or &
		 isnull(dw_1.getitemdatetime(fl_row,'ea_billdate')) or &
		 isnull(dw_1.getitemnumber(fl_row,'ea_billamount')) or dw_1.getitemnumber(fl_row,'ea_billamount')=0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Group ID, Bill Date, Bill Amount, Please Check !!!')
		 return -1
	end if
end if
return 1

end function

public function integer wf_check_duplicate_rec (long fl_grpid, datetime fd_billdt, datetime fd_billdtto);long fl_row, ll_grpid1
datetime ld_dt1,ld_dt2

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 and not isnull(dw_1.getitemdatetime(2,'ea_billdate')) then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ll_grpid1 = dw_1.getitemnumber(fl_row,'ea_grpid')
		ld_dt1 = dw_1.getitemdatetime(fl_row,'ea_billdate')
		ld_dt2 = dw_1.getitemdatetime(fl_row,'ea_billdate_to')
		if ll_grpid1 = fl_grpid and ld_dt1 = fd_billdt and ld_dt2 = fd_billdtto  then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		elseif (ll_grpid1 = fl_grpid and  (fd_billdt >= ld_dt1 and fd_billdt <= ld_dt2)) then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","From Date Should Not Be Between Existing From & To Date : "+string(fl_row))
			return -1
		elseif (ll_grpid1 = fl_grpid and  (fd_billdtto >= ld_dt1 and fd_billdtto <= ld_dt2)) then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","To Date Should Not Be Between Existing From & To Date : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtelaf026.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtelaf026.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false
//dw_1.modify("t_co.text = '"+gs_co_name+"'")

if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if

this.tag = Message.StringParm
ll_user_level = long(this.tag)

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

type cb_4 from commandbutton within w_gtelaf026
integer x = 795
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

type cb_3 from commandbutton within w_gtelaf026
integer x = 530
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

IF (isnull(dw_1.getitemnumber(dw_1.rowcount(),'ea_grpid')) or dw_1.getitemnumber(dw_1.rowcount(),'ea_grpid')=0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

//	for ll_ctr = dw_1.rowcount() to 1 step -1
//		if dw_1.getitemstring(ll_ctr,'del_flag') = 'Y' then
//			dw_1.deleterow(ll_ctr)
//		end if
//	next	
	
	if dw_1.rowcount() > 0 then
		IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
			return 1
		END IF
	end if
	
	for ll_ctr = 1 to dw_1.rowcount() 
		ld_dt = dw_1.getitemdatetime(ll_ctr,'ea_billdate')
		ll_grpid = dw_1.getitemnumber(ll_ctr,'ea_grpid')
		ld_amtpm = dw_1.getitemnumber(ll_ctr,'ea_avgamount')
		ld_amtpw = dw_1.getitemnumber(ll_ctr,'ea_avgamtperweek')
		
		select distinct 'x' into :ls_temp from fb_labouradvance, fb_employee 
		where LABOUR_ID = emp_id and to_char(LA_DATE,'YYYYMM') = to_char(:ld_dt,'YYYYMM') and EDG_ID = :ll_grpid; 
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Detail From dtpdetails Table',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 100 then
			declare c1 cursor for
			select emp_id from fb_employee where EDG_ID = :ll_grpid and emp_inactivetype in ('Regular','Transfer') and emp_type in ('LP','LT','LO') order by 1;
			
			open c1;
			
			IF sqlca.sqlcode = 0 THEN 
				setnull(ls_labour_id)
				fetch c1 into :ls_labour_id;
				
				do while sqlca.sqlcode <> 100
					insert into fb_labouradvance(LABOUR_ID, LA_AMOUNT, LA_DATE, LA_AMOUNTTOPAYTODATE, LA_ACCOUNTFLAG, LA_PFADVANCE, LA_PFINTEREST, 
									 LA_PFOPENING, LA_PFYINTAUTO, LA_PFIN, LA_PFOUT, LA_PFYINT, LA_PFADJ, LA_PFSETTLE, LA_PFUNCLAIMED,
									 LA_ENTRY_BY, LA_ENTRY_DT, LA_ELECTADV,LA_ELECT_EMI)
					values(:ls_labour_id,0,:ld_dt,0,'0',0,0,0,'0',0,0,0,0,0,0,:gs_user,sysdate,:ld_amtpm,:ld_amtpw);
					
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Insert Into Labour Advance Table',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					end if
					setnull(ls_labour_id)
					fetch c1 into :ls_labour_id;
				loop
				close c1;
			end if
	
//		elseif sqlca.sqlcode  = 0 then	
//			update fb_labouradvance set  LA_ELECTADV = :ld_amtpw
//			where to_char(LA_DATE,'YYYYMM') = to_char(:ld_dt,'YYYYMM') and LABOUR_ID in (select emp_id from fb_employee where EDG_ID = :ll_grpid);
//			if sqlca.sqlcode = -1 then
//				messagebox('Error : While Updating Labour Advance Table',sqlca.sqlerrtext)
//				rollback using sqlca;
//				return 1
//			end if
		end if			
	next
	
	if dw_1.update(true,false) = 1 then
		dw_1.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		dw_1.reset()
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
else
	return
end if 
end event

type cb_2 from commandbutton within w_gtelaf026
integer x = 265
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
	lb_neworder = true
	if dw_1.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	dw_1.reset()
	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('ea_grpid')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	lb_query = false
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtelaf026
integer x = 5
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
end if

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'ea_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'ea_entry_dt',datetime(today()))
	dw_1.setcolumn('ea_grpid')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'ea_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'ea_entry_dt',datetime(today()))
	dw_1.setcolumn('ea_grpid')
end if


end event

type dw_1 from datawindow within w_gtelaf026
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 116
integer width = 3515
integer height = 2052
integer taborder = 30
string dataobject = "dw_gtelaf026"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'ea_entry_by',gs_user)
		dw_1.setitem(newrow,'ea_entry_dt',datetime(today()))
		dw_1.setcolumn('ea_grpid')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(dw_1.rowcount())
	end if
	if dw_1.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event ue_keydwn;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(dw_1.rowcount())
	end if
	if dw_1.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event itemchanged;if lb_query = false then
	
	if dwo.name = 'ea_grpid'  then
		ll_grpid = long(data)
		
		select count(*) into :ld_nolab from fb_employee where emp_inactivetype in ('Regular','Transfer') and nvl(EDG_ID,0) = :ll_grpid;
	
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting No Of Labours',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			dw_1.setitem(row,'ea_nolabour',ld_nolab)
		end if	
	end if

	if dwo.name = 'ea_billdate'  then
		ld_dt = datetime(data)
		ld_todt = dw_1.getitemdatetime(row,'ea_billdate_to')
		ll_grpid = dw_1.getitemnumber(row,'ea_grpid')
		
		if date(ld_todt) < date(ld_dt) then
			messagebox('Warning!','From Date Should Be < To Date, Please Check !!!')
			return 1
		end if
		if  wf_check_duplicate_rec(ll_grpid,ld_dt,ld_todt) = -1 then return 1		
		
		if date(ld_dt) > today() then
			messagebox('Warning!','Date Should Not Be > Current Date, Please Check !!!')
			return 1
		end if
		
		if  wf_check_duplicate_rec(ll_grpid,ld_dt,ld_todt) = -1 then return 1
		
		select distinct 'x' into :ls_temp from fb_electricadvance where ea_grpid = :ll_grpid and trunc(:ld_dt) between trunc(ea_billdate) and trunc(ea_billdate_to);
	
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Transaction Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox('Warning!','From & To Date Of New Record Should Be > From & To Date Of Existing Recors, Please Check !!!')
			return 1
		end if	
	end if
	
	if dwo.name = 'ea_billdate_to'  then
		ld_todt = datetime(data)
		ld_dt = dw_1.getitemdatetime(row,'ea_billdate')
		ll_grpid = dw_1.getitemnumber(row,'ea_grpid')
		
		if date(ld_todt) < date(ld_dt) then
			messagebox('Warning!','To Date Should Be > From Date, Please Check !!!')
			return 1
		end if
		
//		if f_check_initial_space(string(data)) = -1 then return 1
		
		if  wf_check_duplicate_rec(ll_grpid,ld_dt,ld_todt) = -1 then return 1
		
		select distinct 'x' into :ls_temp from fb_electricadvance where ea_grpid = :ll_grpid and trunc(ea_billdate) = trunc(:ld_dt) and trunc(ea_billdate_to) = trunc(:ld_todt);
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Bonus Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox('Warning!','Record Already Exists, Please Check !!!')
			return 1
		end if
		
	end if
	
	
	
	if dwo.name = 'ea_billamount' then
		ld_amount = double(data)
		ld_nolab = dw_1.getitemnumber(row,'ea_nolabour')
		ld_dt = dw_1.getitemdatetime(row,'ea_billdate')
		ld_todt = dw_1.getitemdatetime(row,'ea_billdate_to')
		
		//select :ld_todt - :ld_dt into :ll_nod from dual;
		
		ll_nod = DaysAfter(date(ld_dt),date(ld_todt))
		
		ll_now = (ll_nod + 1) / 7

		if isnull(ld_amount) then ld_amount = 0
		if isnull(ld_nolab) then ld_nolab = 0
		
		if ld_nolab = 0  then 
			ld_amtpm = 0 
		else
			ld_amtpm = ld_amount / ld_nolab
		end if
		
		if ll_now = 0  then
			ld_amtpw = 0
		else
			ld_amtpw = ld_amtpm / ll_now
		end if
		dw_1.setitem(row,'ea_avgamount',ld_amtpm)
		dw_1.setitem(row,'ea_avgamtperweek',ld_amtpw)
	end if
	
	dw_1.setitem(row,'ea_entry_by',gs_user)
	dw_1.setitem(row,'ea_entry_dt',datetime(today()))
	
	cb_3.enabled = true
end if

if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if

end event

