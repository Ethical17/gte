$PBExportHeader$w_gteflf002.srw
forward
global type w_gteflf002 from window
end type
type cb_4 from commandbutton within w_gteflf002
end type
type cb_3 from commandbutton within w_gteflf002
end type
type cb_2 from commandbutton within w_gteflf002
end type
type cb_1 from commandbutton within w_gteflf002
end type
type dw_1 from datawindow within w_gteflf002
end type
end forward

global type w_gteflf002 from window
integer width = 5111
integer height = 4352
boolean titlebar = true
string title = "(w_gteflf002) New Planting / Replanting"
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
global w_gteflf002 w_gteflf002

type variables
long ll_ctr, ll_cnt, ll_year,ll_user_level
string ls_temp,ls_del_ind,ls_tmp_id, ls_section_id,ls_last,ls_count, ls_jat, ls_hedging
double ld_x, ld_y, ld_z, ld_std_plant, ld_area
boolean lb_neworder, lb_query

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_sec_id, long fl_sec_year, string fs_jat, string fl_hed)
public function double wf_cal_stdplant (string fs_hedg, double fd_x, double fd_y, double fd_z, double fd_area)
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
	if (isnull(dw_1.getitemstring(fl_row,'section_id')) or  len(dw_1.getitemstring(fl_row,'section_id'))=0 or &
		 isnull(dw_1.getitemnumber(fl_row,'sectionplant_year')) or  dw_1.getitemnumber(fl_row,'sectionplant_year') <= 0 or &
		 isnull(dw_1.getitemstring(fl_row,'sectionplant_type')) or  len(dw_1.getitemstring(fl_row,'sectionplant_type'))=0 or &
		 isnull(dw_1.getitemstring(fl_row,'sectionplant_jat')) or  len(dw_1.getitemstring(fl_row,'sectionplant_jat'))=0 or &
		 isnull(dw_1.getitemstring(fl_row,'sectionplant_hedging')) or  len(dw_1.getitemstring(fl_row,'sectionplant_hedging'))= 0 or &
		 (dw_1.getitemnumber(fl_row,'hedging_hedges') + dw_1.getitemnumber(fl_row,'hedging_bushes') + dw_1.getitemnumber(fl_row,'hedging_treelines'))= 0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Section ID, Plantation Type, Plantation Year, Plant Jat, Section Hedging, Distance Between Hedge or Bush or Treelines, Please Check !!!')
		 return -1
	end if
end if
return 1


//if dw_1.rowcount() > 0 and fl_row > 0 then
//	if (isnull(dw_1.getitemstring(fl_row,'section_id')) or  len(dw_1.getitemstring(fl_row,'section_id'))=0 or &
//		 isnull(dw_1.getitemnumber(fl_row,'sectionplant_year')) or  dw_1.getitemnumber(fl_row,'sectionplant_year') <= 0 or &
//		 isnull(dw_1.getitemstring(fl_row,'sectionplant_type')) or  len(dw_1.getitemstring(fl_row,'sectionplant_type'))=0 or &
//		 isnull(dw_1.getitemstring(fl_row,'sectionplant_jat')) or  len(dw_1.getitemstring(fl_row,'sectionplant_jat'))=0 or &
//		 isnull(dw_1.getitemstring(fl_row,'sectionplant_hedging')) or  len(dw_1.getitemstring(fl_row,'sectionplant_hedging'))= 0 or &
//		 isnull(dw_1.getitemnumber(fl_row,'sectionplant_stdplant')) or  dw_1.getitemnumber(fl_row,'sectionplant_stdplant')= 0 or &
//		 (dw_1.getitemnumber(fl_row,'hedging_hedges') + dw_1.getitemnumber(fl_row,'hedging_bushes') + dw_1.getitemnumber(fl_row,'hedging_treelines'))= 0) then
//	    messagebox('Warning: One Of The Following Fields Are Blank','Section ID, Plantation Type, Plantation Year, Plant Jat, Section Hedging, Distance Between Hedge or Bush or Treelines, Standard Plants, Please Check !!!')
//		 return -1
//	end if
//end if
end function

public function integer wf_check_duplicate_rec (string fs_sec_id, long fl_sec_year, string fs_jat, string fl_hed);long fl_row,ll_year1
string ls_sec_id1, ls_jat1, ls_hed1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_sec_id1 = dw_1.getitemstring(fl_row,'section_id')
		ll_year1 = dw_1.getitemnumber(fl_row,'sectionplant_year')
		ls_jat1 = dw_1.getitemstring(fl_row,'sectionplant_jat')
		ls_hed1 = dw_1.getitemstring(fl_row,'sectionplant_hedging')
		
		if ls_sec_id1 = fs_sec_id and ll_year1 = fl_sec_year and ls_jat1 = fs_jat and ls_hed1 = fl_hed then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function double wf_cal_stdplant (string fs_hedg, double fd_x, double fd_y, double fd_z, double fd_area);double ld_stdplant, ld_neum, ld_denom
if isnull(fs_hedg) then fs_hedg = '0'
if isnull(fd_x) then fd_x = 0
if isnull(string(fd_y)) then fd_y = 0
if isnull(string(fd_z)) then fd_z = 0
if isnull(fd_area) then fd_area = 0

ld_neum = (double(trim(fs_hedg)) * 107635)
ld_denom = (fd_y * (fd_x + fd_z))

if ld_denom = 0 then ld_denom = 1

ld_stdplant = round((fd_area * (ld_neum / ld_denom)),2)
return ld_stdplant
end function

on w_gteflf002.create
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

on w_gteflf002.destroy
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

type cb_4 from commandbutton within w_gteflf002
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

type cb_3 from commandbutton within w_gteflf002
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

IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'section_id')) or len(dw_1.getitemstring(dw_1.rowcount(),'section_id'))=0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
		
	for ll_ctr = dw_1.rowcount() to 1 step -1
		ls_section_id = dw_1.getitemstring(ll_ctr,'section_id')
		ls_hedging  = dw_1.getitemstring(ll_ctr,'sectionplant_hedging')
		ld_x  = dw_1.getitemnumber(ll_ctr,'hedging_hedges')
		ld_y  = dw_1.getitemnumber(ll_ctr,'hedging_bushes')
		ld_z  = dw_1.getitemnumber(ll_ctr,'hedging_treelines')
		ld_std_plant = dw_1.getitemnumber(ll_ctr,'sectionplant_stdplant')
		ll_year =  dw_1.getitemnumber(ll_ctr,'sectionplant_year')
		
		select distinct 'x' into :ls_temp from fb_section where section_id = :ls_section_id;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Section Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 0 then
			update  fb_section  set 	SECTION_HEDGING=:ls_hedging,
											SECTION_BUSHDIST= :ld_y,
											SECTION_HEDGEDIST= :ld_x,
											SECTION_TREELINEDIST= :ld_z,
											SECTION_FORMULAPLANTS= nvl(:ld_std_plant,0),
											section_uprootflag=0, section_plantstatus= '0Y' 
			where section_id= :ls_section_id;
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Updating Section Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			end if
		end if
		if dw_1.getitemstring(ll_ctr,'sectionplant_type') = 'R' then
			update fb_sectionplantation set SECTION_ACTIVE_IND = 'N' where section_id= :ls_section_id and SECTIONPLANT_YEAR < :ll_year;
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Updating Section plantation Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			end if

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

