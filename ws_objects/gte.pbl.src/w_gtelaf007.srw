$PBExportHeader$w_gtelaf007.srw
forward
global type w_gtelaf007 from window
end type
type em_7 from editmask within w_gtelaf007
end type
type em_6 from editmask within w_gtelaf007
end type
type em_5 from editmask within w_gtelaf007
end type
type em_4 from editmask within w_gtelaf007
end type
type em_3 from editmask within w_gtelaf007
end type
type em_2 from editmask within w_gtelaf007
end type
type em_1 from editmask within w_gtelaf007
end type
type st_1 from statictext within w_gtelaf007
end type
type cb_5 from commandbutton within w_gtelaf007
end type
type cb_4 from commandbutton within w_gtelaf007
end type
type cb_3 from commandbutton within w_gtelaf007
end type
type cb_2 from commandbutton within w_gtelaf007
end type
type cb_1 from commandbutton within w_gtelaf007
end type
type dw_1 from datawindow within w_gtelaf007
end type
end forward

global type w_gtelaf007 from window
integer width = 4498
integer height = 2280
boolean titlebar = true
string title = "(w_gtelaf007) Kamjari Codes"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
em_7 em_7
em_6 em_6
em_5 em_5
em_4 em_4
em_3 em_3
em_2 em_2
em_1 em_1
st_1 st_1
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtelaf007 w_gtelaf007

type variables
long ll_ctr, ll_cnt, ll_year, ll_last,ll_user_level
string ls_temp,ls_name,ls_last,ls_type,ls_id, ls_nktype, ls_desc, ls_secind, ls_measind, ls_costcind, ls_rowid, ls_active_ind
boolean lb_neworder, lb_query
datetime ld_dt,ld_frdt
double ld_afrt,ld_ahrt,ld_adfrt,ld_adhrt,ld_cfrt,ld_chrt
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_id, string fs_name, string fs_type, string fs_nktype, datetime fd_dt)
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
	if (isnull(dw_1.getitemstring(fl_row,'kamsub_id')) or  len(dw_1.getitemstring(fl_row,'kamsub_id'))=0 or &
		 isnull(dw_1.getitemstring(fl_row,'kamsub_name')) or  len(dw_1.getitemstring(fl_row,'kamsub_name'))=0 or &
		 isnull(dw_1.getitemstring(fl_row,'kamsub_type')) or  len(dw_1.getitemstring(fl_row,'kamsub_type'))=0 or &
		 isnull(dw_1.getitemstring(fl_row,'kamsub_nkamtype')) or  len(dw_1.getitemstring(fl_row,'kamsub_nkamtype'))=0 or &
		 isnull(dw_1.getitemnumber(fl_row,'kamsub_afrate')) or  dw_1.getitemnumber(fl_row,'kamsub_afrate') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'kamsub_ahrate')) or  dw_1.getitemnumber(fl_row,'kamsub_ahrate') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'kamsub_adfrate')) or  dw_1.getitemnumber(fl_row,'kamsub_adfrate') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'kamsub_adhrate')) or  dw_1.getitemnumber(fl_row,'kamsub_adhrate') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'kamsub_cfrate')) or  dw_1.getitemnumber(fl_row,'kamsub_cfrate') < 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'kamsub_chrate')) or  dw_1.getitemnumber(fl_row,'kamsub_chrate') < 0 ) then
	    messagebox('Warning: One Of The Following Fields Are Blank', 'Expense Sub Head, Kamjari Name, Type, Non Kamjari Type, Adult, Adolescent , Child Full & Half Rate, Please Check !!!')
		 return -1
	end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (string fs_id, string fs_name, string fs_type, string fs_nktype, datetime fd_dt);long fl_row
