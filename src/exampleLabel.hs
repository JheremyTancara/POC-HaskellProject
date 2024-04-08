module Main where

import Graphics.UI.Gtk
import Control.Monad.IO.Class (liftIO)

main :: IO ()
main = do
    -- Inicializar GTK
    _ <- initGUI

    -- Crear una nueva ventana
    window <- windowNew
    set window [ windowTitle := "Hola Mundo GTK"
               , windowDefaultWidth := 1520
               , windowDefaultHeight := 850
               ]

    -- Establecer el fondo de la ventana en blanco
    widgetModifyBg window StateNormal (Color 65535 65535 65535)

    -- Conectar la señal de "destroy" de la ventana para salir del bucle principal de GTK cuando se cierre la ventana
    _ <- window `on` deleteEvent $ liftIO mainQuit >> return False

    -- Crear una etiqueta con un mensaje
    label <- labelNew (Just "" :: Maybe String)
    labelSetMarkup label "<span foreground='black'>¡Hola, mundo!</span>"

    -- Crear un contenedor de caja y agregar la etiqueta y el botón a él
    vbox <- vBoxNew False 5
    boxPackStart vbox label PackNatural 0

    -- Centrar la ventana en la pantalla
    windowSetPosition window WinPosCenter

    -- Agregar la caja a la ventana
    containerAdd window vbox

    -- Mostrar todos los widgets
    widgetShowAll window

    -- Entrar al bucle principal de GTK
    mainGUI
