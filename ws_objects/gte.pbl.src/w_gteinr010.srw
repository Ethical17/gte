$PBExportHeader$w_gteinr010.srw
forward
global type w_gteinr010 from window
end type
type ddlb_3 from dropdownlistbox within w_gteinr010
end type
type st_5 from statictext within w_gteinr010
end type
type ddlb_2 from dropdownlistbox within w_gteinr010
end type
type st_3 from statictext within w_gteinr010
end type
type ddlb_1 from dropdownlistbox within w_gteinr010
end type
type st_4 from statictext within w_gteinr010
end type
type dp_2 from datepicker within w_gteinr010
end type
type dp_1 from datepicker within w_gteinr010
end type
type st_2 from statictext within w_gteinr010
end type
type st_1 from statictext within w_gteinr010
end type
type rb_2 from radiobutton within w_gteinr010
end type
type rb_1 from radiobutton within w_gteinr010
end type
type cb_2 from commandbutton within w_gteinr010
end type
type cb_4 from commandbutton within w_gteinr010
end type
type gb_1 from groupbox within w_gteinr010
end type
type dw_1 from datawindow within w_gteinr010
end type
type dw_2 from datawindow within w_gteinr010
end type
end forward

global type w_gteinr010 from window
integer width = 3950
integer height = 2408
boolean titlebar = true
string title = "(Gteinr010) Return To Supplier"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
ddlb_3 ddlb_3
st_5 st_5
ddlb_2 ddlb_2
st_3 st_3
ddlb_1 ddlb_1
st_4 st_4
dp_2 dp_2
dp_1 dp_1
st_2 st_2
st_1 st_1
rb_2 rb_2
rb_1 rb_1
cb_2 cb_2
cb_4 cb_4
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
end type
global w_gteinr010 w_gteinr010

type variables
long ll_ctr,net, ll_cnt, ll_year,ll_unitprice,ll_qnty,ll_price
string ls_temp,ls_eacsubhead_id,ls_eachead_id,ls_spc_id,ls_sup_id,ls_sp_id
string ls_srep
double ld_area
datetime ld_date
boolean lb_neworder, lb_query
datawindowchild idw_prod,idw_subexp
n_cst_powerfilter iu_powerfilter

string ls_frym,ls_toym

end variables

forward prototypes
public function integer wf_inquiry (long fl_year)
end prototypes

event ue_option();if dw_1.visible=true then
	choose case gs_ueoption
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
elseif dw_2.visible=true then
	choose case gs_ueoption
		case "PRINT"
				OpenWithParm(w_print,this.dw_2)
		case "PRINTPREVIEW"
				this.dw_2.modify("datawindow.print.preview = yes")
		case "RESETPREVIEW"
				this.dw_2.modify("datawindow.print.preview = no")
	case "ZOOM"
			SetPointer (HourGlass!)											
			OpenwithParm (w_zoom,dw_2)
			SetPointer (Arrow!)						
		case "SAVEAS"
				this.dw_2.saveas()
		case "SFILTER"
				iu_powerfilter.checked = NOT iu_powerfilter.checked
				iu_powerfilter.event ue_clicked()
				m_main.m_file.m_filter.checked = iu_powerfilter.checked
		case "FILTER"
				setnull(gs_filtertext)
				this.dw_2.setredraw(false)
				this.dw_2.setfilter(gs_filtertext)
				this.dw_2.filter()
				this.dw_2.groupcalc()
				if this.dw_2.rowcount() > 0 then;
					this.dw_2.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
		case "SORT"
				setnull(gs_sorttext)
				this.dw_2.setredraw(false)
				this.dw_2.setsort(gs_sorttext)
				this.dw_2.sort()
				this.dw_2.groupcalc()
				if this.dw_2.rowcount() > 0 then;
					this.dw_2.setredraw(true)
				else
					Messagebox('Warning','Data Not Available In Given Criteria')
				end if
	end choose
end if
	
end event

public function integer wf_inquiry (long fl_year);dw_1.settransobject(sqlca)
dw_1.retrieve(gs_user,fl_year)
return 1
end function

on w_gteinr010.create
this.ddlb_3=create ddlb_3
this.st_5=create st_5
this.ddlb_2=create ddlb_2
this.st_3=create st_3
this.ddlb_1=create ddlb_1
this.st_4=create st_4
this.dp_2=create dp_2
this.dp_1=create dp_1
this.st_2=create st_2
this.st_1=create st_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_2=create cb_2
this.cb_4=create cb_4
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.ddlb_3,&
this.st_5,&
this.ddlb_2,&
this.st_3,&
this.ddlb_1,&
this.st_4,&
this.dp_2,&
this.dp_1,&
this.st_2,&
this.st_1,&
this.rb_2,&
this.rb_1,&
this.cb_2,&
this.cb_4,&
this.gb_1,&
this.dw_1,&
this.dw_2}
end on