string ls_id1,ls_name1,ls_type1,ls_nktype1
datetime ld_dt1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_id1 = dw_1.getitemstring(fl_row,'kamsub_id')
		ls_name1 = dw_1.getitemstring(fl_row,'kamsub_name')
		ls_type1 = dw_1.getitemstring(fl_row,'kamsub_type')
		ls_nktype1 = dw_1.getitemstring(fl_row,'kamsub_nkamtype')
		ld_dt1 = dw_1.getitemdatetime(fl_row,'kamsub_frdt')
		
		if isnull(ls_nktype1) then ls_nktype1 = 'x'
		if isnull(fs_nktype) then fs_nktype = 'x'
		
		if ls_id1 = fs_id and ls_name1 = fs_name and ls_type1 = fs_type and ls_nktype1 = fs_nktype and ld_dt1 = fd_dt then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtelaf007.create
this.em_7=create em_7
this.em_6=create em_6
this.em_5=create em_5
this.em_4=create em_4
this.em_3=create em_3
this.em_2=create em_2
this.em_1=create em_1
this.st_1=create st_1
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.em_7,&
this.em_6,&
this.em_5,&
this.em_4,&
this.em_3,&
this.em_2,&
this.em_1,&
this.st_1,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtelaf007.destroy
destroy(this.em_7)
destroy(this.em_6)
destroy(this.em_5)
destroy(this.em_4)
destroy(this.em_3)
destroy(this.em_2)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false
//dw_1.modify("t_co.text = '"+gs_co_name+"'")
if f_openwindow(dw_1) = -1 then	
	close(this)
	return 1
end if
//if date(gd_dt) <> today() then
//	messagebox('Warning !!!','Your System Date Is Not Correct, PLease Check !!!')
//	return 1
//end if

this.tag = Message.StringParm
ll_user_level = long(this.tag)

if ll_user_level <> 1 then
	cb_1.enabled = false
	cb_3.enabled = false
	cb_5.enabled = false
end if
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

type em_7 from editmask within w_gtelaf007
integer x = 3822
integer y = 16
integer width = 155
integer height = 88
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0.00"
end type

type em_6 from editmask within w_gtelaf007
integer x = 3648
integer y = 16
integer width = 155
integer height = 88
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0.00"
end type

type em_5 from editmask within w_gtelaf007
integer x = 3456
integer y = 16
integer width = 155
integer height = 88
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0.00"
end type

type em_4 from editmask within w_gtelaf007
integer x = 3282
integer y = 16
integer width = 155
integer height = 88
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0.00"
end type

type em_3 from editmask within w_gtelaf007
integer x = 3072
integer y = 16
integer width = 155
integer height = 88
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0.00"
end type

type em_2 from editmask within w_gtelaf007
integer x = 2898
integer y = 16
integer width = 155
integer height = 88
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##0.00"
end type

type em_1 from editmask within w_gtelaf007
integer x = 2510
integer y = 16
integer width = 302
integer height = 84
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

event modified;if isnull(em_1.text) then
	messagebox('Warning!','Please Enter Valid Date !!!')
	return 1
else
	if ll_user_level = 1 then
		cb_5.enabled = true
	end if
end if
end event

type st_1 from statictext within w_gtelaf007
integer x = 2286
integer y = 28
integer width = 206
integer height = 60
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Date :"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_5 from commandbutton within w_gtelaf007
integer x = 4032
integer y = 8
integer width = 411
integer height = 100
integer taborder = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
boolean enabled = false
string text = "&Replicate Data"
end type

event clicked;if isnull(em_1.text) then
	messagebox('Warning!','Please Enter Valid Date !!!')
	return 1
end if

ld_dt = datetime(em_1.text)


select distinct 'x' into :ls_temp from fb_kamsubhead where trunc(KAMSUB_frdt) >= trunc(:ld_dt);
if sqlca.sqlcode = -1 then
	messagebox('Error : While Getting Details',sqlca.sqlerrtext)
	rollback using sqlca;
	return 1
elseif sqlca.sqlcode  = 0 then
	messagebox('Warning!','Record Already Exists For This Date, Please Enter A Future Date!!!')
	return 1
end if

dw_1.settransobject(sqlca)
dw_1.reset()


