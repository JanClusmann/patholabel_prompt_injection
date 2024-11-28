# Load libraries
library(maps)
library(ggplot2)

# Get Germany map data
germany_map <- map_data("world", region = "Germany")

# Define cities to highlight (excluding Dresden)
cities <- data.frame(
  city = c("Augsburg", "Mainz", "Erlangen", "Marburg", "Kiel"),
  lon = c(10.8978, 8.2473, 11.0039, 8.7668, 10.1228),
  lat = c(48.3705, 49.9929, 49.5897, 50.8078, 54.3233)
)

# Plot the map
germany_map_plot <- ggplot() +
  geom_polygon(data = germany_map, aes(x = long, y = lat, group = group),
               fill = "white", color = "grey") +
  geom_point(data = cities, aes(x = lon, y = lat), 
             color = "#56B4E9", size = 5) + # Regular dots
  geom_text(data = cities, aes(x = lon, y = lat, label = city), 
            hjust = -0.3, vjust = 0.5, size = 5) + # Adjusted hjust for spacing
  labs(title = "Highlighted Cities in Germany",
       x = "Longitude", y = "Latitude") +
  coord_fixed(1.3) + # Fixes aspect ratio to prevent distortion
  theme_bw() +
  theme(
    axis.title = element_blank(),           # Removes axis titles
    axis.text = element_blank(),            # Removes axis text
    axis.ticks = element_blank(),           # Removes axis ticks
    panel.grid = element_blank(),           # Removes background grid
    legend.position = "none"                # Removes legend
  )

germany_map_plot

# Save the map as PDF and SVG
#ggsave("germany_map.pdf", plot = germany_map_plot, width = 4, height = 4, device = "pdf")
#ggsave("germany_map.svg", plot = germany_map_plot, width = 4, height = 4, device = "svg")
