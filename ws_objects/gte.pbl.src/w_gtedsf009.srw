$PBExportHeader$w_gtedsf009.srw
forward
global type w_gtedsf009 from window
end type
type cb_5 from commandbutton within w_gtedsf009
end type
type cb_4 from commandbutton within w_gtedsf009
end type
type cb_3 from commandbutton within w_gtedsf009
end type
type cb_2 from commandbutton within w_gtedsf009
end type
type cb_1 from commandbutton within w_gtedsf009
end type
type dw_1 from datawindow within w_gtedsf009
end type
end forward

global type w_gtedsf009 from window
integer width = 4197
integer height = 2280
boolean titlebar = true
string title = "(w_gtedsf009) Sample Dispatch"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtedsf009 w_gtedsf009

type variables
long ll_ctr, ll_cnt,l_ctr,ix, ll_from,ll_to,ll_ac_year, ll_lotno, ll_season, ll_st_year,ll_end_year,ll_user_level
string ls_temp,ls_tmp_id,ls_tpc_id,ls_inv_no, ls_grade, ls_type
boolean lb_neworder, lb_query
double ld_hrs, ld_min,ld_frmhrs, ld_frmmin
datetime ld_dt
datawindowchild idw_grade
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (datetime fs_dt, string fs_type, string fs_tpc_id, string fs_grade)
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
	if (isnull(dw_1.getitemdatetime(fl_row,'sd_date')) or &
		isnull(dw_1.getitemstring(fl_row,'sd_type')) or  len(dw_1.getitemstring(fl_row,'sd_type'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'tpc_id')) or  len(dw_1.getitemstring(fl_row,'tpc_id'))=0 or &
		isnull(dw_1.getitemnumber(fl_row,'sd_qnty')) or dw_1.getitemnumber(fl_row,'sd_qnty') = 0) then
	    		messagebox('Warning: One Of The Following Fields Are Blank','Drawing Date, Sample Type, Tea Category, Quantity, Please Check !!!')		 
		 	return -1
	end if
	choose case dw_1.getitemstring(fl_row,'sd_type')
	case 'D'
			if (((isnull(dw_1.getitemnumber(fl_row,'sd_runhrs')) or dw_1.getitemnumber(fl_row,'sd_runhrs') = 0) and (isnull(dw_1.getitemnumber(fl_row,'sd_runmin')) or dw_1.getitemnumber(fl_row,'sd_runmin') = 0)) or &
			    ((isnull(dw_1.getitemnumber(fl_row,'sd_fermhrs')) or dw_1.getitemnumber(fl_row,'sd_fermhrs') = 0) and (isnull(dw_1.getitemnumber(fl_row,'sd_fermmin')) or dw_1.getitemnumber(fl_row,'sd_fermmin') = 0)) ) then
				messagebox('Warning: One Of The Following Fields Are Blank','Total Run Time Should Not Be Blank , Please Check !!!')
				return -1
			end if
	case 'P'
			if 	(isnull(dw_1.getitemstring(fl_row,'dtp_lotno')) or  len(dw_1.getitemstring(fl_row,'dtp_lotno'))=0 or &
				 isnull(dw_1.getitemstring(fl_row,'tmp_id')) or  len(dw_1.getitemstring(fl_row,'tmp_id'))=0  or &
		 		 isnull(dw_1.getitemstring(fl_row,'sd_custid')) or  len(dw_1.getitemstring(fl_row,'sd_custid')) =0) then
				 messagebox('Warning: One Of The Following Fields Are Blank','Tea Grade And Invoice No., Buyer, Should Not Be Blank, Please Check !!!')		 
				 return -1
			end if
	case 'S'			
		if 	(isnull(dw_1.getitemstring(fl_row,'tmp_id')) or  len(dw_1.getitemstring(fl_row,'tmp_id'))=0)  then
	    		messagebox('Warning: One Of The Following Fields Are Blank','Tea Grade Should not Be Blank, Please Check !!!')
		 	return -1
		end if
	end choose

end if
return 1

end function

