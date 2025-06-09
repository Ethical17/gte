$PBExportHeader$w_gtebgr007.srw
forward
global type w_gtebgr007 from window
end type
type dw_1 from datawindow within w_gtebgr007
end type
type em_1 from editmask within w_gtebgr007
end type
type cb_2 from commandbutton within w_gtebgr007
end type
type st_1 from statictext within w_gtebgr007
end type
type cb_4 from commandbutton within w_gtebgr007
end type
end forward

global type w_gtebgr007 from window
integer width = 4082
integer height = 2308
boolean titlebar = true
string title = "(W_gtebgr007) Consolidate Budget"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
dw_1 dw_1
em_1 em_1
cb_2 cb_2
st_1 st_1
cb_4 cb_4
end type
global w_gtebgr007 w_gtebgr007

type variables
long ll_ctr,net, ll_cnt, ll_year,ll_unitprice,ll_qnty,ll_price
string ls_temp,ls_eacsubhead_id,ls_eachead_id,ls_spc_id
string ls_srep
double ld_area
datetime ld_date
boolean lb_neworder, lb_query
datawindowchild idw_prod,idw_subexp
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

on w_gtebgr007.create
this.dw_1=create dw_1
this.em_1=create em_1
this.cb_2=create cb_2
this.st_1=create st_1
this.cb_4=create cb_4
this.Control[]={this.dw_1,&
this.em_1,&
this.cb_2,&
this.st_1,&
this.cb_4}
end on

on w_gtebgr007.destroy
destroy(this.dw_1)
destroy(this.em_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.cb_4)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")

lb_query = false	
lb_neworder = false

setpointer(hourglass!)
dw_1.GetChild ("eacsubhead_id", idw_subexp)
idw_subexp.settransobject(sqlca)	


STRING LS_TEXT

