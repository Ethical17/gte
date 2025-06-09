$PBExportHeader$w_gtepfaccess.srw
forward
global type w_gtepfaccess from window
end type
type cb_4 from commandbutton within w_gtepfaccess
end type
type cb_3 from commandbutton within w_gtepfaccess
end type
type cb_2 from commandbutton within w_gtepfaccess
end type
type cb_1 from commandbutton within w_gtepfaccess
end type
type dw_1 from datawindow within w_gtepfaccess
end type
end forward

global type w_gtepfaccess from window
integer width = 2491
integer height = 2280
boolean titlebar = true
string title = "(w_gtepfacess) PF Acess Master"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
event ue_option ( )
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_gtepfaccess w_gtepfaccess

type variables
long ll_ctr, ll_cnt, ll_year, ll_last, ll_st_year, ll_end_year,ll_user_level,ll_temp
string ls_temp,ls_name,ls_last,ls_type,ls_tmp_id,ls_count
boolean lb_neworder, lb_query
string ls_user_id,ls_screen,ls_permission

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fd_user_id)
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
	if ( isnull(dw_1.getitemstring(fl_row,'pfa_permission'))) then
	    messagebox('Warning: One Of The Following Fields Are Blank', 'Screen And Permission,  Please Check !!!')
		 return -1
	end if
end if
return 1
end function

public function integer wf_check_duplicate_rec (string fd_user_id);long fl_row
string ls_userid, ls_screen_id

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_userid = dw_1.getitemstring(fl_row,'pfa_user_id')
		
		
		if ls_userid = fd_user_id  then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gtepfaccess.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_gtepfaccess.destroy
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

type cb_4 from commandbutton within w_gtepfaccess
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

type cb_3 from commandbutton within w_gtepfaccess
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

IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'pfa_user_id'))  ) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF




setnull(ls_user_id)
setnull(ls_screen)
setnull(ls_permission)
IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	if dw_1.rowcount() > 0 then
		IF wf_check_fillcol(ll_ctr) = -1 THEN 
			return 1
		end if
	end if

	if dw_1.rowcount() > 0 then
		for ll_ctr = 1 to dw_1.rowcount( ) 			
			ls_user_id = dw_1.getitemstring(ll_ctr,'pfa_user_id')			
			ls_permission = dw_1.getitemstring(ll_ctr,'pfa_permission')
			
			
			
			if lb_neworder=true then
				select distinct 'x' into :ls_temp from fb_pf_access  where pfa_user_id=:ls_user_id and nvl(pfa_active,'N')='Y';
			else
				select distinct 'x' into :ls_temp from fb_pf_access  where pfa_user_id=:ls_user_id and pfa_permission=:ls_permission ;
			end if
			if sqlca.sqlcode = -1 then
				messagebox('Error : While PF Access screen Detail',sqlca.sqlerrtext)
				rollback using sqlca;
				return 1
			elseif sqlca.sqlcode  = 0 then
				messagebox('Warning!','Record Already Present for user id '+ls_user_id+', Please Check !!!')
				return 1
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

type cb_2 from commandbutton within w_gtepfaccess
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
	dw_1.setcolumn('pfa_user_id')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query = false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gtepfaccess
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
	dw_1.setitem(dw_1.getrow(),'entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'entry_date',datetime(today()))
	dw_1.setcolumn('pfa_user_id')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'entry_date',datetime(today()))
	dw_1.setcolumn('pfa_user_id')
end if


end event

type dw_1 from datawindow within w_gtepfaccess
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 116
integer width = 2405
integer height = 2052
integer taborder = 30
string dataobject = "dw_gtepfacess"
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
		dw_1.setitem(newrow,'entry_date',datetime(today()))
		dw_1.setcolumn('pfa_user_id')
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
	if dwo.name = 'pfa_user_id'  then
		setnull(ls_user_id);	
		ls_user_id=data
		if  wf_check_duplicate_rec(ls_user_id) = -1 then return 1
		dw_1.insertrow(0)
	end if	
	dw_1.setitem(row,'entry_by',gs_user)
	dw_1.setitem(row,'entry_date',datetime(today()))
	
	cb_3.enabled = true
