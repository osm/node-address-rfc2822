@include "./folding_wsp.ne"

@{% var flatten = require('./flatten.js');
    function comment_combine (a, b) {
        if (a && b) {
            return '(' + a + ' ' + b + ')';
        }
        else if (a || b) {
            return a || b;
        }
        return;
    }
 %}

from -> mailbox_list {% id %} | address_list {% id %}

reply_to -> address_list {% id %}

sender -> mailbox {% id %} | address {% id %}

quoted_pair     ->   "\\" [!-~ \t] {% function (d) { return "\\" + d[1] } %}

qtext           ->   [!#-\[\]-~\xF8-\u02C1\u02C6-\u02D1\u02E0-\u02E4\u02EC\u02EE\u0345\u0370-\u0374\u0376\u0377\u037A-\u037D\u037F\u0386\u0388-\u038A\u038C\u038E-\u03A1\u03A3-\u03F5\u03F7-\u0481\u048A-\u052F\u0531-\u0556\u0559\u0561-\u0587\u05B0-\u05BD\u05BF\u05C1\u05C2\u05C4\u05C5\u05C7\u05D0-\u05EA\u05F0-\u05F2\u0610-\u061A\u0620-\u0657\u0659-\u065F\u066E-\u06D3\u06D5-\u06DC\u06E1-\u06E8\u06ED-\u06EF\u06FA-\u06FC\u06FF\u0710-\u073F\u074D-\u07B1\u07CA-\u07EA\u07F4\u07F5\u07FA\u0800-\u0817\u081A-\u082C\u0840-\u0858\u08A0-\u08B4\u08E3-\u08E9\u08F0-\u093B\u093D-\u094C\u094E-\u0950\u0955-\u0963\u0971-\u0983\u0985-\u098C\u098F\u0990\u0993-\u09A8\u09AA-\u09B0\u09B2\u09B6-\u09B9\u09BD-\u09C4\u09C7\u09C8\u09CB\u09CC\u09CE\u09D7\u09DC\u09DD\u09DF-\u09E3\u09F0\u09F1\u0A01-\u0A03\u0A05-\u0A0A\u0A0F\u0A10\u0A13-\u0A28\u0A2A-\u0A30\u0A32\u0A33\u0A35\u0A36\u0A38\u0A39\u0A3E-\u0A42\u0A47\u0A48\u0A4B\u0A4C\u0A51\u0A59-\u0A5C\u0A5E\u0A70-\u0A75\u0A81-\u0A83\u0A85-\u0A8D\u0A8F-\u0A91\u0A93-\u0AA8\u0AAA-\u0AB0\u0AB2\u0AB3\u0AB5-\u0AB9\u0ABD-\u0AC5\u0AC7-\u0AC9\u0ACB\u0ACC\u0AD0\u0AE0-\u0AE3\u0AF9\u0B01-\u0B03\u0B05-\u0B0C\u0B0F\u0B10\u0B13-\u0B28\u0B2A-\u0B30\u0B32\u0B33\u0B35-\u0B39\u0B3D-\u0B44\u0B47\u0B48\u0B4B\u0B4C\u0B56\u0B57\u0B5C\u0B5D\u0B5F-\u0B63\u0B71\u0B82\u0B83\u0B85-\u0B8A\u0B8E-\u0B90\u0B92-\u0B95\u0B99\u0B9A\u0B9C\u0B9E\u0B9F\u0BA3\u0BA4\u0BA8-\u0BAA\u0BAE-\u0BB9\u0BBE-\u0BC2\u0BC6-\u0BC8\u0BCA-\u0BCC\u0BD0\u0BD7\u0C00-\u0C03\u0C05-\u0C0C\u0C0E-\u0C10\u0C12-\u0C28\u0C2A-\u0C39\u0C3D-\u0C44\u0C46-\u0C48\u0C4A-\u0C4C\u0C55\u0C56\u0C58-\u0C5A\u0C60-\u0C63\u0C81-\u0C83\u0C85-\u0C8C\u0C8E-\u0C90\u0C92-\u0CA8\u0CAA-\u0CB3\u0CB5-\u0CB9\u0CBD-\u0CC4\u0CC6-\u0CC8\u0CCA-\u0CCC\u0CD5\u0CD6\u0CDE\u0CE0-\u0CE3\u0CF1\u0CF2\u0D01-\u0D03\u0D05-\u0D0C\u0D0E-\u0D10\u0D12-\u0D3A\u0D3D-\u0D44\u0D46-\u0D48\u0D4A-\u0D4C\u0D4E\u0D57\u0D5F-\u0D63\u0D7A-\u0D7F\u0D82\u0D83\u0D85-\u0D96\u0D9A-\u0DB1\u0DB3-\u0DBB\u0DBD\u0DC0-\u0DC6\u0DCF-\u0DD4\u0DD6\u0DD8-\u0DDF\u0DF2\u0DF3\u0E01-\u0E3A\u0E40-\u0E46\u0E4D\u0E81\u0E82\u0E84\u0E87\u0E88\u0E8A\u0E8D\u0E94-\u0E97\u0E99-\u0E9F\u0EA1-\u0EA3\u0EA5\u0EA7\u0EAA\u0EAB\u0EAD-\u0EB9\u0EBB-\u0EBD\u0EC0-\u0EC4\u0EC6\u0ECD\u0EDC-\u0EDF\u0F00\u0F40-\u0F47\u0F49-\u0F6C\u0F71-\u0F81\u0F88-\u0F97\u0F99-\u0FBC\u1000-\u1036\u1038\u103B-\u103F\u1050-\u1062\u1065-\u1068\u106E-\u1086\u108E\u109C\u109D\u10A0-\u10C5\u10C7\u10CD\u10D0-\u10FA\u10FC-\u1248\u124A-\u124D\u1250-\u1256\u1258\u125A-\u125D\u1260-\u1288\u128A-\u128D\u1290-\u12B0\u12B2-\u12B5\u12B8-\u12BE\u12C0\u12C2-\u12C5\u12C8-\u12D6\u12D8-\u1310\u1312-\u1315\u1318-\u135A\u135F\u1380-\u138F\u13A0-\u13F5\u13F8-\u13FD\u1401-\u166C\u166F-\u167F\u1681-\u169A\u16A0-\u16EA\u16EE-\u16F8\u1700-\u170C\u170E-\u1713\u1720-\u1733\u1740-\u1753\u1760-\u176C\u176E-\u1770\u1772\u1773\u1780-\u17B3\u17B6-\u17C8\u17D7\u17DC\u1820-\u1877\u1880-\u18AA\u18B0-\u18F5\u1900-\u191E\u1920-\u192B\u1930-\u1938\u1950-\u196D\u1970-\u1974\u1980-\u19AB\u19B0-\u19C9\u1A00-\u1A1B\u1A20-\u1A5E\u1A61-\u1A74\u1AA7\u1B00-\u1B33\u1B35-\u1B43\u1B45-\u1B4B\u1B80-\u1BA9\u1BAC-\u1BAF\u1BBA-\u1BE5\u1BE7-\u1BF1\u1C00-\u1C35\u1C4D-\u1C4F\u1C5A-\u1C7D\u1CE9-\u1CEC\u1CEE-\u1CF3\u1CF5\u1CF6\u1D00-\u1DBF\u1DE7-\u1DF4\u1E00-\u1F15\u1F18-\u1F1D\u1F20-\u1F45\u1F48-\u1F4D\u1F50-\u1F57\u1F59\u1F5B\u1F5D\u1F5F-\u1F7D\u1F80-\u1FB4\u1FB6-\u1FBC\u1FBE\u1FC2-\u1FC4\u1FC6-\u1FCC\u1FD0-\u1FD3\u1FD6-\u1FDB\u1FE0-\u1FEC\u1FF2-\u1FF4\u1FF6-\u1FFC\u2071\u207F\u2090-\u209C\u2102\u2107\u210A-\u2113\u2115\u2119-\u211D\u2124\u2126\u2128\u212A-\u212D\u212F-\u2139\u213C-\u213F\u2145-\u2149\u214E\u2160-\u2188\u24B6-\u24E9\u2C00-\u2C2E\u2C30-\u2C5E\u2C60-\u2CE4\u2CEB-\u2CEE\u2CF2\u2CF3\u2D00-\u2D25\u2D27\u2D2D\u2D30-\u2D67\u2D6F\u2D80-\u2D96\u2DA0-\u2DA6\u2DA8-\u2DAE\u2DB0-\u2DB6\u2DB8-\u2DBE\u2DC0-\u2DC6\u2DC8-\u2DCE\u2DD0-\u2DD6\u2DD8-\u2DDE\u2DE0-\u2DFF\u2E2F\u3005-\u3007\u3021-\u3029\u3031-\u3035\u3038-\u303C\u3041-\u3096\u309D-\u309F\u30A1-\u30FA\u30FC-\u30FF\u3105-\u312D\u3131-\u318E\u31A0-\u31BA\u31F0-\u31FF\u3400-\u4DB5\u4E00-\u9FD5\uA000-\uA48C\uA4D0-\uA4FD\uA500-\uA60C\uA610-\uA61F\uA62A\uA62B\uA640-\uA66E\uA674-\uA67B\uA67F-\uA6EF\uA717-\uA71F\uA722-\uA788\uA78B-\uA7AD\uA7B0-\uA7B7\uA7F7-\uA801\uA803-\uA805\uA807-\uA80A\uA80C-\uA827\uA840-\uA873\uA880-\uA8C3\uA8F2-\uA8F7\uA8FB\uA8FD\uA90A-\uA92A\uA930-\uA952\uA960-\uA97C\uA980-\uA9B2\uA9B4-\uA9BF\uA9CF\uA9E0-\uA9E4\uA9E6-\uA9EF\uA9FA-\uA9FE\uAA00-\uAA36\uAA40-\uAA4D\uAA60-\uAA76\uAA7A\uAA7E-\uAABE\uAAC0\uAAC2\uAADB-\uAADD\uAAE0-\uAAEF\uAAF2-\uAAF5\uAB01-\uAB06\uAB09-\uAB0E\uAB11-\uAB16\uAB20-\uAB26\uAB28-\uAB2E\uAB30-\uAB5A\uAB5C-\uAB65\uAB70-\uABEA\uAC00-\uD7A3\uD7B0-\uD7C6\uD7CB-\uD7FB\uF900-\uFA6D\uFA70-\uFAD9\uFB00-\uFB06\uFB13-\uFB17\uFB1D-\uFB28\uFB2A-\uFB36\uFB38-\uFB3C\uFB3E\uFB40\uFB41\uFB43\uFB44\uFB46-\uFBB1\uFBD3-\uFD3D\uFD50-\uFD8F\uFD92-\uFDC7\uFDF0-\uFDFB\uFE70-\uFE74\uFE76-\uFEFC\uFF21-\uFF3A\uFF41-\uFF5A\uFF66-\uFFBE\uFFC2-\uFFC7\uFFCA-\uFFCF\uFFD2-\uFFD7\uFFDA-\uFFDC]:+ {% function (d,l,r) {
    var out = flatten.str(d);
    if (/\\/.test(out)) return r;
    // console.log("QT:" +out);
    return out;
} %}

