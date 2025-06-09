$PBExportHeader$w_gteprof008.srw
forward
global type w_gteprof008 from window
end type
type cb_4 from commandbutton within w_gteprof008
end type
type cb_3 from commandbutton within w_gteprof008
end type
type cb_2 from commandbutton within w_gteprof008
end type
type cb_1 from commandbutton within w_gteprof008
end type
type dw_1 from datawindow within w_gteprof008
end type
end forward

global type w_gteprof008 from window
integer width = 4645
integer height = 2272
boolean titlebar = true
string title = "(w_gteprof008) Source Wise Fine Leaf Count"
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
global w_gteprof008 w_gteprof008

type variables
long ll_ctr, ll_cnt,l_ctr,ll_elect,ll_hsd,ll_user_level
string ls_temp,ls_del_ind,ls_ty,ls_sup_id,ls_tmp_id,ls_appr_ind,ls_entry_user, ls_appr_by,ls_last,ls_count, ls_cntind, ls_section, ls_field
boolean lb_neworder, lb_query
double ld_lfbd1, ld_lfbd2, ld_lfbd3, ld_blfbd1, ld_flper, ldcorlfper, ld_fbmc, ld_cbmc
datetime ld_dt

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_tran_ty, datetime fs_plk_dt)
public function integer wf_check_duplicate_rec_oth (string fs_tran_ty, string fs_supp, datetime fs_plk_dt)
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
 if dw_1.getitemstring(fl_row,'la_countind') = 'Y' then
	if (isnull(dw_1.getitemstring(fl_row,'la_type')) or  len(dw_1.getitemstring(fl_row,'la_type'))=0 or &
		(dw_1.getitemstring(fl_row,'la_type') = 'T' and (isnull(dw_1.getitemstring(fl_row,'sup_id')) or  len(dw_1.getitemstring(fl_row,'sup_id'))=0)) or &
		 isnull(dw_1.getitemdatetime(fl_row,'la_date')) or &
		 ((isnull(dw_1.getitemnumber(fl_row,'la_owllnb1')) or dw_1.getitemnumber(fl_row,'la_owllnb1')=0) and &
		  (isnull(dw_1.getitemnumber(fl_row,'la_owllnb2')) or dw_1.getitemnumber(fl_row,'la_owllnb2')=0) and &
		  (isnull(dw_1.getitemnumber(fl_row,'la_owllnb3')) or dw_1.getitemnumber(fl_row,'la_owllnb3')=0) and &
		  (isnull(dw_1.getitemnumber(fl_row,'la_owlbnj1')) or dw_1.getitemnumber(fl_row,'la_owlbnj1')=0)) ) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Date, Leaf Type, Supplier ID(For Leaf Type Other), Leaf & Bud 1/2/3/Bhanji Leaf 1, Please Check !!!')
		 return -1
	end if
 end if
end if
return 1

end function

public function integer wf_check_duplicate_rec (string fs_tran_ty, datetime fs_plk_dt);long fl_row
string ls_tran_ty1
datetime ld_plk_dt1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_tran_ty1 = dw_1.getitemstring(fl_row,'la_type')
		ld_plk_dt1 = dw_1.getitemdatetime(fl_row,'la_date')
		
		if ls_tran_ty1 = fs_tran_ty and ld_plk_dt1 = fs_plk_dt then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row 11 : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

public function integer wf_check_duplicate_rec_oth (string fs_tran_ty, string fs_supp, datetime fs_plk_dt);long fl_row
string ls_tran_ty1,ls_supp1
datetime ld_plk_dt1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_tran_ty1 = dw_1.getitemstring(fl_row,'la_type')
		ls_supp1 = dw_1.getitemstring(fl_row,'sup_id')
		ld_plk_dt1 = dw_1.getitemdatetime(fl_row,'la_date')
		
		if ls_tran_ty1 = fs_tran_ty and ls_supp1 = fs_supp and ld_plk_dt1 = fs_plk_dt then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gteprof008.create
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

on w_gteprof008.destroy
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

type cb_4 from commandbutton within w_gteprof008
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

type cb_3 from commandbutton within w_gteprof008
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

IF (isnull(dw_1.getitemdatetime(dw_1.rowcount(),'la_date'))) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF


IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	for ll_ctr = dw_1.rowcount() to 1 step -1
		if dw_1.getitemstring(ll_ctr,'del_flag') = 'Y' then
			dw_1.deleterow(ll_ctr)
		end if
	next	
	
	if dw_1.rowcount() > 0 then
		IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
			return 1
		END IF
	end if
	
	if dw_1.rowcount() > 0 then
		for ll_ctr = 1 to dw_1.rowcount( ) 
			ls_cntind = dw_1.getitemstring(ll_ctr,'la_countind')
			ld_dt = dw_1.getitemdatetime(ll_ctr,'la_date')
			ls_ty = dw_1.getitemstring(ll_ctr,'la_type')
			ls_sup_id = dw_1.getitemstring(ll_ctr,'sup_id')
			
			ld_fbmc = dw_1.getitemnumber(ll_ctr,'la_owlbmcfinper')
			ld_cbmc = dw_1.getitemnumber(ll_ctr,'la_owlbmccoaper')
			if isnull(ld_fbmc) then ld_fbmc = 0
			if isnull(ld_cbmc) then ld_cbmc = 0
			if ls_cntind = 'Y' then
				if (dw_1.getitemnumber(ll_ctr,'la_owllnb1') + dw_1.getitemnumber(ll_ctr,'la_owllnb2') + &
					dw_1.getitemnumber(ll_ctr,'la_owllnb3') + dw_1.getitemnumber(ll_ctr,'la_owllnb4') + &
					dw_1.getitemnumber(ll_ctr,'la_owlbnj1') + dw_1.getitemnumber(ll_ctr,'la_owlbnj2') + &
					dw_1.getitemnumber(ll_ctr,'la_owlbnj3') + dw_1.getitemnumber(ll_ctr,'la_owlbnj4') + dw_1.getitemnumber(ll_ctr,'la_owlkcl1')) <> 100 then
					messagebox('Warning!','Sum of Leaf & A Bud (1 to 4), Banjhi Leaf (1 to 4) and Kutchra Leaf Should Be = 100, Please Check !!!')
					return 1
				end if
				
				if ld_cbmc + ld_fbmc > 100 then
					messagebox('Warning!','Sum Of Ballometric Count % Fine and Ballometric Count % Coarse Should Not Be > 100, Please Check !!!')
					return 1
				end if
				
				if lb_neworder = true then
					if ls_ty = 'O' then
						select distinct 'x' into :ls_temp from fb_leafanalysis where trunc(LA_DATE) = :ld_dt and LA_TYPE = :ls_ty;
						if sqlca.sqlcode = -1 then
							messagebox('Error : While Getting Details',sqlca.sqlerrtext)
							rollback using sqlca;
							return 1
						elseif sqlca.sqlcode = 0 then
							messagebox('Warning!','Fine Leaf Count For The Selected Date Is Already Entered, Please Check !!!')
							return 1
						end if	
					elseif ls_ty = 'T' then
						select distinct 'x' into :ls_temp from fb_leafanalysis where trunc(LA_DATE) = :ld_dt and LA_TYPE = :ls_ty and sup_id = :ls_sup_id;
						if sqlca.sqlcode = -1 then
							messagebox('Error : While Getting Details',sqlca.sqlerrtext)
							rollback using sqlca;
							return 1
						elseif sqlca.sqlcode = 0 then
							messagebox('Warning!','Fine Leaf Count For The Selected Date Is Already Entered, Please Check !!!')
							return 1
						end if
					end if
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

type cb_2 from commandbutton within w_gteprof008
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
	dw_1.setcolumn('la_date')
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

type cb_1 from commandbutton within w_gteprof008
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
	dw_1.setitem(dw_1.getrow(),'la_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'la_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'la_date',datetime(today()))
	dw_1.setcolumn('la_date')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'la_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'la_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'la_date',datetime(today()))
	dw_1.setcolumn('la_date')
end if


end event

type dw_1 from datawindow within w_gteprof008
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 104
integer width = 4590
integer height = 2056
integer taborder = 30
string dataobject = "dw_gteprof008"
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
				dw_1.setitem(newrow,'la_entry_by',gs_user)
				dw_1.setitem(newrow,'la_entry_dt',datetime(today()))
				dw_1.setitem(newrow,'la_date',dw_1.getitemdatetime(currentrow,'la_date'))
