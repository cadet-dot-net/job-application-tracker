module Main exposing (main)

import Date exposing (Date)
import Time exposing (Month(..))

-- MODEL
type alias Application =
  { id : Int
  , employer : String
  , role : String
  , salary : Int
  , location : List String
  , date : Date
  }

type alias Board = 
  { applications : List Application
  , nextId : Int
  , input : Application
  }

defaultApplication : Application
defaultApplication = 
  { id = -1
  , employer = ""
  , role = ""
  , salary = 0
  , location = []
  , date = Date.fromCalendarDate 1999 Dec 31
  }

initBoard : Board
initBoard =
  { applications = []
  , nextId = 1
  , input = defaultApplication
  }

main =
  Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }