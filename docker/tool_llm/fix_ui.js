const fs = require('fs');

const customScripts = JSON.parse(fs.readFileSync('/var/llm_ui_scripts.json', 'utf-8'));

const package = JSON.parse(fs.readFileSync('/llm_ui/package.json', 'utf-8'));
const newPackage = {...package}

newPackage.scripts = customScripts.scripts;

const content = JSON.stringify(newPackage, null, 2);

fs.writeFileSync('/llm_ui/package.json', content);

console.log('UI package customization is done.');