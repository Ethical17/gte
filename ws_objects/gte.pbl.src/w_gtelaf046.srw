$PBExportHeader$w_gtelaf046.srw
forward
global type w_gtelaf046 from window
end type
type dw_1 from datawindow within w_gtelaf046
end type
type cb_4 from commandbutton within w_gtelaf046
end type
type cb_2 from commandbutton within w_gtelaf046
end type
type cb_3 from commandbutton within w_gtelaf046
end type
type cb_1 from commandbutton within w_gtelaf046
end type
end forward

global type w_gtelaf046 from window
integer width = 3986
integer height = 2448
boolean titlebar = true
string title = "(w_gtelaf046) Punching Master"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_option ( )
dw_1 dw_1
cb_4 cb_4
cb_2 cb_2
cb_3 cb_3
cb_1 cb_1
end type
global w_gtelaf046 w_gtelaf046

type variables
boolean lb_neworder,lb_query
date ld_frdt,ld_todt, ld_maxattdate
long ll_ctr,ls_noofpunching,ls_timegap
string ls_kamsub,ls_temp

end variables

forward prototypes
public function integer wf_check_fillcol (integer fl_row)
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
	if (dw_1.getitemnumber(fl_row,'pm_noofpunching') = 2) then
			if (isnull(dw_1.getitemnumber(fl_row,'pm_noofpunching')) or dw_1.getitemnumber(fl_row,'pm_noofpunching')=0 or &
				isnull(dw_1.getitemnumber(fl_row,'pm_timegap')) or dw_1.getitemnumber(fl_row,'pm_timegap')=0 or &
				isnull(dw_1.getitemstring(fl_row,'kamsub_id')) or len(dw_1.getitemstring(fl_row,'kamsub_id'))=0 or &
				isnull(dw_1.getitemdatetime(fl_row,'pm_frdt')))  then
				 messagebox('Warning: One Of The Following Fields Are Blank','From date, No. of punching, Kamajari,Timegap Please Check !!!')
				return -1
			end if
		return 1
	elseif (dw_1.getitemnumber(fl_row,'pm_noofpunching') = 3) then
			if (isnull(dw_1.getitemnumber(fl_row,'pm_noofpunching')) or dw_1.getitemnumber(fl_row,'pm_noofpunching')=0 or &
				isnull(dw_1.getitemnumber(fl_row,'pm_timegap')) or dw_1.getitemnumber(fl_row,'pm_timegap')=0 or &
				isnull(dw_1.getitemnumber(fl_row,'pm_timegap2')) or dw_1.getitemnumber(fl_row,'pm_timegap2')=0 or &
				isnull(dw_1.getitemstring(fl_row,'kamsub_id')) or len(dw_1.getitemstring(fl_row,'kamsub_id'))=0 or &
				isnull(dw_1.getitemdatetime(fl_row,'pm_frdt')))  then
				 messagebox('Warning: One Of The Following Fields Are Blank','From date, No. of punching, Kamajari,Timegap, Timegap 2 Please Check !!!')
				return -1
			end if
		return 1
	elseif  (dw_1.getitemnumber(fl_row,'pm_noofpunching') = 4) then
			if (isnull(dw_1.getitemnumber(fl_row,'pm_noofpunching')) or dw_1.getitemnumber(fl_row,'pm_noofpunching')=0 or &
				isnull(dw_1.getitemnumber(fl_row,'pm_timegap')) or dw_1.getitemnumber(fl_row,'pm_timegap')=0 or &
				isnull(dw_1.getitemnumber(fl_row,'pm_timegap2')) or dw_1.getitemnumber(fl_row,'pm_timegap2')=0 or &
				isnull(dw_1.getitemnumber(fl_row,'pm_timegap3')) or dw_1.getitemnumber(fl_row,'pm_timegap3')=0 or &
				isnull(dw_1.getitemstring(fl_row,'kamsub_id')) or len(dw_1.getitemstring(fl_row,'kamsub_id'))=0 or &
				isnull(dw_1.getitemdatetime(fl_row,'pm_frdt')))  then
				 messagebox('Warning: One Of The Following Fields Are Blank','From date, No. of punching, Kamajari,Timegap, Timegap 2, , Timegap 3 Please Check !!!')
				return -1
			end if
		return 1
	else 
			if (isnull(dw_1.getitemnumber(fl_row,'pm_noofpunching')) or dw_1.getitemnumber(fl_row,'pm_noofpunching')=0)  then
				 messagebox('Warning', 'No. Of Punching must be 2, 3 or 4. Please Check !!!')
				return -1
			end if
		return 1
	end if
