$PBExportHeader$w_gteprof006.srw
forward
global type w_gteprof006 from window
end type
type gridgenset from tab within w_gteprof006
end type
type tabpage_1 from userobject within gridgenset
end type
type dw_1 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within gridgenset
dw_1 dw_1
end type
type tabpage_2 from userobject within gridgenset
end type
type dw_2 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within gridgenset
dw_2 dw_2
end type
type gridgenset from tab within w_gteprof006
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type st_1 from statictext within w_gteprof006
end type
type dp_1 from datepicker within w_gteprof006
end type
type cb_4 from commandbutton within w_gteprof006
end type
type cb_3 from commandbutton within w_gteprof006
end type
type cb_2 from commandbutton within w_gteprof006
end type
type cb_1 from commandbutton within w_gteprof006
end type
end forward

global type w_gteprof006 from window
integer width = 3794
integer height = 2564
boolean titlebar = true
string title = "(w_gteprof006) Grid And Own Gen Set Reading"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
gridgenset gridgenset
st_1 st_1
dp_1 dp_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_gteprof006 w_gteprof006

type variables
long ll_ctr, ll_cnt,l_ctr,ll_elect,ll_elect_m,ll_elect_d,ll_elect_i,ll_elect_p,ll_user_level
string ls_temp,ls_del_ind,ls_mac_id,ls_tmp_id,ls_appr_ind,ls_entry_user, ls_appr_by, ls_type
boolean lb_neworder, lb_query,lb_save
double ld_hrs, ld_min, ld_hsd, ld_tothrs,ld_gas
datetime ld_rundt,ld_appr_dt

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fl_mac_id, datetime fd_run_dt)
end prototypes

event ue_option();//choose case gs_ueoption
//	case "PRINT"
//			OpenWithParm(w_print,this.dw_1)
//	case "PRINTPREVIEW"
//			this.dw_1.modify("datawindow.print.preview = yes")
//	case "RESETPREVIEW"
//			this.dw_1.modify("datawindow.print.preview = no")
//	case "SAVEAS"
//			this.dw_1.saveas()
//	case "FILTER"
//			setnull(gs_filtertext)
//			this.dw_1.setredraw(false)
//			this.dw_1.setfilter(gs_filtertext)
//			this.dw_1.filter()
//			this.dw_1.groupcalc()
//			if this.dw_1.rowcount() > 0 then;
//				this.dw_1.setredraw(true)
//			else
//				Messagebox('Warning','Data Not Available In Given Criteria')
//			end if
//	case "SORT"
//			setnull(gs_sorttext)
//			this.dw_1.setredraw(false)
//			this.dw_1.setsort(gs_sorttext)
//			this.dw_1.sort()
//			this.dw_1.groupcalc()
//			if this.dw_1.rowcount() > 0 then;
//				this.dw_1.setredraw(true)
//			else
//				Messagebox('Warning','Data Not Available In Given Criteria')
//			end if
//end choose
//
//
end event

public function integer wf_check_fillcol (integer fl_row);//if dw_1.rowcount() > 0 and fl_row > 0 then
//	if (isnull(dw_1.getitemnumber(fl_row,'peg_elect')) or  dw_1.getitemnumber(fl_row,'peg_elect') = 0 or &
//		isnull(dw_1.getitemnumber(fl_row,'peg_hrs')) or  dw_1.getitemnumber(fl_row,'peg_hrs') = 0 or &
//		((isnull(dw_1.getitemnumber(fl_row,'peg_hsd')) or dw_1.getitemnumber(fl_row,'peg_hsd') = 0) and &
//		  (isnull(dw_1.getitemnumber(fl_row,'peg_gas')) or dw_1.getitemnumber(fl_row,'peg_gas') = 0) and &
//		   (isnull(dw_1.getitemstring(fl_row,'machine_type')) or dw_1.getitemstring(fl_row,'machine_type') = 'PGEN')) or &
//		(gs_garden_snm = 'NP' and dw_1.getitemnumber(fl_row,'manufacture') = 0 and dw_1.getitemnumber(fl_row,'domestic') = 0 and dw_1.getitemnumber(fl_row,'irregation') = 0 and dw_1.getitemnumber(fl_row,'pouch') = 0) or &
//		(gs_garden_snm <> 'NP' and dw_1.getitemnumber(fl_row,'manufacture') = 0 and dw_1.getitemnumber(fl_row,'domestic') = 0 and dw_1.getitemnumber(fl_row,'irregation') = 0)) then
//	    messagebox('Warning: One Of The Following Fields Are Blank','Electricity Units Received/Generated, Total Run Time, HSD Oil/Gas, Manufacture/Domestic/Irrigation/Pouch, Please Check !!!')
//		 return -1
//	end if
//end if
return 1
end function

