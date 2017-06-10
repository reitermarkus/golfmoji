require "./golfmoji/*"

module Golfmoji

end

#p Golfmoji.exec(Golfmoji.load_source || ['⛳'])

p Golfmoji.exec_chain(["3️⃣", "➕", "🔟", "➗", "🔟"]);

p Golfmoji.exec_chain(["⛳", "✖", "2️⃣"]);

p Golfmoji.exec_chain(["⛳", "💥"]);

p Golfmoji.exec([["⛳", "💥"], ["🔗", "➿", "🔗"]]);
