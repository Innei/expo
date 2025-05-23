import { getAssetByID } from '@react-native/assets-registry/registry';

import AssetSourceResolver, { ResolvedAssetSource } from './AssetSourceResolver';

let _customSourceTransformer: (resolver: AssetSourceResolver) => ResolvedAssetSource;

export function setCustomSourceTransformer(
  transformer: (resolver: AssetSourceResolver) => ResolvedAssetSource
): void {
  _customSourceTransformer = transformer;
}

interface resolveAssetSource {
  (source: any): ResolvedAssetSource | null;
  setCustomSourceTransformer(
    transformer: (resolver: AssetSourceResolver) => ResolvedAssetSource
  ): ResolvedAssetSource;
}

/**
 * `source` is either a number (opaque type returned by require('./foo.png'))
 * or an `ImageSource` like { uri: '<http location || file path>' }
 */
function resolveAssetSource(source: any): ResolvedAssetSource | null {
  if (typeof source === 'object') {
    return source;
  }

  const asset = getAssetByID(source);
  if (!asset) {
    return null;
  }

  const resolver = new AssetSourceResolver(
    // Doesn't matter since this is removed on web
    'https://expo.dev',
    null,
    asset
  );
  if (_customSourceTransformer) {
    return _customSourceTransformer(resolver);
  }
  return resolver.defaultAsset();
}

Object.defineProperty(resolveAssetSource, 'setCustomSourceTransformer', {
  get() {
    return setCustomSourceTransformer;
  },
});

export default resolveAssetSource as resolveAssetSource;

export const { pickScale } = AssetSourceResolver;