end if
end function

on w_gtelaf046.create
this.dw_1=create dw_1
this.cb_4=create cb_4
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_4,&
this.cb_2,&
this.cb_3,&
this.cb_1}
end on

on w_gtelaf046.destroy
destroy(this.dw_1)
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_1)
end on

event open;dw_1.settransobject(sqlca)
lb_neworder = false
lb_query = false

if f_openwindow(dw_1) = -1 then
	close(this)
	return 1
end if

if GS_USER <> 'ADMIN' and GS_USER <> 'PARIDA' and GS_USER <> 'MANAGER' and GS_USER <> 'SUBHASIS' then
	cb_1.enabled = false
end if 

end event

type dw_1 from datawindow within w_gtelaf046
event type long ue_tab_to_enter ( )
event key_down pbm_dwnrowchanging
event ue_dwnkey pbm_dwnkey
event ue_keydown pbm_keydown
integer x = 23
integer y = 116
integer width = 3909
integer height = 2100
integer taborder = 30
string title = "none"
string dataobject = "dw_gtelaf046"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event type long ue_tab_to_enter();Send(Handle(this),256,9,Long(0,0))
return 1

end event

event key_down;if lb_query = false then
 if lb_neworder = true then	
	if currentrow <> dw_1.rowcount() then
		IF wf_check_fillcol(currentrow) = -1 THEN
			return 1
		END IF
	END If
	
	if newrow = dw_1.rowcount() and dw_1.rowcount() > 1  then
		dw_1.setitem( dw_1.getrow(), 'pm_entry_by', gs_user)
		dw_1.setitem( dw_1.getrow(), 'pm_entry_dt',datetime(today()))
		dw_1.setcolumn('pm_frdt')
	end if
 end if
end if

end event

event ue_dwnkey;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(dw_1.getrow())
	end if
	if dw_1.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event ue_keydown;if lb_neworder = true then
	IF KeyDown(KeyF6!) THEN
		dw_1.deleterow(dw_1.getrow())
	end if
	if dw_1.rowcount() = 0 then
		cb_3.enabled = false
	end if
end if

end event

event itemchanged;date ld_temp, ld_temp2
if lb_query = false then
	if dwo.name = 'pm_frdt' then
		select max(lma_date) into :ld_maxattdate from fb_mobile_attendance;
		if sqlca.sqlcode = -1 then
			messagebox('Error','Error occured while checking max attendance date')
			return 1;
		elseif sqlca.sqlcode = 100 then
			messagebox('Warning','No attendance found')
			return 1
		end if
		if date(data) <= ld_maxattdate then
			messagebox('Error', 'From date can not be less than max attendance date')
			return 1
		end if 
		ld_temp = date(data)
		select distinct 'x' into :ls_temp from fb_punchingmaster where :ld_temp between pm_frdt and pm_todt;
		if sqlca.sqlcode = -1 then
			messagebox('Error','Error occured while checking Punching master data');
			return 1;
		elseif sqlca.sqlcode = 0 then
			messagebox('Warning','From date cannot lie between from and to date of existing records ')
			return 1;
		end if
	end if
	
	if dwo.name = 'pm_noofpunching' then
		if integer(data) = 0 or isnull(data) then
			messagebox('Error','No. of punching should be equal to or greater than 1')
		end if
		ld_temp = date(dw_1.getitemdatetime(dw_1.getrow(),'pm_frdt'))
		select distinct 'x' into :ld_temp2 from fb_mobile_attendance where lma_date = :ld_temp ;
		if sqlca.sqlcode = 0 then
			messagebox('Error','Attendance exist for this date')
			return 1
		end if
	end if
	
	if dwo.name = 'pm_timegap' then
		ld_temp = date(dw_1.getitemdatetime(dw_1.getrow(),'pm_frdt'))
		select distinct 'x' into :ld_temp2 from fb_mobile_attendance where lma_date = :ld_temp ;
		if sqlca.sqlcode = 0 then
			messagebox('Error','Attendance exist for this date')
			return 1
		end if
	end if