qcontent        ->   (qtext | quoted_pair)  {% function (d,l,r) {
    var out = flatten.str(d);
    if (/"/.test(out)) return r;
    // console.log("QC:" +out);
    return out;
} %}

quoted_string   ->   CFWS:? "\"" (FWS:? qcontent):* FWS:? "\"" CFWS:? {% function (d,l,r) {
    var contents = d[2];
    return flatten.str(contents) + (d[3] && d[3][0] == " " ? " " : "");
} %}

atom            ->  CFWS:? [a-zA-Z0-9!#$%&'*+\-\/=?^_`{|}~]:+ CFWS:? {% function (d) { return d[1].join("") } %}

dot_atom_text   ->  [a-zA-Z0-9!#$%&'*+\-\/=?^_`{|}~]:+ ("." [a-zA-Z0-9!#$%&'*+\-\/=?^_`{|}~]:+):* {% function (d) {
    return flatten.str(d);
} %}

dot_atom        ->  CFWS:? dot_atom_text CFWS:? {% function (d) {
    // console.log("DA:", d[1]);
    var c0 = flatten.str(d[0]).trim();
    var c1 = flatten.str(d[2]).trim();
    var comment = comment_combine(c0, c1);
    if (comment) {
        return {
            dot_atom: d[1],
            comment: comment,
        };
    }
    return d[1];
} %}

word            ->  atom {% id %} | quoted_string {% id %}

phrase          ->  word:+ {% function (d) {
    // console.log("PH:", d);
    return d[0].join(" ");
} %}

addr_spec       ->   local_part "@" domain {% function (d,l,r) {
    // console.log("Addr_spec: ", d);
    var comment = comment_combine(d[0].comment, d[2].comment);
    var ret = {
        local_part: d[0],
        domain: d[2],
    };
    if (ret.domain[0] == "-") {
        // domains can't start with hyphen
        return r;
    }
    if (/-(\.|$)/.test(ret.domain)) {
        // domains can't end with hyphen or sub-domain end in one
        return r;
    }
    if (comment) {
        ret.comment = comment;
        ret.domain = ret.domain.dot_atom || ret.domain;
        ret.local_part = ret.local_part.dot_atom || ret.local_part;
    }
    return ret;
}%}

local_part      ->   dot_atom {% id %} | quoted_string {% id %} | obs_local_part {% id %}

obs_local_part  ->   word ("." word):* {% function (d) { return flatten.str(d) } %}

domain          ->   dot_atom {% id %} | domain_literal {% id %} | obs_domain {% id %}

# I added obs_domain in for: ":sysmail"@ Some-Group. Some-Org
obs_domain      ->   atom ("." atom):* {% function (d) { return flatten.str(d) } %}

domain_literal  ->   CFWS:? "[" (FWS:? dtext):* FWS:? "]" CFWS:? {% function (d) {
    var contents = d[2];
    return "[" + flatten.str(contents) + (d[3] && d[3][0] == " " ? " " : "") + "]";
} %}

dtext           ->   [!-Z\^-~]:+ {% function (d) { return d[0].join("") } %}
                   
address         ->  mailbox {% id %} | group {% id %}

mailbox         ->  name_addr {% id %} | addr_spec {% id %}

name_addr       ->  display_name:? angle_addr {% function (d) {
    if (d[0]) {
        d[1].display_name = d[0];
    }
    return d[1];
}%}

angle_addr      ->  CFWS:? "<" addr_spec ">" CFWS:? {% function (d) {
    var comment = comment_combine(flatten.str(d[0]).trim(), flatten.str(d[4]).trim());
    var ret = d[2];
    if (comment) {
        ret.comment = comment;
    }
    return ret;
}%}

group           ->  display_name ":" group_list:? ";" CFWS:? {% function (d,l,r) {
    var ret = {
        display_name: flatten.str(d[0]),
        groups: flatten.obj(d[2]),
    };
    return ret;
} %}

display_name    ->  phrase {% id %}

mailbox_list    ->  mailbox ([,;] mailbox):* {% function (d) {
    return flatten.obj(d).filter((c) => c != ",");
} %}

address_list    ->  address ([,;] address):* {% function (d) {
    return flatten.obj(d).filter((c) => c != ",");
} %}

group_list      ->  mailbox_list {% id %} | CFWS {% null %}