public function integer wf_check_duplicate_rec (string fl_mac_id, datetime fd_run_dt);long fl_row
string ls_mac_id1
datetime ld_run_dt1

gridgenset.tabpage_1.dw_1.SelectRow(0, FALSE)
if gridgenset.tabpage_1.dw_1.rowcount() > 1 then
	for fl_row = 1 to (gridgenset.tabpage_1.dw_1.rowcount() - 1)
		ls_mac_id1 = gridgenset.tabpage_1.dw_1.getitemstring(fl_row,'machine_id')
		ld_run_dt1 = gridgenset.tabpage_1.dw_1.getitemdatetime(fl_row,'peg_date')
		
		if ls_mac_id1 = fl_mac_id and ld_run_dt1 = fd_run_dt then
			gridgenset.tabpage_1.dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gteprof006.create
this.gridgenset=create gridgenset
this.st_1=create st_1
this.dp_1=create dp_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.gridgenset,&
this.st_1,&
this.dp_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_gteprof006.destroy
destroy(this.gridgenset)
destroy(this.st_1)
destroy(this.dp_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;gridgenset.tabpage_1.dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false
//gridgenset.tabpage_1.dw_1.modify("t_co.text = '"+gs_co_name+"'")

if f_openwindow(gridgenset.tabpage_1.dw_1) = -1 then	
	close(this)
	return 1
end if

if gs_garden_snm <> 'NP' then
	gridgenset.tabpage_1.dw_1.modify("pouch.protect = 1")
elseif gs_garden_snm = 'NP' then
	gridgenset.tabpage_1.dw_1.modify("pouch.protect = 0")
end if

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
	if gridgenset.tabpage_1.dw_1.rowcount() > 0  then
		cb_3.triggerevent(clicked!)
	end if
end if
end event

type gridgenset from tab within w_gteprof006
event create ( )
event destroy ( )
integer x = 14
integer y = 116
integer width = 3698
integer height = 2212
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on gridgenset.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on gridgenset.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within gridgenset
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 3662
integer height = 2088
long backcolor = 67108864
string text = "Grid & Genset Reading"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within tabpage_1
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer y = 12
integer width = 3653
integer height = 2052
integer taborder = 80
string dataobject = "dw_gteprof006"
boolean hscrollbar = true
boolean vscrollbar = true
end type

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
//
end event

event ue_keydwn;//if lb_neworder = true then
//	IF KeyDown(KeyF6!) THEN
//		dw_1.deleterow(dw_1.rowcount())
//	end if
//	if dw_1.rowcount() = 0 then
//		cb_3.enabled = false
//	end if
//end if

end event

event itemchanged;if dwo.name = 'peg_date'  then
	ld_rundt = datetime(data)
	ls_mac_id = dw_1.getitemstring(row,'machine_id')

//	if date(left(string(ld_rundt),10)) > date(string(today(),'dd/mm/yyyy')) then
//		messagebox('Warning','Reading Date Should Not Be > Current Date, Please Check !!!')
//		return 1
//	end if

	if ld_rundt > datetime(today()) then
		messagebox('Warning','Reading Date Should Not Be > Current Date, Please Check !!!')
		return 1
	end if

	select distinct MACHINE_TYPE into :ls_type from fb_machine where upper(machine_id) = upper(:ls_mac_id);
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Machine Type',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode  = 0 then
		dw_1.setitem(row,'machine_type',ls_type)
	end if	
	
	if  wf_check_duplicate_rec(ls_mac_id,ld_rundt) = -1 then return 1
	
	select distinct 'x' into :ls_temp from fb_pegeneration where upper(machine_id) = upper(:ls_mac_id) and trunc(peg_date) = trunc(:ld_rundt);
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Machine Details',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode  = 0 then
		messagebox('Warning!','Machine Reading For Selected Date Already Exists, Please Check !!!')
		return 1
	end if	
end if

if dwo.name = 'peg_hsd' then
	ld_hsd = long(data)
	ld_gas = dw_1.getitemnumber(row,'peg_gas')
	if ld_gas > 0 then
		messagebox('Warning!','When Gas Is Entered Then HSD Oil Is Not Required, Please Check !!!')
		return 1
	end if
end if

if dwo.name = 'peg_gas' then
	ld_gas = double(data)
	ld_hsd = dw_1.getitemnumber(row,'peg_hsd')
	if ld_hsd > 0 then
		messagebox('Warning!','When HSD Oil Is Entered Then Gas Is Not Required, Please Check !!!')
		return 1
	end if	
end if



dw_1.setitem(row,'peg_entry_by',gs_user)
dw_1.setitem(row,'peg_entry_dt',datetime(today()))

cb_3.enabled = true
end event

event itemfocuschanged;if dwo.name = 'peg_date'  then
	ld_rundt = datetime(dw_1.gettext())
	ls_mac_id = dw_1.getitemstring(row,'machine_id')
	
	select distinct MACHINE_TYPE into :ls_type from fb_machine where upper(machine_id) = upper(:ls_mac_id);
	if sqlca.sqlcode = -1 then
		messagebox('Error : While Getting Machine Type',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	elseif sqlca.sqlcode  = 0 then
		dw_1.setitem(row,'machine_type',ls_type)
	end if	
	
//	if  wf_check_duplicate_rec(ls_mac_id,ld_rundt) = -1 then return 1
//	
//	select distinct 'x' into :ls_temp from fb_pegeneration where upper(machine_id) = upper(:ls_mac_id) and trunc(peg_date) = :ld_rundt;
//	if sqlca.sqlcode = -1 then
//		messagebox('Error : While Getting Machine Details',sqlca.sqlerrtext)
//		rollback using sqlca;
//		return 1
//	elseif sqlca.sqlcode  = 0 then
//		messagebox('Warning!','Machine ID Already Exists For This Date, Please Check !!!')
//		return 1
//	end if	
end if
dw_1.setitem(row,'peg_entry_by',gs_user)
dw_1.setitem(row,'peg_entry_dt',datetime(today()))


end event

type tabpage_2 from userobject within gridgenset
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 3662
integer height = 2088
long backcolor = 67108864
string text = "Unit Used"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from datawindow within tabpage_2
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer y = 12
integer width = 3639
integer height = 2052
integer taborder = 40
string dataobject = "dw_gteprof006a"
boolean hscrollbar = true
boolean vscrollbar = true
end type

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
//
end event

event ue_keydwn;//if lb_neworder = true then
//	IF KeyDown(KeyF6!) THEN
//		dw_1.deleterow(dw_1.rowcount())
//	end if
//	if dw_1.rowcount() = 0 then
//		cb_3.enabled = false
//	end if
//end if

end event

event itemchanged;cb_3.enabled = true
end event

type st_1 from statictext within w_gteprof006
integer x = 14
integer y = 32
integer width = 343
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Reading Date"
boolean focusrectangle = false
end type

type dp_1 from datepicker within w_gteprof006
integer x = 370
integer y = 20
integer width = 384
integer height = 84
integer taborder = 60
boolean border = true
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2024-07-30"), Time("11:41:43.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type cb_4 from commandbutton within w_gteprof006
integer x = 1568
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

event clicked;if gridgenset.tabpage_1.dw_1.modifiedcount() > 0 or gridgenset.tabpage_1.dw_1.deletedcount() > 0 then
	IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
		close(parent)
	else
		return
	end if
else
	close(parent)
end if
end event

type cb_3 from commandbutton within w_gteprof006
integer x = 1303
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

event clicked;if gridgenset.tabpage_1.dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	if gridgenset.tabpage_1.dw_1.rowcount() > 0 then
		IF wf_check_fillcol(gridgenset.tabpage_1.dw_1.getrow()) = -1 THEN
			return 1
		END IF
	end if

	
	for ll_ctr = gridgenset.tabpage_1.dw_1.rowcount() to 1 step -1
		IF (isnull(gridgenset.tabpage_1.dw_1.getitemnumber(ll_ctr,'peg_elect')) or gridgenset.tabpage_1.dw_1.getitemnumber(ll_ctr,'peg_elect') = 0) THEN
			 gridgenset.tabpage_1.dw_1.deleterow(ll_ctr)
		END IF
	next	
	
	if gridgenset.tabpage_1.dw_1.rowcount() > 0 then
		for ll_ctr = 1  to gridgenset.tabpage_1.dw_1.rowcount()
			
			if trim(gridgenset.tabpage_1.dw_1.getitemstring(ll_ctr,'machine_type')) = 'PGEN' then
				if  (gridgenset.tabpage_1.dw_1.getitemnumber(ll_ctr,'peg_hsd') = 0 and gridgenset.tabpage_1.dw_1.getitemnumber(ll_ctr,'peg_gas') = 0 ) then
					  messagebox('Warning!','HSD Oil/Gas Should Not Be Blank or 0 In Case Of Genset, Please Check !!!')
				  return 1
				end if
			end if
			
				ld_hrs = gridgenset.tabpage_1.dw_1.getitemnumber(ll_ctr,'peg_hrs')
				ld_min = gridgenset.tabpage_1.dw_1.getitemnumber(ll_ctr,'peg_min')
				if isnull(ld_hrs) then ld_hrs = 0
				if isnull(ld_min) then ld_min = 0
				ld_tothrs = ld_hrs + (ld_min/ 60)
				if isnull(ld_tothrs) then ld_tothrs = 0
				gridgenset.tabpage_1.dw_1.setitem(ll_ctr,'peg_runhours',ld_tothrs)
		next	

	end if

	if gridgenset.tabpage_1.dw_1.getitemnumber(gridgenset.tabpage_1.dw_1.getrow(),'tot_elec') <> (gridgenset.tabpage_2.dw_2.getitemnumber(gridgenset.tabpage_2.dw_2.getrow(),'grid_electric_tot') + gridgenset.tabpage_2.dw_2.getitemnumber(gridgenset.tabpage_2.dw_2.getrow(),'gen_electric_tot')+ gridgenset.tabpage_2.dw_2.getitemnumber(gridgenset.tabpage_2.dw_2.getrow(),'sol_electric_tot')) then
		messagebox('Warning!','Units Used in Manufacturing + Domestic + Irrigation + Pouch Should Be Equal To Units Received/Generated !!!')
		return 1
	end if
			
	if gridgenset.tabpage_1.dw_1.getitemnumber(gridgenset.tabpage_1.dw_1.getrow(),'tot_hsd') <> (gridgenset.tabpage_2.dw_2.getitemnumber(gridgenset.tabpage_2.dw_2.getrow(),'grid_hsd_tot') + gridgenset.tabpage_2.dw_2.getitemnumber(gridgenset.tabpage_2.dw_2.getrow(),'gen_hsd_tot')+ gridgenset.tabpage_2.dw_2.getitemnumber(gridgenset.tabpage_2.dw_2.getrow(),'sol_hsd_tot')) then
		messagebox('Warning!','HSD in Manufacturing + Domestic + Irrigation + Pouch Should Be Equal To Total HSD !!!')
		return 1
	end if


	if gridgenset.tabpage_1.dw_1.update(true,false) = 1 and gridgenset.tabpage_2.dw_2.update(true,false) = 1 then
		gridgenset.tabpage_1.dw_1.resetupdate();
		gridgenset.tabpage_2.dw_2.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		gridgenset.tabpage_1.dw_1.reset()
		gridgenset.tabpage_2.dw_2.reset()
	else
		messagebox('SQL Error : During Save',sqlca.sqlerrtext)
		rollback using sqlca;
		return 1
	end if
	cb_3.enabled = false
	gridgenset.tabpage_1.dw_1.reset()
	gridgenset.tabpage_2.dw_2.reset()
else
	return
end if 
end event

type cb_2 from commandbutton within w_gteprof006
integer x = 1038
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

event clicked;if date(dp_1.text) > date(today()) then
	messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
	return 1
end if

ld_rundt = datetime(dp_1.text)

select distinct 'x' into :ls_temp from fb_pegeneration where trunc(peg_date) = trunc(:ld_rundt);
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Machine Details',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode  = 100 then
	messagebox('Warning!','Machine Reading For Selected Date Not Exists, Please Check !!!')
	return 1
end if

if cb_2.text = "&Query" then
	lb_neworder = true
	if gridgenset.tabpage_1.dw_1.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	gridgenset.tabpage_1.dw_1.reset()
	lb_query = true
	gridgenset.tabpage_1.dw_1.modify("datawindow.queryclear= yes")
	gridgenset.tabpage_1.dw_1.Object.datawindow.querymode= 'yes'
	gridgenset.tabpage_1.dw_1.SetFocus ()
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
 	gridgenset.tabpage_1.dw_1.settransobject(sqlca)
	gridgenset.tabpage_1.dw_1.SetRedraw (FALSE)
	gridgenset.tabpage_1.dw_1.Object.datawindow.querymode = 'no'
	gridgenset.tabpage_1.dw_1.Retrieve(gs_user,date(ld_rundt))
	gridgenset.tabpage_1.dw_1.SetRedraw (TRUE)
	gridgenset.tabpage_2.dw_2.settransobject(sqlca)
	gridgenset.tabpage_2.dw_2.SetRedraw (FALSE)
	gridgenset.tabpage_2.dw_2.Object.datawindow.querymode = 'no'
	gridgenset.tabpage_2.dw_2.Retrieve(gs_user,date(ld_rundt))
	gridgenset.tabpage_2.dw_2.SetRedraw (TRUE)
	cb_2.text = "&Query"
	lb_query = false
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gteprof006
integer x = 773
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
	if gridgenset.tabpage_1.dw_1.modifiedcount() > 0 then
		if messagebox("Confirmation","Row has been modified, Do You Want To Add New Record ...!",question!,yesno!,1) = 2 then
			return
		end if
	end if
end if
gridgenset.tabpage_1.dw_1.reset()
gridgenset.tabpage_2.dw_2.reset()

gridgenset.tabpage_1.dw_1.settransobject(sqlca)
gridgenset.tabpage_2.dw_2.settransobject(sqlca)

if date(dp_1.text) > date(today()) then
	messagebox('Warning!','Reading Date should not be Greater Than Current date, Please Check !!!')
	return 1
end if

ld_rundt = datetime(dp_1.text)


select distinct 'x' into :ls_temp from fb_pegeneration where trunc(peg_date) = trunc(:ld_rundt);
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Machine Details',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode  = 0 then
	messagebox('Warning!','Machine Reading For Selected Date Already Exists, Please Check !!!')
	return 1
end if	

DECLARE c1 CURSOR FOR  
select MACHINE_ID,MACHINE_TYPE from fb_machine a where MACHINE_TYPE in ('GRID','PGEN','SOLA') and MACHINE_ACTIVE='1' and 
	   not exists (select distinct MACHINE_ID from fb_pegeneration b where trunc(peg_date) = trunc(:ld_rundt) and a.MACHINE_ID = b.MACHINE_ID)
order by MACHINE_TYPE;

open c1;
	
IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_mac_id,:ls_type;
	
	do while sqlca.sqlcode <> 100
		gridgenset.tabpage_1.dw_1.scrolltorow(gridgenset.tabpage_1.dw_1.insertrow(0))
		gridgenset.tabpage_1.dw_1.setitem(gridgenset.tabpage_1.dw_1.getrow(),'machine_id',ls_mac_id)
		gridgenset.tabpage_1.dw_1.setitem(gridgenset.tabpage_1.dw_1.getrow(),'machine_type',ls_type)
		gridgenset.tabpage_1.dw_1.setitem(gridgenset.tabpage_1.dw_1.getrow(),'peg_date',date(dp_1.text))
		gridgenset.tabpage_1.dw_1.setitem(gridgenset.tabpage_1.dw_1.getrow(),'peg_entry_by',gs_user)
		gridgenset.tabpage_1.dw_1.setitem(gridgenset.tabpage_1.dw_1.getrow(),'peg_entry_dt',datetime(today()))
		fetch c1 into :ls_mac_id,:ls_type;
	loop
END IF
close c1;
setnull(ls_type)
DECLARE c2 CURSOR FOR  
SELECT pd_code from FB_PARAM_DETAIL where PD_DOC_TYPE = 'POWERCONSUME' and  PD_PERIOD_TO is null order by 1;
open c2;
	
IF sqlca.sqlcode = 0 THEN
	fetch c2 into :ls_type;
	
	do while sqlca.sqlcode <> 100
		gridgenset.tabpage_2.dw_2.scrolltorow(gridgenset.tabpage_2.dw_2.insertrow(0))
		gridgenset.tabpage_2.dw_2.setitem(gridgenset.tabpage_2.dw_2.getrow(),'pegd_date',date(dp_1.text))
		gridgenset.tabpage_2.dw_2.setitem(gridgenset.tabpage_2.dw_2.getrow(),'pegd_time',date(dp_1.text))
		gridgenset.tabpage_2.dw_2.setitem(gridgenset.tabpage_2.dw_2.getrow(),'pegd_gengridflag','GRID')
		gridgenset.tabpage_2.dw_2.setitem(gridgenset.tabpage_2.dw_2.getrow(),'epc_id',ls_type)
		fetch c2 into :ls_type;
	loop
END IF
close c2;
setnull(ls_type)
DECLARE c3 CURSOR FOR  
SELECT pd_code from FB_PARAM_DETAIL where PD_DOC_TYPE = 'POWERCONSUME' and  PD_PERIOD_TO is null order by 1;
open c3;
	
IF sqlca.sqlcode = 0 THEN
	fetch c3 into :ls_type;
	
	do while sqlca.sqlcode <> 100
		gridgenset.tabpage_2.dw_2.scrolltorow(gridgenset.tabpage_2.dw_2.insertrow(0))
		gridgenset.tabpage_2.dw_2.setitem(gridgenset.tabpage_2.dw_2.getrow(),'pegd_date',date(dp_1.text))
		gridgenset.tabpage_2.dw_2.setitem(gridgenset.tabpage_2.dw_2.getrow(),'pegd_time',date(dp_1.text))
		gridgenset.tabpage_2.dw_2.setitem(gridgenset.tabpage_2.dw_2.getrow(),'pegd_gengridflag','PGEN')
		gridgenset.tabpage_2.dw_2.setitem(gridgenset.tabpage_2.dw_2.getrow(),'epc_id',ls_type)
		fetch c3 into :ls_type;
	loop
END IF
close c3;


setnull(ls_type)
DECLARE c4 CURSOR FOR  
SELECT pd_code from FB_PARAM_DETAIL where PD_DOC_TYPE = 'POWERCONSUME' and  PD_PERIOD_TO is null order by 1;
open c4;
	
IF sqlca.sqlcode = 0 THEN
	fetch c4 into :ls_type;
	
	do while sqlca.sqlcode <> 100
		gridgenset.tabpage_2.dw_2.scrolltorow(gridgenset.tabpage_2.dw_2.insertrow(0))
		gridgenset.tabpage_2.dw_2.setitem(gridgenset.tabpage_2.dw_2.getrow(),'pegd_date',date(dp_1.text))
		gridgenset.tabpage_2.dw_2.setitem(gridgenset.tabpage_2.dw_2.getrow(),'pegd_time',date(dp_1.text))
		gridgenset.tabpage_2.dw_2.setitem(gridgenset.tabpage_2.dw_2.getrow(),'pegd_gengridflag','SOLA')
		gridgenset.tabpage_2.dw_2.setitem(gridgenset.tabpage_2.dw_2.getrow(),'epc_id',ls_type)
		fetch c4 into :ls_type;
	loop
END IF
close c4;

gridgenset.tabpage_1.dw_1.setfocus()
gridgenset.tabpage_1.dw_1.scrolltorow(1)
gridgenset.tabpage_1.dw_1.setcolumn('peg_elect')
lb_neworder = true
lb_query = false


end event