end if 

if dw_1.getrow() = dw_1.rowcount() and lb_neworder =true then
	dw_1.insertrow(0)
end if

	
cb_3.enabled = true
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

SELECT COLUMN_ID,COLUMN_Name FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('fb_punchingmaster');

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
												('fb_punchingmaster',:ls_unique_id,'U',:ls_columnname,:ls_old_value,:ls_new_value,:gs_user,sysdate,'');
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

type cb_4 from commandbutton within w_gtelaf046
integer x = 827
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
end type

event clicked;if dw_1.modifiedcount() > 0  then
	IF MessageBox("Exit Alert", 'Do You Want To Exit....?' ,Exclamation!, YesNo!, 1) = 1 THEN
		close(parent)
	else
		return
	end if
else
	close(parent)
end if
end event

type cb_2 from commandbutton within w_gtelaf046
integer x = 283
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
string text = "&Query"
end type

event clicked;if cb_2.text = "&Query" then
	if dw_1.modifiedcount() > 0  then
		if (messagebox('Warning','Row Is Modified, Do You Want To Query?',question!,yesno!,1) = 2) then
			return 1
		end if
	end if
	lb_query  = true
	lb_neworder = true
	dw_1.reset()
	dw_1.modify("datawindow.queryclear = yes")
	dw_1.object.datawindow.querymode = 'yes'
	dw_1.setfocus( )
	dw_1.setcolumn('pm_frdt')
	cb_2.text = "&Run"
	cb_3.enabled = false
	cb_1.enabled = false
else 
	lb_query = false
	lb_neworder = false
 	dw_1.settransobject(sqlca)
	dw_1.setredraw(false)
	dw_1.Object.datawindow.querymode = 'no'
	dw_1.Retrieve()
	dw_1.TriggerEvent(rowfocuschanged!)
	dw_1.SetRedraw (TRUE)
	cb_2.text = "&Query"
	cb_1.enabled = true
	dw_1.settaborder('pm_todt',0)
	dw_1.settaborder('kamsub_id',0)
	dw_1.settaborder('pm_timegap',0)
	dw_1.settaborder('pm_timegap2',0)
	dw_1.settaborder('pm_timegap3',0)
	dw_1.settaborder('pm_noofpunching',0)
	dw_1.settaborder('pm_frdt',0)
	if GS_USER <> 'ADMIN' and GS_USER <> 'PARIDA' and GS_USER <> 'MANAGER' and GS_USER <> 'SUBHASIS' then
		cb_1.enabled = false
	end if 
end if
	 
end event

type cb_3 from commandbutton within w_gtelaf046
integer x = 553
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
string text = "&Save"
end type

event clicked;if dw_1.accepttext() = -1 then
	messagebox('Datawindow Error','Some Fields Are Blank. Please Check...!')
	return 
end if 

IF (isnull(dw_1.getitemdatetime(dw_1.rowcount(),'pm_frdt')) or isnull(dw_1.getitemnumber(dw_1.rowcount(),'pm_noofpunching')) or &
	dw_1.getitemnumber(dw_1.rowcount(),'pm_noofpunching') = 0) THEN
	dw_1.deleterow(dw_1.rowcount())
