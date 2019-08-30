sub init()                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      

      ?"VideoPlayer::Init()"
       
'      m.top.showClock = true

'      videocontent = createObject("RoSGNode", "ContentNode")

'      videocontent.title = "Example Video"
'      videocontent.streamformat = "mp4"
'      videocontent.url = "http://roku.cpl.delvenetworks.com/media/59021fabe3b645968e382ac726cd6c7b/f8de8daf2ba34aeb90edc55b2d380c3f/b228eeaba0f238c48e01e158f99cd96e/rr_123_segment_1_072715.mp4"
     
      index = createObject("roInt")
      m.liveVideo = m.top.findNode("liveVideo")
      
      m.videoData = CreateObject("RoSGNode", "ContentNode")
      m.videoData.SubtitleConfig = {
               trackName: "eia608/708"
      }
      m.videoData.ClosedCaptions = "true"
      testArray=createObject("roArray", 0, true)
      m.liveVideo.content = m.videoData
      m.top.Video = m.liveVideo
      spinner = m.top.FindNode("spinner") 
'      spinner.poster.uri="pkg:/images/loader.png"
        
      spinner.visible = true     
        

      ?"print video content : " m.videoData
'     m.top.Video.content = videocontent
      
'      m.top.Video.setFocus(true)
      
'      video.enableUI = false
'      
'      m.width = 1280.0
'      m.height = 720.0
'      
'      width = 1280.0
'      height = 720.0
'           
'      m.top.width = 1280.0
'      m.top.height = 720.0
'      
'      video.maxWidth = 1280.0
'      video.maxHeight = 720.0
'      
'      video.width = 1280
'      video.height = 720
'      
'      video.isFullScreen = false
'      isFullScreen = false
      
       'm.top.Video.control = "play"
       
      ? "videoscene playing will be started"
      
      'm.top.backgroundURI = "pkg:/images/rsgde_bg_hd.jpg"

'      example = m.top.findNode("examplePoster")
'
'      examplerect = example.boundingRect()
'      centerx = (1280 - examplerect.width) / 2
'      centery = (720 - examplerect.height) / 2
'      example.translation = [ centerx, centery ]
'
'      m.floatanimation = m.top.FindNode("exampleFloatAnimation")
'      m.floatanimation.repeat = true
'      m.floatanimation.control = "start"

'      m.top.width = 1920
'      m.top.height = 1080

      ?"videoscene::init::m.top.width = " m.top.width
      ?"videoscene::init::m.top.height = " m.top.height      
     
      m.hud = m.top.findNode("Hud")
      
      m.top.hud = m.hud
      
      currfocus()
      'm.top.hud.id = "Hud"
      
'      m.top.hud.width = 600'1920
'      m.top.hud.height = 1080      

      m.top.visible = false
      'm.top.setFocus(true)
      
end sub

sub OnContent()

'    m.hud.content = m.top.content

    ?"Live Video - set hud content "
    
    ContentNode = CreateObject("roSGNode", "ContentNode")
    
    ContentNode.subtitleConfig = {Trackname: "pkg:/source/CraigVenter.srt" } 
    
end sub

sub OnWidthChange()

'    m.hud.content = m.top.content
    ?"VideoPlayer - OnWidthChange"
    
    ?"m.top.Resolution = " m.top.Resolution
    
    if m.top.Resolution = 0 then 'SD
    
      m.top.hud.HudResolution = 0
      m.top.hud.width = 300
      m.top.hud.height = m.top.height
      
    else if m.top.Resolution = 1 then 'HD
    
      m.top.hud.HudResolution = 1
      m.top.hud.width = 400'1920
      m.top.hud.height = m.top.height
    
    else if m.top.Resolution = 2 then 'FHD
    
      m.top.hud.HudResolution = 2
      m.top.hud.width = 600'1920
      m.top.hud.height = m.top.height'1080 
    
    endif
    
end sub

sub OnHeightChange()

'    m.hud.content = m.top.content
    ?"VideoPlayer - OnHeightChange"
    
end sub



function currfocus() 
? "hello video player"
    
    ? "--------------------------Array is Here Call in Video player state is start -----------------------"
  '  find = m.hud.epgList.content.getChild(m.hud.epgList.itemFocused)
    'tottitle =  m.hud.epgList.content.getChildCount()
    
   ' epg = m.hud.epgList.content
   
    i = 0
    
   '  for i = 0 to tottitle
    while i < m.hud.epgList.content.getChildCount()
    '    ? "Condition write for the title"
            
        epg = m.hud.epgList.content.getChild(i).TITLE
        
        '? "current index " i " title display " epg
        
        time = left(epg,11) 
        
