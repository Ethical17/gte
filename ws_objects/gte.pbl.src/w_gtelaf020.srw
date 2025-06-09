$PBExportHeader$w_gtelaf020.srw
forward
global type w_gtelaf020 from window
end type
type cb_4 from commandbutton within w_gtelaf020
end type
type cb_3 from commandbutton within w_gtelaf020
end type
type cb_2 from commandbutton within w_gtelaf020
end type
type cb_1 from commandbutton within w_gtelaf020
end type
type dw_1 from datawindow within w_gtelaf020
end type
end forward

global type w_gtelaf020 from window
integer width = 4645
integer height = 2136
boolean titlebar = true
string title = "(w_gtelaf020) Over Time"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtelaf020 w_gtelaf020

type variables
long ll_ctr,net, ll_cnt,l_ctr,ix,ll_labage,ll_user_level,ll_adoleage, ll_child
string ls_temp,ls_emp_id,ls_date,ls_ref,ls_labour_id,ls_kam_id,ls_dt,ls_kam_id_old
boolean lb_neworder, lb_query
datetime ld_dob,ld_date,ld_dt
double ld_afrate, ld_adfrate, ld_cfrate,ld_rate,ld_wages,ld_hour, ld_amt,ld_amt_old
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_con_id, datetime fd_con_dt)
public function double wf_kamjari_rate (datetime fd_date, string fs_labourid, string fs_kamid)
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

public function integer wf_check_fillcol (integer fl_row);if dw_1.rowcount() > 0 and fl_row > 0 then
	if (isnull(dw_1.getitemstring(fl_row,'ot_emp_id')) or  len(dw_1.getitemstring(fl_row,'ot_emp_id'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'ot_kamsub_id')) or  len(dw_1.getitemstring(fl_row,'ot_kamsub_id'))=0 or &
	    isnull(dw_1.getitemstring(fl_row,'ot_remark')) or len(dw_1.getitemstring(fl_row,'ot_remark'))=0 or &
	    isnull(dw_1.getitemnumber(fl_row,'ot_hours')) or dw_1.getitemnumber(fl_row,'ot_hours') = 0 or &	 
	    isnull(dw_1.getitemdatetime(fl_row,'ot_dt')) or &
	    isnull(dw_1.getitemstring(fl_row,'ot_remark')) or  len(dw_1.getitemstring(fl_row,'ot_remark'))=0 ) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Labour Id, Kamjari ID, Over Time Date, Over Time Hour, Remark, Please Check !!!')
	    return -1
	end if
end if
return 1


end function

public function integer wf_check_duplicate_rec (string fs_con_id, datetime fd_con_dt);long fl_row
string ls_con_id1
datetime ld_run_dt1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_con_id1 = dw_1.getitemstring(fl_row,'ot_emp_id')
		ld_run_dt1 = dw_1.getitemdatetime(fl_row,'ot_dt')
					
		if ls_con_id1 = fs_con_id  and ld_run_dt1 = fd_con_dt then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1


end function

public function double wf_kamjari_rate (datetime fd_date, string fs_labourid, string fs_kamid);select sum(decode(pd_doc_type,'ADOLEAGE',pd_value,0)), sum(decode(pd_doc_type,'CHILDAGE',pd_value,0))
into :ll_adoleage, :ll_child
from fb_param_detail 
where pd_doc_type in ('CHILDAGE','ADOLEAGE') and
		 trunc(:fd_date) between PD_PERIOD_FROM and nvl(PD_PERIOD_TO,trunc(sysdate));

if sqlca.sqlcode = -1 then
	messagebox('SQL ERROR: During Parametere checking ',sqlca.sqlerrtext)
	return -1
end if;

select emp.emp_dob labdob, ((:fd_date - emp_dob) /365) into :ld_dob, :ll_labage
  from fb_employee emp
 where emp.emp_id= :fs_labourid;

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Labour Age Detail',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if

select kam.kamsub_afrate afrate, kam.kamsub_adfrate adfrate, kam.kamsub_cfrate cfrate
   into :ld_afrate, :ld_adfrate, :ld_cfrate
 from fb_kamsubhead kam
where trim(kam.kamsub_id) = :fs_kamid and trunc(:fd_date) between trunc(KAMSUB_FRDT) and trunc(nvl(KAMSUB_TODT,sysdate));

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Labour Kamjari Rate Detail',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if

