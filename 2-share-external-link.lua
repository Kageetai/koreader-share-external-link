-- Add Android's native share chooser to the external-link dialog.
-- Install in KOReader's patches directory, then restart KOReader.
-- Remove this file and restart KOReader to uninstall.

local Device = require("device")
if not Device:isAndroid() or not Device:canShareText() then
    return
end

local ReaderLink = require("apps/reader/modules/readerlink")
local UIManager = require("ui/uimanager")
local _ = require("gettext")

local original_init = ReaderLink.init
function ReaderLink:init(...)
    original_init(self, ...)

    self:addToExternalLinkDialog("15_android_share_link", function(this, link_url)
        return {
            text = _("Share"),
            callback = function()
                UIManager:close(this.external_link_dialog)
                -- Let KOReader finish handling the tap before Android takes focus.
                UIManager:nextTick(function()
                    Device:doShareText(link_url, _("Share link"), _("External link"), "text/plain")
                end)
            end,
        }
    end)
end
