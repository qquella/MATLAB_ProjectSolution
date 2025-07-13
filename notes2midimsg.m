function msgs=notes2midimsg(tok,q,vel)
if nargin<2, q=4; end
if nargin<3, vel=80; end
d=q;
msgs=midimsg.empty;
dt=0;
for i=1:numel(tok)
    if tok(i)<=128
        msgs(end+1)=midimsg('note',1,'Note',tok(i)-1,'Velocity',vel,'Delta',dt);
        msgs(end+1)=midimsg('note',1,'Note',tok(i)-1,'Velocity',0,'Delta',d);
        dt=0;
    else
        dt=dt+d;
    end
end
msgs(end).Delta=0;
end