public function integer wf_check_duplicate_rec (datetime fs_dt, string fs_type, string fs_tpc_id, string fs_grade);long fl_row
string ls_type1,ls_tpc_id1, ls_grade1
datetime ld_dt1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_type1 = dw_1.getitemstring(fl_row,'sd_type')
		ls_tpc_id1 = dw_1.getitemstring(fl_row,'tpc_id')
		ls_grade1 = dw_1.getitemstring(fl_row,'tmp_id')
		ld_dt1 = dw_1.getitemdatetime(fl_row,'sd_date')
		if fs_type = 'D' then
			if ls_type1 = fs_type and ls_tpc_id1 = fs_tpc_id and ld_dt1 = fs_dt then
				dw_1.SelectRow(fl_row, TRUE)
				messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
				return -1
			end if
		else
			if ls_type1 = fs_type and ls_tpc_id1 = fs_tpc_id and ld_dt1 = fs_dt and ls_grade1 = fs_grade then
				dw_1.SelectRow(fl_row, TRUE)
				messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
				return -1
			end if		
		end if
	next 
end if 

return 1
end function

on w_gtedsf009.create
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtedsf009.destroy
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

this.tag = Message.StringParm
ll_user_level = long(this.tag)

dw_1.GetChild ("tmp_id", idw_grade)
idw_grade.settransobject(sqlca)	

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

type cb_5 from commandbutton within w_gtedsf009
integer x = 1079
integer y = 12
integer width = 329
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
string text = "&Make CSV"
end type

event clicked;string ls_said,ls_tmpid, ls_invoiceno,ls_custid, ls_date,ls_rec
double ld_qnty
integer li_filenum, li_rec, li_ctr
li_ctr=0;
setpointer(hourglass!) 

setnull(ls_said);setnull(ls_tmpid);setnull(ls_invoiceno);setnull(ls_custid);setnull(ls_date);
ld_qnty = 0; 
ChangeDirectory("c:\")
if DirectoryExists("temp") = false then
	CreateDirectory ("temp")
end if
	ChangeDirectory("temp")
if fileexists("c:\temp\samplesendtoho.csv") = true then
	filedelete("c:\temp\samplesendtoho.csv")
end if

li_filenum =  fileopen("c:\temp\samplesendtoho.csv",linemode!,write!,lockreadwrite!,replace!)

DECLARE c1 CURSOR FOR
select SD_ADVICEID, TMP_ID, DTP_LOTNO, SD_QNTY, SD_DATE, SD_CUSTID  
from fb_sample_dispatch where SD_TYPE = 'P' and nvl(SD_HOSENDIND,'N') = 'N';
 
 open c1;

 if sqlca.sqlcode = 0 then
	setnull(ls_said);setnull(ls_tmpid);setnull(ls_invoiceno);setnull(ls_custid);setnull(ls_date);
	ld_qnty = 0; 
	
   fetch c1 into :ls_said, :ls_tmpid, :ls_invoiceno, :ld_qnty, :ls_date, :ls_custid;

	do while sqlca.sqlcode <> 100
		
		
		if isnull(ls_said) then; ls_said=""; end if;
		if isnull(ls_tmpid) then; ls_tmpid=""; end if;
   		if isnull(ls_invoiceno) then; ls_invoiceno=""; end if;
		if isnull(ld_qnty) then; ld_qnty= 0; end if;
   		if isnull(ls_date) then; ls_date=""; end if;
   		if isnull(ls_custid) then; ls_custid=""; end if;			
				
		ls_rec = ls_said +"," + ls_tmpid + "," + ls_invoiceno + ","
		ls_rec = ls_rec + string(ld_qnty)+","
		if ls_date="" then  ls_rec = ls_rec + "," else	ls_rec = ls_rec+ls_date + ","
		ls_rec = ls_rec + ls_custid + "," + gs_unit
		
		filewrite(li_filenum,ls_rec)
	
//		messagebox('11',ls_said)

		update fb_sample_dispatch set SD_HOSENDIND = 'Y' where SD_ADVICEID = :ls_said and nvl(SD_HOSENDIND,'N') = 'N' ;
		
		 if sqlca.sqlcode = -1 then
			messagebox('Error: During Update Send Date',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
		
		li_rec++
		li_ctr++
		
	setnull(ls_said);setnull(ls_tmpid);setnull(ls_invoiceno);setnull(ls_custid);setnull(ls_date);
	ld_qnty = 0; 
	
  	fetch c1 into :ls_said, :ls_tmpid, :ls_invoiceno, :ld_qnty, :ls_date, :ls_custid;

   loop
	close c1;
else
	messagebox('Error: During Opening of Cursor',sqlca.sqlerrtext)
	return 1
end if

fileclose(li_filenum)

setpointer(arrow!) 
messagebox('Confirmation','Total No Of Records : '+string(li_ctr))
return 1
end event

type cb_4 from commandbutton within w_gtedsf009
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

type cb_3 from commandbutton within w_gtedsf009
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

IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'sd_type')) or len(dw_1.getitemstring(dw_1.rowcount(),'sd_type')) = 0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF
for ll_ctr = dw_1.rowcount() to 1 step -1
	if dw_1.getitemstring(ll_ctr,'del_flag') = 'Y' then
		dw_1.deleterow(ll_ctr)
	end if
next	

if dw_1.rowcount() > 0 then
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
end if

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN	
	if dw_1.rowcount() > 0 then		
		for ll_ctr = 1 to dw_1.rowcount( ) 
			ld_hrs = dw_1.getitemnumber(ll_ctr,'sd_runhrs')
			ld_min = dw_1.getitemnumber(ll_ctr,'sd_runmin')
			ld_hrs = ld_hrs + ld_min/60
			ld_frmhrs = dw_1.getitemnumber(ll_ctr,'sd_fermhrs')
			ld_frmmin = dw_1.getitemnumber(ll_ctr,'sd_fermmin')
			ld_frmhrs = ld_hrs + ld_min/60
			dw_1.setitem(ll_ctr,'sd_hrs',ld_hrs)
			dw_1.setitem(ll_ctr,'sd_frm_hrs',ld_frmhrs)
			ld_dt = dw_1.getitemdatetime(ll_ctr,'sd_date')
			ls_type = dw_1.getitemstring(ll_ctr,'sd_type')
			ls_tpc_id = dw_1.getitemstring(ll_ctr,'tpc_id')
			ls_grade = dw_1.getitemstring(ll_ctr,'tmp_id')
			if lb_neworder = true then
				if ls_type = 'D' then
					select distinct 'x' into :ls_temp from fb_sample_dispatch where trunc(sd_date) = trunc(:ld_dt) and sd_type = :ls_type and tpc_id = :ls_tpc_id;
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting Detail',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					elseif sqlca.sqlcode  = 0 then
						messagebox('Warning!','Record Already Exists, Please Check !!!')
						return 1
					end if		
				else
					select distinct 'x' into :ls_temp from fb_sample_dispatch where trunc(sd_date) = trunc(:ld_dt) and sd_type = :ls_type and tpc_id = :ls_tpc_id and tmp_id = :ls_grade;
					if sqlca.sqlcode = -1 then
						messagebox('Error : While Getting Detail',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1
					elseif sqlca.sqlcode  = 0 then
						messagebox('Warning!','Record Already Exists, Please Check !!!')
						return 1
					end if		
				end if
			end if
		next	
	end if

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

type cb_2 from commandbutton within w_gtedsf009
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
	if dw_1.modifiedcount() > 0  then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	lb_query = true
	lb_neworder = true
	dw_1.reset()
   	cb_3.enabled = false
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('sd_date')
	cb_2.text = "&Run"
	cb_3.enabled = false
	cb_1.enabled = false
else
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user)
 	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if
lb_neworder = false

end event

type cb_1 from commandbutton within w_gtedsf009
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
	dw_1.setitem(dw_1.getrow(),'sd_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'sd_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'sd_date',datetime(today()))
	dw_1.setcolumn('sd_date')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'sd_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'sd_entry_dt',datetime(today()))
	dw_1.setitem(dw_1.getrow(),'sd_date',datetime(today()))
	dw_1.setcolumn('sd_date')
end if


end event

