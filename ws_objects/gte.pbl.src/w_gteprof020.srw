$PBExportHeader$w_gteprof020.srw
forward
global type w_gteprof020 from window
end type
type cb_4 from commandbutton within w_gteprof020
end type
type cb_3 from commandbutton within w_gteprof020
end type
type cb_2 from commandbutton within w_gteprof020
end type
type cb_1 from commandbutton within w_gteprof020
end type
type dw_1 from datawindow within w_gteprof020
end type
end forward

global type w_gteprof020 from window
integer width = 4553
integer height = 2488
boolean titlebar = true
string title = "(w_gteprof013) Sorting"
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
global w_gteprof020 w_gteprof020

type variables
long ll_ctr,net, ll_cnt,l_ctr,ll_user_level,ll_season
string ls_temp,ls_del_ind,ls_tpc_id,ls_tmp_id,ls_entry_user,ls_name,ls_cat_id, ls_grade
boolean lb_neworder, lb_query
double ld_totqnty, ld_uns_bal_ctc, ld_uns_bal_ort, ld_uns_bal_green, ld_uns_bal_samp, ld_sostk
datetime ld_rundt, ld_maxsortdt,ld_maxpackdt, ld_maxtransdt
datawindowchild idw_grade

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (datetime fd_dt, string fs_tmp_id, long rownum)
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
	if (isnull(dw_1.getitemdatetime(fl_row,'tt_date')) or &
		isnull(dw_1.getitemstring(fl_row,'tpc_id')) or  len(dw_1.getitemstring(fl_row,'tpc_id')) = 0 or &
		isnull(dw_1.getitemstring(fl_row,'tmp_id')) or  len(dw_1.getitemstring(fl_row,'tmp_id'))= 0 or &
		isnull(dw_1.getitemnumber(fl_row,'tt_quantity')) or  dw_1.getitemnumber(fl_row,'tt_quantity')= 0 or &
		isnull(dw_1.getitemnumber(fl_row,'tt_season')) or  dw_1.getitemnumber(fl_row,'tt_season')= 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Tea Category, Tea Grade, Quantity and Season Please Check !!!')
		 return -1
	end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (datetime fd_dt, string fs_tmp_id, long rownum);long fl_row
string ls_tmpid
datetime ld_dt

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount())
		IF fl_row <> rownum then
			ld_dt = dw_1.getitemdatetime(fl_row,'tt_date')
			ls_tmpid = dw_1.getitemstring(fl_row,'tmp_id')
			if ld_dt = fd_dt and ls_tmpid = fs_tmp_id then
				dw_1.SelectRow(fl_row, TRUE)
				messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
				return -1
			end if
		end if
	next
end if
return 1
end function

on w_gteprof020.create
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

on w_gteprof020.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false


if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if


this.tag = Message.StringParm
ll_user_level = long(this.tag)

dw_1.GetChild ("tmp_id", idw_grade)
idw_grade.settransobject(sqlca)	
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

type cb_4 from commandbutton within w_gteprof020
integer x = 805
integer y = 16
integer width = 265
integer height = 100
integer taborder = 90
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

type cb_3 from commandbutton within w_gteprof020
integer x = 539
integer y = 16
integer width = 265
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Save"
end type

event clicked;string ls_tmpid
datetime ld_dt

if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	for ll_ctr = dw_1.rowcount() to 1 step -1
		IF (isnull(dw_1.getitemnumber(ll_ctr,'tt_quantity')) or dw_1.getitemnumber(ll_ctr,'tt_quantity') = 0) THEN
			 dw_1.deleterow(ll_ctr)
		END IF
	next	
	
	ls_tmpid = dw_1.getitemstring(dw_1.getrow(),'tmp_id')
	 ld_dt = dw_1.getitemdatetime(dw_1.getrow(),'tt_date')
	IF wf_check_fillcol(dw_1.getrow()) = -1 or wf_check_duplicate_rec(ld_dt,ls_tmpid,dw_1.getrow()) = -1 THEN
		return 1
	END IF
	select 'x' into :ls_temp from fb_teatransfer where tt_date = :ld_dt and tmp_id = :ls_tmpid;
	if sqlca.sqlcode = -1 then
		messagebox('Error occured while checking existing records',sqlca.sqlerrtext)
		return 1
	elseif sqlca.sqlcode = 0 then
		messagebox('Warning','A record for this grade on this date already exists in system')
		return 1
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

type cb_2 from commandbutton within w_gteprof020
integer x = 274
integer y = 16
integer width = 265
integer height = 100
integer taborder = 50
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
	dw_1.setcolumn('tt_date')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user,date(ld_maxsortdt),date(ld_maxtransdt))
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	lb_query = false
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gteprof020
integer x = 9
integer y = 16
integer width = 265
integer height = 100
integer taborder = 40
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
end if
dw_1.reset()

dw_1.settransobject(sqlca)

