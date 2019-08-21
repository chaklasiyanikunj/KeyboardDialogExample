sub init()

    m.DeviceInfo = CreateObject("roDeviceInfo")
    m.time = CreateObject("roList")
    m.taskRegistryNode = m.top.findNode("taskRegistry")
    m.Dialog = m.top.findnode("Dialog")
    m.displaySize = m.DeviceInfo.GetUIResolution()
    'm.top.GlobleEPGURL = createobject("roString")
    m.ChannelPosterGrid = m.top.FindNode("ChannelPosterGrid")
    
'    m.top.SCREEN_WIDTH = m.displaySize.width 
'    m.top.SCREEN_HEIGHT = m.displaySize.height
'    m.top.displayType = m.displaySize.name
'    m.top.isFHD = (m.top.displayType = "FHD") 
'    m.top.isHD  = (m.top.displayType = "HD")
'    m.top.isSD  = (m.top.displayType = "SD")
        
    ?"m.displaySize.name = "m.displaySize.name

  'm.top.color = &H170115FF '&HFFA500FF

if m.displaySize.name = "SD" then
  m.top.backgroundURI = "pkg:/images/bkg_sd.png"
else if m.displaySize.name = "HD" then
  m.top.backgroundURI = "pkg:/images/bkg_hd.png"
else
  m.top.backgroundURI = "pkg:/images/bkg_fhd.png"
end if

    ?"m.top.backgroundURI = " m.top.backgroundURI

'  m.top.backgroundColor=&H170115FF
'  m.top.backgroundURI = ""

  m.panelset = createObject("roSGNode", "PanelSet")
  port = CreateObject("roMessagePort")
'  screen = CreateObject("roVideoScreen")
'  msg = wait(0, m.port)
  'm.panelset.Color = &H170115FF
  'm.panelset.backgroundColor=&HEB1010FF
    
 
    m.keypanel = m.panelset.createChild("KeyboardDialogExample")
     

     m.keypanel.setFocus(true)
'    m.keypanel.setFocus(true) 'here the focus the Login Scree
    
'    m.keypanel.valueforuri = "www.google.com"
    
    
    'Here Show the Date in Console
    date = CreateObject("roDateTime")
'    ? formatDateTime(dtNext)
    print "The date is now :*************************  :"; date.AsDateString("short-month-no-weekday")
    LocalZone = date.ToLocalTime()
    hh = date.GetHours()
    mm = date.GetMinutes()
'    ss = date.GetSeconds()

    'Print Current Time
    print "Current time Display : " hh ":" mm 
    
'    print LocalZone
'    dt = date.ToLocalTime()
 '   formatTimeLeft (secondsLeft)
'  
'    dt = date.ToLocalTime()
'    print dt

    m.top.appendChild(m.panelset)
  
  m.top.videoPlayer = m.top.createChild("VideoComp")
'  player=CreateObject("roVideoPlayer")
  m.top.videoPlayer.id = "videoPlayer"
  m.video = m.top.videoPlayer.findNode("liveVideo")
  
  if m.displaySize.name = "SD"
        m.top.videoPlayer.Resolution = 0
        m.top.videoPlayer.width = 720
        m.top.videoPlayer.height = 480
  else if m.displaySize.name = "HD"
        m.top.videoPlayer.Resolution = 1
        m.top.videoPlayer.width = 1280
        m.top.videoPlayer.height = 720
  else 'if m.displaySize.name = "FHD"
        m.top.videoPlayer.Resolution = 2
        m.top.videoPlayer.width = 1920
        m.top.videoPlayer.height = 1080
  end if

'  ? "channel-list::init() = " m.top.Resolution
'  OnResolutionChange()
'    if m.top.GlobleURL = serverurl then
    
        'Here the condition apply to serverURL wrong than print msg
'        if m.top.GlobleURL = m.top.GlobleURL then
        
              m.top.GlobleURL = GetAuthData()
              
'        else 
              
'        end if
        
'    else
'        print "Server URL should be Wrong"
'    end if
'   if not m.top.GlobleURL = "" then
'        m.top.GlobleURL = GetAuthData()
'   else 
'        m.top.GlobleURL = ""
'   end if
  m.readVideoContentTask = createObject("roSGNode", "XmlReader")
'   m.top.GlobleURL = ""
   print "*********Set URL : " + m.top.GlobleURL
 'm.readVideoContentTask.contenturi = "https://www.xul.fr/rss.xml"
  m.readVideoContentTask.contenturi = "http://" + m.top.GlobleURL + "?file=WiseRoku.xml"
  
  m.readVideoContentTask.observeField("content", "setpanels") '"showvideolist")
  'm.readVideoContentTask.contenturi = "http://www.sdktestinglab.com/Tutorial/content/rendergridps.xml"

  'm.top.GlobleURL = ""
  
  m.readVideoContentTask.control = "RUN" 
 
 print "ExitApp"
 
 
end sub


sub setpanels()
  
  m.listpanel = m.panelset.createChild("ChannelListPanel")
  
  ?"setpanels() - m.top.Resolution = " m.top.videoPlayer.Resolution
  m.listpanel.Resolution = m.top.videoPlayer.Resolution  
  
  m.listpanel.list.color = "0xF4A42C"
  m.listpanel.list.sectionDividerTextColor = "0xC36419"
  m.listpanel.list.focusedColor = "0xC36419"
  m.listpanel.list.backgroundColor = "0xF4A42C"
  
  m.listpanel.list.content = m.readVideoContentTask.content
  
  m.listpanel.list.observeField("itemFocused", "setvideo")
