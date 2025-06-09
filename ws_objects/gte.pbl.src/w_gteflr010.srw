$PBExportHeader$w_gteflr010.srw
forward
global type w_gteflr010 from window
end type
type cb_2 from commandbutton within w_gteflr010
end type
type cb_1 from commandbutton within w_gteflr010
end type
type em_1 from editmask within w_gteflr010
end type
type st_1 from statictext within w_gteflr010
end type
type dw_1 from datawindow within w_gteflr010
end type
end forward

global type w_gteflr010 from window
integer width = 3977
integer height = 2328
boolean titlebar = true
string title = "(Gteflr010) - Section Wise Summary"
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
em_1 em_1
st_1 st_1
dw_1 dw_1
end type
global w_gteflr010 w_gteflr010

type variables
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

on w_gteflr010.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.em_1=create em_1
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.em_1,&
this.st_1,&
this.dw_1}
end on

on w_gteflr010.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.dw_1)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

em_1.text = string(today(),'yyyy')
end event

type cb_2 from commandbutton within w_gteflr010
integer x = 859
integer y = 12
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Close"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_gteflr010
integer x = 594
integer y = 12
integer width = 265
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Run"
boolean default = true
end type

event clicked;double ld_teamade, ld_totgl, ld_recper
long ll_year
dw_1.settransobject(sqlca)

setpointer(hourglass!)

if isnull(em_1.text) or em_1.text='0000' then
	messagebox('Warning','Please Enter The Year!!!')
	return 
end if

if long(em_1.text) > long(string(today(),'yyyy'))  then
	messagebox('Alert!','Year Should Be <= Current Year  !!!')
	return 1
end if

ll_year = long(em_1.text)


select nvl(sum(nvl(GWTM_TEAMADE,0)),0) into :ld_teamade from fb_glforproduction a,fb_gardenwiseteamade b 
where a.GLFP_PK = b.GLFP_PK and (GWTM_TYPE in ('O') or (GWTM_TYPE in ('N','E') and SUP_ID = :gs_supid)) and 
		 to_number(to_char(GLFP_PLUCKINGDATE,'YYYY')) = :ll_year;

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Total Teamade',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if
				
SELECT sum(nvl(glt.gt_quantity,0)) into :ld_totgl
  FROM fb_gltransaction glt, fb_supplier sup
WHERE glt.sup_id = sup.sup_id AND glt.gt_type in ('OWNATTE' ,'OWNUSER')    and NVL (glt.gt_quantity, 0) > 0    and
		  to_number(to_char(glt.pluckingdate,'YYYY')) = :ll_year;

if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Total Green Leaf',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
end if

if isnull(ld_teamade) then ld_teamade = 0
if isnull(ld_totgl) then ld_totgl = 0
if ld_totgl = 0 then
	ld_recper = 0
else
	ld_recper = round(ld_teamade / ld_totgl * 100,2)
end if

dw_1.retrieve(em_1.text,ld_recper)

if dw_1.rowcount() = 0 then
	messagebox('Alert!','No Data Found For The Entered Year !!!')
	return 1
end if
end event

type em_1 from editmask within w_gteflr010
integer x = 375
integer y = 16
integer width = 206
integer height = 92
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "YYYY"
end type

type st_1 from statictext within w_gteflr010
integer x = 5
integer y = 28
integer width = 357
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year (YYYY) : "
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gteflr010
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 120
integer width = 3927
integer height = 1940
string dataobject = "dw_gteflr010"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
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