end if



end event

event updatestart;//
integer li_column, li_row // variables to hold the column index and row number
string ls_old_value, ls_new_value // variables to hold the old and new values
long ll_coumnid,ll_old_value,ll_new_value
string ls_columnname,ls_unique_id,ls_columntype
datetime ld_old_value,ld_new_value



// Loop through all rows in the DataWindow control
FOR li_row = 1 TO This.RowCount()


DECLARE c1 CURSOR FOR  

SELECT COLUMN_ID,COLUMN_Name,DATA_TYPE FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_pf_access');

close c1;
open c1;
if sqlca.sqlcode = -1 then
				messagebox('Error', 'Error occured while opening cursor c1 : '+sqlca.sqlerrtext)
				rollback using sqlca;
				return 1;
		
elseIF sqlca.sqlcode = 0 THEN
	setnull(ll_coumnid);setnull(ls_columnname);
	fetch c1 into :ll_coumnid,:ls_columnname,:ls_columntype;

		do while sqlca.sqlcode <> 100
			// Get the unique Value of Row
			 ls_unique_id=dw_1.GetItemString(li_row, 1, Primary!, true)
			 
			 
			if(ls_columntype='VARCHAR2') then 
 			// Get the old value for the data column
			       ls_old_value = dw_1.GetItemString(li_row, ll_coumnid, Primary!, true)
			// Get the new value for the data column
				  ls_new_value = This.GetItemString(li_row, ll_coumnid)
				  
				  if ls_old_value <> ls_new_value then
						insert into fb_log(table_name, Unique_key, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
												('fb_pf_access',:ls_unique_id,'U',:ls_columnname,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
							if sqlca.sqlcode = -1 then
								messagebox("SQL Error : While Inserting Into Log Table ",SQLCA.SQLErrtext,Information!)
								rollback using sqlca;
								return -1 
							 end if
					end if
				  
			elseif(ls_columntype='NUMBER') then
			// Get the old value for the data column
			       ll_old_value = dw_1.GetItemnumber(li_row, ll_coumnid, Primary!, true)
			// Get the new value for the data column
				  ll_new_value = This.GetItemnumber(li_row, ll_coumnid)
				  
				   if ll_old_value <> ll_new_value then
						insert into fb_log(table_name, Unique_key, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
												('fb_pf_access',:ls_unique_id,'U',:ls_columnname,:ll_old_value,:ll_new_value,:gs_user,sysdate,'');
							if sqlca.sqlcode = -1 then
								messagebox("SQL Error : While Inserting Into Log Table ",SQLCA.SQLErrtext,Information!)
								rollback using sqlca;
								return -1 
							 end if
					end if
				  
			elseif(ls_columntype='DATE') then
			 // Get the old value for the data column
			       ld_old_value = dw_1.GetItemdatetime(li_row, ll_coumnid, Primary!, true)
			// Get the new value for the data column
				  ld_new_value = This.GetItemdatetime(li_row, ll_coumnid)
				  
				   if ld_old_value <> ld_new_value then
						insert into fb_log(table_name, Unique_key, U_ACTION, U_FIELD, U_OLDVALUE, U_NEWVALUE, U_USERCODE, U_DATE, U_COMMENT) values
												('fb_pf_access',:ls_unique_id,'U',:ls_columnname,:ld_old_value,:ld_new_value,:gs_user,sysdate,'');
							if sqlca.sqlcode = -1 then
								messagebox("SQL Error : While Inserting Into Log Table ",SQLCA.SQLErrtext,Information!)
								rollback using sqlca;
								return -1 
							 end if
					end if
				  
				  
			end if
			
		setnull(ll_coumnid);setnull(ls_columnname);setnull(ls_columntype);

	fetch c1 into :ll_coumnid,:ls_columnname,:ls_columntype;
	loop
end if	
NEXT
close c1;
end event

