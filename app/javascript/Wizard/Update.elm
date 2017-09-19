module Wizard.Update exposing (..)

import Wizard.Msgs exposing (..)
import Wizard.Models exposing (..)
import Wizard.Utils exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Navigate page ->
            { model | currentPage = page }
                |> withNoCmd

        Like id ->
            let
                updateProduct p =
                    if p.id == id then
                        { p | liked = Just True }
                    else
                        p
            in
                { model | products = List.map updateProduct model.products }
                    |> withNoCmd

        Skip id ->
            let
                updateProduct p =
                    if p.id == id then
                        { p | liked = Just False }
                    else
                        p
            in
                { model | products = List.map updateProduct model.products }
                    |> withNoCmd
