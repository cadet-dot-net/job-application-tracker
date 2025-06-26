module Main exposing (main)

import Date exposing (Date)

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

main =
  Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }