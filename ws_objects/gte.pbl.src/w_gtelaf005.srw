$PBExportHeader$w_gtelaf005.srw
forward
global type w_gtelaf005 from window
end type
type cb_4 from commandbutton within w_gtelaf005
end type
type cb_3 from commandbutton within w_gtelaf005
end type
type cb_2 from commandbutton within w_gtelaf005
end type
type cb_1 from commandbutton within w_gtelaf005
end type
type dw_1 from datawindow within w_gtelaf005
end type
end forward

global type w_gtelaf005 from window
integer width = 2254
integer height = 2040
boolean titlebar = true
string title = "(w_gtelaf005) Kerosin Issue"
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
global w_gtelaf005 w_gtelaf005

type variables
long ll_ctr, ll_cnt,ll_st_year,ll_end_year,ll_user_level,ll_yrmn
string ls_temp,ls_last,ls_count,ls_tmp_id,ls_pjat,ls_division,ls_emp,ls_section_id
datetime ld_date
double ld_qnty,ld_rate
boolean lb_neworder, lb_query
datawindowchild idw_emp
end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
public function integer wf_check_duplicate_rec (long fl_yrmn)
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
	if (	 isnull(dw_1.getitemnumber(fl_row,'ki_yearmonth')) or dw_1.getitemnumber(fl_row,'ki_yearmonth') = 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'ki_rate')) or dw_1.getitemnumber(fl_row,'ki_rate') = 0 or &
		 isnull(dw_1.getitemnumber(fl_row,'ki_quantity')) or dw_1.getitemnumber(fl_row,'ki_quantity') = 0) then
			messagebox('Warning: One Of The Following Fields Are Blank','Division, Employee ID, Date, Rate, Quantity, Please Check !!!')
			return -1
	end if
end if
return 1

end function

public function integer wf_check_duplicate_rec (long fl_yrmn);long fl_row, ll_yrmn1


dw_1.SelectRow(0, FALSE)
if dw_1.rowcount() > 1 then
	for fl_row = 1 to (dw_1.rowcount() - 1)
		ll_yrmn1  = dw_1.getitemnumber(fl_row,'ki_yearmonth')
			
		if ll_yrmn1 = fl_yrmn  then
			dw_1.SelectRow(fl_row, TRUE)
			messagebox("Error ","Duplicate Record At Row : "+string(fl_row))
			return -1
		end if
	next 
end if 

return 1



end function

on w_gtelaf005.create
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

on w_gtelaf005.destroy
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

dw_1.GetChild ("emp_id", idw_emp)
idw_emp.settransobject(sqlca)		
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

type cb_4 from commandbutton within w_gtelaf005
integer x = 809
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

type cb_3 from commandbutton within w_gtelaf005
integer x = 544
integer width = 265
integer height = 100
integer taborder = 60
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

IF (isnull(dw_1.getitemnumber(dw_1.rowcount(),'ki_yearmonth')) or len(string(dw_1.getitemnumber(dw_1.rowcount(),'ki_yearmonth'))) = 0) THEN
	 dw_1.deleterow(dw_1.rowcount())
END IF

IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN
	
	if dw_1.rowcount() > 0 then
		if wf_check_fillcol(dw_1.getrow()) = -1 then return 1
	end if

	
	for ll_ctr = dw_1.rowcount() to 1 step -1
		if dw_1.getitemstring(ll_ctr,'del_flag') = 'Y' then
			dw_1.deleterow(ll_ctr)
		end if
	next	
	
	
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

type cb_2 from commandbutton within w_gtelaf005
integer x = 279
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
	dw_1.setcolumn('ki_yearmonth')
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

type cb_1 from commandbutton within w_gtelaf005
integer x = 14
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

//if isnull(em_1.text) or len(em_1.text) = 0 or double(em_1.text) <= 0 then
//	messagebox('Warning!','Rate Should Be > 0, Please Check !!!')
//	return 1
//end if
//
//if isnull(em_2.text) or len(em_2.text) = 0 or double(em_2.text) <= 0 then
//	messagebox('Warning!','Quantity Should Be > 0, Please Check !!!')
//	return 1
//end if
//
//ld_rate = double(em_1.text)
//ld_qnty = double(em_2.text)
//
//dw_1.settransobject(sqlca)
//lb_neworder = true
//lb_query = false
//
//declare c1 cursor for 
//select FIELD_ID,EMP_ID from fb_employee a
//where nvl(EMP_KEROSININD,'N') = 'Y' and nvl(emp_inactivetype,'Regular') in ('Regular','Transfer') and nvl(EMP_ACTIVE,'1') = '1' and
//		 not exists(select * from FB_KEROSINISSUE where EMP_ID = a.EMP_ID and KI_DATE = sysdate);
//
//open c1;   
//
//if sqlca.sqlcode = -1 then 
//	messagebox('Sql Error : During Opening Cursor C1 : ',sqlca.sqlerrtext); 
//	rollback using sqlca; 
//	return 1; 
//else 
//	setnull(ls_division);setnull(ls_emp); 
//	fetch c1 into :ls_division,:ls_emp;
//	if sqlca.sqlcode = -1 then 
//		messagebox('Error','Error During Fetching Data'+sqlca.sqlerrtext);
//		return 1
//	end if;
//	do while sqlca.sqlcode <> 100     
//			dw_1.scrolltorow(dw_1.insertrow(0))
//			dw_1.setitem(dw_1.getrow(),'field_id',ls_division)
//			dw_1.setitem(dw_1.getrow(),'emp_id',ls_emp)
//			dw_1.setitem(dw_1.getrow(),'ki_date',datetime(today()))
//			dw_1.setitem(dw_1.getrow(),'ki_rate',ld_rate)
//			dw_1.setitem(dw_1.getrow(),'ki_quantity',ld_qnty)
//			dw_1.setitem(dw_1.getrow(),'ki_entry_by',gs_user)
//			dw_1.setitem(dw_1.getrow(),'ki_entry_dt',datetime(today()))
//
//	setnull(ls_division);setnull(ls_emp); 
//	fetch c1 into :ls_division,:ls_emp;
//		  
//  loop;
//close c1;  
//end if;	
//setpointer(arrow!)

dw_1.settransobject(sqlca)

if dw_1.rowcount() = 0 then
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'ki_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'ki_entry_dt',datetime(today()))
	dw_1.setcolumn('ki_yearmonth')
else
	IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
		return 1
	END IF
	dw_1.scrolltorow(dw_1.insertrow(0))
	dw_1.setfocus()
	dw_1.setitem(dw_1.getrow(),'ki_entry_by',gs_user)
	dw_1.setitem(dw_1.getrow(),'ki_entry_dt',datetime(today()))
	dw_1.setcolumn('ki_yearmonth')
end if


dw_1.setfocus()

lb_neworder = true
lb_query = false


end event

type dw_1 from datawindow within w_gtelaf005
event key_down pbm_dwnrowchanging
event keydwn pbm_dwnkey
event dwn_key pbm_keydown
event ue_tab_to_enter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_keydwn pbm_keydown
integer x = 9
integer y = 112
integer width = 2153
integer height = 1800
integer taborder = 50
string dataobject = "dw_gtelaf005"
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
		dw_1.setitem(newrow,'ki_entry_by',gs_user)
		dw_1.setitem(newrow,'ki_entry_dt',datetime(today()))
		dw_1.setcolumn('ki_yearmonth')
	end if
 end if
end if

end event

event ue_tab_to_enter;Send(Handle(this),256,9,Long(0,0))
return 1

end event

event itemchanged;if lb_query = false then
	
	if dwo.name = 'ki_yearmonth'  then		
		if  wf_check_duplicate_rec(long(data)) = -1 then return 1  
		
		ll_yrmn = long(data)
		
		if left(data,4) <> string(today(),'YYYY') then
			messagebox('warning!','Year Should be Current Year, Please Check !!!')
			return 1
		elseif long(right(data,2)) < 1 or long(right(data,2)) > 12 then
			messagebox('warning!','Month Should be Between (1 To 12), Please Check !!!')
			return 1			
		end if
		
		select distinct 'x' into :ls_temp from FB_KEROSINISSUE where ki_yearmonth = :ll_yrmn;
		
		if sqlca.sqlcode = -1 then
			messagebox('Error : While Getting Details',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		elseif sqlca.sqlcode = 0 then	
			messagebox('Warning: ','Record For This Year Month Already Exists, Please Check .....!')
			return 1
		end if				
	end if

//	if dwo.name = 'emp_id' then
//		ls_emp = data
//		ls_division = dw_1.getitemstring(row,'field_id')
//		ld_date = dw_1.getitemdatetime(row,'ki_date')
//		if  wf_check_duplicate_rec(ls_division,ls_emp,ld_date) = -1 then return 1  
//		
//		select distinct 'x' into :ls_temp from FB_KEROSINISSUE where field_id = :ls_division and emp_id = :ls_emp and trunc(ki_date) = trunc(:ld_date);
//		
//		if sqlca.sqlcode = -1 then
//			messagebox('Error : While Getting Employee Details',sqlca.sqlerrtext)
//			rollback using sqlca;
//			return 1
//		elseif sqlca.sqlcode = 0 then	
//			messagebox('Warning: ','Record For This Employee and Date Already Exists, Please Check .....!')
//			return 1
//		end if		
//	end if		

	dw_1.setitem(row,'ki_entry_by',gs_user)
	dw_1.setitem(row,'ki_entry_dt',datetime(today()))
	
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

SELECT COLUMN_ID,COLUMN_Name FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('FB_KEROSINISSUE');

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
												('FB_KEROSINISSUE',:ls_unique_id,'U',:ls_columnname,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
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

