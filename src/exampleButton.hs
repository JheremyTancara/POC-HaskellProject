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

    -- Crear un botón
    button <- buttonNewWithLabel "Haz clic aquí"    
    -- Establecer el color del fondo del botón como celeste
    widgetModifyBg button StateNormal (Color 10280 20452 30471) -- Celeste

    -- Establecer el color del texto del botón como blanco
    widgetModifyFg button StateNormal (Color 65535 65535 65535) -- Celeste

    -- Establecer el ancho mínimo y máximo del botón
    widgetSetSizeRequest button 20 50 -- Ancho mínimo de 100 píxeles y ancho máximo de 150 píxeles

    -- Manejar el evento de clic del botón
    _ <- button `on` buttonActivated $ do
        -- Mantener el color de fondo del botón como celeste al hacer clic
        widgetModifyBg button StateNormal (Color 10280 20452 30471) -- Celeste
        liftIO (putStrLn "¡Has hecho clic en el botón!")

    -- Crear un contenedor de caja y agregar la etiqueta y el botón a él
    vbox <- vBoxNew False 5
    boxPackStart vbox label PackNatural 0
    boxPackStart vbox button PackNatural 0

    -- Centrar la ventana en la pantalla
    windowSetPosition window WinPosCenter

    -- Agregar la caja a la ventana
    containerAdd window vbox

    -- Mostrar todos los widgets
    widgetShowAll window

    -- Entrar al bucle principal de GTK
    mainGUI