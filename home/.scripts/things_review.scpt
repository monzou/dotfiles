script TermFactory
  
  on create(numericValue, unit)
    
    script Term
      property _numericValue : numericValue
      property _unit : unit
      to displayName()
        (my _numericValue as text) & my _unit
      end displayName
      to calculateDays()
        if my _unit = "D" then
          return my _numericValue
        else if my _unit = "W" then
          return (my _numericValue) * 7
        else if my _unit = "M" then
          return (my _numericValue) * 30
        else
          return (my _numericValue) * 365
        end if
      end calculateDays
    end script
    
  end create
  
end script

on create_term(numericValue, unit)
  create(numericValue, unit) of TermFactory
end create_term

on run
  
  (* インターバル／追加対象プロジェクトの設定 *)
  set terms to {create_term(1, "W"), create_term(2, "W"), create_term(1, "M"), create_term(3, "M")}
  set projectName to "Review"
  
  set baseTaskName to text returned of (display dialog "taskName" default answer "")
  set offsetDays to text returned of (display dialog "offsetDays" default answer 0)
  set baseTagNames to text returned of (display dialog "tags" default answer "")
  
  repeat with t in terms
    set taskName to (baseTaskName & " (" & displayName() of t & ")")
    set tagNames to (baseTagNames & ", Study")
    tell application "Things"
      tell project projectName
        set todo to make new to do with properties {name:taskName, due date:(current date) + (offsetDays + (calculateDays() of t)) * days, tag names:tagNames}
      end tell
    end tell
  end repeat
  
end run
