Summary: RouteUpdate
Name: RouteUpdate
Version: 0.5.1
Release: 1
License: Arista Networks
Group: EOS/Extension
Source0: %{name}-%{version}-%{release}.tar
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}.tar
BuildArch: noarch

%description
This EOS SDK script will monitor IP Routes and update Linux Kernel Routes.

%prep
%setup -q -n source

%build

%install
mkdir -p $RPM_BUILD_ROOT/usr/bin
cp RouteUpdate $RPM_BUILD_ROOT/usr/bin/

%files
%defattr(-,root,root,-)
/usr/bin/RouteUpdate
%attr(0755,root,root) /usr/bin/RouteUpdate
