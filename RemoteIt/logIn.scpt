tell application "Google Chrome"
	activate
	--set doc to front document
	--tell doc
	tell window 1 to tell active tab
		execute Javascript "document.getElementsByName('username')[0].setAttribute('value','analys@sydsvenskan.se');
		document.getElementsByName('password')[0].setAttribute('value','BosseLarsson');
      	--window.document.forms[0].submit();"
	end tell
end tell
