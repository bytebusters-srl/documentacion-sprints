# Configuración global de compilación para LaTeX (Memoria P.D.S. - ISO 26515)

# 1. Enviar toda la salida a la carpeta build/
$out_dir = 'build';

# 1b. Espejar la estructura de sections/ dentro de build/ ANTES de compilar.
# Sin esto, pdflatex con -output-directory no encuentra los subdirectorios
# build/sections/* y \include falla con "I can't write on file ...aux".
# Rutas EXPLÍCITAS (idempotentes): make_path no falla si ya existen.
use File::Path qw(make_path);
foreach my $sub (qw(
    front anexos 07_conclusiones
    01_doc-sprint0 02_doc-sprint1 03_doc-sprint2
    04_doc-sprint3 05_doc-sprint4 06_doc-sprint5
)) {
    make_path("$out_dir/sections/$sub");
}

# 2. Forzar la compilación en PDF
$pdf_mode = 1;

# 2b. Más pasadas: lastpage/toc/referencias cruzadas requieren iteraciones extra
# para estabilizar la paginación y \pageref{LastPage}.
$max_repeat = 7;

# 3. Wrapper de pdflatex que normaliza el código de salida: si el PDF se
# escribió ("Output written on"), un "Rerun" pendiente NO se considera fallo.
$pdflatex = 'internal mypdflatex %O %S';
sub mypdflatex {
    my @args = @_;
    my $ret = system('pdflatex', '-interaction=nonstopmode',
                     '-synctex=1', '-shell-escape', @args);
    my $base = $args[-1];
    $base =~ s/\.tex$//;
    $base =~ s{.*/}{};
    my $log = "$out_dir/$base.log";
    if ($ret != 0 && -e $log) {
        open(my $fh, '<', $log) or return $ret;
        local $/; my $content = <$fh>; close($fh);
        return 0 if $content =~ /Output written on/;
    }
    return $ret;
}

# 4. Extensiones a limpiar
$clean_ext = 'aux out log toc bbl blg synctex.gz fls fdb_latexmk vrb snm nav run.xml bcf pyg _minted*';
