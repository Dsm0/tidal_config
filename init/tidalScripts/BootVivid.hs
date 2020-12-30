import Vivid as V

-- Use C-c C-e in emacs to eval the whole definition:
:{
ss' :: V.SynthDef '["out", "freq"]
ss' = V.sdNamed "foo1" (0::V.I "out", 440::V.I "freq") $ do
   env <- V.percGen none ~* 0.5
   s <- V.sinOsc (freq_ (V.V::V.V "freq")) ~* env
   V.out (V.V::V.V "out") [s,s]
:}

V.defineSD $ ss'