on w_gteinr010.destroy
destroy(this.ddlb_3)
destroy(this.st_5)
destroy(this.ddlb_2)
destroy(this.st_3)
destroy(this.ddlb_1)
destroy(this.st_4)
destroy(this.dp_2)
destroy(this.dp_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;dw_1.modify("t_co.text = '"+gs_co_name+"'")
dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_2.modify("t_co.text = '"+gs_co_name+"'")
dw_2.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
lb_query = false	
lb_neworder = false

setpointer(hourglass!)
dw_1.GetChild ("eacsubhead_id", idw_subexp)
idw_subexp.settransobject(sqlca)	

setpointer(hourglass!)
	ddlb_1.reset()
	ddlb_1.additem('ALL')
	
	declare c1 cursor for
		
   select initcap(SUP_NAME)||'('||SUP_ID||')' 
	 from fb_supplier where  nvl(SUP_ACTIVE,'0')='1' and SUP_TYPE in('LOCAL','BOTH','UNIT','HO')
	 order by 1;
	 
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
setpointer(arrow!)

setpointer(hourglass!)
ddlb_3.reset()
ddlb_3.additem('ALL')
declare c3 cursor for
select SPC_NAME||' ('||SPC_ID||')' from fb_storeproductcategory
where nvl(SPC_ACTIVE_IND,'N')='Y'order by 1;	
		
open c3;

IF sqlca.sqlcode = 0 THEN
	fetch c3 into :ls_temp;
	
	do while sqlca.sqlcode <> 100
		ddlb_3.additem(ls_temp)
		fetch c3 into :ls_temp;
	loop
	close c3;
end if
ddlb_3.text='ALL'

setpointer(arrow!)

lb_query = false	
lb_neworder = false

setpointer(hourglass!)
ddlb_2.reset()
ddlb_2.additem('ALL')
declare c2 cursor for
SELECT initcap(decode(nvl(e.SSP_ID,'x'),'x',SP_NAME,b.SSP_NAME))||'('||e.SP_ID||')'
   FROM FB_STOREPRODUCT E,fb_storeproduct_std b
 WHERE e.SP_ACTIVE_IND='Y' and e.SSP_ID=b.ssp_id(+)
  ORDER BY 1;	
		
		
open c2;

IF sqlca.sqlcode = 0 THEN
	fetch c2 into :ls_temp;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(ls_temp)
		fetch c2 into :ls_temp;
	loop
	close c2;
end if
ddlb_2.text='ALL'

setpointer(arrow!)
end event

event key;IF KeyDown(KeyEscape!) THEN
	cb_4.triggerevent(clicked!)
end if

end event

type ddlb_3 from dropdownlistbox within w_gteinr010
integer x = 503
integer y = 144
integer width = 1029
integer height = 856
integer taborder = 70
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

event selectionchanged;ls_frym =dp_1.text
ls_toym =dp_2.text

ls_sup_id = left(right(ddlb_1.text,9),8)
ls_spc_id = left(right(ddlb_3.text,9),8)

if rb_1.checked then
	setpointer(hourglass!)
	ddlb_2.reset()
	ddlb_2.additem('ALL')
	declare c2 cursor for
	
	SELECT distinct initcap(decode(nvl(a.SSP_ID,'x'),'x',SP_NAME,f.SSP_NAME))||'('||a.SP_ID||')'
	  FROM FB_STOREPRODUCT a,FB_INDENT b,FB_HOPURCHASEINVOICE c,FB_HOPIDETAILS d,FB_SUPPLIER e,fb_storeproduct_std f
	WHERE b.INDENT_ID=c.INDENT_ID AND c.HOPI_ID=d.HOPI_ID AND 
					  c.SUP_ID=e.SUP_ID AND a.SP_ID=d.SP_ID and a.SSP_ID=f.ssp_id(+) AND
					trunc(c.HOPI_DATE) between TO_DATE (:ls_frym, 'dd/mm/yyyy') AND TO_DATE (:ls_toym, 'dd/mm/yyyy') AND c.HOPI_ACTIVE='1'	
					and  c.SUP_ID = decode(:ls_sup_id,'ALL',c.SUP_ID,:ls_sup_id) and
					a.SPC_ID = decode(:ls_spc_id,'ALL',a.SPC_ID,:ls_spc_id)
	ORDER BY 1;	
	
	open c2;
	
	IF sqlca.sqlcode = 0 THEN
		fetch c2 into :ls_temp;
		
		do while sqlca.sqlcode <> 100
			ddlb_2.additem(ls_temp)
			fetch c2 into :ls_temp;
		loop
		close c2;
	end if
	ddlb_2.text='ALL'
	
	setpointer(arrow!)
elseif rb_2.checked then	
	setpointer(hourglass!)
	ddlb_2.reset()
	ddlb_2.additem('ALL')
	declare c5 cursor for
	
	SELECT distinct   initcap(decode(nvl(b.SSP_ID,'x'),'x',SP_NAME,f.SSP_NAME))||'('||b.SP_ID||')'
         FROM FB_STOREPRODUCT b, FB_LPIDETAILS c, FB_LOCALPURCHASEINVOICE d, FB_LOCALPURCHASEORDER e, 
                    FB_SUPPLIER SUP ,fb_storeproduct_std f
      WHERE b.SP_ID=c.SP_ID AND c.LPI_ID=d.LPI_ID AND d.LPO_ID=e.LPO_ID (+) AND  e.SUP_ID=SUP.SUP_ID and b.SSP_ID=f.ssp_id(+) and
                    trunc(d.LPI_DATE) between TO_DATE (:ls_frym, 'dd/mm/yyyy') AND TO_DATE (:ls_toym, 'dd/mm/yyyy') and  
	              e.SUP_ID = decode(:ls_sup_id,'ALL',e.SUP_ID,:ls_sup_id) 	and
					b.SPC_ID = decode(:ls_spc_id,'ALL',b.SPC_ID,:ls_spc_id)
	ORDER BY 1;
	
	open c5;
	
	IF sqlca.sqlcode = 0 THEN
		fetch c5 into :ls_temp;
		
		do while sqlca.sqlcode <> 100
			ddlb_2.additem(ls_temp)
			fetch c5 into :ls_temp;
		loop
		close c5;
	end if
	ddlb_2.text='ALL'
	
	setpointer(arrow!)
end if;	
end event

type st_5 from statictext within w_gteinr010
integer x = 46
integer y = 152
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

type ddlb_2 from dropdownlistbox within w_gteinr010
integer x = 1792
integer y = 144
integer width = 1193
integer height = 856
integer taborder = 70
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

type st_3 from statictext within w_gteinr010
integer x = 1513
integer y = 156
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
string text = "Product : "
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gteinr010
integer x = 2441
integer y = 40
integer width = 1358
integer height = 856
integer taborder = 60
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

event selectionchanged;ls_frym =dp_1.text
ls_toym =dp_2.text

ls_sup_id = left(right(ddlb_1.text,9),8)


if rb_1.checked then
	setpointer(hourglass!)
	ddlb_3.reset()
	ddlb_3.additem('ALL')
	
	declare c3 cursor for
	SELECT distinct g.SPC_NAME||' ('||g.SPC_ID||')'
	  FROM FB_STOREPRODUCT a,FB_INDENT b,FB_HOPURCHASEINVOICE c,FB_HOPIDETAILS d,FB_SUPPLIER e,fb_storeproduct_std f,
	             fb_storeproductcategory g
	WHERE b.INDENT_ID=c.INDENT_ID AND c.HOPI_ID=d.HOPI_ID AND 
			   c.SUP_ID=e.SUP_ID AND a.SP_ID=d.SP_ID and a.SSP_ID=f.ssp_id(+) AND
			   a.SPC_ID=g.SPC_ID and
			   trunc(c.HOPI_DATE) between TO_DATE (:ls_frym, 'dd/mm/yyyy') AND TO_DATE (:ls_toym, 'dd/mm/yyyy') AND c.HOPI_ACTIVE='1'	
			   and c.SUP_ID = decode(:ls_sup_id,'ALL',c.SUP_ID,:ls_sup_id)
	ORDER BY 1;
			
	open c3;
	
	IF sqlca.sqlcode = 0 THEN
		fetch c3 into :ls_temp;
		
		do while sqlca.sqlcode <> 100
			ddlb_3.additem(ls_temp)
			fetch c3 into :ls_temp;
		loop
		close c3;
	end if
	ddlb_3.text='ALL'
	
	setpointer(arrow!)
	
	setpointer(hourglass!)
	ddlb_2.reset()
	ddlb_2.additem('ALL')
	declare c2 cursor for
	
	SELECT distinct initcap(decode(nvl(a.SSP_ID,'x'),'x',SP_NAME,f.SSP_NAME))||'('||a.SP_ID||')'
	  FROM FB_STOREPRODUCT a,FB_INDENT b,FB_HOPURCHASEINVOICE c,FB_HOPIDETAILS d,FB_SUPPLIER e,fb_storeproduct_std f
	WHERE b.INDENT_ID=c.INDENT_ID AND c.HOPI_ID=d.HOPI_ID AND 
					  c.SUP_ID=e.SUP_ID AND a.SP_ID=d.SP_ID and a.SSP_ID=f.ssp_id(+) AND
					trunc(c.HOPI_DATE) between TO_DATE (:ls_frym, 'dd/mm/yyyy') AND TO_DATE (:ls_toym, 'dd/mm/yyyy') AND c.HOPI_ACTIVE='1'	
					and  c.SUP_ID = decode(:ls_sup_id,'ALL',c.SUP_ID,:ls_sup_id)
	ORDER BY 1;	
	
	open c2;
	
	IF sqlca.sqlcode = 0 THEN
		fetch c2 into :ls_temp;
		
		do while sqlca.sqlcode <> 100
			ddlb_2.additem(ls_temp)
			fetch c2 into :ls_temp;
		loop
		close c2;
	end if
	ddlb_2.text='ALL'
	
	setpointer(arrow!)
elseif rb_2.checked then	
	setpointer(hourglass!)
	ddlb_3.reset()
	ddlb_3.additem('ALL')
	declare c4 cursor for
	SELECT distinct  g.SPC_NAME||' ('||g.SPC_ID||')'
       FROM FB_STOREPRODUCT b, FB_LPIDETAILS c, FB_LOCALPURCHASEINVOICE d, FB_LOCALPURCHASEORDER e, 
                  FB_SUPPLIER SUP ,fb_storeproduct_std f,fb_storeproductcategory g
 WHERE b.SP_ID=c.SP_ID AND c.LPI_ID=d.LPI_ID AND d.LPO_ID=e.LPO_ID (+) AND  e.SUP_ID=SUP.SUP_ID and b.SSP_ID=f.ssp_id(+) and
               b.SPC_ID=g.SPC_ID and
               trunc(d.LPI_DATE) between TO_DATE (:ls_frym, 'dd/mm/yyyy') AND TO_DATE (:ls_toym, 'dd/mm/yyyy') and  
	          e.SUP_ID = decode(:ls_sup_id,'ALL',e.SUP_ID,:ls_sup_id) 	
	ORDER BY 1;		
	open c4;
	
	IF sqlca.sqlcode = 0 THEN
		fetch c4 into :ls_temp;
		
		do while sqlca.sqlcode <> 100
			ddlb_3.additem(ls_temp)
			fetch c4 into :ls_temp;
		loop
		close c4;
	end if
	ddlb_3.text='ALL'
	
	setpointer(arrow!)
	
	setpointer(hourglass!)
	ddlb_2.reset()
	ddlb_2.additem('ALL')
	declare c5 cursor for
	
	SELECT distinct   initcap(decode(nvl(b.SSP_ID,'x'),'x',SP_NAME,f.SSP_NAME))||'('||b.SP_ID||')'
         FROM FB_STOREPRODUCT b, FB_LPIDETAILS c, FB_LOCALPURCHASEINVOICE d, FB_LOCALPURCHASEORDER e, 
                    FB_SUPPLIER SUP ,fb_storeproduct_std f
      WHERE b.SP_ID=c.SP_ID AND c.LPI_ID=d.LPI_ID AND d.LPO_ID=e.LPO_ID (+) AND  e.SUP_ID=SUP.SUP_ID and b.SSP_ID=f.ssp_id(+) and
                    trunc(d.LPI_DATE) between TO_DATE (:ls_frym, 'dd/mm/yyyy') AND TO_DATE (:ls_toym, 'dd/mm/yyyy') and  
	              e.SUP_ID = decode(:ls_sup_id,'ALL',e.SUP_ID,:ls_sup_id) 	
	ORDER BY 1;
	
	open c5;
	
	IF sqlca.sqlcode = 0 THEN
		fetch c5 into :ls_temp;
		
		do while sqlca.sqlcode <> 100
			ddlb_2.additem(ls_temp)
			fetch c5 into :ls_temp;
		loop
		close c5;
	end if
	ddlb_2.text='ALL'
	
	setpointer(arrow!)
end if;	
end event

type st_4 from statictext within w_gteinr010
integer x = 2171
integer y = 48
integer width = 274
integer height = 72
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Supplier : "
boolean focusrectangle = false
end type

type dp_2 from datepicker within w_gteinr010
integer x = 1792
integer y = 36
integer width = 357
integer height = 100
integer taborder = 50
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2023-09-13"), Time("11:18:26.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type dp_1 from datepicker within w_gteinr010
integer x = 1179
integer y = 36
integer width = 352
integer height = 100
integer taborder = 40
boolean border = true
string customformat = "dd/mm/yyyy"
date maxdate = Date("2998-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2023-09-13"), Time("11:18:26.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type st_2 from statictext within w_gteinr010
integer x = 1541
integer y = 56
integer width = 247
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "To Date :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_gteinr010
integer x = 878
integer y = 56
integer width = 297
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Date :"
alignment alignment = center!
boolean focusrectangle = false
end type

type rb_2 from radiobutton within w_gteinr010
integer x = 453
integer y = 56
integer width = 402
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Local Invoice"
end type

event clicked;setpointer(hourglass!)
	ddlb_1.reset()
	ddlb_1.additem('ALL')
	
	declare c1 cursor for
		
   select initcap(SUP_NAME)||'('||SUP_ID||')' 
	 from fb_supplier where  nvl(SUP_ACTIVE,'0')='1' and SUP_TYPE in ('LOCAL','BOTH','UNIT')
	 order by 1;
	 
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
setpointer(arrow!)
end event

type rb_1 from radiobutton within w_gteinr010
integer x = 64
integer y = 56
integer width = 393
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "H.O. Invoice"
boolean checked = true
end type

event clicked;setpointer(hourglass!)
	ddlb_1.reset()
	ddlb_1.additem('ALL')
	
	declare c1 cursor for
		
   select initcap(SUP_NAME)||'('||SUP_ID||')' 
	 from fb_supplier where  nvl(SUP_ACTIVE,'0')='1' and (SUP_TYPE='HO' OR SUP_TYPE='BOTH')
	 order by 1;
	 
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
setpointer(arrow!)
end event

type cb_2 from commandbutton within w_gteinr010
integer x = 3264
integer y = 132
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&OK"
end type

event clicked;

if isnull(dp_1.text) or isnull(dp_2.text) or dp_1.text='00/00/0000' or dp_2.text = '00/00/0000' then
	messagebox('Warning','Please Enter From And To Date')
	return 
end if

if Date(dp_1.text) > date(string(today(),'dd/mm/yyyy'))  then
	messagebox('Alert!','From Date Should Be <= Current Date  !!!')
	return 1
end if

if Date(dp_2.text) > date(string(today(),'dd/mm/yyyy'))  then
	messagebox('Alert!','To Date Should Be <= Current Date  !!!')
	return 1
end if

if Date(dp_1.text) > Date(dp_2.text) then
	messagebox('Alert!','From Date Should Be <= Than To Date !!!')
	return 1
end if

if  isnull(ddlb_1.text) or ddlb_1.text = "" then 
	messagebox('Error At Supplier','Please Select Supplier')
	return 1
end if;



if  isnull(ddlb_3.text) or ddlb_3.text = "" then 
	messagebox('Error At Product Category','Please Select Product Category')
	return 1
end if;

if  isnull(ddlb_2.text) or ddlb_2.text = "" then 
	messagebox('Error At Product','Please Select Expense Head')
	return 1
end if;

ls_frym =dp_1.text
ls_toym =dp_2.text

ls_sup_id = left(right(ddlb_1.text,9),8)
ls_spc_id = left(right(ddlb_3.text,9),8)
ls_sp_id = left(right(ddlb_2.text,8),7)

if rb_2.checked then
	dw_2.hide()
	dw_1.show()
	dw_1.settransobject(sqlca)
	dw_1.retrieve(ls_frym,ls_toym,ls_sup_id,ls_spc_id,ls_sp_id)
elseif rb_1.checked then
	dw_1.hide()
	dw_2.show()
	dw_2.settransobject(sqlca)
	dw_2.retrieve(ls_frym,ls_toym,ls_sup_id,ls_spc_id,ls_sp_id)	
end if




end event

type cb_4 from commandbutton within w_gteinr010
integer x = 3534
integer y = 132
integer width = 265
integer height = 100
integer taborder = 40
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

type gb_1 from groupbox within w_gteinr010
integer x = 37
integer width = 832
integer height = 144
integer taborder = 10
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Return"
end type

type dw_1 from datawindow within w_gteinr010
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 27
integer y = 244
integer width = 3771
integer height = 1936
integer taborder = 60
string dataobject = "dw_gteinr010"
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

type dw_2 from datawindow within w_gteinr010
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
event ue_leftbuttonup pbm_dwnlbuttonup
integer x = 27
integer y = 244
integer width = 3771
integer height = 1936
integer taborder = 50
string dataobject = "dw_gteinr010a"
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

