- if screenshots
    h3 Flyover screenshots
    - screenshots.each do | screenshot |
        h4 =="Port #{screenshot.port.to_s}"
        img src=="data:image/jpeg;base64, #{screenshot.image}"
    br 
    br
    br 
    br