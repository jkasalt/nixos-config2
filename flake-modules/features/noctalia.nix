{inputs, withSystem, ...}:
{
  perSystem = {...}: {
    packages.noctaliaShell = inputs.wrapper-modules.wrappers
  };
}
