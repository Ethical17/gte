$PBExportHeader$w_gtebgf002.srw
forward
global type w_gtebgf002 from window
end type
type st_1 from statictext within w_gtebgf002
end type
type em_1 from editmask within w_gtebgf002
end type
type cb_4 from commandbutton within w_gtebgf002
end type
type cb_3 from commandbutton within w_gtebgf002
end type
type cb_2 from commandbutton within w_gtebgf002
end type
type cb_1 from commandbutton within w_gtebgf002
end type
type dw_1 from datawindow within w_gtebgf002
end type
end forward

global type w_gtebgf002 from window
integer width = 4498
integer height = 1904
boolean titlebar = true
string title = "(w_gtebgf002)Weages Budget"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_1 st_1
em_1 em_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtebgf002 w_gtebgf002

type variables
long ll_last
string ls_name,ls_desc,ls_tmp_id 




long ll_ctr, ll_cnt, ll_year,ll_unitprice,ll_qnty,ll_price
string ls_temp,ls_eacsubhead_id,ls_eachead_id,ls_spc_id
string ls_srep
double ld_area,ld_unitprice,ld_qnty,ld_price
datetime ld_date
boolean lb_neworder, lb_query
datawindowchild idw_prod,idw_subexp_salary,idw_subexp_wage,idw_subexp_wage_1,idw_subexp_store,idw_subexp_oth
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (integer fl_year, string fs_eacsubhead_id)
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
	if (isnull(dw_1.getitemnumber(fl_row,'mwb_year')) or  dw_1.getitemnumber(fl_row,'mwb_year')=0 or &
	      isnull(dw_1.getitemstring(fl_row,'eacsubhead_id')) or &
		 isnull(dw_1.getitemstring(fl_row,'mwb_perrestflag')) or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_janrate')) or  dw_1.getitemnumber(fl_row,'mwb_janrate') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_febrate')) or  dw_1.getitemnumber(fl_row,'mwb_febrate') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_marrate')) or  dw_1.getitemnumber(fl_row,'mwb_marrate') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_aprrate')) or  dw_1.getitemnumber(fl_row,'mwb_aprrate') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_mayrate')) or  dw_1.getitemnumber(fl_row,'mwb_mayrate') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_junrate')) or  dw_1.getitemnumber(fl_row,'mwb_junrate') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_julrate')) or  dw_1.getitemnumber(fl_row,'mwb_julrate') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_augrate')) or  dw_1.getitemnumber(fl_row,'mwb_augrate') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_seprate')) or  dw_1.getitemnumber(fl_row,'mwb_seprate') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_octrate')) or  dw_1.getitemnumber(fl_row,'mwb_octrate') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_novrate')) or  dw_1.getitemnumber(fl_row,'mwb_novrate') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_decrate')) or dw_1.getitemnumber(fl_row,'mwb_decrate') < 0 or &
	    	 isnull(dw_1.getitemnumber(fl_row,'mwb_janmandays')) or  dw_1.getitemnumber(fl_row,'mwb_janmandays') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_febmandays')) or  dw_1.getitemnumber(fl_row,'mwb_febmandays') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_marmandays')) or  dw_1.getitemnumber(fl_row,'mwb_marmandays') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_aprmandays')) or  dw_1.getitemnumber(fl_row,'mwb_aprmandays') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_maymandays')) or  dw_1.getitemnumber(fl_row,'mwb_maymandays') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_junmandays')) or  dw_1.getitemnumber(fl_row,'mwb_junmandays') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_julmandays')) or  dw_1.getitemnumber(fl_row,'mwb_julmandays') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_augmandays')) or  dw_1.getitemnumber(fl_row,'mwb_augmandays') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_sepmandays')) or  dw_1.getitemnumber(fl_row,'mwb_sepmandays') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_octmandays')) or  dw_1.getitemnumber(fl_row,'mwb_octmandays') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_novmandays')) or  dw_1.getitemnumber(fl_row,'mwb_novmandays') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'mwb_decmandays')) or dw_1.getitemnumber(fl_row,'mwb_decmandays') < 0) then
	   	 messagebox('Warning: One Of The Following Fields Are Blank','Budget Year, Expanse sub head, or budgeted Wages Rate/Mandays of a month, Please Check !!!')
		 return -1
	end if
end if
return 1


end function

