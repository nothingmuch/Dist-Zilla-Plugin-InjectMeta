package Dist::Zilla::Plugin::InjectMeta;
use Moose;

use namespace::autoclean;

has metadata => (
    isa => "HashRef",
    is  => "ro",
    required => 1,
);

with qw(Dist::Zilla::Role::MetaProvider);

sub BUILDARGS {
    my ( $self, @args ) = @_;

    my $meta = $self->SUPER::BUILDARGS(@args);

    my %args;

    foreach my $attr ( $self->meta->get_all_attributes ) {
        my $arg = $attr->init_arg or next;
        $args{$arg} = delete $meta->{$arg} if exists $meta->{$arg};
    }

    $args{metadata} ||= $meta;

    return \%args;
}

__PACKAGE__->meta->make_immutable;

__PACKAGE__

__END__


# ex: set sw=4 et:
