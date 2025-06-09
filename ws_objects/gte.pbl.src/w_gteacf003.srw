$PBExportHeader$w_gteacf003.srw
forward
global type w_gteacf003 from window
end type
type ddlb_1 from dropdownlistbox within w_gteacf003
end type
type em_2 from editmask within w_gteacf003
end type
type st_1 from statictext within w_gteacf003
end type
type st_2 from statictext within w_gteacf003
end type
type cb_4 from commandbutton within w_gteacf003
end type
type cb_3 from commandbutton within w_gteacf003
end type
type cb_2 from commandbutton within w_gteacf003
end type
type cb_1 from commandbutton within w_gteacf003
end type
type dw_1 from datawindow within w_gteacf003
end type
end forward

global type w_gteacf003 from window
integer width = 4453
integer height = 2280
boolean titlebar = true
string title = "(w_gteacf003) Auto Process Master"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
ddlb_1 ddlb_1
em_2 em_2
st_1 st_1
st_2 st_2
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gteacf003 w_gteacf003

type variables
long ll_cnt,ll_last, ll_user_level
string ls_temp,ls_del_ind,ls_tmp_id, ls_acsubledger_nm,ls_type,ls_desc,ls_count,ls_edt,ls_gl,ls_process
boolean lb_neworder, lb_query
datawindowchild idw_dsgl,idw_csgl,idw_deacsubhead,idw_ceacsubhead
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fs_desc, string fs_desc2, string fs_type)
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
	if (isnull(dw_1.getitemstring(fl_row,'ac_process')) or  len(dw_1.getitemstring(fl_row,'ac_process'))=0 or &
	    isnull(dw_1.getitemstring(fl_row,'remark')) or  len(dw_1.getitemstring(fl_row,'remark'))=0 or &
		isnull(dw_1.getitemstring(fl_row,'ac_process_detail')) or  len(dw_1.getitemstring(fl_row,'ac_process_detail'))=0 )  then
	    messagebox('Warning: One Of The Following Fields Are Blank','Process,Remark,Process Detail, Please Check !!!')
		 return -1
	end if
	if ( ( isnull(dw_1.getitemstring(fl_row,'dr_acledger_id')) or  len(dw_1.getitemstring(fl_row,'dr_acledger_id'))=0 or &
		   isnull(dw_1.getitemstring(fl_row,'dr_acsubledger_id')) or  len(dw_1.getitemstring(fl_row,'dr_acsubledger_id'))=0 ) and &
	     ( isnull(dw_1.getitemstring(fl_row,'cr_acledger_id')) or  len(dw_1.getitemstring(fl_row,'cr_acledger_id'))=0 or &
		   isnull(dw_1.getitemstring(fl_row,'cr_acsubledger_id')) or  len(dw_1.getitemstring(fl_row,'cr_acsubledger_id'))=0) )  then
	    messagebox('Warning: One Of The Following Fields Are Blank','Dc/Cr Account Ledger and Sub Ledger, Please Check !!!')
		 return -1
	end if
	
end if
return 1

end function

public function integer wf_check_duplicate_rec (string fs_desc, string fs_desc2, string fs_type);long fl_row
string ls_desc1,ls_desc2,ls_type1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_desc1 = dw_1.getitemstring(fl_row,'dr_acsubledger_id')
		ls_desc2 = dw_1.getitemstring(fl_row,'cr_acsubledger_id')
		ls_type1 = dw_1.getitemstring(fl_row,'ac_process')
		
		if ls_desc1 = fs_desc and ls_desc2 = fs_desc2 and ls_type1 = fs_type then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gteacf003.create
this.ddlb_1=create ddlb_1
this.em_2=create em_2
this.st_1=create st_1
this.st_2=create st_2
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.ddlb_1,&
this.em_2,&
this.st_1,&
this.st_2,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gteacf003.destroy
destroy(this.ddlb_1)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.st_2)
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

