module Form.Main exposing (..)

import Html exposing (Html, program)
import Form.Models exposing (..)
import Form.Msgs exposing (Msg)
import Form.View exposing (view)
import Form.Update exposing (update)


init : ( Model, Cmd Msg )
init =
    initialModel ! []


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , subscriptions = always Sub.none
        , view = view
        }
