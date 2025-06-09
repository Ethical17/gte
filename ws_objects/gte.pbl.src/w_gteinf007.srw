$PBExportHeader$w_gteinf007.srw
forward
global type w_gteinf007 from window
end type
type cb_4 from commandbutton within w_gteinf007
end type
type cb_3 from commandbutton within w_gteinf007
end type
type cb_2 from commandbutton within w_gteinf007
end type
type cb_1 from commandbutton within w_gteinf007
end type
type dw_1 from datawindow within w_gteinf007
end type
end forward

global type w_gteinf007 from window
integer width = 4731
integer height = 2288
boolean titlebar = true
string title = "(w_gteinf007) Inventory- Disposal - Fixed Assets"
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
global w_gteinf007 w_gteinf007

type variables
long ll_ctr,ll_last
string ls_temp,ls_del_ind,ls_tmp_id, ls_acsubledger_nm,ls_type,ls_desc,ls_name,ls_item_cd,ls_last,ls_count
boolean lb_neworder, lb_query
date ld_scrap_dt
double ld_sale_val
datawindowchild idw_item
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_item_cd)
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
	if (isnull(dw_1.getitemstring(fl_row,'fas_scrap_type')) or  len(dw_1.getitemstring(fl_row,'fas_scrap_type'))=0 or &
	    isnull(dw_1.getitemstring(fl_row,'fas_item_cd')) or  len(dw_1.getitemstring(fl_row,'fas_item_cd'))=0 or &
	    isnull(dw_1.getitemstring(fl_row,'fas_remark')) or  len(dw_1.getitemstring(fl_row,'fas_remark'))=0 ) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Asset ID ,Scrap Type,Remark. Please Check !!!')
		 return -1
	end if
end if
return 1

end function

public function integer wf_check_duplicate_rec (string fs_item_cd);long fl_row
string ls_item_cd1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_item_cd1 = dw_1.getitemstring(fl_row,'fas_item_cd')
				
		if ls_item_cd1 = fs_item_cd  then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gteinf007.create
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

on w_gteinf007.destroy
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
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if

dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false

dw_1.GetChild ("fas_item_cd", idw_item)
idw_item.settransobject(sqlca)	

//this.tag = Message.StringParm
//ll_user_level = long(this.tag)

end event

event key;IF KeyDown(KeyF1!) THEN
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

type cb_4 from commandbutton within w_gteinf007
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

type cb_3 from commandbutton within w_gteinf007
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

IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'fas_scrap_type')) or len(dw_1.getitemstring(dw_1.rowcount(),'fas_scrap_type'))=0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF  MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	if dw_1.rowcount() > 0 then
		for ll_ctr = 1 to dw_1.rowcount( ) 
			IF wf_check_fillcol(ll_ctr) = -1 THEN 
				return 1
			end if
		next	
	end if

	ll_last=0
	for ll_ctr = 1 to dw_1.rowcount()
		if dw_1.getitemstatus(ll_ctr,0,primary!) = NewModified! or dw_1.getitemstatus(ll_ctr,0,primary!) = New! then
			if ll_last=0 then
				select nvl(MAX(substr(fas_scrap_id,4,8)),0) into :ll_last from fb_assets_scrap;
			end if
			ll_last = ll_last + 1
			ls_tmp_id = 'FAS'+string(ll_last,'00000000')
			dw_1.setitem(ll_ctr,'fas_scrap_id',ls_tmp_id)	
			dw_1.setitem(ll_ctr,'fas_scrap_dt',today())	
			
			ls_item_cd	= dw_1.getitemstring(ll_ctr,'fas_item_cd')
			ld_sale_val  = dw_1.getitemnumber(ll_ctr,'sale_value')

			update FB_FIXED_ASSETS set FA_SELL_DATE=sysdate, FA_SELL_AMT=:ld_sale_val, FA_SELL_IND='Y'
		 	 where nvl(FA_SELL_IND,'N')='N' and  FA_ITEM_CD=:ls_item_cd ;
	
			if sqlca.sqlcode = -1 then
				messagebox('Sql Error During Assets Master Update : ',sqlca.sqlerrtext);
				return 1;
			end if;				
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

type cb_2 from commandbutton within w_gteinf007
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
	dw_1.settaborder('fas_scrap_type',10)
	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('fas_scrap_type')
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

type cb_1 from commandbutton within w_gteinf007
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
	dw_1.setitem(dw_1.getrow(),'fas_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'fas_entry_dt',datetime(today()))
	dw_1.setcolumn('fas_scrap_type')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'fa_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'fa_entry_dt',datetime(today()))
	dw_1.setcolumn('fas_scrap_type')
end if


end event

type dw_1 from datawindow within w_gteinf007
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer y = 116
integer width = 4672
integer height = 2052
integer taborder = 30
string dataobject = "dw_gteinf007"
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
		dw_1.setitem(newrow,'fas_entry_by',gs_user)
		dw_1.setitem(newrow,'fas_entry_dt',datetime(today()))
		dw_1.setcolumn('fas_scrap_type')
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

	if dwo.name = 'fas_item_cd'  then
		ls_item_cd = data		
		if isnull(ls_item_cd) or len(ls_item_cd)<1 then
			messagebox('Error:','Please Enter Item Code')
			return 1
		end if	
	
		if  wf_check_duplicate_rec(ls_item_cd) = -1 then return 1
			
		select distinct 'x' into :ls_temp from fb_assets_scrap where upper(FAS_ITEM_CD) = upper(:ls_item_cd);
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Fixed Assets Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox('Warning!','Fixed Assets Already Scrap/Obsolete/Loss/Sale, Please Check !!!')
			return 1
		end if

		select FA_ITEM_NAME, FA_ITEM_DESC into :ls_name, :ls_desc from fb_fixed_assets  where fa_item_cd=:ls_item_cd;
	
		if sqlca.sqlcode = -1 then
	  		 messagebox('Error During Select Of Assets Name',sqlca.sqlerrtext)
	   		rollback using sqlca;
	   		return 1
		end if	
	
		dw_1.setitem(row,'fa_item_name',ls_name)	
		dw_1.setitem(row,'fa_item_desc',ls_desc)	
	end if
	
	if dwo.name = 'fa_assets_group'  then
		idw_item.SetFilter ("trim(fa_assets_group) = '"+trim(data)+"'") 
		idw_item.filter( )
	end if;	
	
	if dwo.name = 'sale_value'  then
		ld_sale_val= double(data)
		if isnull(ld_sale_val) or ld_sale_val<=0 then
			messagebox('Error:','Please Enter Sale Value For this Item')
			return 1
		end if 	
	end if
	

	
	if dwo.name = 'fas_remark' then
		ls_desc = data
		if isnull(ls_desc) or len(ls_desc) < 1 then
			messagebox('Error:','Please Enter Remark To Scrap This Assets')
			return 1
		end if	
	end if
	
	
dw_1.setitem(dw_1.getrow(),'fas_entry_by',gs_user)
dw_1.setitem(dw_1.getrow(),'fas_entry_dt',datetime(today()))
	
cb_3.enabled = true

end if
	
if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if

end event

