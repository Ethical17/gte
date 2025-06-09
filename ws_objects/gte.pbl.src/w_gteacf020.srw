$PBExportHeader$w_gteacf020.srw
forward
global type w_gteacf020 from window
end type
type cb_2 from commandbutton within w_gteacf020
end type
type cb_1 from commandbutton within w_gteacf020
end type
type cb_3 from commandbutton within w_gteacf020
end type
type ddlb_1 from dropdownlistbox within w_gteacf020
end type
type st_3 from statictext within w_gteacf020
end type
type rb_2 from radiobutton within w_gteacf020
end type
type rb_1 from radiobutton within w_gteacf020
end type
type cb_4 from commandbutton within w_gteacf020
end type
type dw_1 from datawindow within w_gteacf020
end type
type gb_1 from groupbox within w_gteacf020
end type
end forward

global type w_gteacf020 from window
integer width = 4005
integer height = 2356
boolean titlebar = true
string title = "(W_gteacf020) Assets Depreciation "
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_2 cb_2
cb_1 cb_1
cb_3 cb_3
ddlb_1 ddlb_1
st_3 st_3
rb_2 rb_2
rb_1 rb_1
cb_4 cb_4
dw_1 dw_1
gb_1 gb_1
end type
global w_gteacf020 w_gteacf020

type variables
long ll_ctr, ll_last
string ls_tmp_id,ls_indent_id,ls_spid
double ld_open_val,ld_curr_dep,ld_orig_val
boolean lb_neworder, lb_query
datawindowchild idw_prod,idw_subexp


end variables

forward prototypes
public function integer wf_inquiry (long fl_year)
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
	case "PDF"
			this.dw_1.saveas("C:\reports\Gtebgr001.pdf",pdf!,true)
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

public function integer wf_inquiry (long fl_year);dw_1.settransobject(sqlca)
dw_1.retrieve(gs_user,fl_year)
return 1
end function

on w_gteacf020.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_3=create cb_3
this.ddlb_1=create ddlb_1
this.st_3=create st_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_4=create cb_4
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.cb_3,&
this.ddlb_1,&
this.st_3,&
this.rb_2,&
this.rb_1,&
this.cb_4,&
this.dw_1,&
this.gb_1}
end on

on w_gteacf020.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.ddlb_1)
destroy(this.st_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_4)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;//dw_1.modify("t_co.text = '"+gs_CO_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if

lb_query = false	
lb_neworder = false

setpointer(hourglass!)

end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

type cb_2 from commandbutton within w_gteacf020
integer x = 1490
integer y = 28
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

event clicked;dw_1.settransobject(sqlca)
lb_neworder = true
lb_query = false
dw_1.reset()

if isnull(ddlb_1.text) then
	messagebox('Warning!','Please Enter Valid year/Month !!!')
	return 1
end if

string ls_item,ls_itemname,ls_cap_dt,ls_group,ls_year,ls_month
double ld_qnty ,ld_org_cost,ld_cad_open,ld_rev_val,ld_rev_open

setnull(ls_item);setnull(ls_itemname); setnull(ls_cap_dt);setnull(ls_group); 
ld_qnty = 0; ld_org_cost = 0;ld_cad_open = 0;ld_rev_val = 0;ld_rev_open = 0;

ls_year=left(ddlb_1.text,4)
ls_month=right(ddlb_1.text,2)


declare c1 cursor for
 select FA_ITEM_CD,FA_ITEM_NAME,FA_CAP_DT,FA_QNTY,FA_ASSETS_GROUP, FA_ITEM_ORG_COST,
            nvl(DD_CAD_OPEN,0)+nvl(DD_CAD_CURR_DEPR,0)CAD_OPEN,
	       DD_REV_VALUE,nvl(DD_RCAD_OPEN,0)+nvl(DD_RCAD_CURR_DEPR,0)RCAD_OPEN
    from FB_FIXED_ASSETS,FB_ASSETS_DEPR_DET  
 where FA_ITEM_CD=DD_ITEM_CD(+) and 
            ((to_number(DD_YEAR)=to_number(:ls_year)-1 and DD_MONTH=:ls_month and nvl(FA_SELL_IND,'N')='N') or
  		   (not exists (select * from FB_ASSETS_DEPR_DET where DD_ITEM_CD=FA_ITEM_CD)))	
order by 1 asc;
	
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_item,:ls_itemname,:ls_cap_dt,:ld_qnty,:ls_group,:ld_org_cost,:ld_cad_open,:ld_rev_val,:ld_rev_open;
	
	do while sqlca.sqlcode <> 100
				
		dw_1.scrolltorow(dw_1.insertrow(0))
		dw_1.setitem(dw_1.getrow(),'dd_item_cd',ls_item)
		dw_1.setitem(dw_1.getrow(),'fa_cap_dt',date(ls_cap_dt))
		dw_1.setitem(dw_1.getrow(),'fa_assets_group',ls_group)
		dw_1.setitem(dw_1.getrow(),'fa_item_name',ls_itemname)
		dw_1.setitem(dw_1.getrow(),'fa_qnty',ld_qnty)
		dw_1.setitem(dw_1.getrow(),'dd_year',ls_year)
		dw_1.setitem(dw_1.getrow(),'dd_month',ls_month)		
		dw_1.setitem(dw_1.getrow(),'dd_orig_value',ld_org_cost)
		dw_1.setitem(dw_1.getrow(),'dd_rev_value',ld_rev_val)
		dw_1.setitem(dw_1.getrow(),'dd_cad_open',ld_cad_open)
		dw_1.setitem(dw_1.getrow(),'dd_rcad_open',ld_rev_open)		
		dw_1.setitem(dw_1.getrow(),'dd_entry_by',gs_user)
		dw_1.setitem(dw_1.getrow(),'dd_entry_dt',datetime(today()))
		
		setnull(ls_item);setnull(ls_itemname); setnull(ls_cap_dt);setnull(ls_group); 
		ld_qnty = 0; ld_org_cost = 0;ld_cad_open = 0;ld_rev_val = 0;ld_rev_open = 0;
		
		fetch c1 into :ls_item,:ls_itemname,:ls_cap_dt,:ld_qnty,:ls_group,:ld_org_cost,:ld_cad_open,:ld_rev_val,:ld_rev_open;
	loop
	close c1;	

end if

end event

type cb_1 from commandbutton within w_gteacf020
integer x = 1760
integer y = 28
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

event clicked;if cb_1.text = "&Query" then
	if dw_1.modifiedcount() > 0 or dw_1.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	lb_query = true
	lb_neworder = true
	dw_1.reset()
	cb_3.enabled = false
  	cb_2.enabled = false
	dw_1.settaborder('dd_cad_curr_depr',10)
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('dd_cad_curr_depr')
	cb_1.text = "&Run"
	cb_3.enabled = false
else
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user)
 	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	cb_1.text = "&Query"
   	cb_2.enabled = true	
end if
lb_neworder = false

end event

type cb_3 from commandbutton within w_gteacf020
integer x = 2030
integer y = 28
integer width = 265
integer height = 100
integer taborder = 60
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

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	if lb_neworder = true then
		for ll_ctr = dw_1.rowcount() to 1 step -1
			if (isnull(dw_1.getitemnumber(ll_ctr,'dd_cad_curr_depr')) or dw_1.getitemnumber(ll_ctr,'dd_cad_curr_depr') = 0) then 
				dw_1.deleterow(ll_ctr)
			end if;
		next
     end if		
	
	if dw_1.update(true,false) = 1  then
		dw_1.resetupdate();
		commit using sqlca;
		cb_3.enabled = false
		cb_1.enabled = true
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

type ddlb_1 from dropdownlistbox within w_gteacf020
integer x = 1042
integer y = 32
integer width = 361
integer height = 856
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_gteacf020
integer x = 658
integer y = 52
integer width = 366
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year-Month: "
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_2 from radiobutton within w_gteacf020
integer x = 343
integer y = 60
integer width = 233
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Query"
end type

event clicked;ddlb_1.AllowEdit = FALSE
setpointer(hourglass!)
ddlb_1.reset()


declare c1 cursor for
select distinct (DD_YEAR*100)+DD_MONTH from FB_ASSETS_DEPR_DET  
order by 1 desc ;
		
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_tmp_id;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_tmp_id)
		fetch c1 into :ls_tmp_id;
	loop
	close c1;
end if


setpointer(arrow!)
end event

type rb_1 from radiobutton within w_gteacf020
integer x = 55
integer y = 60
integer width = 233
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "New"
end type

event clicked;//setpointer(hourglass!)
//ddlb_1.reset()
//
//declare c1 cursor for
//select a.INDENT_ID||'-('||INDENT_DATE||')' 
//  from fb_indent a,fb_indentdetails b where a.INDENT_ID=b.INDENT_ID and INDENT_HOLOCALFLAG= '1' and (inddet_quantity > (nvl(inddet_receivedquantity,0)+nvl(inddet_cancelquantity,0)))
//  group by a.INDENT_ID,INDENT_DATE
//  order by INDENT_DATE desc;
//		
//open c1;
//
//IF sqlca.sqlcode = 0 THEN
//	fetch c1 into :ls_tmp_id;
//	
//	do while sqlca.sqlcode <> 100
//		ddlb_1.additem(ls_tmp_id)
//		fetch c1 into :ls_tmp_id;
//	loop
//	close c1;
//end if
//
//setpointer(arrow!)

ddlb_1.AllowEdit = TRUE


end event

type cb_4 from commandbutton within w_gteacf020
integer x = 2299
integer y = 28
integer width = 265
integer height = 100
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_gteacf020
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 27
integer y = 160
integer width = 3927
integer height = 2068
integer taborder = 30
string dataobject = "dw_gteacf020"
boolean vscrollbar = true
end type

event itemchanged;if dwo.name = 'dd_cad_curr_depr' then	
	ld_curr_dep=double(data)
	ld_orig_val=dw_1.getitemnumber(row,'dd_orig_value') 
	ld_open_val=dw_1.getitemnumber(row,'dd_cad_open') 
	if (ld_curr_dep+ld_open_val) >ld_orig_val then 
		messagebox('SQL Error:','Please enter valid Depreciation Value for this Item, Please check....!')
		return 1;
	end if        
	cb_3.enabled = true
end if;


end event

type gb_1 from groupbox within w_gteacf020
integer x = 41
integer width = 599
integer height = 156
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 16711680
long backcolor = 67108864
borderstyle borderstyle = stylebox!
end type

