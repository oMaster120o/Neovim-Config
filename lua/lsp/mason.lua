local status_mason, mason = pcall(require, "mason")
if status_mason then
    mason.setup()
else
    print("Failed to load Mason")
end