dw_1.settransobject(sqlca)
lb_query = false	
lb_neworder = false

dw_1.GetChild ("dr_acsubledger_id", idw_dsgl)
idw_dsgl.settransobject(sqlca)	

dw_1.GetChild ("cr_acsubledger_id", idw_csgl)
idw_csgl.settransobject(sqlca)	

dw_1.GetChild ("dr_eacsubhead_id", idw_deacsubhead)
idw_deacsubhead.settransobject(sqlca)	

dw_1.GetChild ("cr_eacsubhead_id", idw_ceacsubhead)
idw_ceacsubhead.settransobject(sqlca)	


setpointer(hourglass!)
dw_1.settransobject(sqlca)
declare c1 cursor for
select distinct ac_process from fb_acautoprocess
order by 1 asc;
	
open c1;

IF sqlca.sqlcode = 0 THEN
	fetch c1 into :ls_process;
	
	do while sqlca.sqlcode <> 100
		ddlb_1.additem(string(ls_process))
		fetch c1 into :ls_process;
	loop
	close c1;
end if
setpointer(arrow!)

this.tag = Message.StringParm
ll_user_level = long(this.tag)

if ll_user_level = 3 then
	cb_3.visible = false
	cb_1.visible = false
	cb_3.enabled = false
	cb_1.enabled = false
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

type ddlb_1 from dropdownlistbox within w_gteacf003
integer x = 265
integer y = 12
integer width = 1056
integer height = 960
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean allowedit = true
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type em_2 from editmask within w_gteacf003
integer x = 1595
integer y = 16
integer width = 1737
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
maskdatatype maskdatatype = stringmask!
end type

type st_1 from statictext within w_gteacf003
integer x = 1344
integer y = 20
integer width = 256
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Remark : "
boolean focusrectangle = false
end type

type st_2 from statictext within w_gteacf003
integer x = 32
integer y = 24
integer width = 261
integer height = 64
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Process : "
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_gteacf003
integer x = 4137
integer y = 12
integer width = 265
integer height = 100
integer taborder = 60
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

type cb_3 from commandbutton within w_gteacf003
integer x = 3872
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
boolean enabled = false
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

IF (((isnull(dw_1.getitemstring(dw_1.rowcount(),'dr_acledger_id')) or len(dw_1.getitemstring(dw_1.rowcount(),'dr_acledger_id'))=0) and & 
      (isnull(dw_1.getitemstring(dw_1.rowcount(),'dr_acsubledger_id')) or len(dw_1.getitemstring(dw_1.rowcount(),'dr_acsubledger_id'))=0)) and &
	((isnull(dw_1.getitemstring(dw_1.rowcount(),'cr_acledger_id')) or len(dw_1.getitemstring(dw_1.rowcount(),'cr_acledger_id'))=0) and & 
      (isnull(dw_1.getitemstring(dw_1.rowcount(),'cr_acsubledger_id')) or len(dw_1.getitemstring(dw_1.rowcount(),'cr_acsubledger_id'))=0))) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
//	if dw_1.rowcount()>0 then 
//		if wf_check_fillcol(dw_1.getrow()) =-1 then return  1
//	end if	
	
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

type cb_2 from commandbutton within w_gteacf003
integer x = 3607
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
string text = "&Query"
end type

event clicked;
if trim(ddlb_1.text) = "" or isnull(ddlb_1.text) then 
	messagebox('Error At Document Type ','The Document Type Should Not Be Blank, Please Check...!')
	return 1
end if;
ls_process =ddlb_1.text

if cb_2.text = "&Query" then
	lb_neworder = true
	if dw_1.modifiedcount() > 0 then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	dw_1.reset()
	//dw_1.settaborder('cc_id',10)
	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('ac_process_detail')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user,ls_process)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gteacf003
integer x = 3342
integer y = 12
integer width = 265
integer height = 100
integer taborder = 30
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

