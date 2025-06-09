$PBExportHeader$w_gteacr014.srw
forward
global type w_gteacr014 from window
end type
type ddlb_2 from dropdownlistbox within w_gteacr014
end type
type st_3 from statictext within w_gteacr014
end type
type ddlb_1 from dropdownlistbox within w_gteacr014
end type
type st_2 from statictext within w_gteacr014
end type
type rb_4 from radiobutton within w_gteacr014
end type
type rb_3 from radiobutton within w_gteacr014
end type
type ddlb_5 from dropdownlistbox within w_gteacr014
end type
type st_5 from statictext within w_gteacr014
end type
type cb_2 from commandbutton within w_gteacr014
end type
type cb_1 from commandbutton within w_gteacr014
end type
type em_1 from editmask within w_gteacr014
end type
type st_1 from statictext within w_gteacr014
end type
type dw_1 from datawindow within w_gteacr014
end type
type gb_2 from groupbox within w_gteacr014
end type
end forward

global type w_gteacr014 from window
integer width = 4384
integer height = 2180
boolean titlebar = true
string title = "(W_gteacr014)  Fixed Assets"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
ddlb_2 ddlb_2
st_3 st_3
ddlb_1 ddlb_1
st_2 st_2
rb_4 rb_4
rb_3 rb_3
ddlb_5 ddlb_5
st_5 st_5
cb_2 cb_2
cb_1 cb_1
em_1 em_1
st_1 st_1
dw_1 dw_1
gb_2 gb_2
end type
global w_gteacr014 w_gteacr014

type variables
string ls_unit,ls_unitnm,ls_Assets_name,ls_Assets_group
long ll_fy
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

on w_gteacr014.create
this.ddlb_2=create ddlb_2
this.st_3=create st_3
this.ddlb_1=create ddlb_1
this.st_2=create st_2
this.rb_4=create rb_4
this.rb_3=create rb_3
this.ddlb_5=create ddlb_5
this.st_5=create st_5
this.cb_2=create cb_2
this.cb_1=create cb_1
this.em_1=create em_1
this.st_1=create st_1
this.dw_1=create dw_1
this.gb_2=create gb_2
this.Control[]={this.ddlb_2,&
this.st_3,&
this.ddlb_1,&
this.st_2,&
this.rb_4,&
this.rb_3,&
this.ddlb_5,&
this.st_5,&
this.cb_2,&
this.cb_1,&
this.em_1,&
this.st_1,&
this.dw_1,&
this.gb_2}
end on

on w_gteacr014.destroy
destroy(this.ddlb_2)
destroy(this.st_3)
destroy(this.ddlb_1)
destroy(this.st_2)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.ddlb_5)
destroy(this.st_5)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.gb_2)
end on

event open;//dw_1.modify("t_co.text = '"+gs_co_name+"'")
//dw_1.modify("t_gnm.text = '"+gs_garden_nameadd+"'")
dw_1.settransobject(sqlca)
//Send(Handle(dw_1), 274, 61488, 0)
//dw_1.retrieve()
//if dw_1.rowcount() = 0 then
//	messagebox('Information!','No data Found !!!')
//	return 1
//end if

ddlb_5.additem('ALL (AL)');

declare c1 cursor for
select distinct UNIT_SHORTNAME,initcap(UNIT_NAME)||'('||UNIT_SHORTNAME||')' from fb_gardenmaster,FB_FIXED_ASSETS 
where nvl(UNIT_ACTIVE_IND,'N') = 'Y' and UNIT_SHORTNAME=FA_GARDEN order by 1;
open c1;

IF sqlca.sqlcode = 0 THEN 
	fetch c1 into :ls_unit, :ls_unitnm;
	
	do while sqlca.sqlcode <> 100
		ddlb_5.additem(ls_unitnm)
		fetch c1 into :ls_unit, :ls_unitnm;
	loop
	close c1;
end if


ddlb_2.additem('ALL');

declare c3 cursor for
select distinct FA_ASSETS_GROUP  from FB_FIXED_ASSETS order by 1 ;

open c3;

IF sqlca.sqlcode = 0 THEN 
	fetch c3 into :ls_Assets_group;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(ls_Assets_group)
		fetch c3 into :ls_Assets_group;
	loop
	close c3;
end if


ddlb_1.additem('ALL');

declare c2 cursor for
select distinct FA_ITEM_NAME  from FB_FIXED_ASSETS order by 1 ;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ls_Assets_name;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_Assets_name)
		fetch c2 into :ls_Assets_name;
	loop
	close c2;
end if

end event

type ddlb_2 from dropdownlistbox within w_gteacr014
integer x = 370
integer y = 148
integer width = 1193
integer height = 740
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
end type