//				dw_1.setcolumn('la_countind')
			end if
			if  dw_1.rowcount() > 1  then
				if dw_1.getitemstring(currentrow,'la_countind') = 'Y' then
					if (dw_1.getitemnumber(currentrow,'la_owllnb1') + dw_1.getitemnumber(currentrow,'la_owllnb2') + &
						dw_1.getitemnumber(currentrow,'la_owllnb3') + dw_1.getitemnumber(currentrow,'la_owllnb4') + &
						dw_1.getitemnumber(currentrow,'la_owlbnj1') + dw_1.getitemnumber(currentrow,'la_owlbnj2') + &
						dw_1.getitemnumber(currentrow,'la_owlbnj3') + dw_1.getitemnumber(currentrow,'la_owlbnj4') + dw_1.getitemnumber(currentrow,'la_owlkcl1')) <> 100 then
						messagebox('Warning!','Sum of Leaf & A Bud (1 to 4), Banjhi Leaf (1 to 4) and Kutchra Leaf Should Be = 100, Please Check !!!')
						return 1
					end if
				end if
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
	if dwo.name = 'la_date'  then
		ld_dt = datetime(data)
//		if date(ld_dt) > today() then
//			messagebox('Warning!','Date Should Not Be > Current Date, Pleae Check!!!')
//			return 1
//		end if
		
	end if
	
	if dwo.name = 'la_type' then
		ls_ty = data
		ld_dt = dw_1.getitemdatetime(row,'la_date')
		ls_sup_id = dw_1.getitemstring(row,'sup_id')
		if ls_ty = 'O' then
			if  wf_check_duplicate_rec(ls_ty,ld_dt) = -1 then return 1
			select distinct 'x' into :ls_temp from fb_leafanalysis where trunc(LA_DATE) = :ld_dt and LA_TYPE = :ls_ty;
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 0 then
				messagebox('Warning!','Fine Leaf Count For The Selected Date Is Already Entered, Please Check !!!')
				return 1
			end if	
		else
			setnull(ls_section); setnull(ls_field);
			dw_1.setitem(row,'section_id',ls_section)		
			dw_1.setitem(row,'field_id',ls_field)	
			
			select distinct 'x' into :ls_temp from fb_leafanalysis where trunc(LA_DATE) = :ld_dt and LA_TYPE = :ls_ty and sup_id = :ls_sup_id;
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Details',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode = 0 then
				messagebox('Warning!','Fine Leaf Count For The Selected Date Is Already Entered, Please Check !!!')
				return 1
			end if				
		end if
	end if
	if  dwo.name = 'sup_id' then
		ls_ty = data
		ld_dt = dw_1.getitemdatetime(row,'la_date')
		ls_sup_id = dw_1.getitemstring(row,'sup_id')
		
		if  wf_check_duplicate_rec_oth(ls_ty,ls_sup_id,ld_dt) = -1 then return 1
		
		select distinct 'x' into :ls_temp from fb_leafanalysis where trunc(LA_DATE) = :ld_dt and LA_TYPE = :ls_ty and sup_id = :ls_sup_id;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 0 then
			messagebox('Warning!','Fine Leaf Count For The Selected Date Is Already Entered, Please Check !!!')
			return 1
		end if	
	end if
	
	if dwo.name = 'section_id' then
		ls_section = trim(data) 
		
		select distinct FIELD_ID into :ls_field from fb_section where  SECTION_ID = :ls_section;
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning!','Invalie Section Id, Please Check !!!')
			return 1
		else
			dw_1.setitem(row,'field_id',ls_field)		
		end if	
	else
		ls_section = dw_1.getitemstring(row,'section_id')
		