If ll_labage <= ll_child Then //(144 months=12 years)
		 ld_rate = ld_cFrate
 ElseIf ll_labage > ll_child And ll_labage < ll_adoleage Then
		 ld_rate = ld_adfrate
 ElseIf ll_labage >= ll_adoleage Then
		 ld_rate = ld_afrate
End If

return ld_rate
end function

on w_gtelaf020.create
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

on w_gtelaf020.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;
dw_1.settransobject(sqlca)
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

type cb_4 from commandbutton within w_gtelaf020
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

type cb_3 from commandbutton within w_gtelaf020
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

IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'ot_emp_id')) or len(dw_1.getitemstring(dw_1.rowcount(),'ot_emp_id'))=0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

	n_fames luo_fames
 	luo_fames = Create n_fames

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	for ll_ctr = dw_1.rowcount() to 1 step -1
		ls_kam_id_old = dw_1.getitemstring(ll_ctr,'ot_KAMSUB_ID_old')
		ld_amt_old = dw_1.getitemnumber(ll_ctr,'OT_AMOUNT_old')

		if  dw_1.getitemstring(ll_ctr,'del_flag') = 'Y'  then
			if luo_fames.wf_upd_mes(string(dw_1.getitemdatetime(ll_ctr,'ot_dt'),'dd/mm/yyyy'),ls_kam_id_old,ld_amt_old,'W','Y') = -1 then 
				rollback using sqlca;
				return 1;
			end if			
			dw_1.deleterow(ll_ctr)
		end if
	next	
	
	if (isnull(dw_1.getitemstring(dw_1.getrow(),'ot_emp_id')) or len(dw_1.getitemstring(dw_1.getrow(),'ot_emp_id'))=0 or &
	    isnull(dw_1.getitemstring(dw_1.getrow(),'ot_kamsub_id')) or  len(dw_1.getitemstring(dw_1.getrow(),'ot_kamsub_id'))=0 or &
	    isnull(dw_1.getitemstring(dw_1.getrow(),'ot_remark')) or len(dw_1.getitemstring(dw_1.getrow(),'ot_remark'))=0 or &
	    isnull(dw_1.getitemnumber(dw_1.getrow(),'ot_hours')) or dw_1.getitemnumber(dw_1.getrow(),'ot_hours') = 0 or &	 
	    isnull(dw_1.getitemdatetime(dw_1.getrow(),'ot_dt'))) then
		messagebox('Warning:','One Of The Fields (Labour Id, Kamjari ID, Over Time Date, Over Time Hour, Remark) Are Blank : Please check !!!')
		dw_1.setfocus()
		dw_1.setcolumn('ot_emp_id')
		return
	end if
 
	for ll_ctr = 1 to DW_1.ROWCOUNT()
		ls_dt = string(dw_1.getitemdatetime(ll_ctr,'ot_dt'),'dd/mm/yyyy')
		ls_kam_id = dw_1.getitemstring(ll_ctr,'ot_kamsub_id')
		ld_amt = dw_1.getitemnumber(ll_ctr,'ot_amount')
		ls_kam_id_old = dw_1.getitemstring(ll_ctr,'ot_kamsub_id_old')
		ld_amt_old = dw_1.getitemnumber(ll_ctr,'ot_amount_old')
		if dw_1.GetItemStatus(ll_ctr,0,Primary!) = New!	or dw_1.GetItemStatus(ll_ctr,0,Primary!) = NewModified!	then
			if luo_fames.wf_upd_mes(ls_dt,ls_kam_id,ld_amt,'W','N') = -1 then 
				rollback using sqlca;
				return 1;
			end if
		elseif dw_1.GetItemStatus(ll_ctr,0,Primary!) = DataModified!	then
			
			if luo_fames.wf_upd_mes(ls_dt,ls_kam_id_old,ld_amt_old,'W','Y') = -1 then 
				rollback using sqlca;
				return 1;
			end if
			if luo_fames.wf_upd_mes(ls_dt,ls_kam_id,ld_amt,'W','N') = -1 then 
				rollback using sqlca;
				return 1;
			end if			
		end if
	next
	DESTROY n_fames
	messagebox('Information',' MES Posting Successfully Completed')

		
	if dw_1.update(true,false) = 1  then
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

type cb_2 from commandbutton within w_gtelaf020
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
	if dw_1.modifiedcount() > 0  then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	lb_query = true
	lb_neworder = true
	dw_1.reset()
	cb_3.enabled = false
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('ot_emp_id')
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
end if
lb_neworder = false



end event

type cb_1 from commandbutton within w_gtelaf020
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
end if

dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'ot_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'ot_entry_dt',datetime(today()))	
	dw_1.setcolumn('ot_emp_id')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'ot_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'ot_entry_dt',datetime(today()))
	dw_1.setcolumn('ot_emp_id')
end if


end event

type dw_1 from datawindow within w_gtelaf020
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
integer y = 120
integer width = 4603
integer height = 1908
integer taborder = 30
string dataobject = "dw_gtelaf020"
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
		dw_1.setitem(newrow,'ot_entry_by',gs_user)
		dw_1.setitem(newrow,'ot_entry_dt',datetime(today()))
		dw_1.setcolumn('ot_emp_id')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if lb_query = false then

	if dwo.name = 'ot_emp_id' then
		ls_emp_id=data
		if isnull(ls_emp_id)= true or len(ls_emp_id) = 0 then	
			messagebox('Warning!','Please select  a valid labour id')
			rollback using sqlca;
			return 1
		end if
	end if
	
	if dwo.name = 'ot_dt' then
		ld_date=datetime(data)
		if  isnull(ld_date)  then
			messagebox('Warning!','Over Time Date Should Not Be Blank, Please Check !!!')
			rollback using sqlca;
			return 1
		end if
		
		setnull(ls_temp)
		select distinct 'x' into :ls_temp from fb_overtime	where nvl(ot_mes_ind,'N') = 'Y' and trunc(ot_dt)=trunc(:ld_date);
		if sqlca.sqlcode = -1 then 
			messagebox('Sql Error','Error During MES Posting Date Check: '+sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 0 then 
			messagebox('Error','MES Posting For This Period Is Done, Overtime Entry Not Allowed !!!')
			rollback using sqlca;
			return 1
		end if
		
		setnull(ls_temp)
		select distinct 'x' into :ls_temp  from fb_labourwagesweek
			where trunc(:ld_date) between trunc(LWW_STARTDATE) and trunc(LWW_ENDDATE) and nvl(LWW_PAIDFLAG,'0') = '1';
		
		if sqlca.sqlcode = -1 then 
				messagebox('Sql Error','Error During Getting Payment Details: '+sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
		elseif sqlca.sqlcode = 0 then 
			  messagebox('Error','Payment For This Period Is Already Done, Please Check !!!')
			rollback using sqlca;
			return 1
		end if;	
		
		if  wf_check_duplicate_rec(ls_emp_id,ld_date) = -1 then return 1
		
		///check duplicate from table
		select distinct 'x' into :ls_temp  from fb_overtime	where ot_emp_id=:ls_emp_id and trunc(ot_dt)=trunc(:ld_date);
		
		if sqlca.sqlcode = -1 then 
				messagebox('Sql Error','Error During Getting Labour Id  : '+sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
		elseif sqlca.sqlcode = 0 then 
			  messagebox('Error','Over Time Entry Already Done For This Employee For The Date, Please Check !!!')
			rollback using sqlca;
			return 1
		end if;		
	end if
	
	if dwo.name = 'ot_kamsub_id'  then
		ls_kam_id = trim(data)
		ld_hour= dw_1.getitemnumber(row,'ot_hours')
		ls_labour_id = dw_1.getitemstring(row,'ot_emp_id')
		ld_dt = dw_1.getitemdatetime(row,'ot_dt')

		ld_wages = wf_kamjari_rate(ld_dt,ls_labour_id,ls_kam_id)
		dw_1.setitem(row,'ot_rate',ld_wages)
		if isnull(ld_wages) then ld_wages = 0	
		ld_amt = 0
		ld_amt = (ld_wages / 8) * ld_hour * 2
		dw_1.setitem(row,'ot_amount',ld_amt)		
	end if	
	
	if dwo.name = 'ot_hours' then
		ld_hour=double(data)
		if  isnull(ld_hour)=true or ld_hour = 0 then
			messagebox('Error:','Please enter a valid Over time hour')
			rollback using sqlca;
			return 1
		end if
		
		ld_rate = dw_1.getitemnumber(row,'ot_rate')
		if isnull(ld_rate) then ld_rate = 0	
		ld_amt = 0
		ld_amt = ((ld_rate / 8) * 2) * ld_hour
		dw_1.setitem(row,'ot_amount',ld_amt)		
	end if

	
	if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
		dw_1.insertrow(0)
	end if
	
	dw_1.setitem(row,'ot_entry_by',gs_user)
	dw_1.setitem(row,'ot_entry_dt',datetime(today()))
	
	cb_3.enabled = true
end if
end event

