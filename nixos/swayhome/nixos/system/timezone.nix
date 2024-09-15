{ ... }: let
  timezone = "Asia/Makassar";
in {
  # Set your time zone.
  time.timeZone = "${timezone}";
}
