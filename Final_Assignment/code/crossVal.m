function ferr = crossVal( data, type, rep, maxDistName, feat1, feat2 )

    subset = gendat(data, 0.4);
    [ftrn ftst] = gendat(subset, 0.5);
    
    if feat1 ~= 0
       [fpmap ffrac] = pcam(ftrn, feat1);
       matR = ftrn*fpmap
       mat = subset*fpmap
    else
        matR = ftrn
        mat = ftrn
    end

    

    [fs r] = featself(matR, maxDistName, feat2);

    [ferr(1),std1] = prcrossval(mat*fs, knnc([], 1), type, rep);
    [ferr(2),std2] = prcrossval(mat*fs, knnc([], 2), type, rep);
    [ferr(3),std3] = prcrossval(mat*fs, knnc([], 3), type, rep);
    [ferr(4),std4] = prcrossval(mat*fs, nmc, type, rep);
    [ferr(5),std5] = prcrossval(mat*fs, ldc, type, rep);
    [ferr(6),std6] = prcrossval(mat*fs, qdc, type, rep);
    [ferr(7),std7] = prcrossval(mat*fs, fisherc, type, rep);
    [ferr(8),std8] = prcrossval(mat*fs, loglc, type, rep);
    [ferr(9),std9] = prcrossval(mat*fs, parzenc, type, rep);
end

