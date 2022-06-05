     xz-menu - example
	
    local items = {
        {
            title = "Your title",
            description= "your description",
            event = "event",
            eventType = "client",
            args = "",
            close = true,
            func = function()
                return true;
            end
        },
        {
            title = "Your title",
            description = "your description",
            sub_menu = {
                {
                    title = "Your title",
                    description= "your description",
                    event = "event",
                    eventType = "client",
                    args = "",
                    close = true,
                    func = function()
                        return true;
                    end
                },
            }
        }
    }
    exports["xz-menu"]:openMenu(items);