event selectionchanged;
 ls_Assets_group = ddlb_2.text;	
 reset(ddlb_1);
 if ls_Assets_group ='ALL' then
	ddlb_1.additem('ALL');
	declare c2 cursor for
	select distinct FA_ITEM_NAME  from FB_FIXED_ASSETS   order by 1 ;
	
	open c2;
	
	IF sqlca.sqlcode = 0 THEN 
		fetch c2 into :ls_Assets_name;
		
		do while sqlca.sqlcode <> 100
			ddlb_1.additem(ls_Assets_name)
			fetch c2 into :ls_Assets_name;
		loop
		close c2;
	end if
else	
ddlb_1.additem('ALL');

	declare c3 cursor for
	select distinct FA_ITEM_NAME  from FB_FIXED_ASSETS  where FA_ASSETS_GROUP = : ls_Assets_group order by 1 ;
	
	open c3;
	
	IF sqlca.sqlcode = 0 THEN 
		fetch c3 into :ls_Assets_name;
		
		do while sqlca.sqlcode <> 100
			ddlb_1.additem(ls_Assets_name)
			fetch c3 into :ls_Assets_name;
		loop
		close c3;
	end if
end if;	
end event

type st_3 from statictext within w_gteacr014
integer x = 32
integer y = 168
integer width = 315
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Main Group"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_gteacr014
integer x = 1929
integer y = 144
integer width = 1193
integer height = 740
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
end type

type st_2 from statictext within w_gteacr014
integer x = 1591
integer y = 164
integer width = 315
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Assets Name"
boolean focusrectangle = false
end type

type rb_4 from radiobutton within w_gteacr014
integer x = 1207
integer y = 44
integer width = 261
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detail"
end type

event clicked;
ddlb_1.visible=true;
ddlb_2.visible=true;
ddlb_5.visible=true;

st_2.visible=true;
st_3.visible=true;
st_5.visible=true;

ll_fy = long(em_1.text )


declare c3 cursor for

select distinct FA_ASSETS_GROUP
   from FB_FIXED_ASSETS a,(select DD_ITEM_CD,DD_DEPR_RATE_CO * 100 Rate, sum(nvl(DD_CAD_CURR_DEPR,0))depr,sum(nvl(DD_ADDITIONS,0)) addition, 
                                  sum(nvl(DD_DISPOSALS,0)) disposals, sum(nvl(DD_DEPR_ON_DESPOSAL,0)) disposals_dep, sum(nvl(DD_WDV_VALUE,0)) wdv_val 
                             from FB_ASSETS_DEPR_DET where DD_YEAR = :ll_fy group by DD_ITEM_CD,DD_DEPR_RATE_CO)b
    where a.FA_ITEM_CD=b.DD_ITEM_CD(+) 
    order by 1 ;

open c3;

IF sqlca.sqlcode = 0 THEN 
	fetch c3 into :ls_Assets_group;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(ls_Assets_group)
		fetch c3 into :ls_Assets_group;
	loop
	close c3;
end if
ddlb_2.additem('ALL');


declare c2 cursor for
select distinct FA_ITEM_NAME
   from FB_FIXED_ASSETS a,(select DD_ITEM_CD,DD_DEPR_RATE_CO * 100 Rate, sum(nvl(DD_CAD_CURR_DEPR,0))depr,sum(nvl(DD_ADDITIONS,0)) addition, 
                                  sum(nvl(DD_DISPOSALS,0)) disposals, sum(nvl(DD_DEPR_ON_DESPOSAL,0)) disposals_dep, sum(nvl(DD_WDV_VALUE,0)) wdv_val 
                             from FB_ASSETS_DEPR_DET where DD_YEAR = :ll_fy group by DD_ITEM_CD,DD_DEPR_RATE_CO)b
    where a.FA_ITEM_CD=b.DD_ITEM_CD(+) 
    order by 1 ;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ls_Assets_name;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_Assets_name)
		fetch c2 into :ls_Assets_name;
	loop
	close c2;
end if

ddlb_1.additem('ALL');
end event

type rb_3 from radiobutton within w_gteacr014
integer x = 878
integer y = 44
integer width = 347
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Summary"
boolean checked = true
end type

event clicked;ddlb_1.visible=false;
ddlb_2.visible=false;
ddlb_5.visible=false;

st_2.visible=false;
st_3.visible=false;
st_5.visible=false;
end event

type ddlb_5 from dropdownlistbox within w_gteacr014
boolean visible = false
integer x = 1929
integer y = 36
integer width = 960
integer height = 740
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
end type

event selectionchanged;ll_fy = long(em_1.text )
ls_unit = mid(right(ddlb_5.text,3),1,2);	
reset(ddlb_1);
reset(ddlb_2);

