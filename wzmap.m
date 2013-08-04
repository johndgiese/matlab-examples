function W = wzmap(x,y,funcString)
    [X Y] = meshgrid(x,y);
    Dist = sqrt(X.^2+Y.^2);
    Z = X + 1i*Y;
    W = eval(funcString);
    U = real(W);
    V = imag(W);
    scrsz = get(0,'ScreenSize');
    figure('Position',[1 1 scrsz(3) scrsz(4)]);
    colormap('copper');
    subplot(121);
    scatter(X(:),Y(:),4,Dist(:));
    title('Z-plane');
    xlabel('X = Real(Z)');
    ylabel('Y = Imag(Z)');
    axis square
    subplot(122);
    scatter(U(:),V(:),4,Dist(:));
    title(['W-plane: W(X,Y) = ' funcString]);
    xlabel('U(X,Y) = Real(W(X,Y))');
    ylabel('V(X,Y) = Imag(W(X,Y))');
    axis square
end