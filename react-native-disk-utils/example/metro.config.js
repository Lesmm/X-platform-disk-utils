// metro.config.js
//
// with multiple workarounds for this issue with symlinks:
// https://github.com/facebook/metro/issues/1
//
// with thanks to @johnryan (<https://github.com/johnryan>)
// for the pointers to multiple workaround solutions here:
// https://github.com/facebook/metro/issues/1#issuecomment-541642857
//
// see also this discussion:
// https://github.com/brodybits/create-react-native-module/issues/232

// ************ original workaround ************
// const path = require('path')

// module.exports = {
//   // workaround for an issue with symlinks encountered starting with
//   // metro@0.55 / React Native 0.61
//   // (not needed with React Native 0.60 / metro@0.54)
//   resolver: {
//     extraNodeModules: new Proxy(
//       {},
//       { get: (_, name) => path.resolve('.', 'node_modules', name) }
//     )
//   },

//   // quick workaround for another issue with symlinks
//   watchFolders: [path.resolve('.'), path.resolve('..')]
// }




/**
error: Error: Unable to resolve module missing-asset-registry-path from example/node_modules/react-native/Libraries/LogBox/UI/LogBoxImages/chevron-left.png: missing-asset-registry-path could not be found within the project or in these directories:
  node_modules/react-native/node_modules
  node_modules
  example/node_modules/missing-asset-registry-path
> 1 | �PNG
 */



// ************ the workaround finally worked ************
// https://github.com/facebook/react-native/issues/38282
const { getDefaultConfig, mergeConfig } = require('@react-native/metro-config')
const path = require('path')
const escape = require('escape-string-regexp')
const exclusionList = require('metro-config/src/defaults/exclusionList')
const pak = require('../package.json')

const root = path.resolve(__dirname, '..')
const modules = Object.keys({ ...pak.peerDependencies })

/**
 * Metro configuration
 * https://facebook.github.io/metro/docs/configuration
 *
 * @type {import('metro-config').MetroConfig}
 */
const config = {
  watchFolders: [root],

  // We need to make sure that only one version is loaded for peerDependencies
  // So we block them at the root, and alias them to the versions in example's node_modules
  resolver: {
    blacklistRE: exclusionList(
      modules.map(
        (m) =>
          new RegExp(`^${escape(path.join(root, 'node_modules', m))}\\/.*$`)
      )
    ),

    extraNodeModules: modules.reduce((acc, name) => {
      acc[name] = path.join(__dirname, 'node_modules', name)
      return acc
    }, {}),
  },

  transformer: {
    getTransformOptions: async () => ({
      transform: {
        experimentalImportSupport: false,
        inlineRequires: true,
      },
    }),
  },
}

module.exports = mergeConfig(getDefaultConfig(__dirname), config)

