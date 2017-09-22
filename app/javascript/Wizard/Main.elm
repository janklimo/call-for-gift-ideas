module Wizard.Main exposing (..)

import Html exposing (programWithFlags)
import Wizard.Utils exposing (..)
import Wizard.Msgs exposing (..)
import Wizard.View exposing (view)
import Wizard.Models exposing (..)
import Wizard.Update exposing (update)


-- INIT


withDefaultExtensions : List Product -> List ( Product, Extensions )
withDefaultExtensions products =
    List.map (\p -> ( p, defaultExtensions )) products


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        { recipient_name, products } =
            flags
    in
        Model recipient_name Welcome (withDefaultExtensions products)
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
