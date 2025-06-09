$PBExportHeader$w_gtepur013.srw
forward
global type w_gtepur013 from window
end type
type st_1 from statictext within w_gtepur013
end type
type ddlb_1 from dropdownlistbox within w_gtepur013
end type
type cb_2 from commandbutton within w_gtepur013
end type
type cb_4 from commandbutton within w_gtepur013
end type
type dw_1 from datawindow within w_gtepur013
end type
end forward

global type w_gtepur013 from window
integer width = 3506
integer height = 2564
boolean titlebar = true
string title = "(W_gtepur013) Service Order"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_1 st_1
ddlb_1 ddlb_1
cb_2 cb_2
cb_4 cb_4
dw_1 dw_1
end type
global w_gtepur013 w_gtepur013

type variables
long ll_ctr,net, ll_cnt, ll_year,ll_unitprice,ll_qnty,ll_price
string ls_temp,ls_eacsubhead_id,ls_eachead_id,ls_spc_id,ls_lpoid
string ls_srep
double ld_area
datetime ld_date
boolean lb_neworder, lb_query
datawindowchild idw_prod,idw_subexp
end variables

forward prototypes
public function integer wf_inquiry (long fl_year)
end prototypes

event ue_option();choose case gs_ueoption
	case "PRINT"
			OpenWithParm(w_print,this.dw_1)
			
				ls_lpoid = ddlb_1.text
									
				IF MessageBox("Print  Alert", 'Report Successfully Printed ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
						
					update FB_LOCALPURCHASEORDER set LPO_PRINT_DT = sysdate 
					 where LPO_ID = :ls_lpoid and LPO_PRINT_DT is null and LPO_ENTRY_DT is not null ;
					if sqlca.sqlcode = -1 then
						messagebox('Sql Error : While Updating Print Date !!!',sqlca.sqlerrtext)
						rollback using sqlca;
						return
					end if
					commit using sqlca;
				end if
				
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

on w_gtepur013.create
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_4=create cb_4
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.ddlb_1,&
this.cb_2,&
this.cb_4,&
this.dw_1}
end on

on w_gtepur013.destroy
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

setpointer(hourglass!)
ddlb_1.reset()

declare c1 cursor for
	select distinct LPO_ID from FB_SERVICEPURCHASEORDER 
	order by 1 desc;		
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_temp;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_temp)
		fetch c1 into :ls_temp;
	loop
	close c1;
end if

setpointer(arrow!)
end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

type st_1 from statictext within w_gtepur013
integer x = 32
integer y = 48
integer width = 421
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Purchace Order : "
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gtepur013
integer x = 462
integer y = 36
integer width = 754
integer height = 908
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_gtepur013
integer x = 1230
integer y = 32
integer width = 265
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&OK"
end type

event clicked;if isnull(ddlb_1.text) or len(ddlb_1.text) = 0 then
	messagebox('Warning!','Please Select A Valid Purchase Order !!!')
	return 1
end if

dw_1.show()
dw_1.settransobject(sqlca)
dw_1.retrieve(ddlb_1.text)

end event

type cb_4 from commandbutton within w_gtepur013
integer x = 1499
integer y = 32
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

event clicked;close(parent)
end event

type dw_1 from datawindow within w_gtepur013
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 5
integer y = 168
integer width = 3465
integer height = 2284
integer taborder = 60
string dataobject = "dw_gtepur013"
boolean vscrollbar = true
end type

