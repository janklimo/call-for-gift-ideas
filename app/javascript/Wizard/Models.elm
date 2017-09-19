module Wizard.Models exposing (..)


type Page
    = Welcome
    | Cards


type alias Flags =
    { recipientName : String
    }


type alias Model =
    { recipientName : String
    , currentPage : Page
    }
