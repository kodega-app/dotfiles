local M = {}

-- Workspace structure (aligned with Obsidian workspaces)
M.workspaces = {
  { name = "inbox", path = "0-Inbox", desc = "Inbox - Quick capture" },
  { name = "projects", path = "1-Projects", desc = "Projects - Active work" },
  { name = "areas", path = "2-areas", desc = "Areas - Ongoing responsibilities" },
  { name = "resources", path = "3-resources", desc = "Resources - Reference materials" },
  { name = "archive", path = "4-archive", desc = "Archive - Completed items" },
}

-- PARA folder structure (for detailed selection)
M.folders = {
  { name = "0-Inbox", desc = "Inbox (unsorted)" },
  { name = "1-Projects", desc = "Projects Root" },
  { name = "1-Projects/active", desc = "Active Projects" },
  { name = "1-Projects/planning", desc = "Planning Projects" },
  { name = "2-areas", desc = "Areas Root" },
  { name = "2-areas/devops", desc = "DevOps Area" },
  { name = "2-areas/meetings", desc = "Meetings" },
  { name = "3-resources", desc = "Resources Root" },
  { name = "3-resources/learnings", desc = "Learnings" },
  { name = "3-resources/documentation", desc = "Documentation" },
  { name = "4-archive", desc = "Archive" },
}

-- Template options
M.templates = {
  { name = "project", desc = "Project Template" },
  { name = "meeting", desc = "Meeting Template" },
  { name = "runbook", desc = "Runbook Template" },
  { name = "learning", desc = "Learning Template" },
  { name = "weekly-review", desc = "Weekly Review Template" },
  { name = "quick-note", desc = "Quick Note Template" },
  { name = "daily-note", desc = "Daily Note Template" },
  { name = "none", desc = "No Template (blank)" },
}

-- Get obsidian client
M.get_client = function()
  local has_obsidian, obsidian = pcall(require, "obsidian")
  if not has_obsidian then
    vim.notify("Obsidian plugin not loaded", vim.log.levels.ERROR)
    return nil
  end

  local client = obsidian.get_client()
  if not client then
    vim.notify("Could not get Obsidian client", vim.log.levels.ERROR)
    return nil
  end

  return client
end

-- Generate filename for different note types
M.generate_filename = function(note_type, title)
  local date = os.date("%Y-%m-%d")
  local timestamp = os.date("%Y%m%d%H%M%S")

  local patterns = {
    project = function(t)
      return t:gsub(" ", "-"):lower()
    end,

    meeting = function(t)
      return date .. "-" .. t:gsub(" ", "-"):lower()
    end,

    runbook = function(t)
      return t:gsub(" ", "-"):lower()
    end,

    learning = function(t)
      return t:gsub(" ", "-"):lower()
    end,

    weekly = function(t)
      local week = os.date("%Y-W%W")
      return week .. "-weekly-review"
    end,

    quick = function(t)
      return timestamp .. "-" .. (t ~= "" and t:gsub(" ", "-"):lower() or "quick")
    end,

    none = function(t)
      return t:gsub(" ", "-"):lower()
    end,
  }

  return patterns[note_type] and patterns[note_type](title) or title:gsub(" ", "-"):lower()
end

-- Get default folder for note type
M.get_default_folder = function(note_type)
  local defaults = {
    project = "1-Projects/active",
    meeting = "2-areas/meetings",
    runbook = "3-resources/runbooks",
    learning = "3-resources/learnings",
    weekly = "2-areas",
    quick = "0-Inbox",
    none = "0-Inbox",
  }

  return defaults[note_type] or "0-Inbox"
end

-- Create a new note by creating the file directly
M.create_note = function(folder, filename, title)
  local client = M.get_client()
  if not client then
    return false
  end

  -- Get vault path
  local vault_path = client.dir.filename

  -- Create full directory path
  local dir_path = vault_path .. "/" .. folder

  -- Create directory if it doesn't exist
  vim.fn.mkdir(dir_path, "p")

  -- Create full file path
  local file_path = dir_path .. "/" .. filename .. ".md"

  -- Check if file already exists
  if vim.fn.filereadable(file_path) == 1 then
    vim.notify("File already exists: " .. filename, vim.log.levels.WARN)
    vim.cmd("edit " .. file_path)
    return true
  end

  -- Create the file with basic frontmatter
  local frontmatter = {
    "---",
    "title: " .. title,
    "created: " .. os.date("%Y-%m-%d"),
    "tags: []",
    "---",
    "",
    "# " .. title,
    "",
  }

  -- Write file
  local file = io.open(file_path, "w")
  if file then
    file:write(table.concat(frontmatter, "\n"))
    file:close()

    -- Open the file
    vim.cmd("edit " .. file_path)

    -- Move cursor to end of file
    vim.cmd("normal! G")

    return true
  else
    vim.notify("Failed to create file: " .. file_path, vim.log.levels.ERROR)
    return false
  end