LS_TEXT	= "create OR REPLACE view FB_MONTHLYEXPENSEBUDGET_vw as "&
	+ "(select 'O' meb_type ,MOB_YEAR  MEB_YEAR, 1 MEB_MONTH,EACSUBHEAD_ID,MOB_JANPRICE bg_amt from fb_monthlyothersbudget union all "&
	+ " select 'O' meb_type ,MOB_YEAR  MEB_YEAR, 2 MEB_MONTH,EACSUBHEAD_ID,MOB_FEBPRICE bg_amt from fb_monthlyothersbudget union all "&
	+ " select 'O' meb_type ,MOB_YEAR  MEB_YEAR, 3 MEB_MONTH,EACSUBHEAD_ID,MOB_MARPRICE bg_amt from fb_monthlyothersbudget union all "&
	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 4 MEB_MONTH,EACSUBHEAD_ID,MOB_APRPRICE bg_amt from fb_monthlyothersbudget union all  "&
	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 5 MEB_MONTH,EACSUBHEAD_ID,MOB_MAYPRICE bg_amt from fb_monthlyothersbudget union all "&
	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 6 MEB_MONTH,EACSUBHEAD_ID,MOB_JUNPRICE bg_amt from fb_monthlyothersbudget union all  "&
	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 7 MEB_MONTH,EACSUBHEAD_ID,MOB_JULPRICE bg_amt from fb_monthlyothersbudget union all  "&
	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 8 MEB_MONTH,EACSUBHEAD_ID,MOB_AUGPRICE bg_amt from fb_monthlyothersbudget union all  "&
	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 9 MEB_MONTH,EACSUBHEAD_ID,MOB_SEPPRICE bg_amt from fb_monthlyothersbudget union all  "&
	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 10 MEB_MONTH,EACSUBHEAD_ID,MOB_OCTPRICE bg_amt from fb_monthlyothersbudget union all  "&
	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 11 MEB_MONTH,EACSUBHEAD_ID,MOB_NOVPRICE bg_amt from fb_monthlyothersbudget union all  "&
	+ " select 'O' meb_type ,MOB_YEAR MEB_YEAR, 12 MEB_MONTH,EACSUBHEAD_ID,MOB_DECPRICE bg_amt from fb_monthlyothersbudget union all "&
	+ " select 'W' meb_type ,MWB_YEAR  MEB_YEAR, 1 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_JANMANDAYS,0) * NVL(MWB_JANRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR , 1,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR  MEB_YEAR, 2 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_FEBMANDAYS,0) * NVL(MWB_FEBRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR , 2,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR  MEB_YEAR, 3 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_MARMANDAYS,0) * NVL(MWB_MARRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR , 3,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 4 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_APRMANDAYS,0) * NVL(MWB_APRRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 4,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 5 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_MAYMANDAYS,0) * NVL(MWB_MAYRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 5,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 6 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_JUNMANDAYS,0) * NVL(MWB_JUNRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 6,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 7 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_JULMANDAYS,0) * NVL(MWB_JULRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 7,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 8 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_AUGMANDAYS,0) * NVL(MWB_AUGRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 8,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 9 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_SEPMANDAYS,0) * NVL(MWB_SEPRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 9,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 10 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_OCTMANDAYS,0) * NVL(MWB_OCTRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 10,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 11 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_NOVMANDAYS,0) * NVL(MWB_NOVRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 11,EACSUBHEAD_ID union all "&
	+ " select 'W' meb_type ,MWB_YEAR MEB_YEAR, 12 MEB_MONTH,EACSUBHEAD_ID,SUM(NVL(MWB_DECMANDAYS,0) * NVL(MWB_DECRATE,0)) bg_amt from FB_MONTHLYWAGESBUDGET GROUP BY MWB_YEAR, 12,EACSUBHEAD_ID union all "&
	+ " select 'T' meb_type ,MSB_YEAR  MEB_YEAR, 1 MEB_MONTH,EACSUBHEAD_ID,MSB_JANPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all "&
	+ " select 'T' meb_type ,MSB_YEAR  MEB_YEAR, 2 MEB_MONTH,EACSUBHEAD_ID,MSB_FEBPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all "&
	+ " select 'T' meb_type ,MSB_YEAR  MEB_YEAR, 3 MEB_MONTH,EACSUBHEAD_ID,MSB_MARPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all "&
	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 4 MEB_MONTH,EACSUBHEAD_ID,MSB_APRPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all  "&
	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 5 MEB_MONTH,EACSUBHEAD_ID,MSB_MAYPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all "&
	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 6 MEB_MONTH,EACSUBHEAD_ID,MSB_JUNPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all  "&
	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 7 MEB_MONTH,EACSUBHEAD_ID,MSB_JULPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all  "&
	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 8 MEB_MONTH,EACSUBHEAD_ID,MSB_AUGPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all  "&
	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 9 MEB_MONTH,EACSUBHEAD_ID,MSB_SEPPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all  "&
	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 10 MEB_MONTH,EACSUBHEAD_ID,MSB_OCTPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all  "&
	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 11 MEB_MONTH,EACSUBHEAD_ID,MSB_NOVPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all  "&
	+ " select 'T' meb_type ,MSB_YEAR MEB_YEAR, 12 MEB_MONTH,EACSUBHEAD_ID,MSB_DECPRICE bg_amt from FB_MONTHLYSTOREBUDGET union all "&
	+ " select 'S' meb_type ,MSAB_YEAR  MEB_YEAR, 1 MEB_MONTH,EACSUBHEAD_ID,MSAB_JANSALARY bg_amt from fb_monthlysalarybudget union all "&
	+ " select 'S' meb_type ,MSAB_YEAR  MEB_YEAR, 2 MEB_MONTH,EACSUBHEAD_ID,MSAB_FEBSALARY bg_amt from fb_monthlysalarybudget union all "&
	+ " select 'S' meb_type ,MSAB_YEAR  MEB_YEAR, 3 MEB_MONTH,EACSUBHEAD_ID,MSAB_MARSALARY bg_amt from fb_monthlysalarybudget union all "&
	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 4 MEB_MONTH,EACSUBHEAD_ID,MSAB_APRSALARY bg_amt from fb_monthlysalarybudget union all  "&
	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 5 MEB_MONTH,EACSUBHEAD_ID,MSAB_MAYSALARY bg_amt from fb_monthlysalarybudget union all "&
	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 6 MEB_MONTH,EACSUBHEAD_ID,MSAB_JUNSALARY bg_amt from fb_monthlysalarybudget union all  "&
	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 7 MEB_MONTH,EACSUBHEAD_ID,MSAB_JULSALARY bg_amt from fb_monthlysalarybudget union all  "&
	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 8 MEB_MONTH,EACSUBHEAD_ID,MSAB_AUGSALARY bg_amt from fb_monthlysalarybudget union all  "&
	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 9 MEB_MONTH,EACSUBHEAD_ID,MSAB_SEPSALARY bg_amt from fb_monthlysalarybudget union all  "&
	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 10 MEB_MONTH,EACSUBHEAD_ID,MSAB_OCTSALARY bg_amt from fb_monthlysalarybudget union all  "&
	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 11 MEB_MONTH,EACSUBHEAD_ID,MSAB_NOVSALARY bg_amt from fb_monthlysalarybudget union all  "&
	+ " select 'S' meb_type ,MSAB_YEAR MEB_YEAR, 12 MEB_MONTH,EACSUBHEAD_ID,MSAB_DECSALARY bg_amt from fb_monthlysalarybudget) "


