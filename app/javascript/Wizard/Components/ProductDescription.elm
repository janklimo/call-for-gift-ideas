module Wizard.Components.ProductDescription exposing (previewText)

-- external modules

import Html exposing (Html, text, a, div)
import Html.Attributes exposing (..)


-- internal modules

import Utils exposing (onClick)
import Wizard.Msgs exposing (..)
import Wizard.Models exposing (..)


previewText : Product -> Extensions -> Html Msg
previewText product extensions =
    let
        description =
            case extensions.showingFullDescription of
                True ->
                    product.description

                False ->
                    (String.split " " product.description
                        |> List.take 12
                        |> String.join " "
                    )
                        ++ "..."

        linkLabel =
            case extensions.showingFullDescription of
                True ->
                    "Less..."

                False ->
                    "More..."
    in
        div []
            [ text description
            , a
                [ class "product-description__toggle"
                , onClick (ToggleDescription product.id)
                , href "#"
                ]
                [ text linkLabel ]
            ]
