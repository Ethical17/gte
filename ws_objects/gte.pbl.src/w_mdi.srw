$PBExportHeader$w_mdi.srw
forward
global type w_mdi from window
end type
type mdi_1 from mdiclient within w_mdi
end type
type mditbb_1 from tabbedbar within w_mdi
end type
end forward

global type w_mdi from window
integer width = 3803
integer height = 2860
boolean titlebar = true
string title = "Luxmi Tea"
string menuname = "m_main"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
long backcolor = 12639424
string icon = "New Icon.ico"
boolean toolbarvisible = false
boolean center = true
boolean tabbedview = true
mdi_1 mdi_1
mditbb_1 mditbb_1
end type
global w_mdi w_mdi

type variables
DataStore gds_userwisemenu_list

string ls_type
end variables

forward prototypes
public function integer of_get_menuobject (menu am_main, string as_screen)
end prototypes

public function integer of_get_menuobject (menu am_main, string as_screen);Long ll_cnt, ll_rtn, ll_found_row, ll_permi
String ls_findstr, ls_active
Boolean lbl_menu_active

For ll_cnt = 1 to UpperBound(am_main.item[])
	ll_permi=0;setnull(ls_FindStr);ll_found_row=0
	If am_main.Item[ll_cnt].typeof() = menu!Then
		ll_rtn = of_get_menuobject(am_main.Item[ll_cnt],as_screen)
		If ll_rtn > 0 Then 
			If IsNull( am_main.Item[ll_cnt].Text ) or Len(Trim(am_main.Item[ll_cnt].Text)) < 1 Then Continue
			
			ls_FindStr = "ld_screen = '" + am_main.Item[ll_cnt].ClassName() + "'"
			
			ll_found_row = gds_userwisemenu_list.Find(ls_Findstr, 1, gds_userwisemenu_list.RowCount() )
			If ll_found_row < 1 Then
				Continue
			End If

			lbl_menu_active = False
			
			ll_permi = gds_userwisemenu_list.GetItemnumber(ll_found_row, "ld_permission")

			If ll_permi > 0 Then lbl_menu_active = True
			
			am_main.Item[ll_cnt].tag = string(ll_permi)
			am_main.Item[ll_cnt].visible = lbl_menu_active

			w_mdi.setmicrohelp('as_screen'+as_screen+ 'Current Screen : ' + am_main.Item[ll_cnt].ClassName())
			if am_main.Item[ll_cnt].ClassName() = as_screen then
				am_main.Item[ll_cnt].postevent(clicked!)
			end if
		End if
	End If		
Next

return 1
end function

on w_mdi.create
if this.MenuName = "m_main" then this.MenuID = create m_main
this.mdi_1=create mdi_1
this.mditbb_1=create mditbb_1
this.Control[]={this.mdi_1,&
this.mditbb_1}
end on

on w_mdi.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.mditbb_1)
end on

event close; if f_acess_log(GS_USER,'GTE','LOGOFF') = -1 then
	return 1
 end if
 close (w_login)

end event

event open;
w_mdi.title = 'Welcome '+ GS_USER+space(50-len(gs_user))+' '+'Garden Tea Estate ['+gs_garden_nameadd+']'

long ll_ds_rowcnt,ll_cnt_menu,ll_rtn 
string ls_temp,ls_findstr

	gds_userwisemenu_list = Create DataStore
	gds_userwisemenu_list.DataObject = "dw_menu_writes_detail"
	
	gds_userwisemenu_list.settransobject(sqlca)
	
	if gs_option = 'HO'  then
		ll_ds_rowcnt = gds_userwisemenu_list.Retrieve('PIYUSH')
	else
		ll_ds_rowcnt = gds_userwisemenu_list.Retrieve(GS_USER)
	end if
	
	If ll_ds_rowcnt < 1 Then Halt
	
	ll_cnt_menu = UpperBound(This.MenuId.item[]) 
	
	If ll_cnt_menu < 1 Then Halt
	
	
	select user_exception into :ls_type from fb_login where upper(USER_ID) = upper(:gs_user);
	if sqlca.sqlcode= -1 then
			messagebox('Error', 'Error occured while Checking user_exception: '+sqlca.sqlerrtext)
			return 1
	end if
	
	if(ls_type='Y') then
		opensheetwithparm(w_gtelar083,this.tag,w_mdi,0,layered!)
	end if
	
	

		ll_rtn = of_get_menuobject( This.MenuId,'ALL') 

this.setmicrohelp('Ready...!')
end event

event key;IF KeyDown(KeyEscape!) THEN
	close(w_mdi)
end if
end event

type mdi_1 from mdiclient within w_mdi
long BackColor=268435456
end type

type mditbb_1 from tabbedbar within w_mdi
int X=0
int Y=0
int Width=0
int Height=104
end type