setnull(ls_id); setnull(ls_name); setnull(ls_type); setnull(ls_nktype); setnull(ld_frdt); ld_afrt = 0; ld_ahrt = 0; ld_adfrt = 0; ld_adhrt = 0; ld_cfrt = 0; ld_chrt = 0;
setnull(ls_desc); setnull(ls_secind); setnull(ls_measind); setnull(ls_costcind);

ld_afrt = double(em_2.text); 	ld_ahrt= double(em_3.text); 	ld_adfrt= double(em_4.text);
ld_adhrt= double(em_5.text); ld_cfrt= double(em_6.text); 	ld_chrt= double(em_7.text)

declare c1 cursor for
select KAMSUB_ID, trim(KAMSUB_NAME),  trim(KAMSUB_TYPE), trim(KAMSUB_NKAMTYPE),  trim(KAMSUB_DESC), KAMSUB_SECIND, KAMSUB_MEASIND, KAMSUB_COSTCIND 
from  fb_kamsubhead where KAMSUB_TODT is null and nvl(KAMSUB_ACTIVE_IND,'Y') = 'Y'
order by 1 asc;
	
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_id,:ls_name,:ls_type,:ls_nktype,:ls_desc, :ls_secind, :ls_measind, :ls_costcind;
	
	do while sqlca.sqlcode <> 100
				
		dw_1.scrolltorow(dw_1.insertrow(0))
		dw_1.setitem(dw_1.getrow(),'kamsub_id',ls_id)
		dw_1.setitem(dw_1.getrow(),'kamsub_name',ls_name)
		dw_1.setitem(dw_1.getrow(),'kamsub_type',ls_type)
		dw_1.setitem(dw_1.getrow(),'kamsub_nkamtype',ls_nktype)
		dw_1.setitem(dw_1.getrow(),'kamsub_frdt',ld_dt)
		dw_1.setitem(dw_1.getrow(),'kamsub_afrate',ld_afrt)
		dw_1.setitem(dw_1.getrow(),'kamsub_ahrate',ld_ahrt)
		dw_1.setitem(dw_1.getrow(),'kamsub_adfrate',ld_adfrt)
		dw_1.setitem(dw_1.getrow(),'kamsub_adhrate',ld_adhrt)
		dw_1.setitem(dw_1.getrow(),'kamsub_cfrate',ld_cfrt)
		dw_1.setitem(dw_1.getrow(),'kamsub_chrate',ld_chrt)
		dw_1.setitem(dw_1.getrow(),'kamsub_active_ind','Y')
		dw_1.setitem(dw_1.getrow(),'kamsub_desc',ls_desc)
		dw_1.setitem(dw_1.getrow(),'kamsub_secind',ls_secind)	
		dw_1.setitem(dw_1.getrow(),'kamsub_measind',ls_measind)	
		dw_1.setitem(dw_1.getrow(),'kamsub_costcind',ls_costcind)	
		dw_1.setitem(dw_1.getrow(),'kamsub_entry_by',gs_user)
		dw_1.setitem(dw_1.getrow(),'kamsub_entry_dt',ld_dt)

		
		setnull(ls_id); setnull(ls_name); setnull(ls_type); setnull(ls_nktype); setnull(ld_frdt); 
		setnull(ls_desc); setnull(ls_secind); setnull(ls_measind); setnull(ls_costcind);
		
		fetch c1 into :ls_id,:ls_name,:ls_type,:ls_nktype,:ls_desc, :ls_secind, :ls_measind, :ls_costcind;
	loop
	close c1;
	dw_1.scrolltorow(1)
end if
end event

type cb_4 from commandbutton within w_gtelaf007
integer x = 809
integer y = 12
integer width = 265
integer height = 100
integer taborder = 130
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

type cb_3 from commandbutton within w_gtelaf007
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

event clicked;dw_1.SelectRow(0, FALSE)