EXECUTE IMMEDIATE :LS_TEXT USING SQLCA;
end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

type dw_1 from datawindow within w_gtebgr007
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 18
integer y = 144
integer width = 4009
integer height = 2044
integer taborder = 60
string dataobject = "dw_gtebgr007"
boolean vscrollbar = true
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

type em_1 from editmask within w_gtebgr007
integer x = 187
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

type cb_2 from commandbutton within w_gtebgr007
integer x = 526
integer y = 8
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

event clicked;if isnull(em_1.text) or len(em_1.text) = 0 then
	messagebox('Warning!','Please Select A Year !!!')
	return 1
end if

if  long(em_1.text) < long(string(today(),'YYYY'))-1 then
     messagebox('Warning!','Please Select A Valid Budget Year !!!')
elseif  long(em_1.text) > long(string(today(),'YYYY'))+1 then
     messagebox('Warning!','Please Select A Valid Budget Year !!!')	  
end if

ll_year = long(em_1.text)

double ld_mt_area, ld_yt_area, ld_zt_area, ld_up_area

ld_mt_area=0; ld_yt_area=0; ld_zt_area=0; ld_up_area=0

select sum(nvl(MT_AREA,0)) ,sum(nvl(YT_AREA,0)) ,sum(nvl(ZT_AREA,0)) ,sum(nvl(UP_AREA,0)) 
  into :ld_mt_area,:ld_yt_area,:ld_zt_area,:ld_up_area
from FB_YEARLYAREA
where YEAR = :ll_year;

if sqlca.sqlcode = -1 then
	messagebox('SQL Error: During Area Select',sqlca.sqlerrtext)
	return
end if

if isnull(ld_mt_area) then ld_mt_area=0 
if isnull(ld_yt_area) then ld_yt_area=0 
if isnull(ld_zt_area) then ld_zt_area=0 
if isnull(ld_up_area) then ld_up_area=0

dw_1.settransobject(sqlca)
dw_1.retrieve(ll_year,ld_mt_area,ld_yt_area,ld_zt_area,ld_up_area)

end event

type st_1 from statictext within w_gtebgr007
integer x = 37
integer y = 24
integer width = 169
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

type cb_4 from commandbutton within w_gtebgr007
integer x = 795
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
string text = "&Close"
end type

event clicked;close(parent)

end event