END IF

if dw_1.rowcount( ) > 0 then

	IF MessageBox("Save  Alert", 'Do You Want To Save ....?' ,Exclamation!, YesNo!, 1) = 1 THEN	
		if dw_1.rowcount() > 0 then
			IF wf_check_fillcol(dw_1.getrow()) = -1 THEN
				return 1
			END IF
		end if	 
		
		if lb_neworder = true then
			for ll_ctr = 1 to dw_1.rowcount( ) 
				ls_kamsub = dw_1.getitemstring(ll_ctr,'kamsub_id')
				ls_timegap = dw_1.getitemnumber(ll_ctr,'pm_timegap')
				ls_noofpunching = dw_1.getitemnumber(ll_ctr,'pm_noofpunching')
				ld_frdt = date(dw_1.getitemdatetime(ll_ctr,'pm_frdt'))
					
				select distinct 'x' into :ls_temp from fb_punchingmaster where kamsub_id = :ls_kamsub and pm_todt is null;
			
				if sqlca.sqlcode = -1 then
					messagebox('Error : While Getting Punching details Details',sqlca.sqlerrtext)
					rollback using sqlca;
					return 1
				elseif sqlca.sqlcode  = 0 then
//					dw_1.SelectRow(ll_ctr, TRUE)
//					messagebox("Warning!","Record Already Exists At Row "+string(ll_ctr)+", Please Check !!!")
//					return 1
//				else
					 update fb_punchingmaster set pm_todt = (:ld_frdt - 1) where kamsub_id = :ls_kamsub and pm_todt is null ;
	
					 if sqlca.sqlcode = -1 then
						messagebox('Error : While Updating Punching Records',sqlca.sqlerrtext)
						rollback using sqlca;
						return 1	
					end if	
				end if
			next	
		end if

		if dw_1.update( true,false) = 1 then
			dw_1.resetupdate( );
			commit using sqlca ;
			cb_3.enabled = false
			dw_1.reset( )
		else 
			messagebox('SQL Error : During Save',sqlca.sqlerrtext)
			rollback using sqlca;
			return 1
		end if
	else 
		return
	end if
end if

end event

type cb_1 from commandbutton within w_gtelaf046
integer x = 14
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
string text = "&New"
end type

event clicked;if lb_neworder = false then
	if dw_1.modifiedcount( ) > 0 then
		if messagebox("Confirmation","Row has been modified, Do you want to add new record..! ",question!,yesno!,1) = 2 then
			return
		end if
	end if
	dw_1.reset( )
end if 

dw_1.settransobject( sqlca)
lb_neworder = true
lb_query = false

if dw_1.rowcount( ) = 0 then
	dw_1.scrolltorow( dw_1.insertrow(0))
	dw_1.setfocus( )
	dw_1.setitem( dw_1.getrow(), 'pm_entry_by', gs_user)
	dw_1.setitem( dw_1.getrow(), 'pm_entry_dt',datetime(today()))
	dw_1.setcolumn('kamsub_id')
	dw_1.settaborder('kamsub_id',20)
	dw_1.settaborder('pm_timegap',40)
	dw_1.settaborder('pm_timegap2',50)
	dw_1.settaborder('pm_timegap3',60)
	dw_1.settaborder('pm_noofpunching',30)
	dw_1.settaborder('pm_frdt',10)
else
	return 1
//	if wf_check_fillcol(dw_1.getrow()) = -1 then
//		return 1
//	end if
//	dw_1.scrolltorow( dw_1.insertrow(0))
//	dw_1.setfocus( )
//	dw_1.setitem( dw_1.getrow(), 'pm_entry_by', gs_user)
//	dw_1.setitem( dw_1.getrow(), 'pm_entry_date',datetime(today()))
//	dw_1.setcolumn('pm_frdt')
end if 
	
end event

