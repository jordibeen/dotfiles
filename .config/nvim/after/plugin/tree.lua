-- File Tree
require("neo-tree").setup({
    buffers = {
        follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
        },
    },

    filesystem = {
        filtered_items = {
            always_show = {
                ".gitignore",
                ".env",
                ".github",
                ".test.yaml",
                ".production.yaml",
                "terraform.tfvars",
            }
        }
    }
})