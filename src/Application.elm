module Application exposing (..)

import Date exposing (Date)
import Time exposing (Month(..))

type alias Application =
  { id : Int
  , employer : String
  , role : String
  , salary : Int
  , location : List String
  , date : Date
  }

default : Application
default = 
  { id = -1
  , employer = ""
  , role = ""
  , salary = 0
  , location = []
  , date = Date.fromCalendarDate 1999 Dec 31
  }

salaryToInt : String -> Int
salaryToInt salary = 
  salary |> String.toInt |> Maybe.withDefault 0
