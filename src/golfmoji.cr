require "./src/golfmoji/*"

module Golfmoji

end

p Golfmoji.exec(Golfmoji.parse || [["⛳"]])

#p Golfmoji.exec_chain(["3️⃣", "➕", "🔟", "➗", "🔟"]);

#p Golfmoji.exec_chain(["⛳", "✖", "2️⃣"]);

#p Golfmoji.exec_chain(["⛳", "💥"]);

#p Golfmoji.exec([["⛳", "💥"], ["🔗", "➿", "🔗"]]);
