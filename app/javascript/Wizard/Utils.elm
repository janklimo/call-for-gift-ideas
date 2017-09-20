module Wizard.Utils exposing (..)

import Html exposing (Html)
import Svg exposing (use, svg)
import Svg.Attributes as SvgAttrs
import Wizard.Msgs exposing (Msg)


withNoCmd : model -> ( model, Cmd msg )
withNoCmd model =
    ( model, Cmd.none )


withCmd : Cmd msg -> model -> ( model, Cmd msg )
withCmd cmd model =
    ( model, cmd )


icon : String -> Html Msg
icon name =
    svg [ SvgAttrs.class ("icon icon-" ++ name) ]
        [ use [ SvgAttrs.xlinkHref ("#icon-" ++ name) ] [] ]
