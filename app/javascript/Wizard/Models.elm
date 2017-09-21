module Wizard.Models exposing (..)


type Page
    = Welcome
    | Cards
    | Sort


type alias Flags =
    { recipientName : String
    , products : List Product
    }


type alias Product =
    { id : Int
    , name : String
    , price : Float
    }


type alias Extensions =
    { liked : Maybe Bool
    , rank : Maybe Int
    }


defaultExtensions : Extensions
defaultExtensions =
    Extensions Nothing Nothing


type alias Model =
    { recipientName : String
    , currentPage : Page
    , products : List ( Product, Extensions )
    }
