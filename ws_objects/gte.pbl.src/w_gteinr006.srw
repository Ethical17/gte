$PBExportHeader$w_gteinr006.srw
forward
global type w_gteinr006 from window
end type
type st_1 from statictext within w_gteinr006
end type
type ddlb_2 from dropdownlistbox within w_gteinr006
end type
type cb_4 from commandbutton within w_gteinr006
end type
type cb_2 from commandbutton within w_gteinr006
end type
type ddlb_1 from dropdownlistbox within w_gteinr006
end type
type st_4 from statictext within w_gteinr006
end type
type dw_1 from datawindow within w_gteinr006
end type
end forward

global type w_gteinr006 from window
integer width = 3543
integer height = 2232
boolean titlebar = true
string title = "(W_gteinr006) - ABC-Analysis"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
st_1 st_1
ddlb_2 ddlb_2
cb_4 cb_4
cb_2 cb_2
ddlb_1 ddlb_1
st_4 st_4
dw_1 dw_1
end type
global w_gteinr006 w_gteinr006

type variables
string ls_temp,ls_spc_id,ls_id
boolean lb_neworder, lb_query
n_cst_powerfilter iu_powerfilter 
end variables

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

on w_gteinr006.create
this.st_1=create st_1
this.ddlb_2=create ddlb_2
this.cb_4=create cb_4
this.cb_2=create cb_2
this.ddlb_1=create ddlb_1
this.st_4=create st_4
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.ddlb_2,&
this.cb_4,&
this.cb_2,&
this.ddlb_1,&
this.st_4,&
this.dw_1}
end on

on w_gteinr006.destroy
destroy(this.st_1)
destroy(this.ddlb_2)
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.ddlb_1)
destroy(this.st_4)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
setpointer(hourglass!)
ddlb_1.reset()
ddlb_1.additem('ALL')
declare c1 cursor for
select SPC_NAME||' ('||SPC_ID||')' from fb_storeproductcategory
where nvl(SPC_ACTIVE_IND,'N')='Y'order by 1;	
		
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_temp;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_temp)
		fetch c1 into :ls_temp;
	loop
	close c1;
end if
ddlb_1.text='ALL'
ddlb_2.text='ALL'
setpointer(arrow!)
//dw_1.settransobject(sqlca)
//Send(Handle(dw_1), 274, 61488, 0)
//dw_1.retrieve()
//if dw_1.rowcount() = 0 then
//	messagebox('Information!','No data Found !!!')
//	return 1
//end if
end event

type st_1 from statictext within w_gteinr006
integer x = 1513
integer y = 40
integer width = 270
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Category: "
boolean focusrectangle = false
end type

type ddlb_2 from dropdownlistbox within w_gteinr006
integer x = 1792
integer y = 24
integer width = 311
integer height = 332
integer taborder = 20
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
string item[] = {"ALL","A","B","C"}
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_gteinr006
integer x = 2400
integer y = 24
integer width = 265
integer height = 100
integer taborder = 30
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

type cb_2 from commandbutton within w_gteinr006
integer x = 2130
integer y = 24
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&OK"
end type

event clicked;
if  isnull(ddlb_2.text) or ddlb_2.text = "" then 
	messagebox('Error At Product Category','Please Select Product Category')
	return 1
end if;

ls_spc_id = left(right(ddlb_1.text,9),8)
ls_id = ddlb_2.text

dw_1.show()
dw_1.settransobject(sqlca)
dw_1.retrieve(ls_spc_id,ls_id)


end event

type ddlb_1 from dropdownlistbox within w_gteinr006
integer x = 512
integer y = 28
integer width = 983
integer height = 856
integer taborder = 10
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

event selectionchanged;lb_query = false	
lb_neworder = false


setpointer(hourglass!)
//ddlb_1.reset()
ddlb_1.additem('ALL')
declare c1 cursor for
select SPC_NAME||' ('||SPC_ID||')' from fb_storeproductcategory
where nvl(SPC_ACTIVE_IND,'N')='Y'order by 1;	
		
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_temp;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_temp)
		fetch c1 into :ls_temp;
	loop
	close c1;
end if
//ddlb_1.text='ALL'

setpointer(arrow!)
end event

type st_4 from statictext within w_gteinr006
integer x = 55
integer y = 36
integer width = 457
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Product Category: "
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gteinr006
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 5
integer y = 148
integer width = 3474
integer height = 1960
string dataobject = "dw_gteinr006"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_leftbuttonup;if isvalid(iu_powerfilter) then
	iu_powerfilter.event post ue_buttonclicked(dwo.type,dwo.name)
END IF
end event

event constructor;iu_powerfilter = create n_cst_powerfilter
iu_powerfilter.of_setdw(this)
end event

event resize;if isvalid(iu_powerfilter) then
	iu_powerfilter.event ue_positionbuttons()
END IF
end event