//select max(DTMP_SORTDATE) into :ld_maxsortdt from fb_dailysortedteamadeproduct ;
select max(DTMP_SORTDATE) into :ld_maxsortdt from fb_dailysortedteamadeproduct a, fb_teamadeproduct b where a.tmp_id = b.tmp_id and b.tpc_id = :ls_cat_id;
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Max Stock Date !!!',sqlca.sqlerrtext)
	return 1
end if

select max(DTP_DATE) into :ld_maxpackdt from fb_dailyteapacked;
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Max Stock Date !!!',sqlca.sqlerrtext)
	return 1
end if

select max(tt_date) into :ld_maxtransdt from fb_teatransfer;
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Max Transfer Date !!!',sqlca.sqlerrtext)
	return 1
end if

if isnull(ld_maxsortdt) then ld_maxsortdt = datetime('01/01/2000');

if isnull(ld_maxpackdt) then ld_maxpackdt = datetime('01/01/2000');

if isnull(ld_maxtransdt) then ld_maxtransdt = datetime('01/01/2000');


dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'TT_ENTRY_BY',gs_user)
	dw_1.setitem(dw_1.getrow(),'TT_ENTRY_DT',datetime(today()))
	dw_1.setcolumn('TT_DATE')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'TT_ENTRY_BY',gs_user)
	dw_1.setitem(dw_1.getrow(),'TT_ENTRY_DT',datetime(today()))
	dw_1.setcolumn('TT_DATE')
end if





end event

type dw_1 from datawindow within w_gteprof020
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 128
integer width = 4133
integer height = 1808
integer taborder = 60
string dataobject = "dw_gteprof020"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event key_down;string ls_tmpid
datetime ld_dt

if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() and dw_1.rowcount() > 1 then	
		 ls_tmpid = dw_1.getitemstring(currentrow,'tmp_id')
		 ld_dt = dw_1.getitemdatetime(currentrow,'tt_date')
		IF wf_check_fillcol(currentrow) = -1 or wf_check_duplicate_rec(ld_dt,ls_tmpid,currentrow) = -1 THEN
			return 1
		END IF
		select 'x' into :ls_temp from fb_teatransfer where tt_date = :ld_dt and tmp_id = :ls_tmpid;
		if sqlca.sqlcode = -1 then
			messagebox('Error occured while checking existing records',sqlca.sqlerrtext)
			return 1
		elseif sqlca.sqlcode = 0 then
			messagebox('Warning','A record for this grade on this date already exists in system')
			return 1
		end if
	END If
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem(newrow,'tt_entry_by',gs_user)
		dw_1.setitem(newrow,'tt_entry_dt',datetime(today()))
		
		dw_1.setcolumn('tt_date')
	end if
 end if
end if
//EB_EMPID, EB_YRMON, EB_AMOUNT, EB_PFFLAG, EB_ENTRY_BY, EB_ENTRY_DT, rowid

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event ue_dwnkey;//if lb_neworder = true then
//	IF KeyDown(KeyF6!) THEN
//		dw_1.deleterow(dw_1.rowcount())
//	end if
//	if dw_1.rowcount() = 0 then
//		cb_3.enabled = false
//	end if
//end if
end event

event ue_keydwn;//if lb_neworder = true then
//	IF KeyDown(KeyF6!) THEN
//		dw_1.deleterow(dw_1.rowcount())
//	end if
//	if dw_1.rowcount() = 0 then
//		cb_3.enabled = false
//	end if
//end if
//
end event

event itemchanged;if lb_query = false then
	
	if dwo.name = 'tt_date' then
		if date(data) > date(today()) then
			messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
			return 1
		end if
		if date(data) < date(ld_maxtransdt) then
			messagebox('Warning !','You Have Already Done Transfer Entry Of Date '+string(ld_maxtransdt,'dd/mm/yyyy')+' ,So You cannot Do Entry Before This Date !!')
			return 1
		end if
	end if


	if dwo.name = 'tt_season' then
		if long(data)  <> long(string(today(),'YYYY')) and  long(data)  <> long(string(today(),'YYYY')) - 1  then
			messagebox('Warning !','Please Enter A Valid Season !!!')
			return 1
		end if
	end if
	
	if dwo.name = 'tpc_id' then
		idw_grade.SetFilter ("tpc_id = '"+trim(data)+"'")
		idw_grade.settransobject(sqlca)	
		idw_grade.retrieve()
	end if
	
	if dwo.name = 'tmp_id' then
		ls_grade = data
		ls_tpc_id = dw_1.getitemstring(row,'tpc_id')
		idw_grade.accepttext( )
		ld_sostk = idw_grade.getitemnumber(idw_grade.getrow(),'sortstocktodate')
	end if
	
	if dwo.name = 'tt_quantity' then
		if double(data) > ld_sostk then
			messagebox('Warning','Transfer quantity can not be greater than Sorted Stock available.')
			return 1
		end if
	end if

	dw_1.setitem(row,'tt_entry_by',gs_user)
	dw_1.setitem(row,'tt_entry_dt',datetime(today()))
	
	cb_3.enabled = true
End if
end event

