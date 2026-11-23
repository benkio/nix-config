import Carbon
import Darwin

let wanted = "com.apple.inputmethod.Kotoeri.RomajiTyping"
let sources = TISCreateInputSourceList(nil, true).takeRetainedValue() as! [TISInputSource]
guard let source = sources.first(where: { candidate in
  guard let ptr = TISGetInputSourceProperty(candidate, kTISPropertyInputSourceID) else { return false }
  return (Unmanaged<CFTypeRef>.fromOpaque(ptr).takeUnretainedValue() as? String) == wanted
}) else {
  fputs("Japanese - Romaji input source not found\n", stderr)
  exit(1)
}

if let ptr = TISGetInputSourceProperty(source, kTISPropertyInputSourceIsEnabled),
   let enabled = Unmanaged<CFTypeRef>.fromOpaque(ptr).takeUnretainedValue() as? Bool,
   enabled {
  print("Japanese - Romaji input source already enabled")
} else {
  let status = TISEnableInputSource(source)
  guard status == noErr else {
    fputs("Failed to enable Japanese - Romaji input source (status " + String(status) + ")\n", stderr)
    exit(1)
  }
  print("Enabled Japanese - Romaji input source")
}
