$PBExportHeader$w_gtelaf008.srw
forward
global type w_gtelaf008 from window
end type
type cb_4 from commandbutton within w_gtelaf008
end type
type cb_3 from commandbutton within w_gtelaf008
end type
type cb_2 from commandbutton within w_gtelaf008
end type
type cb_1 from commandbutton within w_gtelaf008
end type
type dw_1 from datawindow within w_gtelaf008
end type
end forward

global type w_gtelaf008 from window
integer width = 4681
integer height = 2388
boolean titlebar = true
string title = "(w_gtelaf008) Kamjari Task"
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
global w_gtelaf008 w_gtelaf008

type variables
long ll_ctr, ll_cnt, ll_year, ll_last,ll_user_level
string ls_temp,ls_name,ls_last,ls_kam,ls_type,ls_prunty, ls_div
boolean lb_neworder, lb_query
datetime ld_frdt, ld_todt
double ld_afrate, ld_adfrate, ld_cfrate,ld_rate , ld_cp1

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_kam, string fs_type, datetime fd_dt, datetime fd_todt, string fs_div, string fs_prunty)
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
	if (isnull(dw_1.getitemstring(fl_row,'task_id')) or  len(dw_1.getitemstring(fl_row,'task_id'))=0 or &
		 isnull(dw_1.getitemstring(fl_row,'task_type')) or  len(dw_1.getitemstring(fl_row,'task_type'))=0 or &
		 isnull(dw_1.getitemdatetime(fl_row,'task_dt_from')) or &
		 isnull(dw_1.getitemdatetime(fl_row,'task_dt_to')) or &
		 isnull(dw_1.getitemnumber(fl_row,'task_changepoint')) or  dw_1.getitemnumber(fl_row,'task_changepoint')=0 or &
		 isnull(dw_1.getitemnumber(fl_row,'task_changepoint2')) or  dw_1.getitemnumber(fl_row,'task_changepoint2')=0 or &
		 isnull(dw_1.getitemnumber(fl_row,'task_ratelower'))  or &
		 isnull(dw_1.getitemnumber(fl_row,'task_rateupper'))  or &
		 isnull(dw_1.getitemnumber(fl_row,'task_rateupper2'))  or &
		 isnull(dw_1.getitemstring(fl_row,'task_unit')) or  len(dw_1.getitemstring(fl_row,'task_unit'))=0) then
	    messagebox('Warning: One Of The Following Fields Are Blank', 'Task ID, Type, From date, To Date, ChangePoint 1, ChangePoint 2, Rate Lower1,Rate Lower2, Rate Upper1, Rate Upper2, Please Check !!!')
		 return -1
	end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (string fs_kam, string fs_type, datetime fd_dt, datetime fd_todt, string fs_div, string fs_prunty);long fl_row
string ls_kam1,ls_type1, ls_prunty1,ls_div1
datetime ld_dt1,ld_tdt1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_kam1 = dw_1.getitemstring(fl_row,'task_id')
		ls_type1 = dw_1.getitemstring(fl_row,'task_type')
		ld_dt1 = dw_1.getitemdatetime(fl_row,'task_dt_from')
		ld_tdt1 = dw_1.getitemdatetime(fl_row,'task_dt_to')
		ls_div1 = dw_1.getitemstring(fl_row,'task_fieldid')
		ls_prunty1 = dw_1.getitemstring(fl_row,'task_pruntype')
		
		if isnull(ls_prunty1) then ls_prunty1 = 'x'
		if isnull(fs_prunty) then fs_prunty = 'x'
		if isnull(ls_div1) then ls_div1 = 'x'
		if isnull(fs_div) then fs_div = 'x'
		
		if ls_kam1 = fs_kam and ls_type1 = fs_type and ld_dt1 = fd_dt and ld_tdt1 = fd_todt and ls_div1 = fs_div and ls_prunty1 = fs_prunty then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtelaf008.create
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

on w_gtelaf008.destroy
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

type cb_4 from commandbutton within w_gtelaf008
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

type cb_3 from commandbutton within w_gtelaf008
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

IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'task_id')) or len(dw_1.getitemstring(dw_1.rowcount(),'task_id'))=0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF  MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	if dw_1.rowcount() > 0 then
		IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
			return 1
		END IF

		for ll_ctr = 1 to dw_1.rowcount( ) 
			ld_frdt = dw_1.getitemdatetime(ll_ctr,'task_dt_from')
			ld_todt = dw_1.getitemdatetime(ll_ctr,'task_dt_to')
			ls_kam = dw_1.getitemstring(ll_ctr,'task_id')
			ls_type = dw_1.getitemstring(ll_ctr,'task_type')
			ls_prunty = dw_1.getitemstring(ll_ctr,'task_pruntype')
			ls_div = dw_1.getitemstring(ll_ctr,'task_fieldid')
					
			if lb_neworder = true then
				select distinct 'x' into :ls_temp from fb_task
				where task_id = :ls_kam and nvl(task_fieldid,'x') = nvl(:ls_div,'x') and task_type = :ls_type and trunc(:ld_frdt) between trunc(TASK_dt_from) and trunc(task_dt_to) and nvl(task_pruntype,'x') = nvl(:ls_prunty,'x');
	
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Payment Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode  = 0 then
					messagebox('Warning!','Period From Of New Record Should Be > Period From & To Of Existing Recors, Please Check !!!')
					return 1
				end if	
					
				select distinct 'x' into :ls_temp from fb_task
				where task_id = :ls_kam and nvl(task_fieldid,'x') = nvl(:ls_div,'x') and task_type = :ls_type and trunc(TASK_dt_from)= trunc(:ld_frdt) and trunc(TASK_dt_to) = trunc(:ld_todt) and nvl(task_pruntype,'x') = nvl(:ls_prunty,'x');
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Rate Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode  = 0 then
					messagebox("Warning!","Record Already Exists, Please Check !!!")
					return 1
				end if
			end if
		next	
	end if

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

type cb_2 from commandbutton within w_gtelaf008
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
	dw_1.setcolumn('task_id')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_garden_snm,gs_garden_state)
//	if gs_garden_state = '03' then
//		dw_1.settaborder('task_changepoint',20)
//		dw_1.settaborder('task_changepoint2',25)
//	else
//		dw_1.settaborder('task_changepoint',0)
//		dw_1.settaborder('task_changepoint2',0)
//	end if
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtelaf008
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
	dw_1.setitem(dw_1.getrow(),'TASK_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'fb_garden',gs_garden_snm)
	dw_1.setitem(dw_1.getrow(),'gs_stcd',gs_garden_state)
	dw_1.setitem(dw_1.getrow(),'TASK_entry_dt',datetime(today()))
	dw_1.setcolumn('task_id')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'TASK_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'fb_garden',gs_garden_snm)
	dw_1.setitem(dw_1.getrow(),'gs_stcd',gs_garden_state)
	dw_1.setitem(dw_1.getrow(),'TASK_entry_dt',datetime(today()))
	dw_1.setcolumn('task_id')
end if


end event

type dw_1 from datawindow within w_gtelaf008
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 116
integer width = 4622
integer height = 2052
integer taborder = 30
string dataobject = "dw_gtelaf008"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
end type

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'task_entry_by',gs_user)
		dw_1.setitem(newrow,'task_entry_dt',datetime(today()))
		dw_1.setitem(newrow,'fb_garden',gs_garden_snm)
		dw_1.setitem(newrow,'gs_stcd',gs_garden_state)
		dw_1.setcolumn('task_id')
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
	if dwo.name = 'task_dt_from'  then
		ld_frdt = datetime(data)
		ls_kam = dw_1.getitemstring(row,'task_id')
		ls_div = dw_1.getitemstring(row,'task_fieldid')
		ls_type = dw_1.getitemstring(row,'task_type')
		ld_todt = dw_1.getitemdatetime(row,'task_dt_to')
		ls_prunty = dw_1.getitemstring(row,'task_pruntype')
		
