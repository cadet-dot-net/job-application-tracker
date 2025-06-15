module Main exposing (main)

import Browser
import Html exposing (text)
import Time

-- MODEL

type alias Application =
  { id: Int
  , employer: String
  , role: String
  , salary: Int
  , location: List String
  , application_date: Time.Posix
  }

type alias Model = 
  { applications: List Application
  , nextId: Int
  , inputEmplyoer: String
  , inputRole: String
  , inputSalary: Int
  , inputLocation: List String
  }

main =
  Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }