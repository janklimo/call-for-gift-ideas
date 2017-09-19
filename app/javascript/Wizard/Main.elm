module Wizard.Main exposing (..)

import Html exposing (programWithFlags)
import Wizard.Utils exposing (..)
import Wizard.Msgs exposing (..)
import Wizard.View exposing (view)
import Wizard.Models exposing (..)
import Wizard.Update exposing (update)


-- INIT


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        { recipientName } =
            flags
    in
        Model recipientName Welcome
            |> withNoCmd


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Flags Model Msg
main =
    programWithFlags
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
