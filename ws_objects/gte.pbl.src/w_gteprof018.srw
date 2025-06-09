$PBExportHeader$w_gteprof018.srw
forward
global type w_gteprof018 from window
end type
type cb_4 from commandbutton within w_gteprof018
end type
type cb_3 from commandbutton within w_gteprof018
end type
type cb_2 from commandbutton within w_gteprof018
end type
type cb_1 from commandbutton within w_gteprof018
end type
type dw_1 from datawindow within w_gteprof018
end type
end forward

global type w_gteprof018 from window
integer width = 3826
integer height = 2288
boolean titlebar = true
string title = "(w_gteprof008) Source Wise Fine Leaf Count"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean clientedge = true
event ue_option ( )
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteprof018 w_gteprof018

type variables
long ll_ctr, ll_cnt,l_ctr,ll_elect,ll_hsd,ll_user_level
string ls_temp,ls_del_ind,ls_ty,ls_sup_id,ls_tmp_id,ls_appr_ind,ls_entry_user, ls_appr_by,ls_last,ls_count, ls_cntind
boolean lb_neworder, lb_query
double ld_lfbd1, ld_lfbd2, ld_lfbd3, ld_blfbd1, ld_flper, ldcorlfper, ld_fbmc, ld_cbmc
datetime ld_dt

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_stmp, string fs_vtmp, date fd_dtmp)
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

public function integer wf_check_fillcol (integer fl_row);
if dw_1.rowcount() > 0 and fl_row > 0 then
	date ld_dt_1
	ld_dt_1 = date(dw_1.getitemdatetime(fl_row,'dbsc_date'))
	if (isnull(dw_1.getitemstring(fl_row,'dbsc_supname')) or  len(dw_1.getitemstring(fl_row,'dbsc_supname'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'dbsc_vehicleno')) or len(dw_1.getitemstring(fl_row,'dbsc_vehicleno'))=0) or &
		isnull(dw_1.getitemnumber(fl_row,'dbsc_greenleaf')) or dw_1.getitemnumber(fl_row,'dbsc_greenleaf')=0 or &
		isnull(dw_1.getitemnumber(fl_row,'dbsc_fineleafprcnt')) or dw_1.getitemnumber(fl_row,'dbsc_fineleafprcnt')=0 or &
		isnull(ld_dt_1) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Date, Supplier, Vehicle No., Green Leaf, Fine Leaf Please Check !!!')
		 return -1
	end if
end if
return 1

end function

public function integer wf_check_duplicate_rec (string fs_stmp, string fs_vtmp, date fd_dtmp);long fl_row
string ls_stmp,ls_vtmp
date ld_dtmp

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount())
		ls_stmp = dw_1.getitemstring(fl_row,'dbsc_supname')
		ls_vtmp = dw_1.getitemstring(fl_row,'dbsc_vehicleno')
		ld_dtmp = date(dw_1.getitemdatetime(fl_row,'dbsc_date'))
		
		if ls_stmp = fs_stmp and ls_vtmp = fs_vtmp and ld_dtmp = fd_dtmp then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row: "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gteprof018.create
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

on w_gteprof018.destroy
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

type cb_4 from commandbutton within w_gteprof018
integer x = 809
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

type cb_3 from commandbutton within w_gteprof018
integer x = 544
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

IF (isnull(dw_1.getitemdatetime(dw_1.rowcount(),'dbsc_date')) or isnull(dw_1.getitemstring(dw_1.rowcount(),'dbsc_vehicleno')) & 
	or isnull(dw_1.getitemstring(dw_1.rowcount(),'dbsc_supname'))) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF


IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	
	if dw_1.rowcount() > 0 then
		IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
			return 1
		END IF
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

type cb_2 from commandbutton within w_gteprof018
integer x = 279
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
	dw_1.setcolumn('dbsc_date')
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
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gteprof018
integer x = 14
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
	dw_1.setitem(dw_1.getrow(),'dbsc_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'dbsc_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'dbsc_date',datetime(today()))
	dw_1.setcolumn('dbsc_date')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'dbsc_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'dbsc_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'dbsc_date',datetime(today()))
	dw_1.setcolumn('dbsc_date')
end if


end event

type dw_1 from datawindow within w_gteprof018
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 104
integer width = 3739
integer height = 2056
integer taborder = 30
string dataobject = "dw_gteprof018"
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
				dw_1.setitem(newrow,'dbsc_entry_by',gs_user)
				dw_1.setitem(newrow,'dbsc_entry_dt',datetime(today()))
				dw_1.setitem(newrow,'dbsc_date',datetime(today()))
				dw_1.setcolumn('dbsc_date')
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

event itemchanged;date ld_dttmp
string ls_vehicletmp,ls_suptmp
if lb_query = false then		
		if dwo.name = 'dbsc_date' then
			if date(data) > date(today()) then
				messagebox ('Warning','Date can not be greater than current date')
				return 1
			end if
			if isnull(data) then
				messagebox ('Warning','Enter a valid date')
				return 1
			end if
			ls_suptmp = dw_1.getitemstring(row,'dbsc_supname')
			ls_vehicletmp = dw_1.getitemstring( row, 'dbsc_vehicleno')
			ld_dttmp = date(data)
			select distinct 'x' into :ls_temp from fb_dailyballshootcounttrans where dbsc_vehicleno = :ls_vehicletmp and dbsc_date = :ld_dttmp and dbsc_supname = :ls_suptmp ;	
			if sqlca.sqlcode = 0 then
				messagebox('Warning','Record already exists for entered sdate')
				return 1
			end if
			if wf_check_duplicate_rec(ls_suptmp,ls_vehicletmp,ld_dttmp) = -1 then
				return 1
			end if
		end if
		
		if dwo.name = 'dbsc_supname' then
			ld_dttmp = date(dw_1.getitemdatetime(row,'dbsc_date'))
			ls_vehicletmp = dw_1.getitemstring( row, 'dbsc_vehicleno')
			ls_suptmp = data
			select distinct 'x' into :ls_temp from fb_dailyballshootcounttrans where dbsc_vehicleno = :ls_vehicletmp and dbsc_date = :ld_dttmp and dbsc_supname = :ls_suptmp ;
			if sqlca.sqlcode = 0 then
				messagebox('Warning','Record already exists for given date')
				return 1
			end if
			if wf_check_duplicate_rec(ls_suptmp,ls_vehicletmp,ld_dttmp) = -1 then
				return 1
			end if
		end if
		
		if dwo.name = 'dbsc_vehicleno' then
			ld_dttmp = date(dw_1.getitemdatetime(row,'dbsc_date'))
			ls_suptmp = dw_1.getitemstring( row, 'dbsc_supname')
			ls_vehicletmp = data
			select distinct 'x' into :ls_temp from fb_dailyballshootcounttrans where dbsc_vehicleno = :ls_vehicletmp and dbsc_date = :ld_dttmp and dbsc_supname = :ls_suptmp ;			
			if sqlca.sqlcode = 0 then
				messagebox('Warning','Record already exists for given date')
				return 1
			end if
			if wf_check_duplicate_rec(ls_suptmp,ls_vehicletmp,ld_dttmp) = -1 then
				return 1
			end if
		end if	
		
		if dwo.name = 'dbsc_fineleafprcnt' then
			if integer(data)>100 then
				messagebox('Warning','Percentage can not be greater than 100')
				return 1
			end if
		end if
		cb_3.enabled = true
end if

if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if

end event