if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'kamsub_id')) or len(dw_1.getitemstring(dw_1.rowcount(),'kamsub_id'))=0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	if dw_1.rowcount() > 0 then
		IF wf_check_fillcol(dw_1.getrow()) = -1 THEN 
			return 1
		end if
	end if
	
	for  ll_ctr = 1 to dw_1.rowcount( ) 
			ls_id = dw_1.getitemstring(ll_ctr,'kamsub_id')
			ls_name = dw_1.getitemstring(ll_ctr,'kamsub_name')
			ls_type = dw_1.getitemstring(ll_ctr,'kamsub_type')
			ls_nktype = dw_1.getitemstring(ll_ctr,'kamsub_nkamtype')
			ld_frdt = dw_1.getitemdatetime(ll_ctr,'kamsub_frdt')
			ls_active_ind = dw_1.getitemstring(ll_ctr, 'kamsub_active_ind')
			ls_rowid = dw_1.getitemstring(ll_ctr, 'rowid')
			
			if ls_Active_ind = 'Y' then
				//messagebox('Error : RowID'+ls_rowid,sqlca.sqlerrtext)
				if isnull(ls_rowid) then
					//messagebox('Error : Isnull RowID'+ls_rowid,sqlca.sqlerrtext)
					select distinct 'x' into :ls_temp from fb_kamsubhead
					where kamsub_id = :ls_id and trim(kamsub_name) = trim(:ls_name) and trim(kamsub_type) = trim(:ls_type) and 
					nvl(trim(kamsub_nkamtype),'x') = trim(nvl(:ls_nktype,'x')) and kamsub_frdt >= :ld_frdt and kamsub_todt is null;
				else
					//messagebox('Error : NOT NULL RowID'+ls_rowid,sqlca.sqlerrtext)
					select distinct 'x' into :ls_temp from fb_kamsubhead
					where kamsub_id = :ls_id and trim(kamsub_name) = trim(:ls_name) and trim(kamsub_type) = trim(:ls_type) and 
					nvl(trim(kamsub_nkamtype),'x') = trim(nvl(:ls_nktype,'x')) and kamsub_frdt >= :ld_frdt and kamsub_todt is null and rowid <> nvl(:ls_rowid, 'x');
				end if
			
			
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Rate Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode  = 0 then
					messagebox("Warning!","Record Already Exists, Please Check !!!")
					dw_1.SelectRow(ll_ctr, TRUE)
					return 1
				end if
			end if
	next
	
	if dw_1.update(true,false) = 1 then
		dw_1.resetupdate();

		for ll_ctr = 1 to dw_1.rowcount( ) 
			ls_id = dw_1.getitemstring(ll_ctr,'kamsub_id')
			ls_name = dw_1.getitemstring(ll_ctr,'kamsub_name')
			ls_type = dw_1.getitemstring(ll_ctr,'kamsub_type')
			ls_nktype = dw_1.getitemstring(ll_ctr,'kamsub_nkamtype')
			ld_frdt = dw_1.getitemdatetime(ll_ctr,'kamsub_frdt')
			
			update fb_kamsubhead set kamsub_todt = (:ld_frdt - 1), kamsub_active_ind = 'N' 
			where kamsub_id = :ls_id and trim(kamsub_name) = trim(:ls_name) and trim(kamsub_type) = trim(:ls_type)  and trim(kamsub_nkamtype) = trim(:ls_nktype) and kamsub_todt is null and kamsub_frdt < :ld_frdt;
	
			 if sqlca.sqlcode = -1 then
				messagebox('Error : While Updating Record 1',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1	
			 end if	
		next	
		
		cb_3.enabled = false
		commit using sqlca;
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

type cb_2 from commandbutton within w_gtelaf007
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
	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('kamsub_id')
	dw_1.settaborder('kamsub_active_ind',200)
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(ll_user_level)
	dw_1.settaborder('kamsub_active_ind',0)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	if ll_user_level = 1 then
		cb_1.enabled = true
	end if
end if

end event

type cb_1 from commandbutton within w_gtelaf007
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
	dw_1.setitem(dw_1.getrow(),'kamsub_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'kamsub_entry_dt',datetime(today()))
	dw_1.setcolumn('kamsub_id')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'kamsub_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'kamsub_entry_dt',datetime(today()))
	dw_1.setcolumn('kamsub_id')
end if


end event

type dw_1 from datawindow within w_gtelaf007
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 116
integer width = 4448
integer height = 2052
integer taborder = 30
string dataobject = "dw_gtelaf007"
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
		dw_1.setitem(newrow,'kamsub_entry_by',gs_user)
		dw_1.setitem(newrow,'kamsub_entry_dt',datetime(today()))
		dw_1.setcolumn('kamsub_id')
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
	if dwo.name = 'kamsub_id'  then
		ls_id = data
		
		if f_check_initial_space(ls_id) = -1 then return 1
				
//		select distinct 'x' into :ls_temp from fb_kamsubhead where kamsub_id = :ls_id;
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode  = 0 then
//			messagebox('Warning!','Kamjari Details Already Exists, Please Check !!!')
//			return 1
//		end if
	end if

	if dwo.name = 'kamsub_name'  then
		ls_name = data
		
		if f_check_initial_space(ls_name) = -1 then return 1
		
		if f_check_string(ls_name) = -1 then return 1
				
//		select distinct 'x' into :ls_temp from fb_kamsubhead where kamsub_name = :ls_name;
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Kamjari Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode  = 0 then
//			messagebox('Warning!','Kamjari Details Already Exists, Please Check !!!')
//			return 1
//		end if
	end if
	
	if dwo.name = 'kamsub_type'  then
		ls_type = data
		ls_id = dw_1.getitemstring(row,'kamsub_id')
		ls_name = dw_1.getitemstring(row,'kamsub_name')

		if ls_type <> 'NKAM' then
			dw_1.setitem(row,'kamsub_nkamtype','OTHERS')
		end if
	//	messagebox('ccc',ls_id+ '    '+ls_name + '    '+ls_type)
		select distinct KAMSUB_AFRATE,  KAMSUB_AHRATE, KAMSUB_ADFRATE, KAMSUB_ADHRATE, KAMSUB_CFRATE,KAMSUB_CHRATE
		into :ld_afrt,:ld_ahrt,:ld_adfrt,:ld_adhrt,:ld_cfrt,:ld_chrt
		from fb_kamsubhead 
		 where kamsub_id = :ls_id and trim(kamsub_name) = :ls_name and trim(kamsub_type) = :ls_type and kamsub_todt is null;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Ration Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			
			if isnull(ld_afrt) then ld_afrt = 0;
			if isnull(ld_ahrt) then ld_ahrt = 0;
			if isnull(ld_adfrt) then ld_adfrt = 0;
			if isnull(ld_adhrt) then ld_adhrt = 0;
			if isnull(ld_cfrt) then ld_cfrt = 0;
			if isnull(ld_chrt) then ld_chrt = 0;

			dw_1.setitem(row,'kamsub_afrate',ld_afrt)
			dw_1.setitem(row,'kamsub_ahrate',ld_ahrt)
			dw_1.setitem(row,'kamsub_adfrate',ld_adfrt)
			dw_1.setitem(row,'kamsub_adhrate',ld_adhrt)
			dw_1.setitem(row,'kamsub_cfrate',ld_cfrt)
			dw_1.setitem(row,'kamsub_chrate',ld_chrt)
		elseif sqlca.sqlcode = 100 then
			ld_afrt = 0; ld_ahrt = 0; ld_adfrt = 0; ld_adhrt = 0; ld_cfrt = 0; ld_chrt = 0;
			
//			dw_1.setitem(row,'kamsub_afrate',ld_afrt)
//			dw_1.setitem(row,'kamsub_ahrate',ld_ahrt)
//			dw_1.setitem(row,'kamsub_adfrate',ld_adfrt)
//			dw_1.setitem(row,'kamsub_adhrate',ld_adhrt)
//			dw_1.setitem(row,'kamsub_cfrate',ld_cfrt)
//			dw_1.setitem(row,'kamsub_chrate',ld_chrt)

		end if		
	end if
	
		
	if dwo.name = 'kamsub_frdt' then
		ls_id = dw_1.getitemstring(row,'kamsub_id')
		ls_name = dw_1.getitemstring(row,'kamsub_name')
		ls_type = dw_1.getitemstring(row,'kamsub_type')
		ls_nktype = dw_1.getitemstring(row,'kamsub_nkamtype')
		ld_frdt = datetime(data)
		
		if  wf_check_duplicate_rec(ls_id,ls_name,ls_type,ls_nktype,ld_frdt) = -1 then return 1
		
		select distinct 'x' into :ls_temp from fb_kamsubhead
		 where kamsub_id = :ls_id and kamsub_name = :ls_name and kamsub_type = :ls_type and nvl(kamsub_nkamtype,'x') = nvl(:ls_nktype,'x') and kamsub_frdt = :ld_frdt and kamsub_todt is null;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Ration Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox('Warning!','Record Already Exists, Please Check !!!')
			return 1
		end if
	end if
	
	dw_1.setitem(row,'kamsub_entry_by',gs_user)
	dw_1.setitem(row,'kamsub_entry_dt',datetime(today()))
	if ll_user_level = 1 then
		cb_3.enabled = true
	end if
end if

if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if
end event

event updatestart;//
integer li_column, li_row // variables to hold the column index and row number
string ls_old_value, ls_new_value // variables to hold the old and new values
long ll_coumnid
string ls_columnname,ls_unique_id




// Loop through all rows in the DataWindow control
FOR li_row = 1 TO This.RowCount()
//SELECT max(COLUMN_ID) COLUMN_id, into :ll_cnt  FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_teamadeproduct') and column_id not in (9,10);
////ll_no =  
//    // Loop through all data columns in the DataWindow control
//    FOR li_column = 1 TO ll_cnt
//
//        // Get the old value for the data column
//        ls_old_value = dw_1.GetItemString(li_row, li_column, Primary!, true)
//
//        // Get the new value for the data column
//        ls_new_value = This.GetItemString(li_row, li_column)
//
//        // Compare the old and new values
//        if ls_old_value <> ls_new_value then
//            // Code to execute if the values are different
//				
//				insert into fb_log(OBJECT, SUBOBJECT, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
//				('fb_teamadeproduct','fb_teamadeproduct','U',:li_column,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
//				if sqlca.sqlcode = -1 then
//							messagebox("SQL Error : While Inserting Into LOg Table ",SQLCA.SQLErrtext,Information!)
//							rollback using sqlca;
//							return -1 
//				end if		
//				
//				
//				
//        end if
//
//    NEXT

DECLARE c1 CURSOR FOR  

SELECT COLUMN_ID,COLUMN_Name FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_kamsubhead');

close c1;
open c1;
if sqlca.sqlcode = -1 then
				messagebox('Error', 'Error occured while opening cursor c1 : '+sqlca.sqlerrtext)
				rollback using sqlca;
				return 1;
		
elseIF sqlca.sqlcode = 0 THEN
	setnull(ll_coumnid);setnull(ls_columnname);
	fetch c1 into :ll_coumnid,:ls_columnname;

		do while sqlca.sqlcode <> 100
 			// Get the old value for the data column
			       ls_old_value = dw_1.GetItemString(li_row, ll_coumnid, Primary!, true)
			 // Get the new value for the data column
			       ls_new_value = This.GetItemString(li_row, ll_coumnid)
			
			// Get the unique Value of Row
			
			ls_unique_id=dw_1.GetItemString(li_row, 1, Primary!, true)
					 
					 
					 if ls_old_value <> ls_new_value then
						insert into fb_log(table_name, Unique_key, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
												('fb_kamsubhead',:ls_unique_id,'U',:ls_columnname,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
							if sqlca.sqlcode = -1 then
								messagebox("SQL Error : While Inserting Into Log Table ",SQLCA.SQLErrtext,Information!)
								rollback using sqlca;
								return -1 
							 end if
						end if
					 
					 
					 
		setnull(ll_coumnid);setnull(ls_columnname);

	fetch c1 into :ll_coumnid,:ls_columnname;
	loop
end if	
NEXT
close c1;
end event