//		if date(ld_frdt) < today() then
//			messagebox('Warning','From Date Should Not Be < Current Date !!!')
//			return 1
//		end if
				
		if isnull(data) or data = '00/00/0000'  then
			messagebox('Warning!','From Date Should Not Be Blank, Please Check !!!')
			return 1
		end if
		
		if string(ld_todt,'dd/mm/yyyy') <> '00/00/0000'  then
			if date(ld_todt) < date(ld_frdt) then
				messagebox('Warning!','From Date Should Be < To Date, Please Check !!!')
				return 1
			end if
		end if
		
		if  wf_check_duplicate_rec(ls_kam,ls_type,ld_frdt, ld_todt,ls_div,ls_prunty) = -1 then return 1
				
		select distinct 'x' into :ls_temp from fb_task
		where task_id = :ls_kam and nvl(task_fieldid,'x') = nvl(:ls_div,'x') and task_type = :ls_type and trunc(:ld_frdt) between trunc(TASK_dt_from) and trunc(task_dt_to) and nvl(task_pruntype,'x') = nvl(:ls_prunty,'x');
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Payment Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox('Warning!','Period From Of New Record Should Be > Period From & To Of Existing Recors, Please Check !!!')
			return 1
		end if

	else
			ld_frdt = dw_1.getitemdatetime(row,'task_dt_from')
	end if
	
	if dwo.name = 'task_dt_to'  then
		ld_todt = datetime(data)
		ls_kam = dw_1.getitemstring(row,'task_id')
		ls_type = dw_1.getitemstring(row,'task_type')
		ls_prunty = dw_1.getitemstring(row,'task_pruntype')
		ls_div = dw_1.getitemstring(row,'task_fieldid')
//		if date(ld_frdt) < today() then
//			messagebox('Warning','From Date Should Not Be < Current Date !!!')
//			return 1
//		end if

		if isnull(data) or isnull(ld_frdt) or data = '00/00/0000' or string(ld_frdt) = '00/00/0000' then
			messagebox('Warning!','From & To Date Should Not Be Blank, Please Check !!!')
			return 1
		end if		
		if date(ld_todt) < date(ld_frdt) then
			messagebox('Warning!','To Date Should Be > From Date, Please Check !!!')
			return 1
		end if
		
		if  wf_check_duplicate_rec(ls_kam,ls_type,ld_frdt,ld_todt,ls_div,ls_prunty) = -1 then return 1
		
		select distinct 'x' into :ls_temp from fb_task
		where task_id = :ls_kam and nvl(task_fieldid,'x') = nvl(:ls_div,'x') and task_type = :ls_type and trunc(TASK_dt_from) = trunc(:ld_frdt) and trunc(TASK_dt_to) = trunc(:ld_todt)  and nvl(task_pruntype,'x') = nvl(:ls_prunty,'x');
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Rate Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox("Warning!","Record Already Exists, Please Check !!!")
			return 1
		end if
	end if
    if dwo.name = 'task_avgrt_lower' then
		if data = 'Y' then
			ls_kam = dw_1.getitemstring(row,'task_id')
			ls_type = dw_1.getitemstring(row,'task_type')
			ld_cp1 = dw_1.getitemnumber(row,'task_changepoint')
			
			select kam.kamsub_afrate afrate, kam.kamsub_adfrate adfrate, kam.kamsub_cfrate cfrate
				into :ld_afrate, :ld_adfrate, :ld_cfrate 
			 from fb_kamsubhead kam
			where trim(kam.kamsub_id) = :ls_kam and KAMSUB_TODT is null;
			
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Labour Kamjari Rate Detail',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			end if
			if isnull(ld_cFrate) then ld_cFrate = 0
			if isnull(ld_adfrate) then ld_adfrate = 0
			if isnull(ld_afrate) then ld_afrate = 0
			if isnull(ld_cp1) then ld_cp1 = 0
			If ls_type = 'CHILD' Then
				if ld_cFrate = 0 then
					ld_rate =0
				else
					ld_rate = ld_cFrate / ld_cp1
				end if
				if isnull(ld_rate) then ld_rate = 0
				dw_1.setitem(row,'task_ratelower',ld_rate)
			 ElseIf ls_type = 'ADOLE' Then
				if ld_adfrate = 0 then
					ld_rate =0
				else
					ld_rate = ld_adfrate / ld_cp1
				end if
				if isnull(ld_rate) then ld_rate = 0
				dw_1.setitem(row,'task_ratelower',ld_rate)					 
			 ElseIf ls_type = 'ADULT' Then
				if ld_afrate = 0 then
					ld_rate =0
				else
					ld_rate = ld_afrate / ld_cp1
				end if
				if isnull(ld_rate) then ld_rate = 0
				dw_1.setitem(row,'task_ratelower',ld_rate)					 
			End If			
			
		end if
	end if
	
    if dwo.name = 'task_avgrt_upper' then
		if data = 'Y' then
			ls_kam = dw_1.getitemstring(row,'task_id')
			ls_type = dw_1.getitemstring(row,'task_type')
			ld_cp1 = dw_1.getitemnumber(row,'task_changepoint')
			
			select kam.kamsub_afrate afrate, kam.kamsub_adfrate adfrate, kam.kamsub_cfrate cfrate
				into :ld_afrate, :ld_adfrate, :ld_cfrate 
			 from fb_kamsubhead kam
			where trim(kam.kamsub_id) = :ls_kam and KAMSUB_TODT is null;
			
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Labour Kamjari Rate Detail',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			end if
			if isnull(ld_cFrate) then ld_cFrate = 0
			if isnull(ld_adfrate) then ld_adfrate = 0
			if isnull(ld_afrate) then ld_afrate = 0
			if isnull(ld_cp1) then ld_cp1 = 0
			If ls_type = 'CHILD' Then
				if ld_cFrate = 0 then
					ld_rate =0
				else
					ld_rate = ld_cFrate / ld_cp1
				end if
				if isnull(ld_rate) then ld_rate = 0
				dw_1.setitem(row,'task_rateupper',ld_rate)
			 ElseIf ls_type = 'ADOLE' Then
				if ld_adfrate = 0 then
					ld_rate =0
				else		
					 ld_rate = ld_adfrate / ld_cp1
				end if
				if isnull(ld_rate) then ld_rate = 0
				dw_1.setitem(row,'task_rateupper',ld_rate)					 
			 ElseIf ls_type = 'ADULT' Then
				if ld_afrate = 0 then
					ld_rate =0
				else						
					 ld_rate = ld_afrate / ld_cp1
				end if
				if isnull(ld_rate) then ld_rate = 0
				dw_1.setitem(row,'task_rateupper',ld_rate)					 
			End If			
			
		end if
	end if	
	if dwo.name = 'task_changepoint'  then
		dw_1.setitem(row,'task_changepoint2',double(data))
		//dw_1.setfocus (row,'task_rateupper')
	end if
	
	if dwo.name = 'task_rateupper'  then
		//dw_1.setitem(row,'task_ratelower',double(data))
		dw_1.setitem(row,'task_rateupper2',double(data))
	end if
	if dwo.name = 'task_fieldid'  then
		ls_div = data
		ls_kam = dw_1.getitemstring(row,'task_id')
		ls_type = dw_1.getitemstring(row,'task_type')
		ld_todt = dw_1.getitemdatetime(row,'task_dt_to')
		ld_frdt = dw_1.getitemdatetime(row,'task_dt_from')
		ls_prunty = dw_1.getitemstring(row,'task_pruntype')
		
		if isnull(data) or data = '00/00/0000'  then
			messagebox('Warning!','From Date Should Not Be Blank, Please Check !!!')
			return 1
		end if
		
		if string(ld_todt,'dd/mm/yyyy') <> '00/00/0000'  then
			if date(ld_todt) < date(ld_frdt) then
				messagebox('Warning!','From Date Should Be < To Date, Please Check !!!')
				return 1
			end if
		end if
		
		if  wf_check_duplicate_rec(ls_kam,ls_type,ld_frdt, ld_todt,ls_div,ls_prunty) = -1 then return 1
				
		select distinct 'x' into :ls_temp from fb_task
		where task_id = :ls_kam and nvl(task_fieldid,'x') = nvl(:ls_div,'x') and task_type = :ls_type and trunc(:ld_frdt) between trunc(TASK_dt_from) and trunc(task_dt_to) and nvl(task_pruntype,'x') = nvl(:ls_prunty,'x');
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Payment Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox('Warning!','Period From Of New Record Should Be > Period From & To Of Existing Recors, Please Check !!!')
			return 1
		end if
	end if	
	
	if dwo.name = 'task_pruntype'  then
		ls_prunty = data
		ls_kam = dw_1.getitemstring(row,'task_id')
		ls_type = dw_1.getitemstring(row,'task_type')
		ld_todt = dw_1.getitemdatetime(row,'task_dt_to')
		ld_frdt = dw_1.getitemdatetime(row,'task_dt_from')
		ls_div = dw_1.getitemstring(row,'task_fieldid')
		
		if isnull(data) or data = '00/00/0000'  then
			messagebox('Warning!','From Date Should Not Be Blank, Please Check !!!')
			return 1
		end if
		
		if string(ld_todt,'dd/mm/yyyy') <> '00/00/0000'  then
			if date(ld_todt) < date(ld_frdt) then
				messagebox('Warning!','From Date Should Be < To Date, Please Check !!!')
				return 1
			end if
		end if
		
		if  wf_check_duplicate_rec(ls_kam,ls_type,ld_frdt, ld_todt,ls_div,ls_prunty) = -1 then return 1
				
		select distinct 'x' into :ls_temp from fb_task
		where task_id = :ls_kam and nvl(task_fieldid,'x') = nvl(:ls_div,'x') and task_type = :ls_type and trunc(:ld_frdt) between trunc(TASK_dt_from) and trunc(task_dt_to) and nvl(task_pruntype,'x') = nvl(:ls_prunty,'x');
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Payment Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox('Warning!','Period From Of New Record Should Be > Period From & To Of Existing Record, Please Check !!!')
			return 1
		end if
	end if

	
	dw_1.setitem(row,'task_entry_by',gs_user)
	dw_1.setitem(row,'task_entry_dt',datetime(today()))