'        part = left(epg,11)

        part = time.Split("-")
        
        starting = part[0]
        ending = part[1]
                            
        date = CreateObject("roDateTime")
        LocalZone = date.ToLocalTime()
      
        hh = date.GetHours().ToStr()
        mm = date.GetMinutes().ToStr()
        
        ' Set hour in HH format
        If Len( hh ) = 1 Then 'Integer only 9 single value store not store 09
        
            hh = "0" + hh
            
        End If
        
         'Set minutes in MM format
         
        If Len( mm ) = 1 Then
        
            mm = "0" + mm
            
        End If 
         
        currtime = hh + ":" + mm
         
        if currtime > starting and currtime < ending
        
            '  curr = m.hud.epgList.content.getChild(i).TITLE
            '    print "hiiiii"
               ' m.global.setField( {index:0})
             '   index = i
               
                
                testArray=createObject("roArray", 0, true)
                
                testArray.Push(i)
                    
                m.global.addFields( {accessToken: []} )
                
                m.global.accessToken = testArray
                print "Array Count: "; m.global.accessToken.Count()
                print "Array Data: "; m.global.accessToken
                
                
              ' ? m.hud.epgList.content.getChild(i)
                'm.global.index = i
                '? m.global.index
                 
                print "Currently play a program : " + epg 
                
        end if
        
        i = i + 1
                  
     end while   
     
     

end function    

function onKeyEvent(key as String, press as Boolean) as Boolean
    
    'function type as void
    
    currfocus() 'here the write logic for under a current program will display
    
    ?"print the access tocken data : " m.global.accessToken
    'here the buffering state hud one time true and false its play in millisecond so client not visible
    
    if m.top.Video.state = "buffering"
        m.hud.show = true
        m.hud.show = false
    end if
    
    ? "on key event" m.top.Video.state
    ? "print the token index in after invalid"m.global.accessToken
    
    handled = false
    
    ? "handle true"
    
    if press
              
    
    
    ? "print the data : " m.global.accessToken
          
          if key = "back"

                if m.hud.show = true    
                   
                    m.hud.show = false
                    handled = true
                    
                end if
                
          else if key = "OK"
             ?"videoscene::Ok button pressed"
            
            if(m.top.hud.show = true)
              
        '        m.top.content.jumpToItem = 4
        
                m.top.Video.control = "stop"
                  
                ?"1 Video state = " m.top.Video.state
              
                    m.top.content = m.hud.epgList.content.getChild(m.hud.epgList.itemSelected)
                
                ?"videocontent.url = " m.top.content.url
               m.top.Video.SubtitleConfig = {
                                trackName: "eia608/708"
               }

               
                m.top.Video.content = m.top.content
                '? "Display Video : "m.top.video.content
                m.top.Video.content = m.videoData
             
                m.top.Video.control = "play"
               
                m.top.hud.show = false            
                

               ?"2 Video state = "m.top.Video.state
              
               m.top.hud.setFocus(false)
               m.top.setFocus(true)               
                
            else 
                
               m.top.hud.show = not m.top.hud.show
               
                ? "hud content : " m.top.hud.show
'                if m.top.hud.show = true
'                ?"hiii hud"
'                        
'                            ?"Total EPG Element  : " m.hud.epgList.content.getChildCount()
'                            ? m.hud.epgList.itemSelected 
'                              nTotalItem = m.hud.epgList.content.getChildCount() 'Store all EPG Content
'                              handled = true 
'                              
'                             if key = "up"
'                             ? "Up key Press"
'                                    
'                                    if m.hud.epgList.itemFocused = 0 then
'                                        m.hud.epgList.itemSelected = nTotalItem - 1
'                        
'                                    else
'                                        m.hud.epgList.itemSelected = m.hud.epgList.itemFocused - 1
'                                    end if
'                                    handled = true
'                                    m.top.hud.show = false
'                            end if
'                            
'                            if key = "down"
'                            ? "Down key Press"                      
'                                   
'                                    if m.hud.epgList.itemSelected = nTotalItem - 1 then
'                
'                                        m.hud.epgList.itemSelected = 0
'                     
'                                    else
'                                        m.hud.epgList.itemSelected = m.hud.epgList.itemFocused + 1
'                     
'                                    end if   
'                                    handled = true
'                           end if 
'                      
'                           handled = true
'                        
'                end if                 

             end if

        end if         
    end if
    
    return handled
    
end function