module Utils exposing (onClick)

import Json.Decode as Json
import Html exposing (Attribute)
import Html.Events exposing (Options, onWithOptions)


onClick : msg -> Attribute msg
onClick message =
    onWithOptions "click" noBubble (Json.succeed message)


noBubble : Options
noBubble =
    { stopPropagation = True
    , preventDefault = True
    }