//if isnull(em_1.text) or len(em_1.text) = 0 then
//	messagebox('Warning','Please Enter a Process !!!')
//	return 
//end if

if trim(ddlb_1.text) = "" or isnull(ddlb_1.text) then 
	messagebox('Error At Document Type ','The Document Type Should Not Be Blank, Please Check...!')
	return 1
end if;
ls_process =ddlb_1.text

if isnull(em_2.text) or len(em_2.text) = 0 then
	messagebox('Warning','Please Entry Process Remark !!!')
	return 
end if


if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'ac_process',ls_process)
	dw_1.setitem(dw_1.getrow(),'remark',em_2.text)
	dw_1.setitem(dw_1.getrow(),'entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'entry_dt',datetime(today()))
	dw_1.setcolumn('ac_process_detail')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'ac_process',ls_process)
	dw_1.setitem(dw_1.getrow(),'remark',em_2.text)
	dw_1.setitem(dw_1.getrow(),'entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'entry_dt',datetime(today()))
	dw_1.setcolumn('ac_process_detail')
end if


end event

type dw_1 from datawindow within w_gteacf003
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 23
integer y = 116
integer width = 4384
integer height = 2052
string dataobject = "dw_gteacf003"
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
		dw_1.setitem(newrow,'entry_by',gs_user)
		dw_1.setitem(newrow,'entry_dt',datetime(today()))
		dw_1.setcolumn('ac_process_detail')
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

	if dwo.name = 'ac_process_detail'   then
		ls_desc = data
		if isnull(ls_desc) or len(ls_desc)=0 then
			messagebox('Error:', 'Please enter Process Detail')
			rollback using sqlca;
			return 1
		end if	
	
		if f_check_initial_space(ls_desc) = -1 then return 1
	end if
	 
	setnull(ls_gl)
	
	if dwo.name = 'dr_acledger_id'   then		
		idw_dsgl.SetFilter ("trim(ACLEDGER_ID) = '"+trim(data)+"'") 
	     idw_dsgl.filter( )
		dw_1.setitem(dw_1.getrow(),'cr_acledger_id',ls_gl)
		dw_1.setitem(dw_1.getrow(),'cr_acsubledger_id',ls_gl)
		dw_1.setitem(dw_1.getrow(),'cr_eacsubhead_id',ls_gl)
	end if
	
	if dwo.name = 'cr_acledger_id'   then
		idw_csgl.SetFilter ("trim(ACLEDGER_ID) = '"+trim(data)+"'") 
	     idw_csgl.filter( )
		dw_1.setitem(dw_1.getrow(),'dr_acledger_id',ls_gl)
		dw_1.setitem(dw_1.getrow(),'dr_acsubledger_id',ls_gl)  
		dw_1.setitem(dw_1.getrow(),'dr_eacsubhead_id',ls_gl)
	end if
	
	if dwo.name = 'dr_acsubledger_id'   then
		idw_deacsubhead.SetFilter ("eachead_id = '"+trim(data)+"'") 
	     idw_deacsubhead.filter( )
	end if

	if dwo.name = 'cr_acsubledger_id'   then
		idw_ceacsubhead.SetFilter ("eachead_id = '"+trim(data)+"'") 
	     idw_ceacsubhead.filter( )
	end if
	
		
	dw_1.setitem(dw_1.getrow(),'ac_process',ls_process)
	dw_1.setitem(dw_1.getrow(),'remark',em_2.text)
	dw_1.setitem(row,'entry_by',gs_user)
	dw_1.setitem(row,'entry_dt',datetime(today()))
	
	if ll_user_level <> 3 then	
		cb_3.enabled = true
	else
		cb_3.enabled = false
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

SELECT COLUMN_ID,COLUMN_Name FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_acautoprocess');

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
												('fb_acautoprocess',:ls_unique_id,'U',:ls_columnname,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
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

