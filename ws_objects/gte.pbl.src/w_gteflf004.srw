$PBExportHeader$w_gteflf004.srw
forward
global type w_gteflf004 from window
end type
type cb_4 from commandbutton within w_gteflf004
end type
type cb_3 from commandbutton within w_gteflf004
end type
type cb_2 from commandbutton within w_gteflf004
end type
type cb_1 from commandbutton within w_gteflf004
end type
type dw_1 from datawindow within w_gteflf004
end type
end forward

global type w_gteflf004 from window
integer width = 3538
integer height = 4456
boolean titlebar = true
string title = "(w_gteflf004) Nursery Detail"
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
global w_gteflf004 w_gteflf004

type variables
long ll_ctr, ll_cnt,ll_user_level
string ls_temp,ls_del_ind,ls_tmp_id,ls_location_id, ls_last, ls_count, ls_nursery_ty
boolean lb_neworder, lb_query

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (string fl_location_id, string fl_nursery_ty)
end prototypes

event ue_option();choose case gs_ueoption
	case "PRINT"
			OpenWithParm(w_print,this.dw_1)
	case "PRINTPREVIEW"
			this.dw_1.modify("datawindow.print.preview = yes")
	case "RESETPREVIEW"
			this.dw_1.modify("datawindow.print.preview = no")
	case "SAVEAS"
			this.dw_1.saveas()
	case "ZOOM"
			SetPointer (HourGlass!)											
			OpenwithParm (w_zoom,dw_1)
			SetPointer (Arrow!)						
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
	if (isnull(dw_1.getitemstring(fl_row,'location_id')) or  len(dw_1.getitemstring(fl_row,'location_id'))=0 or &
		 isnull(dw_1.getitemstring(fl_row,'nursery_type')) or  len(dw_1.getitemstring(fl_row,'nursery_type'))=0 or &
		 isnull(dw_1.getitemnumber(fl_row,'nursery_totplants')) or  dw_1.getitemnumber(fl_row,'nursery_totplants')=0 or &
		 isnull(dw_1.getitemdatetime(fl_row,'nursery_startdate'))) then
	    messagebox('Warning: One Of The Following Fields Are Blank','Location ID, Nursery Type, Start Date, Nursery Capacity, Please Check !!!')
		 return -1
	end if
end if
return 1

end function

public function integer wf_check_duplicate_rec (string fl_location_id, string fl_nursery_ty);long fl_row
string ls_location_id1,ls_nursery_ty1

dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ls_location_id1 = dw_1.getitemstring(fl_row,'location_id')
		ls_nursery_ty1 = dw_1.getitemstring(fl_row,'nursery_type')
		
		if ls_location_id1 = fl_location_id and ls_nursery_ty1 = fl_nursery_ty then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1
end function

on w_gteflf004.create
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

on w_gteflf004.destroy
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

type cb_4 from commandbutton within w_gteflf004
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

type cb_3 from commandbutton within w_gteflf004
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

IF (isnull(dw_1.getitemstring(dw_1.rowcount(),'location_id')) or len(dw_1.getitemstring(dw_1.rowcount(),'location_id'))=0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN

	if lb_neworder = true then
		select nvl(MAX(NURSERY_ID),0) into :ls_last from fb_locationnursery;
		ls_last = right(ls_last,5)
		ll_cnt = long(ls_last)
	end if

	
	if dw_1.rowcount() > 0 then
		for ll_ctr = 1 to dw_1.rowcount( ) 
			if lb_neworder = true then
				ll_cnt = ll_cnt + 1
				select lpad(:ll_cnt,5,'0') into :ls_count from dual;
				ls_tmp_id = 'NURS'+ls_count
				dw_1.setitem(ll_ctr,'nursery_id',ls_tmp_id)
			
		
				ls_location_id = dw_1.getitemstring(ll_ctr,'location_id')
				ls_nursery_ty = dw_1.getitemstring(ll_ctr,'nursery_type')
				
				select distinct 'x' into :ls_temp from fb_locationnursery 
				where upper(trim(location_id)) = upper(trim(:ls_location_id)) and upper(trim(nursery_type)) = upper(trim(:ls_nursery_ty));
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Nursery Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode  = 0 then
					messagebox('Warning!','Nursery ID Already Exists, Please Check !!!')
					return 1
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

type cb_2 from commandbutton within w_gteflf004
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
	dw_1.settaborder('nursery_id',5)
	lb_query = true
	dw_1.modify("datawindow.queryclear= yes")
	dw_1.Object.datawindow.querymode= 'yes'
	dw_1.SetFocus ()
	dw_1.setcolumn('nursery_id')
	cb_2.text = "&Run"
	cb_1.enabled = false
	cb_3.enabled = false
else
	lb_neworder =false
	lb_query =false
 	dw_1.settransobject(sqlca)
	dw_1.SetRedraw (FALSE)
	dw_1.settaborder('nursery_id',0)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve(gs_user)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
end if

end event

type cb_1 from commandbutton within w_gteflf004
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
	dw_1.setitem(dw_1.getrow(),'nursery_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'nursery_entry_dt',datetime(today()))
	dw_1.setcolumn('location_id')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'nursery_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'nursery_entry_dt',datetime(today()))
	dw_1.setcolumn('location_id')
end if


end event

type dw_1 from datawindow within w_gteflf004
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 116
integer width = 3456
integer height = 2052
integer taborder = 30
string dataobject = "dw_gteflf004"
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
		dw_1.setitem(newrow,'nursery_entry_by',gs_user)
		dw_1.setitem(newrow,'nursery_entry_dt',datetime(today()))
		dw_1.setcolumn('location_id')
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
	if dwo.name = 'nursery_type'  then
		ls_nursery_ty = data
		ls_location_id = dw_1.getitemstring(row,'location_id')
		
		if f_check_initial_space(ls_nursery_ty) = -1 then return 1
		
		if f_check_string_sp(ls_nursery_ty) = -1 then return 1
		
		if  wf_check_duplicate_rec(ls_location_id, ls_nursery_ty) = -1 then return 1
		
		select distinct 'x' into :ls_temp from fb_locationnursery 
		where upper(trim(location_id)) = upper(trim(:ls_location_id)) and upper(trim(nursery_type)) = upper(trim(:ls_nursery_ty));
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Nursery Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode  = 0 then
			messagebox('Warning!','Nursery ID Already Exists, Please Check !!!')
			return 1
		end if
	end if
dw_1.setitem(row,'nursery_entry_by',gs_user)
dw_1.setitem(row,'nursery_entry_dt',datetime(today()))

cb_3.enabled = true
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

SELECT COLUMN_ID,COLUMN_Name FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_locationnursery');

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
												('fb_locationnursery',:ls_unique_id,'U',:ls_columnname,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
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