type cb_2 from commandbutton within w_gteflf002
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
	dw_1.settaborder('section_id',10)
	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('section_id')
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

type cb_1 from commandbutton within w_gteflf002
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
	dw_1.setitem(dw_1.getrow(),'section_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'section_entry_dt',datetime(today()))
	dw_1.setcolumn('section_id')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'section_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'section_entry_dt',datetime(today()))
	dw_1.setcolumn('section_id')
end if


end event

type dw_1 from datawindow within w_gteflf002
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 116
integer width = 4530
integer height = 2052
integer taborder = 30
string dataobject = "dw_gteflf002"
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
		dw_1.setitem(newrow,'section_entry_by',gs_user)
		dw_1.setitem(newrow,'section_entry_dt',datetime(today()))
		dw_1.setcolumn('section_id')
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
	if dwo.name = 'section_id'  then
		ls_section_id = data
		
		if f_check_initial_space(ls_section_id) = -1 then return 1
		
		//if f_check_string(ls_section_id) = -1 then return 1
		
		select nvl(SECTION_AREA,0) into :ld_area from fb_section where section_id = :ls_section_id;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Section Area',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		dw_1.setitem(row,'sec_area',ld_area)
	end if
	
	if dwo.name = 'sectionplant_year'  then
		ll_year = long(data)
		if f_check_initial_space(string(ll_year)) = -1 then return 1
		if long(string(today(),'YYYY')) < ll_year then
			messagebox('Warning!','Plantation Year Should Not Be Greater Than Current Year, Please Check !!!')
			return 1
		end if
	end if
	
	if dwo.name = 'sectionplant_jat'  then
		ls_jat = data
		if f_check_initial_space(ls_jat) = -1 then return 1
	end if
	
	if dwo.name = 'sectionplant_hedging'  then
		ls_hedging = data
		ls_section_id = dw_1.getitemstring(row,'section_id')
		ll_year  = dw_1.getitemnumber(row,'sectionplant_year')
		ld_area = dw_1.getitemnumber(row,'sec_area')
		ls_jat  = dw_1.getitemstring(row,'sectionplant_jat')
		ld_x  = dw_1.getitemnumber(row,'hedging_hedges')
		ld_y  = dw_1.getitemnumber(row,'hedging_bushes')
		ld_z  = dw_1.getitemnumber(row,'hedging_treelines')
		
		if f_check_initial_space(ls_hedging) = -1 then return 1
		
	//	if f_check_string(ls_hedging) = -1 then return 1
		
		if  wf_check_duplicate_rec(ls_section_id,ll_year,ls_jat,ls_hedging) = -1 then return 1
		
		ld_std_plant = wf_cal_stdplant(ls_hedging,ld_x,ld_y,ld_z,ld_area)
		
		if isnull(ld_std_plant) then ld_std_plant = 0
		
		select distinct 'x' into :ls_temp from fb_sectionplantation 
		where section_id = :ls_section_id and sectionplant_year = :ll_year and upper(sectionplant_jat) = upper(:ls_jat) and sectionplant_hedging = :ls_hedging;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Plantation Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox('Warning!','Details Already Exists For Entered Section, Year, Plant Jat and Section Heading , Please Check !!!')
			return 1
		end if
		
		dw_1.setitem(row,'sectionplant_stdplant',ld_std_plant)
		
	end if
	
	if dwo.name = 'hedging_hedges'  then
		ld_x = double(data)
		if f_check_initial_space(string(ld_x)) = -1 then return 1
		
		ls_hedging  = dw_1.getitemstring(row,'sectionplant_hedging')
		ld_y  = dw_1.getitemnumber(row,'hedging_bushes')
		ld_z  = dw_1.getitemnumber(row,'hedging_treelines')
		ld_area = dw_1.getitemnumber(row,'sec_area')
		
		ld_std_plant = wf_cal_stdplant(ls_hedging,ld_x,ld_y,ld_z,ld_area)
		if isnull(ld_std_plant) then ld_std_plant = 0
	
		dw_1.setitem(row,'sectionplant_stdplant',ld_std_plant)
	end if
	
	if dwo.name = 'hedging_bushes'  then
		ld_y = double(data)
		if f_check_initial_space(string(ld_x)) = -1 then return 1
		
		ls_hedging  = dw_1.getitemstring(row,'sectionplant_hedging')
		ld_x  = dw_1.getitemnumber(row,'hedging_hedges')
		ld_z  = dw_1.getitemnumber(row,'hedging_treelines')
		ld_area = dw_1.getitemnumber(row,'sec_area')
		
		ld_std_plant = wf_cal_stdplant(ls_hedging,ld_x,ld_y,ld_z,ld_area)
		if isnull(ld_std_plant) then ld_std_plant = 0
	
		dw_1.setitem(row,'sectionplant_stdplant',ld_std_plant)
	end if
	
	if dwo.name = 'hedging_treelines'  then
		ld_z = double(data)
		if f_check_initial_space(string(ld_x)) = -1 then return 1
		
		ls_hedging  = dw_1.getitemstring(row,'sectionplant_hedging')
		ld_x  = dw_1.getitemnumber(row,'hedging_hedges')
		ld_y  = dw_1.getitemnumber(row,'hedging_bushes')
		ld_area = dw_1.getitemnumber(row,'sec_area')
		
		ld_std_plant = wf_cal_stdplant(ls_hedging,ld_x,ld_y,ld_z,ld_area)
		if isnull(ld_std_plant) then ld_std_plant = 0
	
		dw_1.setitem(row,'sectionplant_stdplant',ld_std_plant)
	end if
dw_1.setitem(row,'section_entry_by',gs_user)
dw_1.setitem(row,'section_entry_dt',datetime(today()))

cb_3.enabled = true
end if

if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if


end event

