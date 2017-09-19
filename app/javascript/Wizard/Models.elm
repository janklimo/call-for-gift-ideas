module Wizard.Models exposing (..)


type Page
    = Welcome
    | Cards


type alias Flags =
    { recipientName : String
    , products : List Product
    }


type alias Product =
    { id : Int
    , name : String
    , price : Float
    , liked : Maybe Bool
    }


type alias Model =
    { recipientName : String
    , currentPage : Page
    , products : List Product
    }
