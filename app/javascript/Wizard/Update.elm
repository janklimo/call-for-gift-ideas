module Wizard.Update exposing (..)

import Wizard.Msgs exposing (..)
import Wizard.Models exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Navigate page ->
            { model | currentPage = page } ! []

        Like id ->
            let
                updateProduct ( product, extensions ) =
                    if product.id == id then
                        ( product
                        , { extensions
                            | liked = Just True
                            , seen = True
                          }
                        )
                    else
                        ( product, extensions )
            in
                { model | products = List.map updateProduct model.products }
                    ! []

        Skip id ->
            let
                updateProduct ( product, extensions ) =
                    if product.id == id then
                        ( product
                        , { extensions
                            | liked = Just False
                            , seen = True
                          }
                        )
                    else
                        ( product, extensions )
            in
                { model | products = List.map updateProduct model.products }
                    ! []

        StartAgain ->
            let
                -- set all the seen and not liked products to not seen
                updateProduct ( product, extensions ) =
                    if extensions.seen == True && extensions.liked == Just False then
                        ( product, { extensions | seen = False } )
                    else
                        ( product, extensions )
            in
                { model | products = List.map updateProduct model.products } ! []