//		select distinct FIELD_ID into :ls_field from fb_section where  SECTION_ID = :ls_section;
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 100 then
//			messagebox('Warning!','Invalie Section Id, Please Check !!!')
//			return 1
//		else
//			dw_1.setitem(row,'field_id',ls_field)		
//		end if			
	end if
	
	if dwo.name = 'la_owllnb1' then
		ld_lfbd1 = double(data)
		ld_blfbd1 = dw_1.getitemnumber(row,'la_owlbnj1')
		ld_lfbd2 = dw_1.getitemnumber(row,'la_owllnb2')
		ld_lfbd3 = dw_1.getitemnumber(row,'la_owllnb3')
		if isnull(ld_lfbd1) then ld_lfbd1 = 0
		if isnull(ld_lfbd2) then ld_lfbd2 = 0
		if isnull(ld_lfbd3) then ld_lfbd3 = 0
		if isnull(ld_blfbd1) then ld_blfbd1 = 0

		
		if (dw_1.getitemnumber(row,'la_owllnb1') + dw_1.getitemnumber(row,'la_owllnb2') + &
			dw_1.getitemnumber(row,'la_owllnb3') + dw_1.getitemnumber(row,'la_owllnb4') + &
			dw_1.getitemnumber(row,'la_owlbnj1') + dw_1.getitemnumber(row,'la_owlbnj2') + &
			dw_1.getitemnumber(row,'la_owlbnj3') + dw_1.getitemnumber(row,'la_owlbnj4') + dw_1.getitemnumber(row,'la_owlkcl1')) > 100 then
			messagebox('Warning!','Sum of Leaf & A Bud (1 to 4), Banjhi Leaf (1 to 4) and Kutchra Leaf Should not Be > 100, Please Check !!!')
			return 1
		end if
		
		ld_flper = ld_lfbd1+ ld_lfbd2 + ld_lfbd3 + ld_blfbd1
		dw_1.setitem(row,'la_owlperfinlf',ld_flper)
		
		ldcorlfper = 100 - ld_flper
		dw_1.setitem(row,'la_owlpercoalf',ldcorlfper)		
	end if

	if dwo.name = 'la_owllnb2' then
		ld_lfbd2 = double(data)
		ld_blfbd1 = dw_1.getitemnumber(row,'la_owlbnj1')
		ld_lfbd1 = dw_1.getitemnumber(row,'la_owllnb1')
		ld_lfbd3 = dw_1.getitemnumber(row,'la_owllnb3')
		if isnull(ld_lfbd1) then ld_lfbd1 = 0
		if isnull(ld_lfbd2) then ld_lfbd2 = 0
		if isnull(ld_lfbd3) then ld_lfbd3 = 0
		if isnull(ld_blfbd1) then ld_blfbd1 = 0
		
//		if (dw_1.getitemnumber(row,'la_owllnb1') + dw_1.getitemnumber(row,'la_owllnb2') + &
//			dw_1.getitemnumber(row,'la_owllnb3') + dw_1.getitemnumber(row,'la_owllnb4') + &
//			dw_1.getitemnumber(row,'la_owlbnj1') + dw_1.getitemnumber(row,'la_owlbnj2') + &
//			dw_1.getitemnumber(row,'la_owlbnj3') + dw_1.getitemnumber(row,'la_owlbnj4') + dw_1.getitemnumber(row,'la_owlkcl1')) > 100 then
//			messagebox('Warning!','Sum of Leaf & A Bud (1 to 4), Banjhi Leaf (1 to 4) and Kutchra Leaf Should not Be > 100, Please Check !!!')
//			return 1
//		end if
		
		ld_flper = ld_lfbd1+ ld_lfbd2 + ld_lfbd3 + ld_blfbd1
		dw_1.setitem(row,'la_owlperfinlf',ld_flper)
		
		ldcorlfper = 100 - ld_flper
		dw_1.setitem(row,'la_owlpercoalf',ldcorlfper)		
	end if

	if dwo.name = 'la_owllnb3' then
		ld_lfbd3 = double(data)
		ld_blfbd1 = dw_1.getitemnumber(row,'la_owlbnj1')
		ld_lfbd2 = dw_1.getitemnumber(row,'la_owllnb2')
		ld_lfbd1 = dw_1.getitemnumber(row,'la_owllnb1')
		if isnull(ld_lfbd1) then ld_lfbd1 = 0
		if isnull(ld_lfbd2) then ld_lfbd2 = 0
		if isnull(ld_lfbd3) then ld_lfbd3 = 0
		if isnull(ld_blfbd1) then ld_blfbd1 = 0
		
//		if (dw_1.getitemnumber(row,'la_owllnb1') + dw_1.getitemnumber(row,'la_owllnb2') + &
//			dw_1.getitemnumber(row,'la_owllnb3') + dw_1.getitemnumber(row,'la_owllnb4') + &
//			dw_1.getitemnumber(row,'la_owlbnj1') + dw_1.getitemnumber(row,'la_owlbnj2') + &
//			dw_1.getitemnumber(row,'la_owlbnj3') + dw_1.getitemnumber(row,'la_owlbnj4') + dw_1.getitemnumber(row,'la_owlkcl1')) > 100 then
//			messagebox('Warning!','Sum of Leaf & A Bud (1 to 4), Banjhi Leaf (1 to 4) and Kutchra Leaf Should not Be > 100, Please Check !!!')
//			return 1
//		end if

		
		ld_flper = ld_lfbd1+ ld_lfbd2 + ld_lfbd3 + ld_blfbd1
		dw_1.setitem(row,'la_owlperfinlf',ld_flper)
		
		ldcorlfper = 100 - ld_flper
		dw_1.setitem(row,'la_owlpercoalf',ldcorlfper)		
	end if
	
//	if dwo.name = 'la_owllnb4' then
//		if (dw_1.getitemnumber(row,'la_owllnb1') + dw_1.getitemnumber(row,'la_owllnb2') + &
//			dw_1.getitemnumber(row,'la_owllnb3') + dw_1.getitemnumber(row,'la_owllnb4') + &
//			dw_1.getitemnumber(row,'la_owlbnj1') + dw_1.getitemnumber(row,'la_owlbnj2') + &
//			dw_1.getitemnumber(row,'la_owlbnj3') + dw_1.getitemnumber(row,'la_owlbnj4') + dw_1.getitemnumber(row,'la_owlkcl1')) > 100 then
//			messagebox('Warning!','Sum of Leaf & A Bud (1 to 4), Banjhi Leaf (1 to 4) and Kutchra Leaf Should not Be > 100, Please Check !!!')
//			return 1
//		end if
//	end if
	
//	if dwo.name = 'la_owlbnj2' then
//		if (dw_1.getitemnumber(row,'la_owllnb1') + dw_1.getitemnumber(row,'la_owllnb2') + &
//			dw_1.getitemnumber(row,'la_owllnb3') + dw_1.getitemnumber(row,'la_owllnb4') + &
//			dw_1.getitemnumber(row,'la_owlbnj1') + dw_1.getitemnumber(row,'la_owlbnj2') + &
//			dw_1.getitemnumber(row,'la_owlbnj3') + dw_1.getitemnumber(row,'la_owlbnj4') + dw_1.getitemnumber(row,'la_owlkcl1')) > 100 then
//			messagebox('Warning!','Sum of Leaf & A Bud (1 to 4), Banjhi Leaf (1 to 4) and Kutchra Leaf Should not Be > 100, Please Check !!!')
//			return 1
//		end if
//	end if

//	if dwo.name = 'la_owlbnj3' then
//		if (dw_1.getitemnumber(row,'la_owllnb1') + dw_1.getitemnumber(row,'la_owllnb2') + &
//			dw_1.getitemnumber(row,'la_owllnb3') + dw_1.getitemnumber(row,'la_owllnb4') + &
//			dw_1.getitemnumber(row,'la_owlbnj1') + dw_1.getitemnumber(row,'la_owlbnj2') + &
//			dw_1.getitemnumber(row,'la_owlbnj3') + dw_1.getitemnumber(row,'la_owlbnj4') + dw_1.getitemnumber(row,'la_owlkcl1')) > 100 then
//			messagebox('Warning!','Sum of Leaf & A Bud (1 to 4), Banjhi Leaf (1 to 4) and Kutchra Leaf Should not Be > 100, Please Check !!!')
//			return 1
//		end if
//	end if