cb_3.enabled = true
end if

if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if


end event

event updatestart;
//
integer li_column, li_row // variables to hold the column index and row number
string ls_old_value, ls_new_value // variables to hold the old and new values
long ll_coumnid
string ls_columnname,ls_unique_id




// Loop through all rows in the DataWindow control
FOR li_row = 1 TO This.RowCount()
//SELECT max(COLUMN_ID) COLUMN_id, into :ll_cnt  FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_teamadeproduct') and column_id not in (9,10);
////ll_no =  
//    // Loop through all data columns in the DataWindow control
//    FOR li_column = 1 TO ll_cnt
//
//        // Get the old value for the data column
//        ls_old_value = dw_1.GetItemString(li_row, li_column, Primary!, true)
//
//        // Get the new value for the data column
//        ls_new_value = This.GetItemString(li_row, li_column)
//
//        // Compare the old and new values
//        if ls_old_value <> ls_new_value then
//            // Code to execute if the values are different
//				
//				insert into fb_log(OBJECT, SUBOBJECT, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
//				('fb_teamadeproduct','fb_teamadeproduct','U',:li_column,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
//				if sqlca.sqlcode = -1 then
//							messagebox("SQL Error : While Inserting Into LOg Table ",SQLCA.SQLErrtext,Information!)
//							rollback using sqlca;
//							return -1 
//				end if		
//				
//				
//				
//        end if
//
//    NEXT

DECLARE c1 CURSOR FOR  

SELECT COLUMN_ID,COLUMN_Name FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_task');

close c1;
open c1;
if sqlca.sqlcode = -1 then
				messagebox('Error', 'Error occured while opening cursor c1 : '+sqlca.sqlerrtext)
				rollback using sqlca;
				return 1;
		
elseIF sqlca.sqlcode = 0 THEN
	setnull(ll_coumnid);setnull(ls_columnname);
	fetch c1 into :ll_coumnid,:ls_columnname;

		do while sqlca.sqlcode <> 100
 			// Get the old value for the data column
			       ls_old_value = dw_1.GetItemString(li_row, ll_coumnid, Primary!, true)
			 // Get the new value for the data column
			       ls_new_value = This.GetItemString(li_row, ll_coumnid)
			
			// Get the unique Value of Row
			
			ls_unique_id=dw_1.GetItemString(li_row, 1, Primary!, true)
					 
					 
					 if ls_old_value <> ls_new_value then
						insert into fb_log(table_name, Unique_key, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
												('fb_task',:ls_unique_id,'U',:ls_columnname,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
							if sqlca.sqlcode = -1 then
								messagebox("SQL Error : While Inserting Into Log Table ",SQLCA.SQLErrtext,Information!)
								rollback using sqlca;
								return -1 
							 end if
						end if
					 
					 
					 
		setnull(ll_coumnid);setnull(ls_columnname);

	fetch c1 into :ll_coumnid,:ls_columnname;
	loop
end if	
NEXT
close c1;
end event

