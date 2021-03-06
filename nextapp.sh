#!/bin/bash

# Create a React app:
echo -e "\n\n++ Running create-next-app...\n\n"
npx create-next-app@latest $1
cd $1

# Remove default built-in files:
rm README.md
touch README.md
rm pages/api/*
rm public/*
rm styles/*
mkdir hooks
mkdir redux
mkdir components

# Add base components
nextbasecmps.sh

# Install dependencies:
echo -e "\n\n++ Installing dependencies...\n\n"
yarn add --dev typescript @types/react @types/node
touch tsconfig.json
yarn add sass redux react-redux next-redux-wrapper
yarn add @fortawesome/fontawesome-free

# Configure next.js and TypeScript:
echo -e "{
  \"compilerOptions\": {
    \"baseUrl\": \".\"
  }
}" > tsconfig.json

echo -e "module.exports = {
  i18n: {
    locales: ['en'],
    defaultLocale: 'en'
  }
};" > next.config.js

echo -e "\n++ Finished installing. Adding finishing touches..."

# Replace default pages:
rm -f pages/index.js

echo "import React from 'react';
import TextBox from 'components/inputs/TextBox';
import Layout from 'components/layouts/Layout';

const Home = () => (
  <Layout>
    <TextBox
      label=\"Label\"
      autocomplete={['Dog', 'Cat', 'Dragon', 'Lion']}
    />
  </Layout>
);

export default Home;" > pages/index.tsx

# Create base styles:
echo "@import './global.scss';

*, *::before, *::after {
  box-sizing: inherit;
}

html {
  box-sizing: border-box;
  background-color: \$clr-bg;
}

html, body {
  height: 100%;
  margin: 0;
  font-size: \$fs;
  font-size: \$fs;
  font-weight: \$fw;
  font-family: \$ff;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

body {
  padding: 0 \$pad-dbl;
}

@media (min-width: \$tablet) {
  body {
    padding: 0 \$pad-xl;
  }
}

#__next {
  height: 100vh;
  display: flex;
  flex-direction: column;
}

code {
  font-family:
    source-code-pro,
    Menlo,
    Monaco,
    Consolas,
    \"Courier New\",
    monospace;
}" > styles/index.scss

echo "@import url('https://fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,500i,600,600i,700,700i&display=swap');
@import './colors.scss';

\$clr-bg: \$clr-gray-xl;
\$clr-accent: \$clr-blue;
\$clr-accent-l: \$clr-blue-l;
\$clr-accent-d: \$clr-blue-d;
\$clr-accent-xd: \$clr-blue-xd;

\$border-radius-s: 10px;
\$border-radius: 20px;

\$pad-xs: 6px;
\$pad-s: 8px;
\$pad-half: 10px;
\$pad-ms: 14px;
\$pad: 20px;
\$pad-ml: 30px;
\$pad-dbl: 40px;
\$pad-l: 48px;
\$pad-xl: 60px;

\$ff:
  \"Montserrat\",
  -apple-system,
  BlinkMacSystemFont,
  \"Segoe UI\",
  \"Roboto\",
  \"Oxygen\",
  \"Ubuntu\", 
  \"Cantarell\",
  \"Fira Sans\",
  \"Droid Sans\",
  \"Helvetica Neue\",
  sans-serif;

\$fs: 16px;
\$fs-s: 14px;
\$fs-l: 18px;
\$fs-xl: 20px;
\$fs-xxl: 24px;

\$fw: 400;
\$fw-m: 500;
\$fw-sb: 600;
\$fw-b: 700;
\$fw-xb: 800;
\$fw-l: 300;
\$fw-xl: 200;
\$fw-thin: 100;

\$tablet: 720px;
\$desktop: 1080px;" > styles/global.scss

echo "import '../styles/index.scss';
import '../styles/global.scss';
import '@fortawesome/fontawesome-free/js/fontawesome';
import '@fortawesome/fontawesome-free/js/solid';
import wrapper from '../redux/store';

const App = ({ Component, pageProps, store }) => {
  return <Component {...pageProps} />;
}

App.getInitialProps = async ({Component, ctx}) => {
  return {
    pageProps: {
      ...(
        Component.getInitialProps ?
        await Component.getInitialProps(ctx) :
        {}
      )
    }
  };
};

export default wrapper.withRedux(App);" > pages/_app.js

echo "@import './material.scss';

\$clr-white: rgba(255, 255, 255, 1);
\$clr-black: rgba(0, 0, 0, 1);

\$clr-gray-xxl: \$clr-material-gray-50;
\$clr-gray-xl: \$clr-material-gray-100;
\$clr-gray-l: \$clr-material-gray-200;
\$clr-gray: \$clr-material-gray-300;
\$clr-gray-ml: \$clr-material-gray-400;
\$clr-gray-md: \$clr-material-gray-600;
\$clr-gray-d: \$clr-material-gray-700;
\$clr-gray-xd: \$clr-material-gray-800;
\$clr-gray-xxd: \$clr-material-gray-900;

\$clr-red: \$clr-material-red-600;
\$clr-red-l: \$clr-material-red-500;
\$clr-red-xl: \$clr-material-red-400;
\$clr-red-d: \$clr-material-red-700;
\$clr-red-xd: \$clr-material-red-800;

\$clr-green: \$clr-material-green-600;
\$clr-green-l: \$clr-material-green-500;
\$clr-green-xl: \$clr-material-green-400;
\$clr-green-d: \$clr-material-green-700;
\$clr-green-xd: \$clr-material-green-800;

\$clr-blue: \$clr-material-blue-600;
\$clr-blue-l: \$clr-material-blue-500;
\$clr-blue-xl: \$clr-material-blue-400;
\$clr-blue-d: \$clr-material-blue-700;
\$clr-blue-xd: \$clr-material-blue-800;

\$clr-purple: \$clr-material-purple-600;
\$clr-purple-l: \$clr-material-purple-500;
\$clr-purple-xl: \$clr-material-purple-400;
\$clr-purple-d: \$clr-material-purple-700;
\$clr-purple-xd: \$clr-material-purple-800;

\$clr-yellow: \$clr-material-yellow-600;
\$clr-yellow-l: \$clr-material-yellow-500;
\$clr-yellow-xl: \$clr-material-yellow-400;
\$clr-yellow-d: \$clr-material-yellow-700;
\$clr-yellow-xd: \$clr-material-yellow-800;

\$clr-orange: \$clr-material-orange-600;
\$clr-orange-l: \$clr-material-orange-500;
\$clr-orange-xl: \$clr-material-orange-400;
\$clr-orange-d: \$clr-material-orange-700;
\$clr-orange-xd: \$clr-material-orange-800;

\$clr-brown: \$clr-material-brown-600;
\$clr-brown-l: \$clr-material-brown-500;
\$clr-brown-xl: \$clr-material-brown-400;
\$clr-brown-d: \$clr-material-brown-700;
\$clr-brown-xd: \$clr-material-brown-800;" > styles/colors.scss

echo "\$clr-material-gray-50: rgba(250, 250, 250, 1);
\$clr-material-gray-100: rgba(245, 245, 245, 1);
\$clr-material-gray-200: rgba(238, 238, 238, 1);
\$clr-material-gray-300: rgba(224, 224, 224, 1);
\$clr-material-gray-400: rgba(189, 189, 189, 1);
\$clr-material-gray-500: rgba(158, 158, 158, 1);
\$clr-material-gray-600: rgba(117, 117, 117, 1);
\$clr-material-gray-700: rgba(97, 97, 97, 1);
\$clr-material-gray-800: rgba(66, 66, 66, 1);
\$clr-material-gray-900: rgba(33, 33, 33, 1);

\$clr-material-red-300: rgba(229, 115, 115, 1);
\$clr-material-red-400: rgba(239, 83, 80, 1);
\$clr-material-red-500: rgba(244, 67, 54, 1);
\$clr-material-red-600: rgba(229, 57, 53, 1);
\$clr-material-red-700: rgba(211, 47, 47, 1);
\$clr-material-red-800: rgba(198, 40, 40, 1);
\$clr-material-red-900: rgba(183, 28, 28, 1);

\$clr-material-green-300: rgba(129, 199, 132, 1);
\$clr-material-green-400: rgba(102, 187, 106, 1);
\$clr-material-green-500: rgba(76, 175, 80, 1);
\$clr-material-green-600: rgba(67, 160, 71, 1);
\$clr-material-green-700: rgba(56, 142, 60, 1);
\$clr-material-green-800: rgba(46, 125, 50, 1);
\$clr-material-green-900: rgba(27, 94, 32, 1);

\$clr-material-blue-300: rgba(100, 181, 246, 1);
\$clr-material-blue-400: rgba(66, 165, 245, 1);
\$clr-material-blue-500: rgba(33, 150, 243, 1);
\$clr-material-blue-600: rgba(30, 136, 229, 1);
\$clr-material-blue-700: rgba(25, 118, 210, 1);
\$clr-material-blue-800: rgba(21, 101, 192, 1);
\$clr-material-blue-900: rgba(13, 71, 161, 1);

\$clr-material-purple-300: rgba(186, 104, 200, 1);
\$clr-material-purple-400: rgba(171, 71, 188, 1);
\$clr-material-purple-500: rgba(156, 39, 176, 1);
\$clr-material-purple-600: rgba(142, 36, 170, 1);
\$clr-material-purple-700: rgba(123, 31, 162, 1);
\$clr-material-purple-800: rgba(106, 27, 154, 1);
\$clr-material-purple-900: rgba(74, 20, 140, 1);

\$clr-material-yellow-300: rgba(255, 241, 118, 1);
\$clr-material-yellow-400: rgba(255, 238, 88, 1);
\$clr-material-yellow-500: rgba(255, 235, 59, 1);
\$clr-material-yellow-600: rgba(253, 216, 53, 1);
\$clr-material-yellow-700: rgba(251, 192, 45, 1);
\$clr-material-yellow-800: rgba(249, 168, 37, 1);
\$clr-material-yellow-900: rgba(245, 127, 23, 1);

\$clr-material-orange-300: rgba(255, 183, 77, 1);
\$clr-material-orange-400: rgba(255, 167, 38, 1);
\$clr-material-orange-500: rgba(255, 152, 0, 1);
\$clr-material-orange-600: rgba(251, 140, 0, 1);
\$clr-material-orange-700: rgba(245, 124, 0, 1);
\$clr-material-orange-800: rgba(239, 108, 0, 1);
\$clr-material-orange-900: rgba(230, 81, 0, 1);

\$clr-material-brown-300: rgba(161, 136, 127, 1);
\$clr-material-brown-400: rgba(141, 110, 99, 1);
\$clr-material-brown-500: rgba(121, 85, 72, 1);
\$clr-material-brown-600: rgba(109, 76, 65, 1);
\$clr-material-brown-700: rgba(93, 64, 55, 1);
\$clr-material-brown-800: rgba(78, 52, 46, 1);
\$clr-material-brown-900: rgba(62, 39, 35, 1);" > styles/material.scss

# Setup redux directory:
mkdir redux/actions
mkdir redux/reducers

echo "import { createStore } from 'redux';
import { createWrapper } from 'next-redux-wrapper';
import rootReducer from 'redux/reducers';

const makeStore = (context) => {
  const globalObject = (typeof window === 'undefined') ? globalThis : window;
  const devToolsExtension = (globalObject as any).__REDUX_DEVTOOLS_EXTENSION__;
  const preloadedState = {};
  return createStore(
    rootReducer,
    preloadedState,
    devToolsExtension && devToolsExtension()
  );
};

export default createWrapper(makeStore);" > redux/store.ts

echo "import { combineReducers } from 'redux';

const rootReducer = combineReducers({});

export default rootReducer;" > redux/reducers/index.ts

# Commit to git:
echo -e "** Creating initial git commit...\n"
git add -A
git commit -m "Initial commit"

echo -e "\n** Run \`npx next dev\` to start a dev server.\n"
code .
