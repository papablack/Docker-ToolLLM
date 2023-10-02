# Use the slim image of Node.js 16
FROM node:16-alpine

COPY ui_scripts.json /var/llm_ui_scripts.json
COPY fix_ui.js /var/fix_llm_ui.js

RUN chmod +x /var/fix_llm_ui.js

ENTRYPOINT ["/var/entrypoint.sh"]
