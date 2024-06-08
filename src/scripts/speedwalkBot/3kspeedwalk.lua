
speedwalkBot = {}
speedwalkBot.handlerID = {}
speedwalkBot.paths = {}

-- speedwalk segments must start with a number, everything else is a command

--Chaos
speedwalkBot.paths["topool"] = {"enter", "3e 2s 2e n 3e 4n ne n nw sw sw", "dive pool", "1ne ne se s sw 4s 3w s 2w 2n 3w", "vortex"}
speedwalkBot.paths["tochess"] = {"enter", "1e","climb pipe", "scaler 117"}
speedwalkBot.paths["fromchess"] = {"slide", "1w", "vortex"}
speedwalkBot.paths["toalphabet"] = {"enter", "2e, d","mission ask", "scaler 1"}
speedwalkBot.paths["fromalphabet"] = {"1u 2w", "vortex"}
speedwalkBot.paths["tosb"] = {"enter", "1n","climb tower", "board baloon"}
speedwalkBot.paths["fromsb"] = {"board baloon", "1d s", "vortex"}
speedwalkBot.paths["tohotel"] = {"enter", "3e 2s 2e s 2w","buy hotel transylvania", "theatre", "e", "enter", "pull rug", "dispose ticket", "scaler 117"}
speedwalkBot.paths["fromhotel"] = {"out", "out", "1w s 2e n 2w 2n 3w","vortex"}
speedwalkBot.paths["tospirit"] = {"enter", "4w", "embrace void"}
speedwalkBot.paths["fromspirit"] = {"leave", "1w 3e", "vortex"}
speedwalkBot.paths["todftree"] = {"enter", "3w n", "enter", "scaler 123"}
speedwalkBot.paths["fromdftree"] = {"out", "1s 3e", "vortex"}
speedwalkBot.paths["torocks"] = {"enter", "2s 2w", "enter", "4n", "buy rocks", "smuggle rocks", "buy rocks", "smuggle rocks", "buy rocks", "smuggle rocks", "buy rocks", "smuggle rocks", "4s", "leave", "2e 2n", "vortex"}
speedwalkBot.paths["tohotel"] = {"enter", "3e 2s 2e s 2w","buy hotel transylvania", "theatre", "e", "enter", "pull rug", "dispose ticket", "scaler 117"}
speedwalkBot.paths["fromhotel"] = {"out", "out", "1w s 2e n 2w 2n 3w","vortex"}
speedwalkBot.paths["toveg"] = {"enter", "3e 1s w ne"}
speedwalkBot.paths["fromveg"] = {"1sw e n 3w","vortex"}
speedwalkBot.paths["toanchorman"] = {"enter", "3e 2s 2e s 2w","buy anchorman", "theatre", "2w", "watch", "dispose ticket"}
speedwalkBot.paths["fromanchorman"] = {"exit", "out", "2e s 2e n 2w 2n 3w","vortex"}
speedwalkBot.paths["todundee"] = {"enter", "1w s", "enter swamp"}
speedwalkBot.paths["fromdundee"] = {"leave", "1n e", "vortex", }
speedwalkBot.paths["todundee2"] = {"13e s 10e"}
speedwalkBot.paths["fromdundee2"] = {"10w n 13w","leave", "1n e", "vortex", }
speedwalkBot.paths["toqoh"] = {"enter", "3e 4s", "tear card"}
speedwalkBot.paths["fromqoh"] = {"sit bench", "4n 3w", "vortex", }
speedwalkBot.paths["tomj"] = {"enter", "2w 2s", "draw tile", "scaler 99"}
speedwalkBot.paths["frommj"] = {"portal", "s", "exit", "2n 2e", "vortex"}
speedwalkBot.paths["tochins"] = {"enter", "3e 2s 2e n 3e s 2w", "stroke pelt", "gate"}
speedwalkBot.paths["fromchins"] = {"gate","sit bench", "2e n 3w s 2w 2n 3w","vortex"}
--Magic
speedwalkBot.paths["tounderdark"] = {"portal eforest", "1e 8s w 4s 2sw s"}
speedwalkBot.paths["fromunderdark"] = {"1n 2ne 4n e 8n w", "portal"}
speedwalkBot.paths["tohk"] = {"portal road", "5e n", "enter", "2w"}
speedwalkBot.paths["fromhk"] = {"2e", "leave", "1s 5w", "portal"}
speedwalkBot.paths["torimalkin"] = {"portal", "12n", "leave", "8n 4e 6n 7w s", "slide rock"}
speedwalkBot.paths["fromrimalkin"] = {"leave", "1n 2w", "portal"}
speedwalkBot.paths["tozel"] = {"scaler 95", "portal", "12n", "leave", "3n 4w", "enter" }
speedwalkBot.paths["fromzel"] = { "leave", "4e 3s", "enter", "12s", "portal" }
speedwalkBot.paths["topol"] = {"portal", "15e", "leave", "4e ne 3e", "portal"}
speedwalkBot.paths["topol2"] = {"portal", "15e", "leave", "4e ne 3e", "climb left tree"}
speedwalkBot.paths["topol3"] = {"portal", "15e", "leave", "4e ne 3e", "climb right tree"}
speedwalkBot.paths["frompol"] = {"portal", "2w 4n 5e", "portal"}
speedwalkBot.paths["frompol2"] = speedwalkBot.paths["frompol"]
speedwalkBot.paths["frompol3"] = speedwalkBot.paths["frompol"]
speedwalkBot.paths["tobrigands"] = {"portal wforest", "1nw ne 2w n 2ne 3n 2e 3n 2nw 2n 2e s e n"}
speedwalkBot.paths["frombrigands"] = {"1s w n 2w 2s 2se 3s 2w 3s 2sw s 2e sw se", "portal"}

--Sci
speedwalkBot.paths["tomammon"] = {"enter", "1u 4n d 6n", "path"}
speedwalkBot.paths["frommammon"] = {"path", "6s u 4s d", "out"}
speedwalkBot.paths["towh"] = {"enter", "1u 3e d e", "path", "6e 15n 5e n e n e n 7e", "bridge", "1e n w"}
speedwalkBot.paths["fromwh"] = { "exit", "1e s w", "bridge", "8w s w s w s 5w 15s 6w", "path", "1w u 3w d", "out" }
speedwalkBot.paths["toaegis"] = {"enter", "1u 3e d e", "path", "6e 15n 5e n e n e n 7e", "bridge", "1e 2se 2e", "enter"}
speedwalkBot.paths["fromaegis"] = { "exit", "2w 2nw w", "bridge", "8w s w s w s 5w 15s 6w", "path", "1w u 3w d", "out" }
speedwalkBot.paths["toz"] = {"enter", "1u 3n w n", "play"}
speedwalkBot.paths["fromz"] = { "pause game", "1s e 3s d", "out" }
speedwalkBot.paths["tobshroud"] = { "enter", "1u 4n d n 2e n 2e n 10e 18n e", "enter", "10e 10ne w 3n", "stairs", 
        "say yourname", "say azrael", "say go upstairs", "say test", "say answers: talon, kerrie, azrael", "say sonybishi, megatech",
        "say basement" }
speedwalkBot.paths["frombshroud"] = { "stairs", "3s e 10sw 10w s w 18s 10w s 2w s 2w s u 4s d", "out" }
--Legacy
speedwalkBot.paths["tokey1"] = {"1n 2e s 2e", "search box", "get key", "say key2"}
speedwalkBot.paths["tokey2"] = {"2n w 2n e 2n w", "search crate", "get key", "say computer"}
speedwalkBot.paths["tocomputer"] = {"1w s 3w n w", "turn on computer", "say upstairs"}
speedwalkBot.paths["toupstairs"] = {"1w 2s e s w u e "}
speedwalkBot.paths["tooutside"] = {"1w d e 2s 2e s", "leave"}
speedwalkBot.paths["todocks"] = {"portal", "7w 8s e"}
speedwalkBot.paths["tofg"] = {"portal road", "8e 2s 6e", "enter"}
speedwalkBot.paths["togenlab"] = {"enter", "1u 4n d 2n 13w 13n", "se"}
speedwalkBot.paths["tokilton"] = {"enter", "1u 4n d 2n e n 18e 16n"}
speedwalkBot.paths["towestersea"] = {"portal wforest", "1e 3s w s 3w s 2w nw w nw w sw s", "clear log", "1nw n nw", "clear path", "2w sw 2w sw 9w"}
speedwalkBot.paths["fromwestersea"] = {"9e ne 2e ne 2e se s se n ne e se e se 2e n 3e n e 3n w", "portal"}
speedwalkBot.paths["tosopem"] = {"2se 2e 4s w 5s e 4s 6w sw 7s 3w 5s se e s sw s"}
speedwalkBot.paths["towexmux"] = {"3se e 5s w 4s e 3s 5w sw w 2s se 3e"}
speedwalkBot.paths["totigger"] = {" (enter) 4w e (open chest) 2n 3e 5n 8w 5s 2w (climb branch) "}
speedwalkBot.paths["tovault"] = {" e s 2e 3s 2e n e 3n e d s w s w 2s w d 2w 3n 4e n e 4d"}
speedwalkBot.paths["todonut"] = {"(enter) u 3e d e (path) 6e 15n 5e n e n e n 7e (bridge) e n w (fork over 10000) (enter) 2e u 2w 3n w n"}
speedwalkBot.paths["todogs"] = {"(scaler 130) (enter) 2w n (follow tracks) n n (climb gate) n w 2n e n"}
speedwalkBot.paths["tocarnegie"] = {"(enter) u 3e d e (path) 6e 15n 5e n e n e n 7e (bridge) e 2(se) 2e 2n 3w n (enter)"}
speedwalkBot.paths["toantcave"] = {"(portal) 12n (leave/enter) 8n 4e 6n 7e n e n e 3n e n e d "}
speedwalkBot.paths["tocorrinsyl"] = {"(in) 3n w n w w s w 3n e e n e s e d 5s  e s w s s w s s w w w d 5e 5n d s s w w  w n w n w n w w w n w n w w s d e e n n e e e 5n (ne) (nw) n n n (ne) (nw) n n n (ne) (ne) n n n (nw) (nw) n n n (nw) (ne) 9n (nw) n n n n (ne) n n n n (nw) (ne) (ne) (nw) (nw) n n n n (ne) n n n n (nw) n n n (nw) (nw) (nw) n n (nw) (nw) n (nw) n (nw) e e e (se) s s (se) (se) (se) e (se) e e (se) 8e (ne) (ne) (ne) n (nw) (nw) w w w (sw) (sw) (sw) (se) (se) e e e (ne) (ne) n (nw) w w w (sw) (sw) (se) e e e (ne) n w w w (sw) e e e "}
speedwalkBot.paths["towhetstone"] = {"(in) 3n w n 2w s w 3n 2e n e s e d 4s 3e 2n e s e 2s e s e s w 2s e s e n d 2n 3w 3s w s w n w n w 4n "}
speedwalkBot.paths["topedes"] = {"d 2s 3e 3s e d d 2e n e n 3e n 3u w 4n d w n 3w n 3w n d d "}
speedwalkBot.paths["tocrystals"] = {"(in) 3n w n 2w s w 3n 2e n e s e d 4s 3e 2n e s e 2s e s e s w 2s e s e n d 2n 5w 2s 2w 4n d 2s 5e n e n e 4n 2e (ne) "}
speedwalkBot.paths["tocrystals2"] = {"2n (ne) n (nw) 2n 5(ne) 7s 10(se) 14e 11(ne) 8n 10(nw) 14w 10(sw) e 9(ne) 14e (sw) 3w d"}
speedwalkBot.paths["tocrystals3"] = {"2(se) 4e 2(se) 7e 3(se) 7e 7(se) 2s (se) e (se) (sw) 20w 4(sw) d"}
speedwalkBot.paths["tocrap"] = {" (enter) 3e 2s (ride cow) 8n (ne) 4e (se) e (push through) 2e (say north to enter)"}
speedwalkBot.paths["towinds"] = {" w 2(nw) 3n e (nw) w 6s 2w n w "}
speedwalkBot.paths["toland2"] = {" (enter) 3e 2s 2e 4n (break arch) (say land2) "}
speedwalkBot.paths["toland"] = {" (enter) 3e 2s 2e 4n (break arch) (say land)"}
speedwalkBot.paths["tosewers"] = {" (enter) 2e s 2e (la hole) 2n 4e 3n (enter)"}
speedwalkBot.paths["tocows"] = {" (enter) 4w e n w (push fence) 3n 3e (search reeds) (swim river) "}
speedwalkBot.paths["tod2"] = {" (enter) 4w e s w s 2e (grab joystick) 2s (play diablo 2)"}
speedwalkBot.paths["tohalo"] = {"(scaler 130) (enter) 4w e s w s 2e (grab joystick) w s (play halo)"}
speedwalkBot.paths["tojuggers"] = {" (enter) u 4n d n 13w 24n (nw) n "}
speedwalkBot.paths["toelf"] = {"(portal) 15e (leave) 4e ne 6e (path) (nw) n (ne) 2w n "}
speedwalkBot.paths["tosci"] = {"n 2e s 2e "}
speedwalkBot.paths["tochickens"] = {"(enter) u 4n d 9n 20e (enter) 2s (door) w s e (search urinal) (get keycard) w 3s (door) w (fill out application) (door) (give application to richard) n 4w n n (insert keycard) (door) (exa liquid)"}
speedwalkBot.paths["tohamiltonplant"] = {"(enter) u 4n d 26n 5e d (enter)"}
speedwalkBot.paths["totwilight"] = {"(eforest) 3w 2(sw) 2w (path) 2n 3w 3n (down) (smash east wall)"}
speedwalkBot.paths["toaliens"] = {"(enter) u 4n d 3n e (enter large truck)"}
speedwalkBot.paths["tocubes"] = {" d 6w (nw) w (nw) n e (nw) (ne) 5w 2(sw) 2e (se) e 2d"}
speedwalkBot.paths["todarkmoore"] = {" (enter) 3e 2s 2e n 8e 2n e 2n "}
speedwalkBot.paths["toicyblue"] = {" (portal) 12n (leave) 8n 4e 6n w 6n (portal) "}
speedwalkBot.paths["toarchmage"] = {" (portal) 12n (leave) 5n 10w (enter) (sit chair) (enter mirror) u"}
speedwalkBot.paths["toninjas"] = {" w 5s 2w (swim) w (paddle) (nw) (ne) (se) w (search south wall) (enter door)"}
speedwalkBot.paths["togeorge"] = {"n (nw) n (ne) n (nw) n (ne) n 10w s 4(sw) 6w (sw) s "}
speedwalkBot.paths["tosink1"] = {" (sw) s (sw) 4s (sw) s (sw) 3w 2n e (ne) 3n (sinkhole) (ne) "}
speedwalkBot.paths["tosink2"] = {" (sw) u 3s (sw) w (sw) 2s (sinkhole) s "}
speedwalkBot.paths["tosink3"] = {" n u (sw) e 3s (se) 3(sw) w (sw) w (sinkhole) (nw) "}
speedwalkBot.paths["tosink4"] = {" (se) u s 3e 3s 2e s (sinkhole) (se) "}
speedwalkBot.paths["tosink5"] = {" (nw) u 2n e 2n e (sinkhole) "}
speedwalkBot.paths["tofirebat"] = {"2e 2n 2w 3n 2w n 2w n"}
speedwalkBot.paths["tolasersword"] = {" (enter) u 4n d 11n 2e (enter) 2w s w (nw) "}
speedwalkBot.paths["totasset"] = {"(portal) 12n (leave) 10n 10w (nw) (sw) (se) (sw) n (inspect trunks) w n n (exa bench) (search bench) 2s 2e (recite teleuteiu;'recite teleisthai) (enter) "}
speedwalkBot.paths["torevelwood"] = {"w 2(nw) 3n e (nw) w n (nw) 4n 4w (ford) n (climb tree) 2u"}
speedwalkBot.paths["tospectres"] = {"w (nw) (nw) 3n 3e 2n 4e 4n (enter opening) e s (ne) e n e n (ne) 2e"}
speedwalkBot.paths["totaco"] = {" (scaler 91) (enter) 4w e n w 2n (taco)"}

function isSpeedwalk(value)
    if value:match("^(%d).*") then
      return true
    end
    return false
end

function mushclientspeedwalk(mushpath, backward)
   echo("\nGoing to "..walker_current_path.."\n" )
   for i,v in ipairs(mushpath) do
        if (isSpeedwalk(v)) then
           echo('i:'..i..' v:'..v.."\n" )
           speedwalk(v, backward)
        else
            send(v)
        end   
    end
end

