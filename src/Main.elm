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

-- UPDATE
type Msg = 
  Create
  | Delete Int 

update : Msg -> Board -> Board
update msg board =
  let
    currentInput = board.input
  in
  case msg of
    Create ->
      if currentInput.employer == "" then
        board
      else
        let
          { employer, role, salary, location, date } = currentInput
        in
        { board
            | applications = board.applications ++ 
              [Application board.nextId employer role salary location date]
            , nextId = board.nextId + 1
            , input = defaultApplication
        }

    Delete id ->
      { board | applications = List.filter (\application -> application.id /= id) board.applications }  

main =
  Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }