# SCUTER Penguins Manubot manuscript

This repository is the Manubot manuscript companion to [TaylorResearchLab/SCUTER-penguins](https://github.com/TaylorResearchLab/SCUTER-penguins).

## Project status

This manuscript is currently **pre-results**. The project question is:

> Among Palmer penguins, what is the relationship between flipper length and body mass, and how does that relationship change when species is taken into account?

Scientific results and conclusions will not be added until the supporting analysis has been completed, routed for SCUTER review, and accepted by the User.

The durable scientific record is maintained in the project Notion page:
https://app.notion.com/p/3d829187800880ae9cd0fb1c531f8eea

## Manubot

This repository is initialized from the current structure and build conventions of [`manubot/rootstock`](https://github.com/manubot/rootstock), with a project-specific minimal manuscript scaffold. GitHub Actions builds the manuscript from `content/` using the Manubot processing pipeline.

Primary manuscript source lives in `content/`. Generated files belong in Manubot's `output` and `gh-pages` branches and should not be edited manually.

## Related repository

Executable analysis, preserved input data, run evidence, and scientific outputs live in:
https://github.com/TaylorResearchLab/SCUTER-penguins
