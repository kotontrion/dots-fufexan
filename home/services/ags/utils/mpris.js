import { GLib, Icons, Utils } from "../imports.js";

export const mprisStateIcon = (status) => {
  const state = status == "Playing" ? "pause" : "play";
  return Icons.media[state];
};

export const MEDIA_CACHE_PATH = Utils.CACHE_DIR + "/media";
export const blurredPath = MEDIA_CACHE_PATH + "/blurred";

export const generateBackground = (cover_path) => {
  const url = cover_path;
  if (!url) return "";

  const makeBg = (bg) => `background: center/cover url('${bg}')`;

  const blurred = blurredPath +
    url.substring(MEDIA_CACHE_PATH.length);

  if (GLib.file_test(blurred, GLib.FileTest.EXISTS)) {
    return makeBg(blurred);
  }

  Utils.ensureDirectory(blurredPath);
  Utils.exec(`convert ${url} -blur 0x22 ${blurred}`);

  return makeBg(blurred);
};

export function lengthStr(length) {
  const min = Math.floor(length / 60);
  const sec = Math.floor(length % 60);
  const sec0 = sec < 10 ? "0" : "";
  return `${min}:${sec0}${sec}`;
}