ddlb_1.additem('ALL');
declare c2 cursor for
select distinct FA_ITEM_NAME
   from FB_FIXED_ASSETS a,(select DD_ITEM_CD,DD_DEPR_RATE_CO * 100 Rate, sum(nvl(DD_CAD_CURR_DEPR,0))depr,sum(nvl(DD_ADDITIONS,0)) addition, 
                                  sum(nvl(DD_DISPOSALS,0)) disposals, sum(nvl(DD_DEPR_ON_DESPOSAL,0)) disposals_dep, sum(nvl(DD_WDV_VALUE,0)) wdv_val 
                             from FB_ASSETS_DEPR_DET where DD_YEAR = :ll_fy group by DD_ITEM_CD,DD_DEPR_RATE_CO)b
    where a.FA_ITEM_CD=b.DD_ITEM_CD(+) and FA_GARDEN = decode(nvl(:ls_unit,'AL'),'AL',FA_GARDEN,:ls_unit) 
    order by 1 ;

open c2;

IF sqlca.sqlcode = 0 THEN 
	fetch c2 into :ls_Assets_name;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(ls_Assets_name)
		fetch c2 into :ls_Assets_name;
	loop
	close c2;
end if


ddlb_2.additem('ALL');

declare c3 cursor for

select distinct FA_ASSETS_GROUP
   from FB_FIXED_ASSETS a,(select DD_ITEM_CD,DD_DEPR_RATE_CO * 100 Rate, sum(nvl(DD_CAD_CURR_DEPR,0))depr,sum(nvl(DD_ADDITIONS,0)) addition, 
                                  sum(nvl(DD_DISPOSALS,0)) disposals, sum(nvl(DD_DEPR_ON_DESPOSAL,0)) disposals_dep, sum(nvl(DD_WDV_VALUE,0)) wdv_val 
                             from FB_ASSETS_DEPR_DET where DD_YEAR = :ll_fy group by DD_ITEM_CD,DD_DEPR_RATE_CO)b
    where a.FA_ITEM_CD=b.DD_ITEM_CD(+) and FA_GARDEN = decode(nvl(:ls_unit,'AL'),'AL',FA_GARDEN,:ls_unit) 
    order by 1 ;

open c3;

IF sqlca.sqlcode = 0 THEN 
	fetch c3 into :ls_Assets_group;
	
	do while sqlca.sqlcode <> 100
		ddlb_2.additem(ls_Assets_group)
		fetch c3 into :ls_Assets_group;
	loop
	close c3;
end if

end event

type st_5 from statictext within w_gteacr014
boolean visible = false
integer x = 1719
integer y = 56
integer width = 197
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Garden"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_gteacr014
integer x = 3177
integer y = 136
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
boolean cancel = true
end type

event clicked;Close(parent)
end event

type cb_1 from commandbutton within w_gteacr014
integer x = 3177
integer y = 36
integer width = 265
integer height = 100
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&OK"
end type

event clicked; double ld_actcrop_tot_tp,ld_actcrop_tot,ld_lyrcrop_tot,ld_actcrop_pur_tp,ld_actcrop_pur,ld_lyrcrop_pur,ld_actcrop_sal_tp,ld_actcrop_sal,ld_lyrcrop_sal,ld_budcrop_own,ld_budcrop_own_tot,ld_budcrop_pur,ld_budcrop_pur_tot
string ls_todt, ls_ysdt,ls_ly_todt,ls_ly_ysdt

setpointer(hourglass!)

ll_fy = long(em_1.text )

ls_unit = mid(right(ddlb_5.text,3),1,2);			
ls_Assets_name = ddlb_1.text;		
ls_Assets_group = ddlb_2.text;	

if rb_3.checked then
	dw_1.DataObject = "dw_gteacr014_s"// "dw_ltcacr032a_new"
	dw_1.settransobject(sqlca)
     dw_1.retrieve(ll_fy,gs_garden_snm)
elseif rb_4.checked then
	dw_1.DataObject = "dw_gteacr014"// "dw_ltcacr032aa"
	dw_1.settransobject(sqlca)
	dw_1.retrieve(ll_fy,ls_unit,ls_Assets_group,ls_Assets_name)
end if	
setpointer(arrow!)

end event

type em_1 from editmask within w_gteacr014
integer x = 658
integer y = 24
integer width = 183
integer height = 100
integer taborder = 10
integer textsize = -10
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
string mask = "yyyy"
end type

type st_1 from statictext within w_gteacr014
integer x = 18
integer y = 40
integer width = 617
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Year (End Of Fin. Year) :"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_gteacr014
event ue_leftbuttonup pbm_dwnlbuttonup
integer y = 252
integer width = 4320
integer height = 1932
string dataobject = "dw_gteacr014"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
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

type gb_2 from groupbox within w_gteacr014
integer x = 855
integer width = 631
integer height = 144
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
end type

