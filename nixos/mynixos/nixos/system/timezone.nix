{ ... }: let
  timezone = "Europe/Helsinki";
in {
  # Set your time zone.
  time.timeZone = "${timezone}";
}
