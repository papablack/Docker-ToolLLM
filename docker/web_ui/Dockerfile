# Use the slim image of Node.js 16
FROM node:16-alpine

COPY ./entrypoint.sh /var/entrypoint.sh
COPY ./install.sh /var/install.sh

COPY ui_scripts.json /var/llm_ui_scripts.json
COPY fix_ui.js /var/fix_llm_ui.js

RUN chmod +x /var/fix_llm_ui.js
RUN chmod +x /var/entrypoint.sh
RUN chmod +x /var/install.sh

RUN dos2unix /var/install.sh
RUN dos2unix /var/entrypoint.sh

ENTRYPOINT ["/var/entrypoint.sh"]