public function integer wf_check_duplicate_rec (integer fl_year, string fs_eacsubhead_id);//long fl_row
//string ls_desc1,ls_type1
//
//dw_1.SelectRow(0, FALSE)
//if dw_1.rowcount() > 1 then
//	for fl_row = 1 to (dw_1.rowcount() - 1)
//		ls_desc1 = dw_1.getitemstring(fl_row,'fa_item_name')
//		ls_type1 = dw_1.getitemstring(fl_row,'fa_item_desc')
//		
//		if ls_desc1 = fs_desc and ls_type1 = fs_type then
//			dw_1.SelectRow(fl_row, TRUE)
//			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
//			return -1
//		end if
//	next 
//end if 
//
//return 1

long fl_row,ll_year1
string ls_eacsubhead_id1


dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount())
		ls_eacsubhead_id1 = dw_1.getitemstring(fl_row,'eacsubhead_id')
		ll_year1 = dw_1.getitemnumber(fl_row,'mwb_year')
		
		if ls_eacsubhead_id1 = fs_eacsubhead_id and ll_year1 = fl_year then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtebgf002.create
this.st_1=create st_1
this.em_1=create em_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.em_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtebgf002.destroy
destroy(this.st_1)
destroy(this.em_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;//dw_1.modify("t_co.text = '"+gs_CO_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if

dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false


dw_1.GetChild ("eacsubhead_id", idw_subexp_wage)
idw_subexp_wage.settransobject(sqlca)	

dw_1.GetChild ("eacsubhead_id_1", idw_subexp_wage_1)
idw_subexp_wage_1.settransobject(sqlca)	

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

type st_1 from statictext within w_gtebgf002
integer x = 64
integer y = 24
integer width = 155
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year"
boolean focusrectangle = false
end type

type em_1 from editmask within w_gtebgf002
integer x = 224
integer y = 20
integer width = 283
integer height = 80
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "YYYY"
boolean dropdowncalendar = true
end type

type cb_4 from commandbutton within w_gtebgf002
integer x = 1307
integer y = 8
integer width = 265
integer height = 100
integer taborder = 60
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

type cb_3 from commandbutton within w_gtebgf002
integer x = 1042
integer y = 8
integer width = 265
integer height = 100
integer taborder = 50
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

IF (isnull(dw_1.getitemnumber(dw_1.rowcount(),'mwb_year')) or dw_1.getitemnumber(dw_1.rowcount(),'mwb_year')=0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	for ll_ctr = dw_1.rowcount() to 1 step -1
			if dw_1.getitemstring(ll_ctr,'del_flag') = 'Y' then
				dw_1.deleterow(ll_ctr)
			end if
	next	
		
	if dw_1.rowcount() > 0 then
		for ll_ctr = 1 to dw_1.rowcount( ) 
			IF wf_check_fillcol(ll_ctr) = -1 THEN 
				return 1
			end if
		next	
	end if
	
		
//	ll_last=0
//	for ll_ctr = 1 to dw_1.rowcount()
//		if dw_1.getitemstatus(ll_ctr,0,primary!) = NewModified! or dw_1.getitemstatus(ll_ctr,0,primary!) = New! then
//			if ll_last=0 then
//				select nvl(MAX(substr(FA_ITEM_CD,3,6)),0) into :ll_last from fb_fixed_assets;
//			end if
//			ll_last = ll_last + 1
//			ls_tmp_id = 'FA'+string(ll_last,'0000')
//			dw_1.setitem(ll_ctr,'FA_ITEM_CD',ls_tmp_id)	
//		end if
//	next
	
	
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

type cb_2 from commandbutton within w_gtebgf002
integer x = 777
integer y = 8
integer width = 265
integer height = 100
integer taborder = 30
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
	
	if isnull(em_1.text) or len(em_1.text) = 0 then
		messagebox('Warning!','Please Select A Year !!!')
		return 1
	end if
	
	if  long(em_1.text) < long(string(today(),'YYYY'))-1 then
		  messagebox('Warning!','Please Select A Valid Budget Year !!!')
		 return 1 
	elseif  long(em_1.text) > long(string(today(),'YYYY'))+1 then
		  messagebox('Warning!','Please Select A Valid Budget Year !!!')
		 return 1 
	end if
	ll_year = long(em_1.text)

	dw_1.reset()
	dw_1.settaborder('eachead_id',10)
	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('eachead_id')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user,ll_year)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtebgf002
integer x = 512
integer y = 8
integer width = 265
integer height = 100
integer taborder = 20
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

if isnull(em_1.text) or len(em_1.text) = 0 then
	messagebox('Warning!','Please Select A Year !!!')
	return 1
end if

if  long(em_1.text) < long(string(today(),'YYYY'))-1 then
     messagebox('Warning!','Please Select A Valid Budget Year !!!')
	 return 1 
elseif  long(em_1.text) > long(string(today(),'YYYY'))+1 then
     messagebox('Warning!','Please Select A Valid Budget Year !!!')
	 return 1 
end if
ll_year = long(em_1.text)


dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'mwb_year',ll_year)
	dw_1.setitem(dw_1.getrow(),'eachead_id',ls_eachead_id)
	dw_1.setitem(dw_1.getrow(),'eacsubhead_id',ls_eacsubhead_id)
	dw_1.setitem(dw_1.getrow(),'mwb_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'mwb_entry_dt',datetime(today()))
	dw_1.setcolumn('eachead_id')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'mwb_year',ll_year)
	dw_1.setitem(dw_1.getrow(),'eachead_id',ls_eachead_id)
	dw_1.setitem(dw_1.getrow(),'eacsubhead_id',ls_eacsubhead_id)
	dw_1.setitem(dw_1.getrow(),'mwb_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'mwb_entry_dt',datetime(today()))
	dw_1.setcolumn('eachead_id')
end if


end event

type dw_1 from datawindow within w_gtebgf002
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer y = 116
integer width = 4434
integer height = 1656
integer taborder = 40
string dataobject = "dw_gtebgf002"
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
		dw_1.setitem(dw_1.getrow(),'mwb_year',ll_year)	
		dw_1.setitem(dw_1.getrow(),'mwb_entry_by',gs_user)
		dw_1.setitem(dw_1.getrow(),'mwb_entry_by',datetime(today()))
		dw_1.setcolumn('eachead_id')
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

event itemchanged;if dwo.name = 'eachead_id' or dwo.name = 'eachead_id_1' then
	ls_eachead_id = data
	idw_subexp_wage.SetFilter ("eachead_id = '"+trim(data)+"'") 
	idw_subexp_wage.filter( )
	idw_subexp_wage_1.SetFilter ("eachead_id = '"+trim(data)+"'") 
	idw_subexp_wage_1.filter( )
end if

if lb_query = false then

	
	if dwo.name = 'mwb_year'  then
		ll_year = long(data)
		ls_eacsubhead_id = dw_1.getitemstring(row,'eacsubhead_id')
		
//		 if  wf_check_dupwage(ll_year,ls_eacsubhead_id) = -1 then return 1
           if  wf_check_duplicate_rec(ll_year, ls_eacsubhead_id) = -1 then return 1
	end if
	
	if lb_neworder = true and dwo.name = 'mwb_aprrate' then
		if dw_1.getitemnumber(row, 'mwb_mayrate') = 0 or isnull( dw_1.getitemnumber(row, 'mwb_mayrate')) then dw_1.setitem(row, 'mwb_mayrate', double(data))
		if dw_1.getitemnumber(row, 'mwb_junrate') = 0 or isnull( dw_1.getitemnumber(row, 'mwb_junrate')) then dw_1.setitem(row, 'mwb_junrate', double(data))
		if dw_1.getitemnumber(row, 'mwb_julrate') = 0 or isnull( dw_1.getitemnumber(row, 'mwb_julrate')) then dw_1.setitem(row, 'mwb_julrate', double(data))
		if dw_1.getitemnumber(row, 'mwb_augrate') = 0 or isnull( dw_1.getitemnumber(row, 'mwb_augrate')) then dw_1.setitem(row, 'mwb_augrate', double(data))
		if dw_1.getitemnumber(row, 'mwb_seprate') = 0 or isnull( dw_1.getitemnumber(row, 'mwb_seprate')) then dw_1.setitem(row, 'mwb_seprate', double(data))
		if dw_1.getitemnumber(row, 'mwb_octrate') = 0 or isnull( dw_1.getitemnumber(row, 'mwb_octrate')) then dw_1.setitem(row, 'mwb_octrate', double(data))
		if dw_1.getitemnumber(row, 'mwb_novrate') = 0 or isnull( dw_1.getitemnumber(row, 'mwb_novrate')) then dw_1.setitem(row, 'mwb_novrate', double(data))
		if dw_1.getitemnumber(row, 'mwb_decrate') = 0 or isnull( dw_1.getitemnumber(row, 'mwb_decrate')) then dw_1.setitem(row, 'mwb_decrate', double(data))
		if dw_1.getitemnumber(row, 'mwb_janrate') = 0 or isnull( dw_1.getitemnumber(row, 'mwb_janrate')) then dw_1.setitem(row, 'mwb_janrate', double(data))
		if dw_1.getitemnumber(row, 'mwb_febrate') = 0 or isnull( dw_1.getitemnumber(row, 'mwb_febrate')) then dw_1.setitem(row, 'mwb_febrate', double(data))
		if dw_1.getitemnumber(row, 'mwb_marrate') = 0 or isnull( dw_1.getitemnumber(row, 'mwb_marrate')) then dw_1.setitem(row, 'mwb_marrate', double(data))
	end if
	///////////
	
//if dwo.name = 'mwb_janrate' then
//	ld_unitprice=0 
//	ld_qnty=0
//	ld_price=0
//	ld_unitprice = double(data)
//	 ld_qnty=dw_1.getitemnumber(row,'mwb_janmandays') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'janwages',ld_price)
// end if;	
//	
// if dwo.name ='mwb_janmandays'  then
//	ld_unitprice=0 
//	ld_qnty=0 
//	ld_price=0
//	ld_qnty = double(data)
//	 ld_unitprice=dw_1.getitemnumber(row,'mwb_janrate') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'janwages',ld_price)
// end if;	
// 
//  if dwo.name = 'mwb_febrate' then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_unitprice = double(data)
//	 ld_qnty=dw_1.getitemnumber(row,'mwb_febmandays') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'febwages',ld_price)
// end if;	
//	
// if dwo.name ='mwb_febmandays'  then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_qnty = double(data)
//	 ld_unitprice=dw_1.getitemnumber(row,'mwb_febrate') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'febwages',ld_price)
// end if;	
// 
// if dwo.name = 'mwb_marrate' then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_unitprice = double(data)
//	 ld_qnty=dw_1.getitemnumber(row,'mwb_marmandays') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'marwages',ld_price)
// end if;	
//	
// if dwo.name ='mwb_marmandays'  then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_qnty = double(data)
//	 ld_unitprice=dw_1.getitemnumber(row,'mwb_marrate') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'marwages',ld_price)
// end if;	
// 
// if dwo.name = 'mwb_aprrate' then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_unitprice = double(data)
//	 ld_qnty=dw_1.getitemnumber(row,'mwb_aprmandays') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'aprwages',ld_price)
// end if;	
//	
// if dwo.name ='mwb_aprmandays'  then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_qnty = double(data)
//	 ld_unitprice=dw_1.getitemnumber(row,'mwb_aprrate') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'aprwages',ld_price)
// end if;	
// 
// if dwo.name = 'mwb_mayrate' then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_unitprice = double(data)
//	 ld_qnty=dw_1.getitemnumber(row,'mwb_maymandays') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'maywages',ld_price)
// end if;	
//	
// if dwo.name ='mwb_maymandays'  then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_qnty = double(data)
//	 ld_unitprice=dw_1.getitemnumber(row,'mwb_mayrate') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'maywages',ld_price)
// end if;	
// 
// if dwo.name = 'mwb_junrate' then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_unitprice = double(data)
//	 ld_qnty=dw_1.getitemnumber(row,'mwb_junmandays') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'junwages',ld_price)
// end if;	
//	
// if dwo.name ='mwb_junmandays'  then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_qnty = double(data)
//	 ld_unitprice=dw_1.getitemnumber(row,'mwb_junrate') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'junwages',ld_price)
// end if;	
// 
//  if dwo.name = 'mwb_julrate' then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_unitprice = double(data)
//	 ld_qnty=dw_1.getitemnumber(row,'mwb_julmandays') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'julwages',ld_price)
// end if;	
//	
// if dwo.name ='mwb_julmandays'  then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_qnty = double(data)
//	 ld_unitprice=dw_1.getitemnumber(row,'mwb_julrate') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'julwages',ld_price)
// end if;	
// 
//  if dwo.name = 'mwb_augrate' then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_unitprice = double(data)
//	 ld_qnty=dw_1.getitemnumber(row,'mwb_augmandays') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'augwages',ld_price)
// end if;	
//	
// if dwo.name ='mwb_augmandays'  then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_qnty = double(data)
//	 ld_unitprice=dw_1.getitemnumber(row,'mwb_augrate') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'augwages',ld_price)
// end if;	
// 
//   if dwo.name = 'mwb_seprate' then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_unitprice = double(data)
//	 ld_qnty=dw_1.getitemnumber(row,'mwb_sepmandays') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'sepwages',ld_price)
// end if;	
//	
// if dwo.name ='mwb_sepmandays'  then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_qnty = double(data)
//	 ld_unitprice=dw_1.getitemnumber(row,'mwb_seprate') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'sepwages',ld_price)
// end if;	
// 
//    if dwo.name = 'mwb_octrate' then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_unitprice = double(data)
//	 ld_qnty=dw_1.getitemnumber(row,'mwb_octmandays') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'octwages',ld_price)
// end if;	
//	
// if dwo.name ='mwb_octmandays'  then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_qnty = double(data)
//	 ld_unitprice=dw_1.getitemnumber(row,'mwb_octrate') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'octwages',ld_price)
// end if;	
// 
//    if dwo.name = 'mwb_novrate' then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_unitprice = double(data)
//	 ld_qnty=dw_1.getitemnumber(row,'mwb_novmandays') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'novwages',ld_price)
// end if;	
//	
// if dwo.name ='mwb_novmandays'  then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_qnty = double(data)
//	 ld_unitprice=dw_1.getitemnumber(row,'mwb_novrate') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'novwages',ld_price)
// end if;	
// 
//     if dwo.name = 'mwb_decrate' then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_unitprice = double(data)
//	 ld_qnty=dw_1.getitemnumber(row,'mwb_decmandays') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'decwages',ld_price)
// end if;	
//	
// if dwo.name ='mwb_decmandays'  then
//	ld_unitprice=0
//	ld_qnty=0
//	ld_price=0
//	ld_qnty = double(data)
//	 ld_unitprice=dw_1.getitemnumber(row,'mwb_decrate') 
//	 ld_price=ld_unitprice * ld_qnty
//	dw_1.setitem(dw_1.getrow(),'decwages',ld_price)
// end if;	
	///////
	 
	dw_1.setitem(dw_1.getrow(),'mwb_year',ll_year)	
	dw_1.setitem(dw_1.getrow(),'mwb_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'mwb_entry_by',datetime(today()))
	
//	Budget_Detail.tabpage_2.dw_2.modify(' b_2.visible = true')
//	Budget_Detail.tabpage_2.dw_2.modify(' b_2.enabled = true')

	cb_3.enabled = true
	if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
		dw_1.insertrow(0)
	end if

end if 	




//if lb_query = false then
//
//	if dwo.name = 'fa_item_name' then
//		ls_name = data
//		if isnull(ls_name) or len(ls_name)<1 then
//			messagebox('Error:','Please Enter Asset Name')
//			return 1
//		end if	
//		if f_check_initial_space(ls_name) = -1 then return 1
//		if f_check_string(ls_name) = -1 then return 1
//	else	
//		ls_name = dw_1.getitemstring(row,'fa_item_name')
//	end if
//
//	if dwo.name = 'fa_item_desc'  then
//		ls_desc = data
//		if isnull(ls_desc) or len(ls_desc) < 1 then
//			messagebox('Error:','Please Enter Item Description')
//			return 1
//		end if	
//		
//		if f_check_initial_space(ls_desc) = -1 then return 1
//		
//		if  wf_check_duplicate_rec(ls_name, ls_desc) = -1 then return 1
//			
////		select distinct 'x' into :ls_temp from fb_fixed_assets
////		 where upper(fa_item_name) = upper(:ls_name) and upper(fa_item_desc) = upper(:ls_desc);
////
////		if sqlca.sqlcode = -1 then
////			messagebox('Error : While Getting Fixed Assets Details',sqlca.sqlerrtext)
////			rollback using sqlca;
////			return 1
////		elseif sqlca.sqlcode  = 0 then
////			messagebox('Warning!','Fixed Assets Already Exists, Please Check !!!')
////			return 1
////		end if
////	end if
//	
//	dw_1.setitem(dw_1.getrow(),'mwb_entry_by',gs_user)
//	dw_1.setitem(dw_1.getrow(),'mwb_entry_by',datetime(today()))
//		
//	cb_3.enabled = true
//	if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
//		dw_1.insertrow(0)
//	end if
//
//end if 	

end event

