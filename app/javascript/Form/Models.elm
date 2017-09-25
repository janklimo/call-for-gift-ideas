module Form.Models exposing (..)

import RemoteData exposing (RemoteData(..), WebData)


type alias Model =
    { recipientName : String
    , recipientEmail : String
    , senderName : String
    , senderEmail : String
    , validating : Bool
    , requestStatus : WebData String
    }


initialModel : Model
initialModel =
    { recipientName = ""
    , recipientEmail = ""
    , senderName = ""
    , senderEmail = ""
    , validating = False
    , requestStatus = NotAsked
    }