//	if dwo.name = 'la_owlbnj4' then
//		if (dw_1.getitemnumber(row,'la_owllnb1') + dw_1.getitemnumber(row,'la_owllnb2') + &
//			dw_1.getitemnumber(row,'la_owllnb3') + dw_1.getitemnumber(row,'la_owllnb4') + &
//			dw_1.getitemnumber(row,'la_owlbnj1') + dw_1.getitemnumber(row,'la_owlbnj2') + &
//			dw_1.getitemnumber(row,'la_owlbnj3') + dw_1.getitemnumber(row,'la_owlbnj4') + dw_1.getitemnumber(row,'la_owlkcl1')) > 100 then
//			messagebox('Warning!','Sum of Leaf & A Bud (1 to 4), Banjhi Leaf (1 to 4) and Kutchra Leaf Should not Be > 100, Please Check !!!')
//			return 1
//		end if
//	end if

//	if dwo.name = 'la_owlkcl1' then
//		if (dw_1.getitemnumber(row,'la_owllnb1') + dw_1.getitemnumber(row,'la_owllnb2') + &
//			dw_1.getitemnumber(row,'la_owllnb3') + dw_1.getitemnumber(row,'la_owllnb4') + &
//			dw_1.getitemnumber(row,'la_owlbnj1') + dw_1.getitemnumber(row,'la_owlbnj2') + &
//			dw_1.getitemnumber(row,'la_owlbnj3') + dw_1.getitemnumber(row,'la_owlbnj4') + dw_1.getitemnumber(row,'la_owlkcl1')) > 100 then
//			messagebox('Warning!','Sum of Leaf & A Bud (1 to 4), Banjhi Leaf (1 to 4) and Kutchra Leaf Should not Be > 100, Please Check !!!')
//			return 1
//		end if
//	end if

	
	if dwo.name = 'la_owlbnj1' then
		ld_blfbd1 = double(data)
		ld_lfbd1 = dw_1.getitemnumber(row,'la_owllnb1')
		ld_lfbd2 = dw_1.getitemnumber(row,'la_owllnb2')
		ld_lfbd3 = dw_1.getitemnumber(row,'la_owllnb3')
		//ld_flper, ldcorlfper
		if isnull(ld_lfbd1) then ld_lfbd1 = 0
		if isnull(ld_lfbd2) then ld_lfbd2 = 0
		if isnull(ld_lfbd3) then ld_lfbd3 = 0
		if isnull(ld_blfbd1) then ld_blfbd1 = 0
		
//		if (dw_1.getitemnumber(row,'la_owllnb1') + dw_1.getitemnumber(row,'la_owllnb2') + &
//			dw_1.getitemnumber(row,'la_owllnb3') + dw_1.getitemnumber(row,'la_owllnb4') + &
//			dw_1.getitemnumber(row,'la_owlbnj1') + dw_1.getitemnumber(row,'la_owlbnj2') + &
//			dw_1.getitemnumber(row,'la_owlbnj3') + dw_1.getitemnumber(row,'la_owlbnj4') + dw_1.getitemnumber(row,'la_owlkcl1')) > 100 then
//			messagebox('Warning!','Sum of Leaf & A Bud (1 to 4), Banjhi Leaf (1 to 4) and Kutchra Leaf Should not Be > 100, Please Check !!!')
//			return 1
//		end if

		ld_flper = ld_lfbd1+ ld_lfbd2 + ld_lfbd3 + ld_blfbd1
		dw_1.setitem(row,'la_owlperfinlf',ld_flper)
		
		ldcorlfper = 100 - ld_flper
		dw_1.setitem(row,'la_owlpercoalf',ldcorlfper)		
	end if
	
	if dwo.name = 'la_owlbmcfinper' then
		ld_fbmc = double(data)
		ld_cbmc = 100 - ld_fbmc
		if isnull(ld_fbmc) then ld_fbmc = 0
		if isnull(ld_cbmc) then ld_cbmc = 0

		dw_1.setitem(row,'la_owlbmccoaper',ld_cbmc)
	end if
	
	if dwo.name = 'la_owlbmccoaper' then
		ld_cbmc = double(data)
		ld_fbmc = 100 - ld_fbmc
		if isnull(ld_fbmc) then ld_fbmc = 0
		if isnull(ld_cbmc) then ld_cbmc = 0
		dw_1.setitem(row,'la_owlbmcfinper',ld_cbmc)
	end if
	
	dw_1.setitem(row,'la_entry_by',gs_user)
	dw_1.setitem(row,'la_entry_dt',datetime(today()))
	
	cb_3.enabled = true
end if
if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if

end event