type dw_1 from datawindow within w_gtedsf009
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_keydwn pbm_keydown
event ue_dwnkey pbm_dwnkey
integer x = 9
integer y = 116
integer width = 4137
integer height = 2052
integer taborder = 30
string dataobject = "dw_gtedsf009"
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
		dw_1.setitem(newrow,'sd_entry_by',gs_user)
		dw_1.setitem(newrow,'sd_entry_dt',datetime(today()))
		dw_1.setitem(newrow,'sd_date',dw_1.getitemdatetime(currentrow,'sd_date'))
		dw_1.setcolumn('sd_date')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

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

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(dw_1.rowcount())
	end if
	if dw_1.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event itemchanged;if lb_query = false then
	if dwo.name = 'sd_type' then
		
	end if
	
	if dwo.name = 'sd_date'  then
		ld_dt = datetime(data)
		
		if date(ld_dt) > today() then
			messagebox('Warning!','Date Should Not Be > Current Date, Please Check !!!')
			return 1
		end if
		
		if long(string(today(),'mm')) < 4 then
			ll_st_year  = ((long(string(today(),'YYYY'))-1)*100)+4;
			ll_end_year = (long(string(today(),'YYYY'))*100)+3;
		else
			ll_st_year  = (long(string(today(),'YYYY'))*100)+4;
			ll_end_year = ((long(string(today(),'YYYY'))+1)*100)+3;
		end if;
	
//		if (long(right(string(ld_dt,'dd/mm/yyyy'),4)) * 100 + long(mid(string(ld_dt,'dd/mm/yyyy'),4,2))) < ll_st_year or &
//			(long(right(string(ld_dt,'dd/mm/yyyy'),4)) * 100 + long(mid(string(ld_dt,'dd/mm/yyyy'),4,2)))  > ll_end_year then
//			messagebox('Warning!','Sample Drawing Date Should Be Between Current Financial Year, Please Check !!!')
//			return 1
//		end if
		
	end if
	
	if dwo.name = 'tpc_id' then
		ls_tpc_id = data
		ls_type = dw_1.getitemstring(row,'sd_type')
		ld_dt = dw_1.getitemdatetime(row,'sd_date')
		
		ix=idw_grade.SetFilter ("tpc_id = '"+ls_tpc_id+"'")
		idw_grade.settransobject(sqlca)	
		idw_grade.retrieve()		
		
		if ls_type = 'D' then
			if  wf_check_duplicate_rec(ld_dt,ls_type,ls_tpc_id,' ') = -1 then return 1
			select distinct 'x' into :ls_temp from fb_sample_dispatch where trunc(sd_date) = trunc(:ld_dt) and sd_type = :ls_type and tpc_id = :ls_tpc_id;
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Detail',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode  = 0 then
				messagebox('Warning!','Record Already Exists, Please Check !!!')
				return 1
			end if		
		end if
	end if
	
	if dwo.name = 'tmp_id' then
		ls_grade = data
		ls_tpc_id = dw_1.getitemstring(row,'tpc_id')
		ls_type = dw_1.getitemstring(row,'sd_type')
		ld_dt = dw_1.getitemdatetime(row,'sd_date')

		if ls_type <> 'D' then
			if  wf_check_duplicate_rec(ld_dt,ls_type,ls_tpc_id,ls_grade) = -1 then return 1
			
			select distinct 'x' into :ls_temp from fb_sample_dispatch where trunc(sd_date) = trunc(:ld_dt) and sd_type = :ls_type and tpc_id = :ls_tpc_id and tmp_id = :ls_grade;
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Detail',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode  = 0 then
				messagebox('Warning!','Record Already Exists, Please Check !!!')
				return 1
			end if		
		
		end if
	end if
	if dwo.name = 'dtp_lotno' then
		ls_inv_no = data
		ls_type = dw_1.getitemstring(row,'sd_type')
		if ls_type = 'P' then
			select distinct 'x' into :ls_temp from fb_dailyteapacked where trim(dtp_lotno) = :ls_inv_no;
			if sqlca.sqlcode = -1 then
				messagebox('Error : While Getting Detail',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode  = 100 then
				messagebox('Warning!','Invalid Invoice No., Please Check !!!')
				return 1
			end if		
		end if
	end if

	dw_1.setitem(row,'sd_entry_by',gs_user)
	dw_1.setitem(row,'sd_entry_dt',datetime(today()))
	cb_3.enabled = true
end if

if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if


end event

