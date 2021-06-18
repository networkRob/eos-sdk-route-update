Summary: RouteUpdate
Name: RouteUpdate
Version: 0.1.0
Release: 1
License: Arista Networks
Group: EOS/Extension
Source0: %{name}-%{version}-%{release}.tar
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}.tar
BuildArch: i386

%description
This EOS SDK script will monitor IP Routes and update Linux Kernel Routes.

%prep
%setup -q -n RouteUpdate

%build

%install
mkdir -p $RPM_BUILD_ROOT/usr/bin
mkdir -p $RPM_BUILD_ROOT/usr/lib/SysdbMountProfiles
cp RouteUpdate.mp $RPM_BUILD_ROOT/usr/lib/SysdbMountProfiles/RouteUpdate
cp RouteUpdate $RPM_BUILD_ROOT/usr/bin/

%files
%defattr(-,root,root,-)
/usr/bin/RouteUpdate
/usr/lib/SysdbMountProfiles/RouteUpdate
%attr(0755,root,root) /usr/bin/RouteUpdate
