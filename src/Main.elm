module Main exposing (main)

import Application exposing (Application)

import Browser exposing (application)
import Debug exposing (toString)
import Html exposing (Html, br, button, div, input, label, li, option, select, text, ul)
import Html.Attributes exposing (multiple, placeholder, value)
import Html.Events exposing (on, onClick, onInput)
import Json.Decode as Decode

-- MODEL
type alias Board = 
  { applications : List Application
  , nextId : Int
  , input : Application
  }

initBoard : Board
initBoard =
  { applications = []
  , nextId = 1
  , input = Application.default
  }

-- UPDATE
type Msg = 
  Create
  | Delete Int 
  | UpdateEmployer String
  | UpdateRole String
  | UpdateSalary String
  | UpdateLocation (List String)

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
            , input = Application.default
        }

    Delete id ->
      { board | applications = List.filter (\application -> application.id /= id) board.applications }  

    UpdateEmployer newEmployer ->
      {board | input = { currentInput | employer = newEmployer }}

    UpdateRole newRole ->
      {board | input = { currentInput | role = newRole }}

    UpdateSalary newSalary ->
      {board | input = { currentInput | salary = Application.salaryToInt newSalary }}

    UpdateLocation newLocation ->
      {board | input = { currentInput | location = newLocation }}

-- VIEW
view : Board -> Html Msg
view board =
  div []
    [ label [] [ text "Employer: " ]
    , input
      [ placeholder "Big Employer"
      , value board.input.employer
      , onInput UpdateEmployer
      ]
      []
    , br [] []

    ,  label [] [ text "Role: " ]
    , input
      [ placeholder "Software Engineer"
      , value board.input.role
      , onInput UpdateRole
      ]
      []
    , br [] []

    , label [] [ text "Salary: " ]
    , input
      [ value (toString board.input.salary)
      , onInput UpdateSalary
      ]
      []
    , br [] []

    , label [] [ text "Location: " ]
    , select 
      [ multiple True
      , on "change" (Decode.map UpdateLocation decodeSelection)
      ]
      [ option [ value "remote" ] [ text "Remote" ]
      , option [ value "hybrid" ] [ text "Hybrid" ] 
      , option [ value "site" ] [ text "On-site" ]
      , option [ value "europe" ] [ text "Europe" ]
      , option [ value "north america" ] [ text "North America"]
      ]
    , br [] []

    , button [ onClick Create ] [ text "Add" ]
    , ul [] (List.map viewApplication board.applications)
    ]

viewApplication : Application -> Html Msg
viewApplication application =
  li []
    [ text
      ( String.join " | "
        [ application.role
        , application.employer
        , ( "£" ++ toString application.salary )
        , ( toString application.location )
        , " "
        ]
      )
    , button [ onClick (Delete application.id) ] [ text "Delete" ]
    ]

decodeSelection : Decode.Decoder (List String)
decodeSelection =
    Decode.at [ "target", "selectedOptions" ] 
      (Decode.keyValuePairs (Decode.field "value" Decode.string))
    |> Decode.map (List.map Tuple.second)

main =
  Browser.sandbox
    { init = initBoard
    , update = update
    , view = view
    }