' m.listpanel.list.observeField("itemSelected", "playvideo")   
  m.gridpanel = m.panelset.createChild("ChannelPosterGridComponent")  
  m.gridpanel.Resolution = m.top.videoPlayer.Resolution
 

    
'm.gridpanel.backgroundColor=&HEB1010FF
' m.listpanel.setFocus(true)
   
end sub



sub setvideo()
'In future please replace with channel category [[
      videocontent = m.listpanel.list.content.getChild(m.listpanel.list.itemFocused)
      
'      m.video.content = videocontent
'      
 
'      if m.panelset.isGoingBack and m.gridpanel.grid.hasFocus() = false
'        ? "I am in isGoingBack in setvideo()"
'        m.panelset.appendChild(m.gridpanel)
'      else
'        m.panelset.removeChild(m.gridpanel)
'        m.gridpanel = m.panelset.createChild("ChannelPosterGridComponent")
'     end if
        
        
  '      ? videocontent.url
        
      'm.gridpanel = m.panelset.createChild("ChannelPosterGridComponent")         
     ' m.gridpanel = m.panelset.createChild("ChannelPosterGridComponent")
      'm.gridpanel.gridcontenturi = "pkg:/xml/AllChannel.xml"'m.readVideoContentTask.contenturi
   '   m.gridpanel.gridcontenturl = "http://api.delvenetworks.com/rest/organizations/59021fabe3b645968e382ac726cd6c7b/channels/1cfd09ab38e54f48be8498e0259f5c83/media.rss"
'      m.gridpanel.gridlink = "http://api.delvenetworks.com/rest/organizations/59021fabe3b645968e382ac726cd6c7b/channels/1cfd09ab38e54f48be8498e0259f5c83/media.rss "
      m.gridpanel.gridcontenturi = videocontent.url
      
      m.gridpanel.grid.observeField("itemFocused", "grid_setvideo")
      m.gridpanel.grid.observeField("itemSelected", "grid_playvideo")
      
     ' m.gridpanel.grid.observeField("focusedChild", "slidepanels")
      
end sub



Sub OnChangeOptionsContent()
    m.gridpanel.grid.content = m.top.OptionsContent
    m.listpanel.list.content = m.top.OptionsContent
End Sub



sub grid_setvideo()

  videocontent = m.gridpanel.grid.content.getChild(m.gridpanel.grid.itemFocused)
 
  'm.videoposter.uri = videocontent.hdposterurl
  'm.videoinfo.text = videocontent.description
  
'  m.video.content = videocontent
  'm.videoplayer.video = videocontent
  
   ? "Video URL = " videocontent.url
    
    m.global.id = videocontent.SubtitleUrl
    
'    m.global.title = videocontent.title
    
    ?"EPG URL GLobal Display here : " m.global.id
    
'    ?"EPG Global Title : " m.global.title
    
'     m.top.GlobleEPGURL = onEPGSet(epgurl)
    '   ? "Subtitle  URL : " videocontent.SubtitleUrl
    m.top.videoPlayer.Video.content = videocontent
'    m.topvideoPlayer.focusBitmapUri = "pkg:/images/imagegrid.png"
'    m.top.videoPlayer.Video.width = 580
'    m.top.videoPlayer.Video.height = 480
'    m.top.videoPlayer.Video.translation = "[150,550]"
'    if  m.gridpanel.grid.content.setFocus = true then
'        videocontent = m.gridpanel.grid.content.getChild(m.gridpanel.grid.itemFocused)
'        m.top.videoPlayer.Video.content = videocontent
'        m.gridpanel.gridcontenturi = videocontent.url
'        if m.gridpanel.gridcontenturi = false 
         
 '           m.top.videoPlayer.Video.width = 250
 '           m.top.videoPlayer.Video.height = 250
            
            'Belove only one comment remove and display above image
'            m.top.videoPlayer.Video.translation = "[783,250]"   ' PBS Channel display
'            m.top.videoPlayer.Video.translation = "[1052,250]"  ' ABC Channel display
'            m.top.videoPlayer.Video.translation = "[1320,250]"  ' KPHO Channel display
'            m.top.videoPlayer.Video.translation = "[1587,250]"  ' KPNX Channel display
'            m.top.videoPlayer.Video.translation = "[783,509]"
 
'            m.readVideoContentTask.hdposterurl = false
            
            ? "video set in on the image"
'            m.examplerectangle.translation = rectconfig.translation
'            m.top.videoPlayer.Video.videocontent = m.gridpanel.grid.hdposterurl
'            m.readVideoContentTask.hdposterurl = m.gridpanel.grid.content

            m.top.videoPlayer.Video.videocontent = m.gridpanel.grid.setFocus
            

end sub'Function getsubstr(ss As String) As Object'sss = CreateObject("roObject")
'sss =  ss.Split(":")'return sss'        'end function

'Function onEPGSet(epgurl As String) As Dynamic
'    
'    m.top.GlobleEPGURL = epgurl
' ?"EPG URL ====== :" m.top.GlobleEPGURL
' 
'End Function

sub showEPGList()
  
'  ? "showEPGlist() " m.readEPGlist.content.title " & " m.readEPGlist.content.Description
'  m.EPGpanel.list.content = m.readEPGlist.content
  
'  m.readEPGlist.content.title = "Hello"
 ' m.readEPGlist.content.Description = "Welcome"
  
'  m.EPGpanel.list.content = contentItem

end sub

sub grid_playvideo()
   
'   ? "grid_playvideo()"

'   
'      m.video.visible = true
'      m.video.setFocus(true) 
'      
''      sleep(2000)
'     m.video.enableUI = true
'     m.video.isFullScreen = false
'     m.video.translation = [ 100, 100]
'     
'    ? " video left = " m.video.leftPosition
'    ? " video tranlation = " m.video.translation
'    ? " video width = " m.video.width
'    ? " video height = " m.video.height
'    ? " video fullscreen = " m.video.isFullScreen
'      
'      m.video.control = "play"
'      
''      m.videoLabel.visible = true
'
'      m.listpanel.visible = false
'      m.gridpanel.visible = false
''      m.EPGpanel.visible = false
'      
'      m.testLabel.visible = false
'      

      'for getting video to be viewed else only sound will be played
m.top.setFocus(false)
'      m.top.visible = false
m.panelset.setFocus(false)
      
      'm.videoplayer = createObject("roSGNode", "WiseVideo")
    
    'video = m.top.videoPlayer.findNode("liveVideo")  
m.video.visible = true
m.video.control = "play"
    
m.top.videoPlayer.visible = true
m.top.videoPlayer.setFocus(true)          
      
'      m.videoplayer.setFocus(true)

      'for getting onkeyevent we need this to be activated
'      m.gridpanel.setFocus(false)
'      m.top.setFocus(true)
      
'      m.epgLabel.visible = true

end sub

sub OnResolutionChange()

? "channel-list::m.top.Resolution = " m.top.Resolution
  if m.top.Resolution = 0 then
     m.top.grid.backgroundColor = "008000"
     m.top.grid.basePosterSize = [ 120, 120 ]
  else if m.top.Resolution = 1 then
     m.top.grid.backgroundColor = "008000"
     m.top.grid.basePosterSize = [ 160, 160 ]
  else
     m.top.grid.backgroundColor = "008000"
     m.top.grid.basePosterSize = [ 248, 248 ]
  end if
end sub 


'sub Keyopen()
'
'             screen = CreateObject("roSGScreen")
'                    scr = CreateObject("roKeyboardScreen")   'Create object for roKeyboardScreen
'                    port = CreateObject("roMessagePort")
'                    scr.SetMessagePort(port)
'                    scr.SetTitle("Search URL")   'Set the Title on the Particular Screen
'                    scr.SetText("192.168.1.37:8686")  'Set text on the textbox
'                    scr.SetDisplayText("Enter Text to URL") ' Display text on the belove textbox
'                    scr.SetMaxLength(15) ' Set MAximum length on the enter the maximum letter on the textbox
'                    scr.AddButton(1,"Finished") 'Add button name as finished
'                    scr.AddButton(2,"Back") 'Add button name as Back
'                    scr.show()
'      
'                    port = CreateObject("roMessagePort")
'                    screen.SetMessagePort(port)
'                    screen.SetTitle("Search Screen")
'                    screen.SetText("192.168.1.37:8686")
'                    screen.SetDisplayText("enter text to search")
'                    screen.SetMaxLength(8)
'                    screen.AddButton(1, "finished")
'                    screen.AddButton(2, "back")
'                    screen.Show()
'                    while true
'                        msg = wait(0, scr.GetMessagePort())
'                        print "message received"
'                        if type(msg) = "roKeyboardScreenEvent"
'                            if msg.isScreenClosed()
'                                return
'                            else if msg.isButtonPressed() then
'                                print "Evt:"; msg.GetMessage ();" idx:"; msg.GetIndex()
'                                if msg.GetIndex() = 1
'                                    searchText = scr.GetText()
'                                    print "search text: "; searchText
'                                    return
'                                endif
'                            endif
'                        endif
'                    end while
'                    m.dialog.visible = false 
'                    m.dialog.setFocus(false)
'                    m.top.videoplayer.setfocus = true
'                    m.gridpanel.grid.content.setFocus = true
'                    m.listpanel.list.content.setFocus = true
'                    m.focusedNode.SetFocus(true)
'                    result = true
'                    return true
'
'End sub

'     'These Function is display the url with okay and cancle button add

'function ShowKeyboardScreen(prompt = "", secure = false)
'  result = ""
'
'  ' create a roKeyboardScreen and assign a message port to it
''  port = CreateObject("roMessagePort")
'  scr = CreateObject("roKeyboardScreen")
''  screen.SetMessagePort(port)
'
'  ' display a short string telling the user what they need to enter
'  
'  'scr.SetDisplayText(prompt)
'
'  ' add some buttons
'  scr.AddButton(1, "Okay")
'  scr.AddButton(2, "Cancel")
'
'  ' if secure is true, the typed text will be obscured on the screen
'  ' this is useful when the user is entering a password
'  scr.SetSecureText(secure)
'
'  ' display our keyboard screen
'  scr.Show()
'
''  while true
''    ' wait for an event from the screen
'' '   msg = wait(0, port)
''
''    if type(msg) = "roKeyboardScreenEvent" then
''      if msg.isScreenClosed() then
''        exit while
''      else if msg.isButtonPressed()
''        if msg.GetIndex() = 1
''          ' the user pressed the Okay button
''          ' close the screen and return the text they entered
''          result = screen.GetText()
''          exit while
''        else if msg.GetIndex() = 2
''          ' the user pressed the Cancel button
''          ' close the screen and return an empty string
''          result = ""
''          exit while
''        end if
''      end if
''    end if
''  end while
'
'  scr.Close()
'  return result
'end function

' Show keyboard code for demo it's set on menu


sub showdialog()
  keyboarddialog = createObject("roSGNode", "KeyboardDialog")
  keyboarddialog.backgroundUri = "pkg:/images/keyboardbackground.jpg"
  keyboarddialog.optionsDialog = true
  'Here directly not set to opacity
'  keyboarddialog.opacity = "1.0"  'transparancy set almost 0
'  keyboarddialog.opacity = "1"  'transparancy set almost 0
'  keyboarddialog.keyboardBitmapUri= "pkg:/images/keyboardbackground.jpg"
  '? "Print a opacity value : " + keyboarddialog.opacity 
  keyboarddialog.title = "Enter the URL"
  keyboarddialog.text = "203.109.69.134:8686/"
  keyboarddialog.buttons=["Ok","Cancel"]  'Priority is Ok button first AND cancel second
  
'  keyboarddialog.label.text = "Sorry, You Enter Wrong URL"
  m.top.dialog = keyboarddialog
  m.top.dialog.observeField("buttonSelected","onVerifyURL") 'ButtonSelected Fieled call and function called
  m.top.dialog.setFocus(true)  
  m.cText="" 'initialize variable for this component
  m.cFocused=0 'initialize variable
 ' m.top.GlobleURL = ""
  m.top.dialog.setFocus(TRUE)
  
'  m.key.showTextEditBox= true
'  m.key = m.top.Dialog
'  return m.key.text 'Not Accepted return type anything only accept here boolean
  
end sub
'sub sleepurl()
'        sleep(5000)
'        m.top.dialog.close = true
'end sub
'Function for Database handler and print text to onVerifyURL to call function

Sub dbText()
    print "***************   I am in dbText() *************"
    'cText print the Copied text its last charecter display its use right function
    Serverurl = m.top.dialog.text
    Print"Text: "+ Serverurl
    m.cText=m.cText+right(m.top.dialog.text,1) 'Grab the right character of the dialog text
    If Len(m.top.dialog.text)>40 m.top.dialog.text=Right(m.top.dialog.text,40) 'truncate value for display with a limit of 40 characters
         Print"CTEXT:"+m.cText 'Print copied value to screen
     'Set the URL Globally
     'Print the URL
'    m.Dialog.visible = false
    m.top.dialog.visible = false
    m.top.dialog.close = true
     
    'Here the code for the Process Dialog box
'    progressdialog = createObject("roSGNode", "ProgressDialog")
'    progressdialog.backgroundUri = "pkg:/images/rsgde_dlg_bg_hd.9.png"
'    progressdialog.title = "Process the URL"
'    m.top.dialog = progressdialog  
   
    'Print The Error message viewer Enter the Wrong URL
    
    'Here call first time otherwise not compare to right URL and wrong URL
                m.top.GlobleURL = GetAuthData()
                print "Read URL : " + m.top.GlobleURL
                SetAuthData(Serverurl)

    if m.top.GlobleURL = m.top.dialog.text then 
    'sleep(3000)
    ? "Progress Bar Open"
        ? "m.top.GlobleURL----------------------------------------" m.top.GlobleURL
        ? "m.top.dialog------------------------------------------" m.top.dialog.text
        
          progressdialog = createObject("roSGNode", "ProgressDialog")
          progressdialog.backgroundUri = "pkg:/images/keyboardbackground.jpg"
          progressdialog.title = "Check URL"
'          progressdialog.titleColor = "0x7CFC00" 
          
          m.top.dialog = progressdialog
         ' sleepurl()           
          m.top.dialog.close = true
          
                'Call the function of read Data
                m.top.GlobleURL = GetAuthData()
                print "Read URL : " + m.top.GlobleURL
                SetAuthData(Serverurl)
             
    else 
    ? "Dialog Box Open Simple Dialog"
            ? "else part m.top.GlobleURL----------------------------------------" m.top.GlobleURL
            ? "else part m.top.dialog------------------------------------------" m.top.dialog.text
              dialog = createObject("roSGNode", "Dialog")
              dialog.backgroundUri = "pkg:/images/keyboardbackground.jpg"
              dialog.title = "Warning"
              dialog.optionsDialog = true
              dialog.message = "Please Enter Valid URL......"      
              dialog.messageColor = "0xFF0000"
              dialog.bulletText = ["Press * to Closed"]      
              m.top.dialog = dialog
    end if
    
'    m.top.GlobleURL = Serverurl
'    print "URL = " m.top.GlobleURL

'     m.readVideoContentTask.control = "RUN"
'     m.dialog.visible = false 
'     m.dialog.setFocus(false)
'     m.top.videoplayer.setfocus = true
'     m.gridpanel.grid.content.setFocus = true
'     m.listpanel.list.content.setFocus = true
'     m.focusedNode.SetFocus(true)
'     result = true
  '  print m.top.GlobleURL 
  '  ?"URL = " m.top.GlobleURL
    
'    Here COde for a display a URL every file
'     defaultText = "http://192.168.1.24:8686/test/"  
'     m.top.dialog.GlobleURL.SetString(defaultText)', defaultText.Length)
'    ? m.top.dialog.GlobleURL.GetString()
'     m.top.dialog.GlobleURL.SetString(Serverurl)', Serverurl.Length)
'    ? m.top.dialog.GlobleURL.GetString()
    
    'Its a syntax error here 
         
End Sub

'Here Function roRegistry

'Here the GetAuthData to read URL
Function GetAuthData() As Dynamic
' reg = CreateObject("roRegistry")
 sec = CreateObject("roRegistrySection", "Authentication")
' print "section : " + Authentication
 if sec.Exists("Authentication")
  print "Read URL : " + m.top.GlobleURL
  print " ****************** DATA :" + m.top.GlobleURL
  return sec.Read("Authentication")
 'return sec.Delete("Authentication") ' Here not override concept so compalsary delete first and after again second URL Store pannel.brs and hud.brs both file

 print "***********************GetAuthData************************"
 endif

 return invalid
End Function

'Here the SetAuthData to wrire URL
Function SetAuthData(Serverurl As String) As Void
' reg = CreateObject("roRegistry")
 sec = CreateObject("roRegistrySection", "Authentication")
 m.top.GlobleURL = Serverurl
' if not m.top.GlobleURL = Serverurl 
sec.Write("Authentication", m.top.GlobleURL)
?"key for the URL" sec.GetKeyList()

    Print "Write URL :" + m.top.GlobleURL
' end if

 print "***********************SetAuthData************************"
' Flush(true)
    
End Function

'function getConfig() as Object
'    print "Getting Registry Values"
''    config = {}
'   sec = CreateObject("roRegistrySection", "Authentication") 
'    configString = sec.Read("Authentication")
'    config = ParseJson(configString.GetString())
'    
'    
'    ? config
'    
''    if sec.Exists("Authentication")
''        if configString = "" ' No data available execute here
''            print "getConfig. No config registry info found"
''        else  ' Data Insert ok button click and parse json
''             config = ParseJson(configString)
'        
''                if Type(config) <> "roAssociativeArray"
''                    print "getConfig. Expecting roAssociativeArray, found: "; Type(config)
'''                    print "here the config data : " + config
''                    config = {}
''                end if       
''        end if
''    end if
'    return config
'end function

'Sub StoreURL()
'    m.top.GlobleURL = " "
'    m.top.GlobleURL = Serverurl
'    print m.top.GlobleURL
'end Sub

'Sub confirmSelection()
'   m.cFocused=m.top.dialog.button


'   If m.cFocused=0
'      Print"OK"
'      Print"Entry complete, use cText value of: "+m.cText
'   End If
'   If m.cFocused=1 Print"Cancel"
'   End Sub
         
sub onVerifyURL()
    if m.top.dialog.buttonSelected = 0
       print "ok button pressed" 'O is called first
       dbText() 'Function call
      
      'Here set Condition of if wrong URL and Blank URL
'      if m.top.GlobleURL = m.top.dialog.text  then
       
        init()  ' Wise Panel Call and print the data
        
'         ? "m.top.GlobleURL----------------------------------------" m.top.GlobleURL
'            ? "m.top.dialog------------------------------------------" m.top.dialog.text
'          progressdialog = createObject("roSGNode", "ProgressDialog")
'          progressdialog.backgroundUri = "pkg:/images/rsgde_dlg_bg_hd.9.png"
'          progressdialog.title = "Check URL"
'          m.top.dialog = progressdialog
'          m.top.dialog.close = true
'      else 
'            ? "else part m.top.GlobleURL----------------------------------------" m.top.GlobleURL
'            ? "else part m.top.dialog------------------------------------------" m.top.dialog
'              dialog = createObject("roSGNode", "Dialog")
'              dialog.backgroundUri = "pkg:/images/rsgde_dlg_bg_hd.9.png"
'              dialog.title = "Enter Valid URL"
'              dialog.optionsDialog = true
'              dialog.message = "Please Enter Valid URL......"             
'              m.top.dialog = dialog
'      end if
'      m.top.dialog.visible = false 'Dialog is visible false
      m.top.videoplayer.setfocus = true
      if m.listpanel.list.content.setFocus = false then
            print " ********list Focus***********"
            m.gridpanel.grid.content.setFocus = true
            m.listpanel.list.content.setFocus = true
      end if

'      m.Reset() 
'      result = true
'      m.focusedNode.SetFocus(true)  'Its not working here
      
'      m.top.dialog.setFocus(true)
'       m.top.videoplayer.setfocus = true 
'       m.gridpanel.grid.content.setFocus = true
'       m.listpanel.list.content.setFocus = true
'       m.focusedNode.SetFocus(true)
'      m.top.dialog.focusable(false)
      'Here the redirect the screen to WisePanels
      
       'Here the ok button press and loading dialog box call and display the all channel 
       
  '     Print"Entry complete, use cText value of: "+m.cText
    else if m.top.dialog.buttonSelected = 1  
       print "cancel button pressed" '1 is called first
       print m.top.GlobleURL
   '    m.dialog.visible = false
      m.top.dialog.visible = false
      m.top.dialog.close = true 
    else
        print "nothing press" ' this is not require for code just write understanding
        
    end if
    
end sub

'Code For Simple KeyBoard one Function and Function key event
'sub showdialog()
'?"IN SETEMAIL"
'keyboarddialog = createObject("roSGNode", "KeyboardDialog")
'keyboarddialog.title= "Enter Email Address"
'keyboarddialog.visible = true
'keyboarddialog.buttons=["Continue","Cancel"]
'm.key=keyboarddialog.keyboard
'm.key.showTextEditBox= true
'm.top.setFocus(true)
'm.top.dialog = keyboarddialog
'return 'm.key.text
'end sub
'
'Function onKeyEvent(key as String, press as Boolean) as Boolean
'      button_val = m.top.dialog.buttonSelected
'        if not press then
'            if key = "OK"
'        if(button_val = 0)
'       ?"EMAIL "m.key.text
'        m.top.dialog.close = true
'        return true
'        else if (button_val = 1)
'        Print "CANCEL"
'       m.top.dialog.close = true
'      return true
'                      end if
'                    end if
'                end if
'            return FALSE
'end function
'sub config()
'
'config =  {
'          key1: 42
'          key2: "Forty Two"
'          key3: ["Roku", "Roku"]
'          }
'          m.taskRegistryNode.write = config
'          m.taskRegistryNode.control = "RUN"
'end sub
function verifyexit() as boolean
                    ? "verifyexit  call"
                    exitdialog = createObject("roSGNode", "Dialog")
                    exitdialog.backgroundUri = "pkg:/images/keyboardbackground.jpg"
                    exitdialog.title = "Exit Application"
                    'dialog.optionsDialog = true
'                    if dialog.visible = true then 
'                       
'                    end if
                    
                    exitdialog.message = "Are you sure to Exit?"
                    exitdialog.buttons=["Ok","Cancel"]
                   
                    m.top.dialog = exitdialog          
                    

                    m.top.dialog.observeField("buttonSelected","exitapp")
               '      m.top.dialog.observeField("m.top.dialog.buttons","exitapp")
                      m.top.dialog.setFocus(true)
                  '  ?m.top.dialog.observeField
                    handled = true
                    
                    return handled
end function

function exitapp() as boolean
                    ?"Print exitapp"
                    'Here the exit dialog box button selected OK AND CANCEL
                    if m.top.dialog.buttonSelected = 0
                           ' m.top.dialog = dialog        
                           ?"Exit OK Press"
                           
                          m.top.exitApp = true
                           
                     ?"Selected 0"
                          ' handled = false
                       '    return handled
                    else if m.top.dialog.buttonSelected = 1
                            ?"Exit Cancle Press"
                            m.top.dialog.visible = false
                            m.top.dialog.close = true         
'                    else 
'                            ?"Any else press"
                    end if   

end function

function onKeyEvent(key as String, press as Boolean) as Boolean
  
  ? "PanelSet :: Key Event is about to execute - key = "key " press = " press 
  '  getConfig()

'  ? "Display the XML Data: "m.gridpanel.grid.content.getChild(m.gridpanel.grid.itemFocused)
  handled = false
  
  if press then

 '       if key = "options"
 '       
           ' If mm.top.videoPlayer.Video Then
 '       
           
           ? "Video size incresed"
          
            
 '          m.top.videoPlayer.Video.width = 1920
 '          m.top.videoPlayer.Video.height = 1080
 '          m.top.videoPlayer.Video.translation = "[0,0]"
           
'             if key = "back"
'           +         m.top.videoPlayer.Video.width = 250
'                    m.top.videoPlayer.Video.height = 300
'             end if
'                if m.displaySize.name = "SD"
'                    m.top.videoPlayer.Resolution = 0
'                    m.top.videoPlayer.width = 720
'                    m.top.videoPlayer.height = 480
'                else if m.displaySize.name = "HD"
'                    m.top.videoPlayer.Resolution = 1
'                    m.top.videoPlayer.width = 1280
'                    m.top.videoPlayer.height = 720
'                else 'if m.displaySize.name = "FHD"
'                    m.top.videoPlayer.Resolution = 2
'                    m.top.videoPlayer.width = 1920
'                    m.top.videoPlayer.height = 1080
'                end if
'           ' end if
'        end if

'Key handler for ok button press then store the url in xml file and use everywhere particular url
  
   
   if key="options" then
           'we are not in video playback
           
'            If Not m.video.visible Then
            
                if NOT m.dialog.visible then
                
                    ? "video option menu is open"
'                   ShowKeyboardScreen()
                     showdialog()
                     m.dialog.visible = false
                     m.dialog.focusable = false
'                    if m.dialog.visible = true
      
'                            m.dialog.visible = false ' Here the close the keyboard dialog box

'                    end if

'Here the Code For the if ok button Press then dialog box close and load the channel
'                   if not press then
'                        if key = "OK"
'                            if(button_val = 0)
'                                ?"EMAIL "m.key.text
'                                    m.top.dialog.close = true
'                                    return true
'                             end if
'                         end if
'                    end if
'                    if key="ok" then
'                        config()    
'                    end if
'                    m.focusedNode = m.panelSet.focusedChild
'                    m.gridpanel.grid.content.setFocus = false
'                    m.listpanel.list.content.setFocus = false
'                    m.top.videoplayer.setfocus = false
'                     m.dialog.visible = true
'                    m.dialog.setFocus(true)
'                    m.dialog.visible = true
                    result = true
                    return true
                     
                else
                          
                    ? "video option menu is closed"
                    
'                    Keyopen() ' KeyBoard Function is open
'                    screen = CreateObject("roSGScreen")
'                    scr = CreateObject("roKeyboardScreen")   'Create object for roKeyboardScreen
'                    port = CreateObject("roMessagePort")
'                    scr.SetMessagePort(port)
'                    scr.SetTitle("Search URL")   'Set the Title on the Particular Screen
'                    scr.SetText("192.168.1.37:8686")  'Set text on the textbox
'                    scr.SetDisplayText("Enter Text to URL") ' Display text on the belove textbox
'                    scr.SetMaxLength(15) ' Set MAximum length on the enter the maximum letter on the textbox
'                    scr.AddButton(1,"Finished") 'Add button name as finished
'                    scr.AddButton(2,"Back") 'Add button name as Back
'                    scr.show()
'      
'                    port = CreateObject("roMessagePort")
'                    screen.SetMessagePort(port)
'                    screen.SetTitle("Search Screen")
'                    screen.SetText("192.168.1.37:8686")
'                    screen.SetDisplayText("enter text to search")
'                    screen.SetMaxLength(8)
'                    screen.AddButton(1, "finished")
'                    screen.AddButton(2, "back")
'                    screen.Show()
'                    while true
'                        msg = wait(0, scr.GetMessagePort())
'                        print "message received"
'                        if type(msg) = "roKeyboardScreenEvent"
'                            if msg.isScreenClosed()
'                                return
'                            else if msg.isButtonPressed() then
'                                print "Evt:"; msg.GetMessage ();" idx:"; msg.GetIndex()
'                                if msg.GetIndex() = 1
'                                    searchText = scr.GetText()
'                                    print "search text: "; searchText
'                                    return
'                                endif
'                            endif
'                        endif
'                    end while
                    m.dialog.visible = false 
                    m.dialog.setFocus(false)
                    m.top.videoplayer.setfocus = true
                    m.gridpanel.grid.content.setFocus = true
                    m.listpanel.list.content.setFocus = true
                    m.focusedNode.SetFocus(true)
                    result = true
                    return true
                    
                end if
            end if
 '       end if
              
    if key = "back"
      ? "Back pressed - nikunj = handled = " handled
  if  not m.video.state = "playing" then
       
      handled = verifyexit()
      
      ? "Back pressed - jigar = handled = " handled
      
      return handled'true
  end if    
            
'      return handled
'            ?"Panelset::back button is pressed"
'            if  not m.video.state = "playing" then
'                    'Here the Exit dialog box
'                    'here the screen will be stope        
'                    exitdialog = createObject("roSGNode", "Dialog")
'                    exitdialog.backgroundUri = "pkg:/images/keyboardbackground.jpg"
'                    exitdialog.title = "Exit Application"
'                    m.top.dialog.observeField("buttonSelected","onVerifyURL")
'                    'dialog.optionsDialog = true
''                    if dialog.visible = true then 
''                       
''                    end if
'                    ? exitdialog.visible
'                    exitdialog.message = "Are you sure to Exit?"
'                    exitdialog.buttons=["Ok","Cancel"]
'                  
'                    m.top.dialog = exitdialog
'                    'verifyexit()
'                    'return handled
'                    if m.top.dialog.visible = true
'                    
'                    end if
'                    'Here the exit dialog box button selected OK AND CANCEL
'                    if m.top.dialog.buttonSelected = 0
'                           ' m.top.dialog = dialog        
'                           ?"Exit OK Press"
'                           handled = false
'                           return handled
'                    else if m.top.dialog.buttonSelected = 1
'                            ?"Exit Cancle Press"
'                            m.top.dialog.visible = false
'                            m.top.dialog.close = true
'                            
'                    else 
'                            ?"Any else press"
'                            
'                    end if   
                        
                   
                    
                   ' screen.show()
                    
                   
                 '   return handled
'            end if
            handled = false  
            'video = m.top.videoPlayer.findNode("liveVideo")
            
            ? "Video state = " m.video.state
      
            if (m.video.state = "playing")
                ?"set videoplayer focus"
                m.video.control = "stop"
 '               m.ButtonGroup.setFocus(true)
                m.video.visible = false
                m.top.videoPlayer.visible = false
                m.top.visible = true
                m.top.setFocus(true)
                m.panelset.setFocus(true)
                m.gridpanel.setFocus(true)
                handled = true
                
            end if
        'handled = true
        return handled
    end if  

    if key = "play"
            
                 list = []
                     color = "#80000000" 'semi-transparent black
                
  
                   ' m.video.control = "pause"
                    
                    if m.video.state = "playing"
                    ? "video is paused"
                     'Here the paused label print on above video 
                     list.Push({
                          Text: "Paused"
                          TextAttrs: { font: "huge" }
                          TargetRect: m.top.videoPlayer.Resolution
                           
                    })
                    
                    m.video.control = "pause"   
                    
                     m.top.visible = true
                    else
                    ? "video is resumed"     
                    
                          m.video.control = "resume"
                          
                          list.Push({
                          Text: "Paused"
                          TextAttrs: { font: "huge" }
                          TargetRect: m.top.videoPlayer.Resolution
                         
                    })
                    end if
                    'if  m.video.control = "pause"
                    '    while true
                    '          if type(msg) = "roVideoScreenEvent" then  
                    '            if msg.isCaptionModeChanged()
                    '                  print "Paused and Resumed"
                    '                  print "which Index: "; msg.GetIndex()
                    '                  print "Paused Video: "; msg.GetMessage()
                    '            end if
                    '           end if
                    '    end while
                   ' if key = "paused"
                   ' ? "video play"
                   '         
                   ' end if    
               '  m.canvas.SetLayer(0, { Color: color, CompositionMode: "Source" })
                ' m.canvas.SetLayer(1, list)                       
       end if
     m.progress = 0
     
'     player = CreateObject("roVideoPlayer")
 '    if key = "left"
 '       if m.video.state = "playing"
 '           ?"video is rewind"
 '       '    m.progress.tostr() - 10 
 '       end if
 '    end if
     
'     if key = "right"
'     
'        if m.video.state = "playing"
'            
'            if m.video.duration > 0
'            ? "video fast forward"
''            ? "Total Duration : "m.video.duration "Seconds"
'            ? m.progress = m.progress + 60
'             end if
'        end if
 '    end if
 
  m.position = 60
 if key = "fastforward"
 
    ? "video fast forward"
    
     m.video.control = "FastForward"
     m.position = m.position + 60
      
 end if
 if key = "rewind"
 
 ? "video Rewind"
 
     m.video.control = "Rewind"
     m.position = m.position - 60
     
 end if
 
     if key = "replay"
     
     ? "video replay"
     
            m.video.control = "play"
            
     end if
     
    if key = "up" or key = "down"
         
        ? "Up key is change the video channel and down key for again particular video displayed"
         
        bUp = true
        if key = "down" then
            bUp = false
        end if
    
        if (m.video.state = "playing")
            ?"set videoplayer focus"
            m.video.control = "stop"
            
            m.gridpanel.setFocus(true)
            ?" m.gridpanel.content.getChildCount() = " m.gridpanel.grid.content.getChildCount()
            
            nTotalItem = m.gridpanel.grid.content.getChildCount()
             
             ? " m.gridpanel.grid.itemFocused = " m.gridpanel.grid.itemFocused
             if key = "up"
                 if m.gridpanel.grid.itemFocused = 0 then
                     m.gridpanel.grid.jumpToItem = nTotalItem - 1
                     ? "arrow selected "
                 else
                     m.gridpanel.grid.jumpToItem = m.gridpanel.grid.itemFocused - 1
                     ? "arrow selected "
                 end if
             endif
             
             if key = "down"
                 
                 if m.gridpanel.grid.itemFocused = nTotalItem - 1 then
                     m.gridpanel.grid.jumpToItem = 0
                     ? "arrow selected "
                 else
                     m.gridpanel.grid.jumpToItem = m.gridpanel.grid.itemFocused + 1
                     ? "arrow selected "
                 end if
             endif
             
            ? " m.gridpanel.grid.itemFocused = " m.gridpanel.grid.itemFocused

            m.video.control = "Play"
            
            m.top.videoPlayer.setFocus(true) 
            
            handled = true            
           
        end if     
    end if

'    if key = "OK"
'          
'           ? "ok pressed - I am in EPG list - A"
'          
''           if (m.videoplayer.getchild(1).state = "playing")
''                ?"set videoplayer focus"
''                m.videoplayer.getchild(0).setFocus(true)
''           end if
'           
''        ' m.listpanel.list.setFocus(true)
''        if ( m.EPGpanel.list.hasFocus() = "false")
''            ? "ok pressed - I am in grid panel - B"
''            m.EPGpanel.visible = true
''            m.EPGpanel.list.setFocus(true)            
''            return true
''        else
''            ? "ok pressed - I am in EPG panel - D"
''            m.EPGpanel.visible = false
''            'm.videoplayer.video.setFocus(true)
''            m.video.setFocus(true)
''            return true
''        end if
'        handled = true
'    end if
    
'    if key = "left"
'        ? "left pressed - I am in EPG list - A " 'm.EPGpanel.visible
'        ' m.listpanel.list.setFocus(true)
'        'if ( m.EPGpanel.visible = false and m.video.state = "playing")
' '       if ( m.video.state = "playing")
' '           ? "Left pressed - I am in EPG panel - B"
'            
' '           m.top.visible = true 
'           ' m.video.control = "stop"            
'            'm.video.visible = false
'            
' '           m.EPGpanel.visible = true
' '           m.EPGlabel.visible = true
'            
'            'm.videoplayer.visible = false
'            
''            m.top.visible = true
''            m.listpanel.visible = true
''            m.gridpanel.visible = true
''            m.gridpanel.list.setFocus(true)
'            
''             m.EPGpanel.visible = true
''            m.EPGpanel.list.visible = true
''            m.EPGpanel.setFocus(true)
'            
' '           m.testLabel = m.top.findNode("testLabel")
''             m.testLabel.visible = true
'            
'            'm.epgLabel = m.EPGpanel.findNode("EPG_Label")
''            m.epgLabel.setFocus(true)
''            m.epgLabel.visible = true
'
''            return true         
''        end if
'        handled = true
'    end if
'    if key = "right"
'        ? "right pressed - I am in EPG list - C"
'        ' m.listpanel.list.setFocus(true)
''        if ( m.EPGpanel.visible = true)
''            ? "right pressed - I am in EPG panel - D"
''            m.EPGpanel.visible = false
''            m.gridpanel.setFocus(false)
''            m.top.setFocus(true) 
''            return true         
''        end if
'        handled = true
'    end if
  end if

  return handled
end function 