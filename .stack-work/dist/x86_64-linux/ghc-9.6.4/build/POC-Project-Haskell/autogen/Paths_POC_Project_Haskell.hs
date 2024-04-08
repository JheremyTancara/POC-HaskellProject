{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
#if __GLASGOW_HASKELL__ >= 810
{-# OPTIONS_GHC -Wno-prepositive-qualified-module #-}
#endif
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_POC_Project_Haskell (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath




bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/fundacion/Subjects/ProjectsOficial/aaaa/POC-haskell/POC-Project-Haskell/.stack-work/install/x86_64-linux/4fb9eed9e2c2e7f83b3c6251ca0f3103ca4e8b7c37f06feb3358204abe0245db/9.6.4/bin"
libdir     = "/home/fundacion/Subjects/ProjectsOficial/aaaa/POC-haskell/POC-Project-Haskell/.stack-work/install/x86_64-linux/4fb9eed9e2c2e7f83b3c6251ca0f3103ca4e8b7c37f06feb3358204abe0245db/9.6.4/lib/x86_64-linux-ghc-9.6.4/POC-Project-Haskell-0.1.0.0-5PVoexrsvpe4yFOGKaNCpQ-POC-Project-Haskell"
dynlibdir  = "/home/fundacion/Subjects/ProjectsOficial/aaaa/POC-haskell/POC-Project-Haskell/.stack-work/install/x86_64-linux/4fb9eed9e2c2e7f83b3c6251ca0f3103ca4e8b7c37f06feb3358204abe0245db/9.6.4/lib/x86_64-linux-ghc-9.6.4"
datadir    = "/home/fundacion/Subjects/ProjectsOficial/aaaa/POC-haskell/POC-Project-Haskell/.stack-work/install/x86_64-linux/4fb9eed9e2c2e7f83b3c6251ca0f3103ca4e8b7c37f06feb3358204abe0245db/9.6.4/share/x86_64-linux-ghc-9.6.4/POC-Project-Haskell-0.1.0.0"
libexecdir = "/home/fundacion/Subjects/ProjectsOficial/aaaa/POC-haskell/POC-Project-Haskell/.stack-work/install/x86_64-linux/4fb9eed9e2c2e7f83b3c6251ca0f3103ca4e8b7c37f06feb3358204abe0245db/9.6.4/libexec/x86_64-linux-ghc-9.6.4/POC-Project-Haskell-0.1.0.0"
sysconfdir = "/home/fundacion/Subjects/ProjectsOficial/aaaa/POC-haskell/POC-Project-Haskell/.stack-work/install/x86_64-linux/4fb9eed9e2c2e7f83b3c6251ca0f3103ca4e8b7c37f06feb3358204abe0245db/9.6.4/etc"

getBinDir     = catchIO (getEnv "POC_Project_Haskell_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "POC_Project_Haskell_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "POC_Project_Haskell_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "POC_Project_Haskell_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "POC_Project_Haskell_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "POC_Project_Haskell_sysconfdir") (\_ -> return sysconfdir)



joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
