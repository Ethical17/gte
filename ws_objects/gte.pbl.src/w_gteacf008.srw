$PBExportHeader$w_gteacf008.srw
forward
global type w_gteacf008 from window
end type
type cb_4 from commandbutton within w_gteacf008
end type
type cb_3 from commandbutton within w_gteacf008
end type
type cb_2 from commandbutton within w_gteacf008
end type
type cb_1 from commandbutton within w_gteacf008
end type
type dw_1 from datawindow within w_gteacf008
end type
end forward

global type w_gteacf008 from window
integer width = 4649
integer height = 2384
boolean titlebar = true
string title = "(w_gteacf008) Bill Entry"
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
global w_gteacf008 w_gteacf008

type variables
long ll_ctr, ll_user_level,ll_last,ll_ac_year,ll_bill_no
//string ls_temp,ls_del_ind,ls_tpc_id,ls_man_id,ls_tmp_id,ls_count, ls_last, ls_name
datetime ld_bill_dt
boolean lb_neworder, lb_query
string ls_bill_ty
n_cst_powerfilter iu_powerfilter
datawindowchild idw_party
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fl_tpc_id)
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
	case "SFILTER"
			iu_powerfilter.checked = NOT iu_powerfilter.checked
			iu_powerfilter.event ue_clicked()
			m_main.m_file.m_filter.checked = iu_powerfilter.checked			
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
	if ( isnull(dw_1.getitemstring(fl_row,'bh_bill_ty')) or  len(dw_1.getitemstring(fl_row,'bh_bill_ty'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'bh_ref_party')) or  len(dw_1.getitemstring(fl_row,'bh_ref_party'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'bh_ref_no')) or  len(dw_1.getitemstring(fl_row,'bh_ref_no'))=0 or &
		isnull(dw_1.getitemdatetime(fl_row,'bh_ref_dt')) or &
		isnull(dw_1.getitemnumber(fl_row,'bh_amt')) or dw_1.getitemnumber(fl_row,'bh_amt')=0) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Bill Type, Date, Party Name, ~rParty Bill No, Date Or Amount,~rPlease Check !!!')
		 return -1
	end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (string fl_tpc_id);long fl_row
string ls_tpc_id1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_tpc_id1  = dw_1.getitemstring(fl_row,'tpc_manid')
			
		if ls_tpc_id1 = fl_tpc_id  then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1



end function

on w_gteacf008.create
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

on w_gteacf008.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if

dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false
//dw_1.modify("t_co.text = '"+gs_co_name+"'")

this.tag = Message.StringParm
ll_user_level = long(this.tag)

dw_1.GetChild ("bh_ref_party", idw_party)
idw_party.settransobject(sqlca)
idw_party.retrieve( )
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

type cb_4 from commandbutton within w_gteacf008
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

type cb_3 from commandbutton within w_gteacf008
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
	return 1
end if 

IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'bh_ref_party')) or len(dw_1.getitemstring(dw_1.rowcount(),'bh_ref_party'))=0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 2 THEN
	return 1
end if 

	if dw_1.rowcount() > 0 then
		IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
			return 1
		END IF
	end if

	ll_last=0

	if dw_1.rowcount() > 0 then
		for ll_ctr = 1 to dw_1.rowcount( ) 
			if dw_1.GetItemStatus(ll_ctr,0,Primary!) = New!	or dw_1.GetItemStatus(ll_ctr,0,Primary!) = NewModified!	then
				if ll_last=0 then
					select count(1) into :ll_last from fb_bill_head;
				end if
				ll_last = ll_last + 1
				dw_1.setitem(ll_ctr,'BH_SRL_NO',ll_last)	
			
				ld_bill_dt = dw_1.getitemdatetime(ll_ctr,'bh_bill_dt')
				ls_bill_ty = dw_1.getitemstring(ll_ctr,'bh_bill_ty')
				
				if long(string(ld_bill_dt,'mm')) < 4 then
					ll_ac_year = long(string(ld_bill_dt,'YYYY'))-1
				else
					ll_ac_year = long(string(ld_bill_dt,'YYYY'))
				end if;
				
				choose case ls_bill_ty
				case 'GREENLEAF'
						ls_bill_ty = 'BGL'
				case 'LOCALPURC'
						ls_bill_ty = 'BLP'
				case 'HOPURC'
						ls_bill_ty = 'BHP'
				case 'HRVEHICLE'
						ls_bill_ty = 'BHV'
				end choose
				ll_bill_no = f_get_lastno(ls_bill_ty,string(ll_ac_year));
				dw_1.setitem(ll_ctr,'bh_bill_no',ll_bill_no)	
				if f_upd_lastno(ls_bill_ty,string(ll_ac_year),ll_bill_no) = -1 then 
					rollback using sqlca;
					return 1
				end if;
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

end event

type cb_2 from commandbutton within w_gteacf008
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
	idw_party.reset( )
	idw_party.SetFilter ("")
	idw_party.settransobject(sqlca)
	idw_party.retrieve()
	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
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

type cb_1 from commandbutton within w_gteacf008
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
idw_party.reset( )
idw_party.retrieve()

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'bh_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'bh_entry_dt',datetime(today()))
	dw_1.setcolumn('bh_bill_ty')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'bh_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'bh_entry_dt',datetime(today()))
	dw_1.setcolumn('bh_bill_ty')
end if


end event

type dw_1 from datawindow within w_gteacf008
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 116
integer width = 4571
integer height = 2052
integer taborder = 30
string dataobject = "dw_gteacf008"
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
		dw_1.setitem(newrow,'bh_entry_by',gs_user)
		dw_1.setitem(newrow,'bh_entry_dt',datetime(today()))
		dw_1.setcolumn('bh_bill_ty')
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

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF
end event

event itemchanged;if lb_query = false then
	if dwo.name = 'bh_bill_ty'  then
		
		choose case trim(data)
		case 'GREENLEAF'
				idw_party.SetFilter ("sup_type in ('UNIT','GLS')") 
		case 'LOCALPURC'
				idw_party.SetFilter ("sup_type in ('LOCAL','BOTH','UNIT')") 
		case 'HOPURC'
				idw_party.SetFilter ("sup_type in ('HO','BOTH')") 
		case 'HRVEHICLE'
				idw_party.SetFilter ("sup_type in ('LOCAL','BOTH','UNIT')") 
		end choose		
		idw_party.filter( )

//		
//		if f_check_initial_space(ls_man_id) = -1 then return 1	
//		
//		if f_check_string(ls_man_id) = -1 then return 1
//		
//		if f_check_special_char(ls_man_id) = -1 then return 1
//		
//		if  wf_check_duplicate_rec(ls_man_id) = -1 then return 1  
//		
//		select distinct 'x' into :ls_temp from fb_teamadeproductcategory where upper(tpc_manid) = upper(:ls_man_id);
//		
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Tea Category ID',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 0 then	
//			messagebox('Warning: ','Tea Category Id already exists, Please Check .....!')
//			return 1
//		end if		
	end if


	if dw_1.GetItemStatus(row,0,Primary!) = New!	or dw_1.GetItemStatus(row,0,Primary!) = NewModified!	then
		dw_1.setitem(row,'bh_entry_by',gs_user)
		dw_1.setitem(row,'bh_entry_dt',datetime(today()))
	else
		dw_1.setitem(row,'bh_upd_by',gs_user)
		dw_1.setitem(row,'bh_upd_dt',datetime(today()))
	end if
	
	cb_3.enabled = true	
end if
//
if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if

end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