end

-- Apply template to current buffer
M.apply_template = function(template_name)
  -- Use vim command to apply template
  vim.defer_fn(function()
    local success, err = pcall(vim.cmd, "ObsidianTemplate " .. template_name)
    if not success then
      vim.notify("Failed to apply template: " .. tostring(err), vim.log.levels.ERROR)
    end
  end, 100)
end

-- Create note with workspace selection first, then template
M.create_note_with_workspace_selection = function()
  -- Select workspace
  vim.ui.select(M.workspaces, {
    prompt = "Select workspace:",
    format_item = function(item)
      return item.desc
    end,
  }, function(workspace_choice)
    if not workspace_choice then
      return
    end

    -- Select template
    vim.ui.select(M.templates, {
      prompt = "Select template:",
      format_item = function(item)
        return item.desc
      end,
    }, function(template_choice)
      if not template_choice then
        return
      end

      -- Get note title
      vim.schedule(function()
        local title = vim.fn.input("Note title: ")
        if title == "" then
          vim.notify("Note creation cancelled", vim.log.levels.WARN)
          return
        end

        -- Generate filename
        local filename = M.generate_filename(template_choice.name, title)

        -- Create note in workspace path
        local success = M.create_note(workspace_choice.path, filename, title)

        -- Apply template if selected and note was created successfully
        if success and template_choice.name ~= "none" then
          M.apply_template(template_choice.name)
        end
      end)
    end)
  end)
end

-- Create note with folder selection using vim.ui.select (legacy, detailed selection)
M.create_note_with_folder_selection = function()
  -- Select folder
  vim.ui.select(M.folders, {
    prompt = "Select folder:",
    format_item = function(item)
      return item.desc .. " (" .. item.name .. ")"
    end,
  }, function(folder_choice)
    if not folder_choice then
      return
    end

    -- Select template
    vim.ui.select(M.templates, {
      prompt = "Select template:",
      format_item = function(item)
        return item.desc
      end,
    }, function(template_choice)
      if not template_choice then
        return
      end

      -- Get note title
      vim.schedule(function()
        local title = vim.fn.input("Note title: ")
        if title == "" then
          vim.notify("Note creation cancelled", vim.log.levels.WARN)
          return
        end

        -- Generate filename
        local filename = M.generate_filename(template_choice.name, title)

        -- Create note
        local success = M.create_note(folder_choice.name, filename, title)

        -- Apply template if selected and note was created successfully
        if success and template_choice.name ~= "none" then
          M.apply_template(template_choice.name)
        end
      end)
    end)
  end)
end

-- Create note with template (predefined folder)
M.create_note_with_template = function(note_type)
  local template_map = {
    project = "project",
    meeting = "meeting",
    runbook = "runbook",
    learning = "learning",
    weekly = "weekly-review",
  }

  local template_name = template_map[note_type]
  if not template_name then
    vim.notify("Invalid note type: " .. note_type, vim.log.levels.ERROR)
    return
  end

  -- Get note title
  local prompt = note_type:gsub("^%l", string.upper) .. " title: "
  local title = vim.fn.input(prompt)

  if title == "" then
    vim.notify("Note creation cancelled", vim.log.levels.WARN)
    return
  end

  -- Generate filename with default folder
  local filename = M.generate_filename(note_type, title)
  local folder = M.get_default_folder(note_type)

  -- Create note
  local success = M.create_note(folder, filename, title)

  -- Apply template if note was created successfully
  if success then
    M.apply_template(template_name)
  end
end

-- Quick capture
M.quick_capture = function()
  local timestamp = os.date("%Y%m%d%H%M%S")
  local filename = timestamp .. "-quick"

  -- Create note
  local success = M.create_note("0-Inbox", filename, "Quick Note")

  -- Apply template if note was created successfully
  if success then
    M.apply_template("quick-note")
  end
end

return M
