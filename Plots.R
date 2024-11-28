# Bibliotheken laden
library(ggplot2)
library(patchwork)
library(ggrepel)
library(svglite)

# Sample data including Total counts
data <- data.frame(
  Group = c("COAD-READ", "KIRC", "KIRP", "HCC", "THCA", "BRCA", "OVCA", "UCEC", "PRAD"),
  Count = c(55, 53, 23, 4, 50, 123, 1, 22, 108),
  Total = c(462, 519, 301, 264, 516, 1113, 108, 183, 329)
)

# Calculate the Percentage column
data$Percentage <- (data$Count / data$Total) * 100
mean_percentage <- mean(data$Percentage)

# Daten für beide Gruppen (Boxplot 1)
data2 <- data.frame(
  Group = rep(c("Cases with at least \n one marked slide", "Marked slides \n of all slides"), each = 5),
  Percentage = c(40, 36, 20.43, 20.00, 34.00, 22.00, 15.40, 17.00, 19.21, 17.05)
)

# Daten für den zweiten Boxplot (Boxplot 2)
data3 <- data.frame(
  Group = rep(c("Readable Text", "Marked Regions"), each = 5),
  Percentage = c(62.10, 59.09, 78.23, 56.12,77.30, 42.9, 53.79, 35.29, 43.88,48.65)
)


# --- Scatterplot ---
plot1 <- ggplot(data, aes(y = Percentage, x = Total)) +
  geom_point(color = "#E69F00", size = 5) +
  geom_text_repel(aes(label = paste(Group, sprintf("(%.1f%%)", Percentage))), 
                  size = 3, box.padding = 1.5, point.padding = 0,
                  nudge_x = 0, nudge_y = 2.5, segment.size=0.25) +
  labs(y = "Percentage with marks [%]", x = "Total slides evaluated") +
  theme_bw() +
  theme(legend.position = "none", plot.title = element_blank())

# --- Boxplot 1 ---
plot2 <- ggplot(data2, aes(x = Group, y = Percentage, fill = Group)) +
  geom_boxplot(outlier.shape = NA, alpha = 0.7, width = 0.5) + # Boxplot schmal beibehalten
  geom_jitter(aes(color = Group), width = 0.2, size = 2, alpha = 0.7) +
  scale_color_manual(values = c("#E69F00", "#56B4E9")) +
  scale_fill_manual(values = c("#E69F00", "#56B4E9")) +
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, by = 10)) +
  labs(y = "Percentage [%]", x = "Groups") +
  theme_bw() +
  theme(
    legend.position = "none",
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
    plot.title = element_blank()
  )

# --- Boxplot 2 ---
plot3 <- ggplot(data3, aes(x = Group, y = Percentage, fill = Group)) +
  geom_boxplot(outlier.shape = NA, alpha = 0.7, width = 0.5) + # Boxplot schmal beibehalten
  geom_jitter(aes(color = Group), width = 0.2, size = 2, alpha = 0.7) +
  scale_color_manual(values = c("#009E73", "#D55E00")) +
  scale_fill_manual(values = c("#009E73", "#D55E00")) +
  scale_y_continuous(limits = c(20, 80), breaks = seq(20, 80, by = 10)) +
  labs(y = "Percentage [%]", x = "Groups") +
  theme_bw() +
  theme(
    legend.position = "none",
    axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
    plot.title = element_blank()
  )

# --- Kombinierte Darstellung mit breiteren Plots ---
combined_plot <- plot1 + plot2 + plot3 + 
  plot_layout(ncol = 3, widths = c(2, 1, 1)) # Scatterplot und Boxplots breiter

# Zeige die Plots an
combined_plot
