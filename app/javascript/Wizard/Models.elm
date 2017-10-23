module Wizard.Models exposing (..)

import Animation.Messenger
import Wizard.Msgs exposing (..)


type alias Flags =
    { recipient_name : String
    , products : List Product
    }


type alias Product =
    { id : Int
    , name : String
    , price : Float
    , description : String
    , url : String
    , image_url : String
    }


type alias Extensions =
    { liked : Bool
    , seen : Bool
    , rank : Int
    }


type alias Products =
    List ( Product, Extensions )


defaultExtensions : Extensions
defaultExtensions =
    Extensions False False 0


type alias Model =
    { recipientName : String
    , currentPage : Page
    , products : Products
    , cardStyle : Animation.Messenger.State Msg
    }
